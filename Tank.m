//
//  Tanks.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/2/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "Tank.h"

@implementation Tank


@synthesize currentNode , objectShape , pathCounter , life ,maxLife  ,tankSize ,speed  , killRevenue , tankPath , lifeBarShape , name;

-(id) init : (UIView*) ref :  (int) x : (int) y : (int) i : (int) j  : (CGSize) blockSize : (NSString*) tankType : (int) lifeMultiplier;
{
    pathCounter=0;
    
    tankExist = true;
    
    name = tankType;
    
    
    currentNode = [[IJIndex alloc] init];
    currentNode.i = i;
    currentNode.j = j;
    
    tankSize.width = blockSize.width * 0.9;
    tankSize.height = blockSize.height * 0.9;
    
    
    CGSize lifeBarSize;
    lifeBarSize.width  = tankSize.width* 0.7;
    lifeBarSize.height = tankSize.height *0.1;

    
    
    objectShape = [[DrawableObject alloc] init:ref : x : y : tankSize :tankType];
    lifeBarShape = [[DrawableObject alloc] init:ref : x + blockSize.width * 0.15  : y - lifeBarSize.height  - 4   : lifeBarSize :@"life.png"];
    
    
    [self setLifeSpeedAndKillRevenueValues: tankType : lifeMultiplier];
        
    
    return self;
}
-(void) removeTank
{
    tankExist = false;
    [objectShape removeDrawableObject];
    [lifeBarShape removeDrawableObject];
    
}
-(void) moveTank : (int) x : (int) y
{
    [objectShape moveDrawableObject:x :y];
    
    [lifeBarShape moveDrawableObject:x :y];
}
-(void) rotateTank : (int) degrees
{
    [objectShape rotateDrawableObject:degrees];
}
-(void) setLifeBarWidth
{
    CGSize newSize ;
    newSize.width = (life  / maxLife) * (tankSize.width*0.7) ;
    newSize.height = tankSize.height * 0.1;
    [lifeBarShape setImageSize:newSize];
}
-(void) setLifeSpeedAndKillRevenueValues : (NSString*) tankType : (int) lifeMultiplier
{
    int tempLife = 3 * lifeMultiplier; //5
    int tempSpeed = tankSize.width * 0.1;
    if( [tankType isEqualToString:@"motorBike.png"] )
    {
        life = tempLife * 1;
        maxLife = tempLife * 1;
        speed = tempSpeed;
        
        killRevenue = 1;
    }
    else if( [tankType isEqualToString:@"newHummer.png"] )
    {
        life = tempLife * 6;
        maxLife = tempLife * 6;
        speed = tempSpeed;
        
        killRevenue = 2;

    }
    else if( [tankType isEqualToString:@"tank.png"] )
    {
        life = tempLife * 12;
        maxLife = tempLife * 12;
        speed = tempSpeed;
        
        killRevenue = 3;

    }
    else if( [tankType isEqualToString:@"apache.png"] )
    {
        life = tempLife * 24;
        maxLife = tempLife * 24;
        speed = tempSpeed;
        
        killRevenue = 4;

    }
    else if( [tankType isEqualToString:@"plane.png"] )
    {
        life = tempLife * 48;
        maxLife = tempLife * 48;
        speed = tempSpeed;
        
        killRevenue = 5;

    }
    
}
-(void) dealloc
{
    [currentNode release];
    [objectShape release];
    [lifeBarShape release];
    [name release];
    [tankPath release];

    [super dealloc];
}



@end
