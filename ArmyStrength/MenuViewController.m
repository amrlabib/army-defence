//
//  MenuViewController.m
//  Army Defence Free
//
//  Created by Amr Labib on 16/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import "MenuViewController.h"


@interface MenuViewController ()

@end

@implementation MenuViewController

- (IBAction)RateButton:(id)sender {
    [soundObject playMySoundFile:@"buttonSound"];
    [saveTextObject updateArmyRated:true];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefencefree"]];
}
- (IBAction)BuyFullAppButton:(id)sender {
    [soundObject playMySoundFile:@"buttonSound"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefence"]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setBackground];
    [self initMenu];
}

-(id) initMenu
{
    saveTextObject = [[savedText alloc] init];
    soundEnabled = [saveTextObject getLevelValue:26];
    musicEnabled = [saveTextObject getLevelValue:27];
    soundObject = [[soundEffectsHandler alloc] init : soundEnabled : musicEnabled];
    [soundObject playMySoundFile:@"gameMusic"];
}

-(void) setBackground
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    int width = screenBounds.size.width;
    int height = screenBounds.size.height;
    
    UIStoryboard *menu = [UIStoryboard storyboardWithName: @"LaunchScreen" bundle:nil];
    UIViewController *menuViewController = [menu instantiateViewControllerWithIdentifier: @"backgroundStoryBoard"];
    menuViewController.view.frame = CGRectMake(0, 0, width, height);
    
    [self.view addSubview: menuViewController.view];
    [self.view sendSubviewToBack:menuViewController.view];
}


@end
