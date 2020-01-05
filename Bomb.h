//
//  Bomb.h
//  Army Defence
//
//  Created by amr hamdy on 10/23/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"

@interface Bomb : NSObject
{
    DrawableObject *bombShape;
    DrawableObject *explosionShape;
    UIView *viewReference;
    NSString *bombName;
    bool bombExist;
    int power;
    int cost;
    
    NSTimer *explosionTimer;
    int explosionCounter;
    
    
}

@property bool bombExist;
@property int cost , power;


-(id) init : (UIView *) ref : (int) x : (int) y : (CGSize) blockSize : (NSString*) bName;
-(void) setBombPower;
-(void) removeBomb;
-(void) showExplosion;
-(void) hideExplosion;

@end
