//
//  Shooter.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/2/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "Shooter.h"

@implementation Shooter

@synthesize shooterExist , objectShape , dollarShape  , range , busyShooting , power , reloading,  name ,objectGunShape , cost;

-(id) init : (UIView *) ref : (int) x : (int) y : (CGSize) blockSize : (NSString*) shooterName
{
    name = shooterName;    
    
    viewReference  = ref;
    
    shooterExist = true;
  
    
    CGSize gunSize;
    gunSize.width = blockSize.width * 0.7;
    gunSize.height = blockSize.height * 0.7;

    
    
    if([shooterName rangeOfString:@"lectric" ].location == NSNotFound)
    {
        objectShape = [[DrawableObject alloc] init:ref : x :y : blockSize :[shooterName stringByAppendingString:@"Base.png" ]];
        
        objectGunShape = [[DrawableObject alloc] init:ref : (x + blockSize.width / 2) - gunSize.width*0.5   : (y + blockSize.height / 2) - gunSize.height*0.5   : gunSize :[shooterName stringByAppendingString:@"Gun.png" ]];
    }
    else
    {
        objectShape = [[DrawableObject alloc] init:ref : x :y : blockSize :[shooterName stringByAppendingString:@".png" ]];
        objectGunShape = [[DrawableObject alloc] init:ref : (x + blockSize.width / 2) - gunSize.width*0.5   : (y + blockSize.height / 2) - gunSize.height*0.5   : gunSize :[shooterName stringByAppendingString:@"whatever" ]];
    }
    
    
    
    [self setPowerRangeRateAndCostValues:shooterName : blockSize];

    
    
    
    CGSize circleSize ;
    circleSize.width = range;
    circleSize.height= range;

    rangeCircleShape = [[DrawableObject alloc] init:ref :  x + blockSize.width/2 - range/2 : y + blockSize.height/2 -range/2 : circleSize :@"rangeCircle.png"];
    [rangeCircleShape removeDrawableObject];

    
    CGSize dollarSize;
    dollarSize.width = blockSize.width * 0.6;
    dollarSize.height = blockSize.height*0.6;
    
    
    if( (int)ref.frame.size.width  -  x  - (int)blockSize.width*2 < 10 )
        dollarShape  =  [[DrawableObject alloc] init : ref : x  - range*0.25 : y + range*0.05: dollarSize : @"dollarWithPercent.png" ];
    else
        dollarShape  =  [[DrawableObject alloc] init : ref : x + range*0.4 : y + range*0.05: dollarSize : @"dollarWithPercent.png" ];

    
    [dollarShape removeDrawableObject ];
    
    
    
    busyShooting= false;
    reloading=  false;
    
    
    
    return self;
}
-(void) setPowerRangeRateAndCostValues : (NSString*) shooterType : (CGSize) blockSize
{
    power = 1;
    int tempRate = 3;
    if([shooterType isEqualToString:@"manShooter"])
    {
        rate = tempRate * 1;
        maxRate = tempRate * 1;
        
        range = blockSize.width * 3;
        power = 1;
        
        cost = 5;
    }
    else if([shooterType isEqualToString:@"singleArmShooter"])
    {
        rate  = tempRate * 2;
        maxRate = tempRate * 2;
        
        range = blockSize.width * 3.5;
        power = 4;
        
        cost = 15;
    }
    else if([shooterType isEqualToString:@"starShooter"])
    {
        rate  = tempRate * 3;
        maxRate = tempRate * 3;
        
        range = blockSize.width * 4.5;
        power = 9;
        
        cost = 25;
    }
    else if([shooterType isEqualToString:@"electricShooter"])
    {
        rate  = tempRate * 4;
        maxRate = tempRate * 4;
        
        range = blockSize.width * 5.5;
        power = 16;
        
        cost = 40;
    }
    else if([shooterType isEqualToString:@"strongElectricShooter"])
    {
        rate  = tempRate * 5;
        maxRate = tempRate * 5;
        
        range = blockSize.width * 6;
        power = 25;
        
        cost = 60;
    }
}
-(void) removeShooter
{
    shooterExist = false;
    [objectShape removeDrawableObject];
    [objectGunShape removeDrawableObject];
    
    if([rangeCircleShape.imageShape isDescendantOfView:viewReference])
    {
        [rangeCircleShape removeDrawableObject ];
        [dollarShape removeDrawableObject];
    }
}
-(void) addAndRemoveRangeCircle
{
    if([rangeCircleShape.imageShape isDescendantOfView:viewReference])
    {
        [rangeCircleShape removeDrawableObject];
        [dollarShape removeDrawableObject];
    }
    else
    {
        [rangeCircleShape addDrawableObject];
        [dollarShape addDrawableObject];
    }
}
-(void) updateRate
{    
    if(rate <=0 )
    {
        reloading = false;
        rate = maxRate;
    }
    else
    {
        rate--;
        reloading = true;
    }
}
-(void) dealloc
{
    [objectShape release];
    [objectGunShape release];
    [rangeCircleShape release];
    [dollarShape release];
    [name release];
    
    [super dealloc];
}
 
@end
