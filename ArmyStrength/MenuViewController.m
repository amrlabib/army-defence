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
    if (@available(iOS 10.3, *)) {
        [SKStoreReviewController requestReview];
    } else {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefencefree"]];
    }
    [saveTextObject updateArmyRated:true];
}
- (IBAction)BuyFullAppButton:(id)sender {
    [soundObject playMySoundFile:@"buttonSound"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefence"]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationLandscapeRight || interfaceOrientation == UIInterfaceOrientationLandscapeLeft );
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView* background = [ViewsUtil getViewBackgroundFromLaunchScreen];
    [self.view addSubview: background];
    [self.view sendSubviewToBack: background];
    
    [self initMenu];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showOptionsSegue"])
    {
        OptionsViewController *vc = segue.destinationViewController;
        vc.soundRef = soundObject;
    } else if ([segue.identifier isEqualToString:@"showLevelsSegue"]) {
        LevelsViewController *vc = segue.destinationViewController;
        vc.soundRef = soundObject;
    }
}

-(id) initMenu
{
    saveTextObject = [[savedText alloc] init];
    soundEnabled = [saveTextObject getLevelValue:26];
    musicEnabled = [saveTextObject getLevelValue:27];
    soundObject = [[soundEffectsHandler alloc] init : soundEnabled : musicEnabled];
    [soundObject playMySoundFile:@"gameMusic"];
}

@end
