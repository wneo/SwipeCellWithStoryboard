//
//  SwipeCellWithStoryboardViewController.h
//  SwipeCellWithStoryboard
//
//  Created by neo on 13-9-5.
//  Copyright (c) 2013年 Neo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeCellWithStoryboardViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *accountText;
@property (weak, nonatomic) IBOutlet UITextField *passwdText;

@property (weak, nonatomic) IBOutlet UIButton *submit;
@end
