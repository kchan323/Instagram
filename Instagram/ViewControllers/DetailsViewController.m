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
        
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [formatter setDateFormat:@"E MMM d HH:mm:ss Z y"];
    NSDate *createdAt = [self.post createdAt];
    NSDate *todayDate = [NSDate date];
    double ti = [createdAt timeIntervalSinceDate:todayDate];
    ti = ti * -1;
    if (ti < 60) {
        //return @"less than a min ago";
        //return [NSString stringWithFormat:@"%d less than a min ago"];
        self.timestampLabel.text = @"less than a min ago";
    } else if (ti < 3600) {
        int diff = round(ti / 60);
        //return [NSString stringWithFormat:@"%d min ago", diff];
        self.timestampLabel.text = [NSString stringWithFormat:@"%d min ago", diff];
    } else if (ti < 86400) {
        int diff = round(ti / 60 / 60);
        //return[NSString stringWithFormat:@"%d hr ago", diff];
        self.timestampLabel.text = [NSString stringWithFormat:@"%d hr ago", diff];
    } else {
        formatter.dateStyle = NSDateFormatterShortStyle;
        formatter.timeStyle = NSDateFormatterNoStyle;
        self.timestampLabel.text = [formatter stringFromDate:createdAt];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
