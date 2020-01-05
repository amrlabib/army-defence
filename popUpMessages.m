//
//  popUpMessages.m
//  Army Defence
//
//  Created by amr hamdy on 10/17/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "popUpMessages.h"

@implementation popUpMessages


@synthesize  delegate;

-(id) init : (UIView*) viewRef : (CGSize) sSize : (NSString*) mText : (int) sCount : (soundEffectsHandler*)sound
{
    self = [super initWithFrame:CGRectMake(0, 0 , sSize.width, sSize.height)];
    self.backgroundColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:0.6] autorelease];

    soundObject = sound;
    
    starsCount = sCount;
    
    innerMessage = [UIView new];
    innerMessage.frame = CGRectMake(0, sSize.height*0.25 , sSize.width, sSize.height*0.5);
    innerMessage.backgroundColor = [[[UIColor alloc] initWithRed:0 green:0 blue:0 alpha:1] autorelease];

    [self addSubview:innerMessage];
    
    
    messageSize.width = sSize.width;
    messageSize.height = sSize.height*0.5;
    
    messageText = mText;
    viewReference = viewRef;
    
    [self addMessageAttributes];
    
    return self;
}

-(void) addMessageAttributes 
{
    CGSize victorySize;
    victorySize.width = messageSize.height*1.15;
    victorySize.height = messageSize.height*1.15;
    
    
    
    CGSize buttonSize;
    buttonSize.width = messageSize.height*0.2;
    buttonSize.height = messageSize.height *0.2;
    
    
    CGSize starSize;
    starSize.width = messageSize.height*0.3;
    starSize.height = messageSize.height *0.3;
    
    
    
    int victoryXStart = messageSize.width/2 - victorySize.width/2;


    UIImageView *victoryImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:messageText]];
    
    victoryImage.frame = CGRectMake( victoryXStart, messageSize.height/2 - victorySize.height*0.8, victorySize.width, victorySize.height);

    
    int starsXStart = victoryXStart + starSize.width/2;
    
    for(int i=0 ;i < 3  && starsCount > 0; i++)
    {
        if(i+1 <= starsCount)
        {
            UIImageView *starImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"star.png"]];
            starImage.frame = CGRectMake(  starsXStart + (starSize.width*1.2*i), messageSize.height*0.4, starSize.width, starSize.height);
            [innerMessage addSubview:starImage];
            
            [starImage release];
        }
        else
        {
            UIImageView *starImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"emptyStar.png"]];
            starImage.frame = CGRectMake(  starsXStart + (starSize.width*1.2*i), messageSize.height*0.4, starSize.width, starSize.height);
            [innerMessage addSubview:starImage];
            
            [starImage release];
        }

    }

    
  
    if(starsCount >=0)
    {
    
    resetButton = [self initButtonAttr:victoryXStart: messageSize.height*0.75 : buttonSize.width : buttonSize.height  :@"resetButton.png"];
        [innerMessage addSubview:resetButton];
        
    
    if(starsCount > 0)
    {
        nextLevelButton = [self initButtonAttr:victoryXStart + victorySize.width/2 - buttonSize.width/2: messageSize.height*0.75 : buttonSize.width : buttonSize.height  : @"runFastButton.png"];
        [innerMessage addSubview:nextLevelButton];
    }
    
    
    goToLevelsButton  = [self initButtonAttr:victoryXStart + victorySize.width - buttonSize.width: messageSize.height*0.75 : buttonSize.width : buttonSize.height  :@"goToLevelsButton.png"] ;
        [innerMessage addSubview:goToLevelsButton];

    

    }
    else if(starsCount <= -1)
    {
        
        if(starsCount == -3)
        {
            yesButton = [self initButtonAttr:victoryXStart: messageSize.height*0.75 : buttonSize.width*1.2 : buttonSize.height*1.2  :@"rateButton.png"];
            
            noButton = [self initButtonAttr:victoryXStart + victorySize.width - buttonSize.width*1.2: messageSize.height*0.75 : buttonSize.width*1.2 : buttonSize.height*1.2  :@"laterButton.png"];
        }
        else
        {
            yesButton = [self initButtonAttr:victoryXStart: messageSize.height*0.75 : buttonSize.width : buttonSize.height  :@"okButton.png"];
            
            noButton = [self initButtonAttr:victoryXStart + victorySize.width - buttonSize.width: messageSize.height*0.75 : buttonSize.width : buttonSize.height  :@"noButton.png"];

        }

    
        [innerMessage addSubview:yesButton];
        [innerMessage addSubview:noButton];
    }

    
    [innerMessage addSubview:victoryImage];
    
    [victoryImage release];


}
-(void) addMessage
{
    [viewReference addSubview:self];
}

-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height  : (NSString*) name
{
    UIButton *currentButton = [[UIButton alloc] initWithFrame:CGRectMake(x , y, width, height)];
    [currentButton setTitle:name forState:UIControlStateNormal ];
    [currentButton addTarget:self action:@selector(buttonsClick:) forControlEvents:UIControlEventTouchUpInside];
    [currentButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    currentButton.exclusiveTouch =YES;
    
    return currentButton;
}
-(void) buttonsClick : (id) sender
{
    [soundObject playMySoundFile:@"buttonSound"];
    [self removeFromSuperview];
    if((UIButton*)sender == resetButton)
        [[self delegate] resetGame];
    else if((UIButton*)sender == nextLevelButton)
        [[self delegate] goToNextLevel];
    else if((UIButton*)sender == goToLevelsButton)
        [[self delegate] levelsButtonHandler];
    else if((UIButton*)sender == noButton)
    {
        if(starsCount == -3)
            [[self delegate] handleGameRateSubmitted : false];
        
        [[self delegate] setPopUpMessageActivated ];
        [self removeFromSuperview];
    }
    else if((UIButton*)sender == yesButton)
    {
        if(starsCount == -2)
            [[self delegate] resetGame];
        else if(starsCount == -3)
        {
            [[self delegate] handleGameRateSubmitted : true];
            
            [[self delegate] setPopUpMessageActivated ];
            [self removeFromSuperview];
        }
        else
            [[self delegate] levelsButtonHandler];

    }
    [self release];
}
-(void) dealloc
{
    [innerMessage release];
    [resetButton release];
    [nextLevelButton release];
    [goToLevelsButton release];
    [noButton release];
    [yesButton release];
    [super dealloc];
}

@end
