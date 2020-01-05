//
//  optionsCancas.h
//  ArmyStrength
//
//  Created by amr hamdy on 9/29/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "menuCanvasAttr.h"
#import "savedText.h"
#import "soundEffectsHandler.h"

@interface optionsCancas : menuCanvasAttr
{
    UIButton *soundButton , *star1 , *star2 , *star3 , *musicButton;
    savedText *savedTextRef;
    
    NSString *starURL;
    
    soundEffectsHandler *soundRef;
}
-(id) init : (UIView*)ref :   (int) screenWidth : (int) screenHeight :(soundEffectsHandler*) sound :  (savedText*) text ;
-(void) addTextAndButtons : (int) screenWidth : (int) screenHeight;
@end
