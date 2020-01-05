//
//  popUpMessages.h
//  Army Defence
//
//  Created by amr hamdy on 10/17/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import  "soundEffectsHandler.h"

@protocol delegateFunctions <NSObject>
@required
-(void) resetGame;
-(void) goToNextLevel;
-(void) levelsButtonHandler;
-(void) setPopUpMessageActivated;
-(void) handleGameRateSubmitted : (bool) value;
@end


@interface popUpMessages : UIView
{
    
    UIView *viewReference;
    
    UIView *innerMessage;
    UIImageView *messageImage;
    CGSize messageSize;
    
    int starsCount;
    
    NSString *messageText;
    
    
    
    UIButton *resetButton;
    UIButton *nextLevelButton;
    UIButton *goToLevelsButton;
    UIButton *noButton;
    UIButton *yesButton;

    
    
    id <delegateFunctions> delegate;
    
    soundEffectsHandler *soundObject;
    
}

@property (retain) id delegate;


-(id) init : (UIView*) viewRef : (CGSize) screenSize : (NSString*) messageText : (int) sCount : (soundEffectsHandler*)sound;
-(void) addMessage;
-(void) addMessageAttributes ;
-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height  : (NSString*) name;

@end
