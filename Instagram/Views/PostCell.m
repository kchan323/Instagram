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

- (IBAction)didTapLike:(id)sender {
    if(self.favorited == NO){
        NSLog(@"Successfully favorited");
        self.favorited = YES;
        //self.favoriteCount += 1;
        [self.favoriteButton setSelected:YES];
        //self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    }
    else {
        NSLog(@"Successfully unfavorited");
        self.favorited = NO;
        //self.favoriteCount -= 1;
        [self.favoriteButton setSelected:NO];
        //self.favoriteLabel.text = [NSString stringWithFormat:@"%d", self.tweet.favoriteCount];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

- (void) didTapUserProfile:(UITapGestureRecognizer *)sender{
    [self.delegate postCell:self didTap:self.post.author];
}

@end
