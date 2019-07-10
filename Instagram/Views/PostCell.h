//
//  PostCell.h
//  Instagram
//
//  Created by kchan23 on 7/9/19.
//  Copyright © 2019 kchan23. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"

NS_ASSUME_NONNULL_BEGIN

@interface PostCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UILabel *captionLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (strong, nonatomic) Post *post;

@end

NS_ASSUME_NONNULL_END
