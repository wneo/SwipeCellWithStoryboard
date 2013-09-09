//
//  SwipeTabelViewCell.m
//  SwipeCellWithStoryboard
//
//  Created by neo on 13-9-6.
//  Copyright (c) 2013年 Neo. All rights reserved.
//

#define kAnimateTime	1//1秒时间滑动整个控件


typedef enum SwipeState {
	kSwipeStateMid,
	kSwipeStateNone,
	kSwipeStateShortLeft,
	kSwipeStateLongLeft,
	kSwipeStateShortRight,
	kSwipeStateLongRight,
} SwipeState;

#import "SwipeTabelViewCell.h"
@interface SwipeTabelViewCell ()
@property (nonatomic, strong) UIPanGestureRecognizer *gesture;
@property (nonatomic) CGPoint startCenter;
@property (nonatomic) CGPoint startCenterLeft;

@property (nonatomic) SwipeState swipeState;


//cache data


//config
@property (nonatomic, strong) UIImage *imageShortLeft;
@property (nonatomic, strong) UIImage *imageLongLeft;
@property (nonatomic, strong) UIImage *imageShortRight;
@property (nonatomic, strong) UIImage *imageLongRight;

@property (nonatomic, strong) UIColor *colorNone;//未生效的颜色
@property (nonatomic, strong) UIColor *colorShortLeft;
@property (nonatomic, strong) UIColor *colorLongLeft;
@property (nonatomic, strong) UIColor *colorShortRight;
@property (nonatomic, strong) UIColor *colorLongRight;

@end

@implementation SwipeTabelViewCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//		
//    }
//    return self;
//}

- (void)configSwipeWithDict:(NSDictionary *)configDict
{
	if (self.gesture != nil) {
		return;
	}
	self.gesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureHappen:)];
	self.gesture.delegate = self;
	[self addGestureRecognizer:self.gesture];
	
	self.imageShortLeft = configDict[@"imageShortLeft"];
	self.imageLongLeft = configDict[@"imageLongLeft"];
	self.imageShortRight = configDict[@"imageShortRight"];
	self.imageLongRight = configDict[@"imageLongRight"];
	
	self.colorNone = configDict[@"colorNone"];
	self.colorShortLeft = configDict[@"colorShortLeft"];
	self.colorLongLeft = configDict[@"colorLongLeft"];
	self.colorShortRight = configDict[@"colorShortRight"];
	self.colorLongRight = configDict[@"colorLongRight"];
}
- (void)changeCellColorAndPictureWithState:(SwipeState)state
{
	switch (state) {
		case kSwipeStateLongLeft:
			if (self.colorLongLeft != nil) {
				self.contentView.backgroundColor = self.colorLongLeft;
			}
			if (self.imageLongLeft != nil) {
				self.rightImageView.image = self.imageLongLeft;
			}

			break;
		case kSwipeStateShortLeft:
			if (self.colorShortLeft != nil) {
				self.contentView.backgroundColor = self.colorShortLeft;
			}
			if (self.imageShortLeft != nil) {
				self.rightImageView.image = self.imageShortLeft;
			}
			break;
		case kSwipeStateLongRight:
			if (self.colorLongRight != nil) {
				self.contentView.backgroundColor = self.colorLongRight;
			}
			if (self.imageLongRight != nil) {
				self.leftImageView.image = self.imageLongRight;
			}
			break;
		case kSwipeStateShortRight:
			if (self.colorShortRight != nil) {
				self.contentView.backgroundColor = self.colorShortRight;
			}
			if (self.imageShortRight != nil) {
				self.leftImageView.image = self.imageShortRight;
			}

			break;
		case kSwipeStateNone:
			if (self.colorNone != nil) {
				self.contentView.backgroundColor = self.colorNone;
			}
			if (self.imageShortRight != nil) {
				self.leftImageView.image = self.imageShortRight;
			}
			if (self.imageShortLeft != nil) {
				self.rightImageView.image = self.imageShortLeft;
			}
			break;
		case kSwipeStateMid:
			self.leftImageView.image = nil;
			self.rightImageView.image = nil;
			break;
			
		default:
			break;
	}
}
- (void)moveCellOriginX:(CGFloat)xMove
{
	//计算view x 轴偏移量
	//CGFloat xMove = originX - self.frame.origin.x;

	//设置 containView 的 坐标
	CGRect containViewRect = self.contentView.frame;
	containViewRect.origin.x += xMove;
	self.containView.frame = containViewRect;
	
	self.containView.backgroundColor = [UIColor blueColor];
	

	//附加图坐标
	if (abs(xMove) >= self.leftImageView.frame.size.width){
		//左图坐标
		CGRect leftImageViewRect = self.leftImageView.frame;
		leftImageViewRect.origin.x =  self.containView.frame.origin.x - self.leftImageView.frame.size.width;
		self.leftImageView.frame = leftImageViewRect;
		
		//右图坐标
		CGRect rightImageViewRect = self.rightImageView.frame;
		rightImageViewRect.origin.x =  self.containView.frame.origin.x + self.containView.frame.size.width;
		self.rightImageView.frame = rightImageViewRect;
	}else{
		//左图坐标
		CGRect leftImageViewRect = self.leftImageView.frame;
		leftImageViewRect.origin.x =  self.contentView.frame.origin.x;
		self.leftImageView.frame = leftImageViewRect;
		
		//右图坐标
		CGRect rightImageViewRect = self.rightImageView.frame;
		rightImageViewRect.origin.x =  self.contentView.frame.origin.x + self.contentView.frame.size.width - rightImageViewRect.size.width;
		self.rightImageView.frame = rightImageViewRect;
	}
	
	
	if (xMove >= self.contentView.frame.size.width - self.leftImageView.frame.size.width) {//向右长拉
		self.swipeState = kSwipeStateLongRight;
	}else if (xMove >= self.leftImageView.frame.size.width){//向右短拉
		self.swipeState = kSwipeStateShortRight;
	}else if (xMove > 0){//向右拉一点
		self.swipeState = kSwipeStateNone;
	}else if (-xMove >= self.contentView.frame.size.width - self.rightImageView.frame.size.width) {//向左长拉
		self.swipeState = kSwipeStateLongLeft;
	}else if (-xMove >= self.rightImageView.frame.size.width){//向左短拉
		
		self.swipeState = kSwipeStateShortLeft;
	}else if (-xMove > 0){//向左拉一点
		self.swipeState = kSwipeStateNone;
	}else{//居中
		self.swipeState = kSwipeStateMid;
	}
	
	
}

