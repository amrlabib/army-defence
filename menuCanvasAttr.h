//
//  menuCanvasAttr.h
//  ArmyStrength
//
//  Created by amr hamdy on 9/29/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"
#import "soundEffectsHandler.h"

@interface menuCanvasAttr : UIView
{
    UIView *viewReference;
    UIButton *backButton;
    
    bool activated;
    
    soundEffectsHandler *soundR;
    
    
}
@property bool activated;




-(id) init : (UIView *)  ref : (int) screenWidth : (int) screenHeight : (soundEffectsHandler*) sound;
-(void) setBackground : (int)screenWidth : (int) screenHeight;
-(void) addBackButton : (int) screenHeight;
-(void) addToMenu;
-(void) removeFromMenu;

-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height  : (NSString*) name;
-(void) buttonClickHandler : (id) sender;



@end
