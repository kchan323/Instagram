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

@interface TimelineViewController () <UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *postsArray;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self fetchPosts];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchPosts) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:self.refreshControl atIndex:0];
}

- (void)fetchPosts {
    // construct PFQuery
    PFQuery *postQuery = [Post query];
    [postQuery orderByDescending:@"createdAt"];
    [postQuery includeKey:@"author"];
    postQuery.limit = 20;
    
    // fetch data asynchronously
    [postQuery findObjectsInBackgroundWithBlock:^(NSArray<Post *> * _Nullable posts, NSError * _Nullable error) {
        if (posts) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.postsArray = posts;
            [self.tableView reloadData];
        }
        else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
        [self.refreshControl endRefreshing];
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
    if([segue.identifier isEqualToString:@"detailSegue"]) {
        PostCell *tappedCell = sender;
        DetailsViewController *detailsViewController =  [segue destinationViewController];
        detailsViewController.post = tappedCell.post;
    }
    
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    PostCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostCell"];
    Post *post = self.postsArray[indexPath.row];
    cell.post = post;
    
    [post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        cell.posterView.image = [UIImage imageWithData:data];
    }];
    
    cell.captionLabel.text = post.caption;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *createdAt = [post createdAt];
    NSDate *todayDate = [NSDate date];
    double ti = [createdAt timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if(ti < 1) {
        cell.dateLabel.text = @"never";
    } else  if (ti < 60) {
        cell.dateLabel.text = @"less than a min ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        cell.dateLabel.text = [NSString stringWithFormat:@"%d min ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        cell.dateLabel.text = [NSString stringWithFormat:@"%d hr ago", diff];
    } else if (ti < INFINITY) {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        cell.dateLabel.text = [formatter stringFromDate:createdAt];
    }
    else {
        cell.dateLabel.text = @"never";
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.postsArray.count;
}

@end
