//
//  tutorialClass.m
//  Army Defence
//
//  Created by amr hamdy on 11/6/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "tutorialClass.h"

@implementation tutorialClass



-(id) init :(UIView*) vRef : (int) sWidth : (int) sHeight
{
    
    screenWidth   = sWidth;
    screenHeight = sHeight;
    
    viewReference = vRef;
    
    CGSize handSize;
    handSize.width = screenWidth*0.13;
    handSize.height = screenWidth*0.13;
    
    if(screenWidth == 568)
        handShape = [[DrawableObject alloc] init: vRef : screenWidth*0.54  : screenHeight*0.92: handSize :@"hand.png" ];
    else
        handShape = [[DrawableObject alloc] init: vRef : screenWidth / 2  : screenHeight*0.92: handSize :@"hand.png" ];
    
    
    waitingTime = 0;
    
    [self initTutTimer];
    
    return self;
}
-(void) initTutTimer
{
    tutTimer = [NSTimer scheduledTimerWithTimeInterval: 0.01 target:self selector:@selector(timerTickingHandler) userInfo:nil repeats:YES];
}

-(void) timerTickingHandler
{
    int yStep = -2;
    int xStep = 0;
    
    int waitingTimeEnd = 10;
    
    if(waitingTime == 120)
    {
        CGSize handSize;
        handSize.width = screenHeight*0.25;
        handSize.height = screenHeight*0.25;
        
        
        [handShape imageShape].image = [UIImage imageNamed:@"hand.png"];
        
        if(screenWidth == 568)
            [handShape imageShape].frame = CGRectMake(screenWidth*0.54  , screenHeight*0.92, handSize.width, handSize.height);
        else
            [handShape imageShape].frame = CGRectMake(screenWidth / 2  , screenHeight*0.92, handSize.width, handSize.height);
        
        [handShape setYPosition:screenHeight*0.92];

        waitingTime++;
    }
    
    
    if(waitingTime > 120)
    {
        xStep = -1;
        waitingTimeEnd = 130;
    }
    
    

    
    if([handShape yPosition ] < screenHeight*0.88  && [handShape yPosition]+2 >   screenHeight*0.88)
        [handShape imageShape].image = [UIImage imageNamed:@"handTouch.png"];
    
    
    if([handShape yPosition ] < screenHeight*0.17 && waitingTime < waitingTimeEnd  )
    {
        waitingTime++;
        
        if(waitingTime == waitingTimeEnd)
        {
            [handShape imageShape].image = [UIImage imageNamed:@"handNoHand.png"];
        }
        return;
    }
    
    
    
    if([handShape yPosition ] < screenHeight*0.7 && waitingTime >= waitingTimeEnd )
    {
        waitingTime++;
        
        
        if(waitingTime == 250)
        {
            /*[tutTimer invalidate];
            tutTimer = NULL;
            
            [handShape removeDrawableObject];
            *///[[self tutObjectDelegateFunction] stopAndReleaseTut ];
            [self stop];
        }
        return;
    }

    [handShape moveDrawableObject:xStep : yStep];

    
}

-(void) dealloc
{
    if(tutTimer !=NULL)
    {
        [tutTimer invalidate];
        tutTimer = NULL;
    }
    [handShape release];
    
    [super dealloc];
}

-(void) stop
{
    if(tutTimer != NULL)
    {
        [tutTimer invalidate];
        tutTimer = NULL;
        [handShape removeDrawableObject];

    }
}

-(void) pause
{
    if(tutTimer != NULL)
    {
        [tutTimer invalidate];
        tutTimer = NULL;
    }
}
-(void) play
{
    if(tutTimer == NULL)
    {
        [self initTutTimer];
    }
}
@end
