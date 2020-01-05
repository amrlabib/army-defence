//
//  bullet.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/18/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"

@interface bullet : NSObject
{
    DrawableObject *objectShape;
    DrawableObject *explosionObjectShape;
    UIView *viewReference;
    int xVar, yVar , xMouse, yMouse , prev_x , prev_y  , step ;
    int xTarget , yTarget;
    double m,b;
    bool done , dir;
    
    CGSize bulletSize;
    
    int xStart , yStart;
    
    
    int explosionTime;
}


@property (nonatomic , retain) UIView *viewReference;
@property int xVar, yVar , xMouse,yMouse , prev_x , prev_y   , step  ,explosionTime , xStart , yStart ;
@property double m,b;
@property bool done , dir;
@property (nonatomic , retain) NSString *bulletType;
@property (nonatomic , retain) DrawableObject *explosionObjectShape;


-(id) init:(int) initialXPosition : (int) initialYPosition : (int) xT : (int) yT :  (CGSize) bSize :(UIView *) ref : (NSString*) type : (NSString*) exType;
-(void) setBulletSize : (CGSize) bSize : (NSString*) bulletType;
-(void) rotateBullet;
- (void) initiateBulletDestination;
- (void) executeEquation;
- (void) getPathEquation : (double) x : (double) y : (double)mx  : (double)my;
- (void) setPrevVariables;


-(bool) checkBulletReachedDestination;


@end
