//
//  PostCell.m
//  Instagram
//
//  Created by kchan23 on 7/9/19.
//  Copyright © 2019 kchan23. All rights reserved.
//

#import "PostCell.h"

@implementation PostCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    UITapGestureRecognizer *profileTapGestureRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(didTapUserProfile:)];
    [self.profileView addGestureRecognizer:profileTapGestureRecognizer];
    [self.profileView setUserInteractionEnabled:YES];
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate postCell:self didTap:self.post.author];
}

//- (IBAction)didTapLike:(id)sender {
//    PFUser *user = [PFUser currentUser];
//    NSArray *likeArray = [[NSArray alloc] init];
//    likeArray = [self.post objectForKey:@"likeArray"];
//    NSString *username = [user objectForKey:@"username"];
//    if(![likeArray containsObject:username]) {
//        NSLog(@"Successfully favorited");
//        [self.favoriteButton setSelected:YES];
//        [self.post addObject:username forKey:@"likeArray"];
//        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        }];
//        likeArray = [self.post objectForKey:@"likeArray"];
//        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
//        self.likeCount.text = likeCount;
//    }
//    else {
//        NSLog(@"Successfully unfavorited");
//        [self.favoriteButton setSelected:NO];
//        [self.post removeObject:username forKey:@"likeArray"];
//        [self.post saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
//        }];
//        likeArray = [self.post objectForKey:@"likeArray"];
//        NSString *likeCount = [NSString stringWithFormat:@"%lu", (unsigned long)likeArray.count];
//        self.likeCount.text = likeCount;
//    }
//}

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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
