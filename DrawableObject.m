//
//  DrawableObject.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/1/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "DrawableObject.h"

#import <QuartzCore/CATransform3D.h>
#import <QuartzCore/CALayer.h>


@implementation DrawableObject


@synthesize viewReference  ,  imageSize , imageShape , xPosition , yPosition , rotation ;


-(id) init : (UIView *) ref : (int) x :(int) y : (CGSize) sizeRef : (NSString *) uri
{
    viewReference = ref;
    
    
    xPosition = x;
    yPosition = y;
    
    
    rotation = 0;
    
    imageSize = sizeRef;

    [self drawableShapeInit:uri];

    return self;
}

-(void) drawableShapeInit : (NSString *) uri
{
    imageShape =  [[UIImageView alloc]init];
    imageShape.frame = CGRectMake(xPosition, yPosition, imageSize.width  , imageSize.height);

    
    imageShape.image=[UIImage imageNamed:uri];
    imageShape.userInteractionEnabled = TRUE;
    
    
    NSRange isRange = [uri rangeOfString:@"Gun"];
    if(isRange.location != NSNotFound) {
        imageShape.layer.anchorPoint = CGPointMake(0.2, 0.5);
    }

    [self addDrawableObject];
}

-(void) moveDrawableObject : (int) xStep : (int) yStep 
{
    xPosition += xStep;
    yPosition += yStep;
    imageShape.frame = CGRectMake(xPosition, yPosition, imageSize.width, imageSize.height);
}

-(void) removeDrawableObject
{
    [imageShape removeFromSuperview];
}

-(void) addDrawableObject
{
    [viewReference addSubview:imageShape];
}
-(void) rotateDrawableObject : (int) degrees
{
    rotation += degrees;    // kanet  +=  mesh  =
    double radians = degrees * (M_PI / 180);
    imageShape.transform = CGAffineTransformMakeRotation(radians);
}
-(void) changeDrawableObject : (NSString*) uri
{
    [self imageShape].image = [UIImage imageNamed:uri];
}



-(void) dealloc
{
    [imageShape release];
    [super dealloc];
}





@end
