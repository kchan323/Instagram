//
//  DetailsViewController.m
//  Instagram
//
//  Created by kchan23 on 7/9/19.
//  Copyright © 2019 kchan23. All rights reserved.
//

#import "DetailsViewController.h"
#import "Post.h"
#import "DateTools.h"

@interface DetailsViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIButton *favoriteButton;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *sendButton;
@property (weak, nonatomic) IBOutlet UIButton *bookmarkButton;
@property (weak, nonatomic) IBOutlet UILabel *likeCount;
@property (weak, nonatomic) IBOutlet UILabel *likeLabel;
@property (weak, nonatomic) IBOutlet UILabel *userLabel;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.post.image getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
        if (!data) {
            return NSLog(@"%@", error);
        }
        self.posterView.image = [UIImage imageWithData:data];
    }];
    self.captionLabel.text = self.post.caption;
    self.userLabel.text = self.post.author.username;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *createdAt = [self.post createdAt];
    NSDate *todayDate = [NSDate date];
    double ti = [createdAt timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if (ti < 60) {
        self.timestampLabel.text = @"less than a min ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        self.timestampLabel.text = [NSString stringWithFormat:@"%d min ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        self.timestampLabel.text = [NSString stringWithFormat:@"%d hr ago", diff];
    } else {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        self.timestampLabel.text = [formatter stringFromDate:createdAt];
    }
    
    NSArray *likeArray = [[NSArray alloc] init];
    likeArray = [self.post objectForKey:@"likeArray"];
    NSString *username = [self.user objectForKey:@"username"];
    if(![likeArray containsObject:username]) {
        [self.favoriteButton setSelected:NO];
        [self.favoriteButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
        self.likeCount.text = likeCount;
    }
    else {
        [self.favoriteButton setSelected:YES];
        [self.favoriteButton setImage:[UIImage imageNamed:@"likered"] forState:UIControlStateSelected];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
        self.likeCount.text = likeCount;
    }
}

- (void)viewDidAppear:(BOOL)animated {
//    NSArray *likeArray = [[NSArray alloc] init];
//    likeArray = [self.post objectForKey:@"likeArray"];
//    NSString *username = [self.user objectForKey:@"username"];
//    if(![likeArray containsObject:username]) {
//        [self.favoriteButton setSelected:NO];
//        [self.favoriteButton setImage:[UIImage imageNamed:@"like"] forState:UIControlStateNormal];
//        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
//        self.likeCount.text = likeCount;
//    }
//    else {
//        [self.favoriteButton setSelected:YES];
//        [self.favoriteButton setImage:[UIImage imageNamed:@"likered"] forState:UIControlStateSelected];
//        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
//        self.likeCount.text = likeCount;
//    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapLike:(id)sender {
    PFUser *user = [PFUser currentUser];
    NSArray *likeArray = [[NSArray alloc] init];
    likeArray = [self.post objectForKey:@"likeArray"];
    NSString *username = [user objectForKey:@"username"];
    if(![likeArray containsObject:username]) {
        NSLog(@"Successfully favorited");
        [self.favoriteButton setSelected:YES];
        [self.post addObject:username forKey:@"likeArray"];
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        }];
        likeArray = [self.post objectForKey:@"likeArray"];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
        self.likeCount.text = likeCount;
    }
    else {
        NSLog(@"Successfully unfavorited");
        [self.favoriteButton setSelected:NO];
        [self.post removeObject:username forKey:@"likeArray"];
        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
        }];
        likeArray = [self.post objectForKey:@"likeArray"];
        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
        self.likeCount.text = likeCount;
    }
}

@end
