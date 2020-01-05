//
//  BombView.h
//  Army Defence
//
//  Created by amr hamdy on 10/23/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"
#import <QuartzCore/QuartzCore.h>

@interface BombView : UIView
{
    DrawableObject *bomb1,*bomb2,*bomb3 ,*bomb4;
    
    UIView *viewReference;
    
    bool activated;
}
@property (nonatomic, retain) DrawableObject *bomb1 , *bomb2 , *bomb3 , *bomb4;
@property bool activated;

-(id) init : (UIView*) viewRef : (int) x :  (int) y : (int) width : (int) height : (int) money;
-(void) addBombWeapons;
-(void) updateBombsImages : (int) currentMoney;
-(void) show;
-(void) hide;
-(void) dealloc;
@end
