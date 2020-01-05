//
//  DrawableObject.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/1/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DrawableObject :NSObject
{
    UIImageView *imageShape;
    UIView *viewReference;
    int xPosition , yPosition;
    CGSize imageSize;
    int rotation;
    
}

@property (nonatomic , retain) UIView* viewReference;
@property CGSize imageSize;
@property (nonatomic , retain) UIImageView *imageShape;
@property int xPosition , yPosition , rotation;



-(id) init : (UIView *) ref : (int) x :(int) y : (CGSize) sizeRef : (NSString *) uri;
-(void) drawableShapeInit : (NSString *) uri;
-(void) moveDrawableObject : (int) x : (int) y;
-(void) removeDrawableObject;
-(void) addDrawableObject;
-(void) rotateDrawableObject : (int) degrees;

@end
