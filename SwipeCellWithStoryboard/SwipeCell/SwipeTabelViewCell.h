//
//  SwipeTabelViewCell.h
//  SwipeCellWithStoryboard
//
//  Created by neo on 13-9-6.
//  Copyright (c) 2013年 Neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeTabelViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *containView;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

- (void)configSwipeWithDict:(NSDictionary *)configDict;
@end
