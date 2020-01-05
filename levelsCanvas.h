//
//  levelsCanvas.h
//  Army Defence
//
//  Created by amr hamdy on 10/10/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "menuCanvasAttr.h"
#import "gameObject.h"
#import "savedText.h"
#import "InAppPurchaseController.h"

@interface levelsCanvas : menuCanvasAttr <UIApplicationDelegate, gameObjectDelegateFunctions>

{
    CGSize buttonsSize;
    gameObject *currentGame;
    
    
    savedText *savedTextRef;
    
    InAppPurchaseController *inAppPurchaseObj;
    
    
    int screenWidth , screenHeight;
    
    
    soundEffectsHandler *soundObject;
    
}

-(id) init : (UIView*)ref :   (int) screenWidth : (int) screenHeight : (soundEffectsHandler*) sound : (savedText*) text;
-(void) addButtons ;
-(UIImage*) mergeImages : (NSString*) num : (int) levelStatus;
-(void) addSingleButton : (int) i : (int) j;
-(void) updateLevelButton : (int) l;
-(void) levelButtonClickHandler : (id) sender;
-(void) updateValuesInMainMenu;
@end
