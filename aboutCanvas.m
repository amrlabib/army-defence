//
//  aboutCanvas.m
//  BubbleGun
//
//  Created by amr hamdy on 7/16/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "aboutCanvas.h"

@implementation aboutCanvas


-(id) init : (UIView*)ref :   (int) screenWidth : (int) screenHeight   : (soundEffectsHandler*)sound
{
    self  = [super init:ref :screenWidth :screenHeight : sound ];
    [self addImage : screenHeight : screenWidth];
    return self;
}

-(void) addImage  : (int) screenHeight  :(int) screenWidth
{
    CGSize imageSize;
    imageSize.width = screenWidth*0.4;
    imageSize.height = screenWidth*0.4;
    
    UIImageView *aboutImage = [[UIImageView alloc]init];
    aboutImage.frame = CGRectMake(screenWidth/2 - imageSize.width/2 , screenHeight/2 - imageSize.height*0.4, imageSize.width, imageSize.height);
    aboutImage.image=[UIImage imageNamed:@"aboutText.png"];
    
    [self addSubview:aboutImage];
    
}



@end
