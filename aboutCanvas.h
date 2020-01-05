//
//  aboutCanvas.h
//  BubbleGun
//
//  Created by amr hamdy on 7/16/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"
#import "menuCanvasAttr.h"
#import "soundEffectsHandler.h"

@interface aboutCanvas :  menuCanvasAttr
{
    
}

-(id) init : (UIView*)ref :   (int) screenWidth : (int) screenHeight :(soundEffectsHandler*) sound ;
-(void) addImage  : (int) screenHeight  :(int) screenWidth;
@end
