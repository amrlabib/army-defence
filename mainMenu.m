//
//  mainMenu.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/26/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "mainMenu.h"

@implementation mainMenu


@synthesize activated , background , playButton , optionsButton , helpButton, aboutButton;



-(id) init : (UIView*) controllerRef : (CGSize) sSize
{    
    [self initWithFrame:CGRectMake(0, 0, sSize.width, sSize.height)];


   

    saveTextObject = [[savedText alloc] init];
    
    
    screenSize = sSize;
    
    viewReference  = controllerRef;

    
    soundEnabled = [saveTextObject getLevelValue:26];
    musicEnabled = [saveTextObject getLevelValue:27];


    
    soundObject = [[soundEffectsHandler alloc] init : soundEnabled : musicEnabled];
    
    
    [soundObject playMySoundFile:@"gameMusic"];
    
    levelsObject =  [[levelsCanvas alloc] init:viewReference : (int)screenSize.width  : (int)screenSize.height : soundObject : saveTextObject  ];
    optionsObject = [[optionsCancas alloc] init:viewReference : (int)screenSize.width  : (int)screenSize.height  : soundObject :  saveTextObject];
    //helpObject = [[helpCanvas alloc] init:viewReference : (int)screenSize.width  : (int)screenSize.height : soundObject ];
    aboutObject = [[aboutCanvas alloc] init:viewReference : (int)screenSize.width  : (int)screenSize.height : soundObject  ];
    
    
    self.multipleTouchEnabled = false;
    
    if(sSize.width == 1024)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"ipad-landscape.jpg"];
    else if(sSize.width == 480)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-4s-landscape.jpg"];
    else if(sSize.width == 568)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-SE-landscape.jpg"];
    else if (sSize.width == 667)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-7-landscape.jpg"];
    else //if (sSize.width == 736)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-7-plus-landscape.jpg"];
    
    
    
    //[self addAnimationImages ];
    [self addButtons ];
    [self addMainMenu ];
    
    touchingButton=  0;
    
    //[self initAnimationTimer];
    
    
    
    return self;
}

-(void) addAnimationImages
{
    
    CGSize animationImagesSize;
    animationImagesSize.width = screenSize.width*0.2;
    animationImagesSize.height = screenSize.width*0.2;
    
    int x =  screenSize.width*0.5 ;// arc4random() % ((int)screenSize.width - (int)animationImagesSize.width);
    int y = screenSize.height/2 ;// arc4random() % ((int)screenSize.height - (int)animationImagesSize.height);
    
    animationImage1 = [[DrawableObject alloc] init: self :x :y :animationImagesSize :@"menuAnimationImage.png"];
    
    
    

}
-(void) addButtons
{
    
    CGSize buttonsSize;
    
    buttonsSize.width = 0.2*screenSize.height;
    buttonsSize.height = 0.635*buttonsSize.width; 
    
    int xStep = screenSize.width /2 - buttonsSize.width / 2;
    
    
    playButton = [self initButtonAttr:xStep :0.29 * screenSize.height + (0 * screenSize.height * 0.16) :buttonsSize.width :buttonsSize.height  :@"playButton.png"];
    
    optionsButton = [self initButtonAttr:xStep :0.29 * screenSize.height + (1 * screenSize.height * 0.16) :buttonsSize.width :buttonsSize.height  :@"optionsButton.png"];

     aboutButton = [self initButtonAttr:xStep :0.29* screenSize.height + (2 * screenSize.height * 0.16) :buttonsSize.width :buttonsSize.height  :@"aboutButton.png"];

    
    
    
    CGSize rateButtonSize;
    rateButtonSize.width = buttonsSize.width*0.45;
    rateButtonSize.height = buttonsSize.width*0.45;
    
    rateButton = [self initButtonAttr:rateButtonSize.width*0.2 :screenSize.height - rateButtonSize.height*1.2 :rateButtonSize.width :rateButtonSize.height  :@"rateButton.png"];
    
    moreButton = [self initButtonAttr:screenSize.width - rateButtonSize.width*1.2 :screenSize.height - rateButtonSize.height*1.2 :rateButtonSize.width :rateButtonSize.height  :@"moreAppsButton.png"];
    
    
    buyButton = [self initButtonAttr:rateButtonSize.width*1.4 :screenSize.height - rateButtonSize.height*1.2 :rateButtonSize.width :rateButtonSize.height  :@"buyFullVersionButton.png"];

    

    
    [self addSubview:playButton];
    [self addSubview:optionsButton];
    [self addSubview:aboutButton];
    [self addSubview:rateButton];
    [self addSubview:moreButton];
    [self addSubview:buyButton];






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
-(void) addMainMenu
{
    activated  = true;
    [viewReference addSubview:self];
}
-(void) removeMainMenu
{
    activated  = false;
    [self removeFromSuperview];
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


@end
