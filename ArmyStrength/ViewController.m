//
//  ViewController.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/1/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "ViewController.h"
#import "IJIndex.h"


@interface ViewController ()

@end

@implementation ViewController




-(void) mainFunction
{
    [self adjustScreenResolution];
    
    mainMenuObject = [[mainMenu alloc] init: self.view : currentWindowBounds];
}
-(void) adjustScreenResolution
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    currentWindowBounds.height =screenBounds.size.height;
    currentWindowBounds.width =screenBounds.size.width;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft );
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    //[[UIApplication sharedApplication] setStatusBarHidden:YES];
    [self mainFunction];

    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
