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
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
