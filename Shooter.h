//
//  Shooter.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/2/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"

@interface Shooter : NSObject
{
    DrawableObject *objectShape , *objectGunShape , *dollarShape , *rangeCircleShape;
    UIView *viewReference;
    NSString *name;
    int range;
    UIImageView *gunShape;
    bool shooterExist;
    
    bool busyShooting , reloading;
    
    int power;
        
    
    int rate , maxRate;
    
    int cost;
    
    
}

@property (nonatomic , retain) DrawableObject *objectShape , *dollarShape , *objectGunShape;
@property bool shooterExist,busyShooting , reloading;
@property  int range , power , cost;
@property (nonatomic , retain) NSString *name;

-(id) init : (UIView *) ref : (int) x : (int) y : (CGSize) shapeSize : (NSString*) shooterName;
-(void) removeShooter;
-(void) addAndRemoveRangeCircle;

-(void) setPowerRangeRateAndCostValues : (NSString*) shooterType : (CGSize) blockSize;


-(void) updateRate;

@end
