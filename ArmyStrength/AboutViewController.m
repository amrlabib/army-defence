//
//  AboutViewController.m
//  Army Defence Free
//
//  Created by Amr Labib on 17/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController
- (IBAction)HomeButton:(id)sender {
    [[self navigationController] popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor* backgroundColor = [ViewsUtil getGreenBackground:self.view];
    self.view.backgroundColor = backgroundColor;
}


@end
