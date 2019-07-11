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
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)didTapLike:(id)sender {
    if(self.favorited == NO){
        NSLog(@"Successfully favorited");
        self.favorited = YES;
        [self.favoriteButton setSelected:YES];
    }
    else {
        NSLog(@"Successfully unfavorited");
        self.favorited = NO;
        [self.favoriteButton setSelected:NO];
    }
}

@end
