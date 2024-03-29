//
//  TimelineViewController.m
//  Instagram
//
//  Created by kchan23 on 7/8/19.
//  Copyright © 2019 kchan23. All rights reserved.
//

#import "TimelineViewController.h"
#import "Parse/Parse.h"
#import "LoginViewController.h"
#import "AppDelegate.h"
#import "PostCell.h"
#import "Post.h"
#import "DetailsViewController.h"
#import "DateTools.h"
#import "MBProgressHUD/MBProgressHUD.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, PostCellDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *postsArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;
@property (strong, nonatomic) NSArray *likeArray;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"insta3.png"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:image];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.postsArray = [[NSMutableArray alloc] init];
    [self fetchPostsWithFilter:nil];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)viewDidAppear:(BOOL)animated {
    //[self fetchPosts];
}

- (void)fetchPosts {
    [self fetchPostsWithFilter:nil];
}

- (void)fetchPostsWithFilter: (NSDate *)lastDate{
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    if(lastDate) {
        [postQuery whereKey:@"createdAt" lessThan:lastDate];
    }
    postQuery.limit = 20;

    [MBProgressHUD showHUDAddedTo:self.navigationController.view animated:YES];
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if ([posts count] != 0) {
            if(lastDate){
                self.isMoreDataLoading = NO;
                [self.postsArray addObjectsFromArray:posts];
            }
            else {
                self.postsArray = posts;
            }
            [self.tableView reloadData];
            NSLog(@"😎😎😎 Successfully loaded home timeline");
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
        [MBProgressHUD hideHUDForView:self.navigationController.view animated:YES];
    }];
}

- (IBAction)didTapLogout:(id)sender {
    [PFUser logOutInBackgroundWithBlock:^(NSError * _Nullable error) {
        if(PFUser.currentUser == nil) {
            AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            appDelegate.window.rootViewController = loginViewController;
            
            NSLog(@"User logged out successfully");
        } else {
            NSLog(@"Error logging out: %@", error);
        }
    }];
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"postSegue"]) {
        PostCell *tappedCell = sender;
        DetailsViewController *detailsViewController =  [segue destinationViewController];
        detailsViewController.post = tappedCell.post;
        detailsViewController.user = self.user;
    }
    else if([segue.identifier isEqualToString:@"profileSegue"]) {
        ProfileViewController *profileViewController =  [segue destinationViewController];
        profileViewController.user = sender;
    }
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postsArray[indexPath.row];
    cell.post = post;
    self.user = [PFUser currentUser];
    
    PFFileObject *image = [post.author objectForKey:@"image"];
    
    cell.userLabel1.text = post.author.username;
    cell.userLabel2.text = post.author.username;

    [image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.profileView.image = [UIImage imageWithData:data];
    }];
    cell.profileView.layer.cornerRadius = cell.profileView.frame.size.height/2;
    
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.posterView.image = [UIImage imageWithData:data];
    }];
    
    NSArray *likeArray = [[NSArray alloc] init];
    likeArray = [cell.post objectForKey:@"likeArray"];
    NSString *username = [self.user objectForKey:@"username"];
    if(![likeArray containsObject:username]) {
        [cell.favoriteButton setSelected:NO];
        [cell.favoriteButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
        cell.likeCount.text = likeCount;
    }
    else {
        [cell.favoriteButton setSelected:YES];
        [cell.favoriteButton setImage:[UIImage imageNamed:@"likered"] forState:UIControlStateSelected];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
        cell.likeCount.text = likeCount;
    }
    
    cell.captionLabel.text = post.caption;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *createdAt = [post createdAt];
    NSDate *todayDate = [NSDate date];
    double ti = [createdAt timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if (ti < 60) {
        cell.dateLabel.text = @"less than a min ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        cell.dateLabel.text = [NSString stringWithFormat:@"%d min ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        cell.dateLabel.text = [NSString stringWithFormat:@"%d hr ago", diff];
    } else {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        cell.dateLabel.text = [formatter stringFromDate:createdAt];
    }
    
    cell.delegate = self;
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if(!self.isMoreDataLoading){
        int scrollViewContentHeight = self.tableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.tableView.bounds.size.height;
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.tableView.isDragging) {
            self.isMoreDataLoading = true;
            Post *lastPost = [self.postsArray lastObject];
            NSDate *lastDate = lastPost.createdAt;
            [self fetchPostsWithFilter:lastDate];
        }
    }
}

- (void)postCell:(PostCell *)postCell didTap:(PFUser *)user{
    [self performSegueWithIdentifier:@"profileSegue" sender:user];
}

@end
