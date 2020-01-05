//
//  menuCanvasAttr.m
//  ArmyStrength
//
//  Created by amr hamdy on 9/29/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "menuCanvasAttr.h"

@implementation menuCanvasAttr

@synthesize activated;

-(id) init : (UIView *)  ref : (int) screenWidth : (int) screenHeight  : (soundEffectsHandler*)sound
{
    self = [super initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];
    
    soundR = sound;
    
    activated = false;
    viewReference = ref;
    [self setBackground :screenWidth :  screenHeight];
    [self addBackButton : screenHeight];
    return self;
}


-(void) setBackground : (int)screenWidth : (int) screenHeight
{
    DrawableObject *background ;
    CGSize screenSize;
    screenSize.width = screenWidth;
    screenSize.height = screenHeight;
    
    
    
    if(screenWidth == 1024)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"ipad-menu-env.jpg"];
    else if(screenWidth == 480)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-4s-menu-env.jpg"];
    else if(screenWidth == 568)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-SE-menu-env.jpg"];
    else if (screenWidth == 667)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-7-menu-env.jpg"];
    else //if (screenWidth == 736)
        background = [[DrawableObject alloc] init: self :0 :0 :screenSize :@"iphone-7-plus-menu-env.jpg"];
    

    [background release];
    
    
}
-(void) addToMenu
{
    [viewReference addSubview:self];
    activated = true;
}
-(void) removeFromMenu
{
    activated = false;
    [self removeFromSuperview];
}
-(void) addBackButton : (int) screenHeight
{
    CGSize buttonSize;
    buttonSize.width = screenHeight*0.08;
    buttonSize.height = screenHeight*0.08;
    
    
    if(screenHeight == 320)
    {
        buttonSize.width = screenHeight*0.075;
        buttonSize.height = screenHeight*0.075;
        
    }

    
    
    backButton = [self initButtonAttr:buttonSize.width : buttonSize.height :buttonSize.width :buttonSize.height  :@"homeButton.png"];
    
    [self addSubview:backButton];
}
-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height : (NSString*) name
{
    UIButton* currentButton = [[UIButton alloc] initWithFrame:CGRectMake(x , y, width, height)];
    [currentButton setTitle:name forState:UIControlStateNormal ];
    [currentButton addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [currentButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    currentButton.exclusiveTouch =YES;

    return currentButton;
}
-(void) buttonClickHandler : (id) sender
{
    [soundR playMySoundFile:@"buttonSound"];
    if(  (UIButton*)sender == backButton )
        [self removeFromMenu];
    
}


@end
