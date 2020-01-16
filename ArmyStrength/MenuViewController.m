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
    [self addButtons ];

    
    touchingButton=  0;
}

-(void) addButtons
{
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    int width = screenBounds.size.width;
    int height = screenBounds.size.height;
    
    CGSize buttonsSize;
    
    buttonsSize.width = 0.2*height;
    buttonsSize.height = 0.635* width;
    
    int xStep = width /2 - buttonsSize.width / 2;
    
    
    playButton = [self initButtonAttr:xStep :0.29 * height + (0 * height * 0.16) :buttonsSize.width :buttonsSize.height  :@"playButton.png"];
    
    optionsButton = [self initButtonAttr:xStep :0.29 * height + (1 * height * 0.16) :width :height  :@"optionsButton.png"];

     aboutButton = [self initButtonAttr:xStep :0.29* height + (2 * height * 0.16) :buttonsSize.width :buttonsSize.height  :@"aboutButton.png"];

    
    
    
    CGSize rateButtonSize;
    rateButtonSize.width = buttonsSize.width*0.45;
    rateButtonSize.height = buttonsSize.width*0.45;
    
    rateButton = [self initButtonAttr:rateButtonSize.width*0.2 :height - rateButtonSize.height*1.2 :rateButtonSize.width :rateButtonSize.height  :@"rateButton.png"];
    
    moreButton = [self initButtonAttr:screenSize.width - rateButtonSize.width*1.2 :height - rateButtonSize.height*1.2 :rateButtonSize.width :rateButtonSize.height  :@"moreAppsButton.png"];
    
    
    buyButton = [self initButtonAttr:rateButtonSize.width*1.4 :height - rateButtonSize.height*1.2 :rateButtonSize.width :rateButtonSize.height  :@"buyFullVersionButton.png"];

    
//    [self.view addSubview:playButton];
//    [self.view addSubview:optionsButton];
//    [self.view addSubview:aboutButton];
    [self.view addSubview:rateButton];
    [self.view addSubview:moreButton];
    [self.view addSubview:buyButton];

}
-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height : (NSString*) name
{
    UIButton *currentButton = [[UIButton alloc] initWithFrame:CGRectMake(x , y, width, height)];
    [currentButton setTitle:name forState:UIControlStateNormal ];
    [currentButton addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [currentButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    currentButton.exclusiveTouch =YES;
    
    
    return currentButton;
}

-(void) buttonClickHandler : (id) sender
{
    [soundObject playMySoundFile:@"buttonSound"];


    if(  (UIButton*)sender == rateButton )
    {
        [saveTextObject updateArmyRated:true];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefencefree"]];
    }
    else if((UIButton*)sender == moreButton)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/amrlabib"]];
    else if((UIButton*)sender == buyButton)
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefence"]];
    else if((UIButton*)sender == playButton)
        [levelsObject addToMenu];
    else  if( (UIButton*)sender == optionsButton  )
        [optionsObject addToMenu];
    else  if(  (UIButton*)sender == aboutButton  )
        [aboutObject addToMenu];

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
