//
//  ImageNumber.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/21/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"

@interface ImageNumber : NSObject
{
    UIView *viewReference;
    NSMutableArray *ImagesArray;
    int length;
    CGSize numberSize;
    
}

-(id) init : (int) len : (int) xStart : (int) yStart : (UIView*) ref : (CGSize) size ;
-(void) addImagesToArray :  (int) xStart : (int) yStart;
-(bool) updateNumberValue : (int) currentNumber;



@end
