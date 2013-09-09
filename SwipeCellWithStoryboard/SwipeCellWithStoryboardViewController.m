//
//  SwipeCellWithStoryboardViewController.m
//  SwipeCellWithStoryboard
//
//  Created by neo on 13-9-5.
//  Copyright (c) 2013年 Neo. All rights reserved.
//

#import "SwipeCellWithStoryboardViewController.h"

@interface SwipeCellWithStoryboardViewController ()

@end

@implementation SwipeCellWithStoryboardViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload
{
    [self setSubmit:nil];
    [super viewDidUnload];
}
- (IBAction)submitAccountAndPasswd
{
	//segue
//	[self performSegueWithIdentifier:@"segueSubmit" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
	NSLog(@"will segue");
}
#pragma mark - textField
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
	NSLog(@"text:%@", textField);
	return YES;
}
- (void)textFieldDidEndEditing:(UITextField *)textField
{
	NSLog(@"end:%@", textField);
}
@end
