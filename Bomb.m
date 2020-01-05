//
//  Bomb.m
//  Army Defence
//
//  Created by amr hamdy on 10/23/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "Bomb.h"

@implementation Bomb

@synthesize  bombExist , cost , power;

-(id) init : (UIView *) ref : (int) x : (int) y : (CGSize) blockSize : (NSString*) bName
{
    viewReference = ref;
    bombName = bName;
    
    bombExist = true;
    
    CGSize bombSize;
    bombSize.width = blockSize.width*0.7;
    bombSize.height = blockSize.height*0.7;
    
    
    int xStart = x + blockSize.width/2 - bombSize.width/2;
    int yStart = y + blockSize.height/2 - bombSize.height/2;
    
    bombShape = [[DrawableObject alloc] init:viewReference :xStart :yStart : bombSize :[bombName stringByAppendingString:@".png"]];
    explosionShape = [[DrawableObject alloc] init:viewReference :xStart : yStart : bombSize :@"bombExplosion4.png"];
    [explosionShape removeDrawableObject];
    
    
    
    cost = [[bName substringFromIndex:bName.length-1] intValue];
    
    [self setBombPower ];
    
    explosionCounter  =0;
    
    return self;
}
-(void) setBombPower
{
    int tempPower = 10;
    if([bombName isEqualToString:@"bomb1"])
        power = tempPower*1;
    else if([bombName isEqualToString:@"bomb2"])
        power = tempPower *2;
    else if([bombName isEqualToString:@"bomb3"])
        power = tempPower *3;
    else if([bombName isEqualToString:@"bomb4"])
        power = tempPower *4;
}
-(void) removeBomb
{
    bombExist = false;
    [bombShape removeDrawableObject];
}
-(void) showExplosion
{
    [explosionShape addDrawableObject];
    [self initExplosionTimer];
}
-(void) hideExplosion
{
    [explosionShape removeDrawableObject];
}

-(void) initExplosionTimer
{
    explosionTimer= [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(timerTickingHandler) userInfo:nil repeats:YES];
}
-(void) timerTickingHandler
{
    explosionCounter++;
    if(explosionCounter >= 3)
    {
        [explosionTimer invalidate];
        explosionTimer = NULL;
        [self hideExplosion];
    }
}
-(void) dealloc
{
    [bombShape release];
    [explosionShape release];
    
    [super dealloc];
}
@end
