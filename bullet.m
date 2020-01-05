//
//  bullet.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/18/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "bullet.h"

@implementation bullet
@synthesize viewReference  , xVar , yVar , xMouse , yMouse , prev_x , prev_y  , step , bulletType , m , b, done , dir , explosionTime,explosionObjectShape , xStart , yStart;


-(id) init:(int) initialXPosition : (int) initialYPosition : (int) xT : (int) yT :  (CGSize) bSize :(UIView *) ref : (NSString*) type : (NSString*) exType
{
    viewReference = ref;
    
    
    xStart = initialXPosition;
    yStart = initialYPosition;
    
    
    prev_x = xVar;
    prev_y = yVar;
    
    m = b = 0;
    dir = true;
    done = false;
    xVar = initialXPosition;
    yVar = initialYPosition ;
    step = 1;
    
    xTarget = xT;
    yTarget = yT;
    
    bulletType = type;
    
    
    [self setBulletSize : bSize : bulletType];


    
    objectShape = [[DrawableObject alloc] init:ref : initialXPosition : initialYPosition : bulletSize : bulletType];
    

    CGSize explosionSize;
    explosionSize.width = bSize.width *0.8;
    explosionSize.height = bSize.height *0.8;

    explosionObjectShape = [[DrawableObject alloc] init:ref : xTarget - (bSize.width * 0.35) : yTarget - (bSize.height * 0.35) : explosionSize : exType];
    [explosionObjectShape removeDrawableObject];

    
   
    
    
    
    [self initiateBulletDestination];
    
    
    explosionTime = 3;
    

    return self;
}

-(void) setBulletSize : (CGSize) bSize : (NSString*) bType
{
    if([bType isEqualToString:@"bullet1.png" ])
    {
        bulletSize.width = bSize.width * 0.05;
        bulletSize.height  =  bulletSize.width;
    }
    else if([bType isEqualToString:@"bullet2.png" ])
    {
        bulletSize.width = bSize.width * 0.2;
        bulletSize.height  =  bulletSize.width;
    }
    else if([bType isEqualToString:@"bullet3.png" ])
    {
        bulletSize.width = bSize.width * 0.3;
        bulletSize.height  =  bulletSize.width;
    }
}

-(void) rotateBullet
{
    double x = xVar - xTarget ;
    double y = yVar - yTarget ;
    double degrees = 360 - ( (atan2( x,y) * (180 / M_PI) ) + 90 );
    
    [objectShape rotateDrawableObject:degrees];
}


- (void) initiateBulletDestination
{
    step  = 20;
   
    
    xMouse = xTarget;
    yMouse = yTarget;
    
    [self getPathEquation : xVar : yVar : xMouse : yMouse];
    if (!done)
    {
        done = true;
    }
}

- (void) executeEquation
{
    if (step == 0)
    {
        yVar -= 8;
    }
    else
    {
        xVar = (dir) ? (xVar + step) : (xVar - step);
        double y_Axis = m * xVar + b;
        yVar = y_Axis;
    }
    
    
    if (  !isnan(yVar) && !isnan(yVar) && !isnan(xVar) && !isnan(xVar) && !isnan(yVar)     )
    {
        objectShape.imageShape.frame = CGRectMake(xVar, yVar, bulletSize.width ,bulletSize.height);
    }
}

- (void) getPathEquation : (double) x : (double) y : (double)mx  : (double)my
{
    if (mx >= x) dir = true;
    else if (mx < x) dir = false;
    
    m = (y - my) / (x - mx);
    b = (y - m * x);
}

- (void) setPrevVariables
{
    prev_x = xVar;
    prev_y = yVar;
}

-(bool) checkBulletReachedDestination
{
    bool result = false;
    
    if(xVar <= xTarget && prev_x >= xTarget)
        result =  true;
    else if(xVar >= xTarget && prev_x <= xTarget)
        result =  true;
    
    if(yVar <= yTarget && prev_y >= yTarget)
        result =  true;
    else if(yVar >= yTarget && prev_y <= yTarget)
        result =  true;
    
    if(result)
    {
        [objectShape removeDrawableObject];
        [explosionObjectShape addDrawableObject];
        explosionTime--;
    }
    

    
    return result;
}
-(void) dealloc
{
    [objectShape release];
    [explosionObjectShape release];
    [super dealloc];
}

@end