- (void)panGestureHappen:(UIPanGestureRecognizer *)gesture
{
	CGPoint transPoint = [gesture translationInView:self];
	CGPoint thisCenter = self.startCenter;
	CGPoint thisCenterLeft = self.startCenterLeft;
	switch (gesture.state) {
		case UIGestureRecognizerStateBegan:
			self.startCenter = self.containView.center;
			self.startCenterLeft = self.leftImageView.center;
			break;
		case UIGestureRecognizerStateChanged:
			thisCenter.x = self.startCenter.x + transPoint.x;
			thisCenterLeft.x = self.startCenterLeft.x + transPoint.x;
			//self.containView.center = thisCenter;
			//self.leftImageView.center = thisCenterLeft;
			[self moveCellOriginX:transPoint.x];
			[self changeCellColorAndPictureWithState:self.swipeState];
			//[self setNeedsDisplay];
			break;
		case UIGestureRecognizerStateEnded:
			NSLog(@"Ended");
			[UIView beginAnimations:@"swipecellviewAnimate" context:(__bridge void*)self.contentView];
			[UIView setAnimationCurve:UIViewAnimationCurveLinear];
			[UIView setAnimationDuration:0.5f];
			[UIView setAnimationDelegate:self];
			switch (self.swipeState) {
				case kSwipeStateNone:
					[self moveCellOriginX:0];
					break;
					
				default:
					break;
			}
			[self moveCellOriginX:0];
			//<#statements#>
			[UIView commitAnimations];
			break;
		
		default:
			break;
	}
	
}

- (void)prepareForReuse
{
	NSLog(@"per");
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
	// We only want to deal with the gesture of it's a pan gesture
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:self];
        return (fabs(translation.x) / fabs(translation.y) > 0.8) ? YES : NO;
    } else {
        return NO;
    }
}

@end
