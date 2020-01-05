//
//  Tanks.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/2/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"
#import "IJIndex.h"

@interface Tank : NSObject//DrawableObject
{
    DrawableObject *objectShape;
    DrawableObject *lifeBarShape;
    
    
    double life  , maxLife;
    NSString *name;
    bool tankExist;
    
    IJIndex *currentNode;
    
    CGSize tankSize;
    
    int speed;
    
    int pathCounter;
    
    int killRevenue;
    
    
    NSMutableArray *tankPath;
        
}

@property (nonatomic , retain) NSMutableArray * tankPath;
@property (nonatomic , retain) IJIndex * currentNode;
@property (nonatomic , retain) DrawableObject *objectShape , *lifeBarShape;
@property CGSize tankSize;
@property int pathCounter , speed ,killRevenue ;
@property double life,maxLife;
@property (nonatomic , retain) NSString *name;

-(id) init : (UIView*) ref :  (int) x : (int) y : (int) i : (int) j  : (CGSize) size : (NSString*) tankType : (int) lifeMultiplier;
-(void) removeTank;
-(void) moveTank : (int) x : (int) y;
-(void) rotateTank : (int) degrees;


-(void) setLifeBarWidth;
-(void) setLifeSpeedAndKillRevenueValues : (NSString*) tankType : (int) lifeMultiplier;


@end
