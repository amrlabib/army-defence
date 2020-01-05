//
//  BombView.m
//  Army Defence
//
//  Created by amr hamdy on 10/23/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "BombView.h"

@implementation BombView

@synthesize bomb1 , bomb2 , bomb3 , bomb4 , activated;

-(id) init : (UIView*) viewRef : (int) x :  (int) y : (int) width : (int) height : (int) money
{
    self = [super initWithFrame:CGRectMake(x, y - height*0.07, width, height)];
    [self setBackgroundColor: [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6]];
    
    viewReference = viewRef;

    self.userInteractionEnabled = false;
    self.layer.cornerRadius = height*0.3;
    self.layer.masksToBounds = YES;
    
    [self addBombWeapons];
    [self updateBombsImages:money];

    
    return self;
}

-(void) addBombWeapons
{
    CGSize bombWeaponSize;
    bombWeaponSize.width = self.frame.size.width * 0.2;
    bombWeaponSize.height = self.frame.size.width * 0.2;
    

    int xStart = self.frame.size.width/2 - bombWeaponSize.width*2.4 ;
    int yStart = self.frame.size.height/2 - bombWeaponSize.height/2;

    
    bomb1 = [[DrawableObject alloc] init:self :xStart :yStart :bombWeaponSize :@"bomb1Valid.png"];
    bomb2 = [[DrawableObject alloc] init:self :xStart + bombWeaponSize.width*1.1 : yStart :bombWeaponSize :@"bomb2Valid.png"];
    bomb3 = [[DrawableObject alloc] init:self :xStart + bombWeaponSize.width*2.2 :yStart  :bombWeaponSize :@"bomb3Valid.png"];
    bomb4 = [[DrawableObject alloc] init:self :xStart + bombWeaponSize.width*3.3 :yStart :bombWeaponSize :@"bomb4Valid.png"];

    
}
-(void) updateBombsImages : (int) currentMoney
{
    if(currentMoney >= 4)
    {
        [bomb1 imageShape].image = [UIImage imageNamed:@"bomb1Valid.png"];
        [bomb2 imageShape].image = [UIImage imageNamed:@"bomb2Valid.png"];
        [bomb3 imageShape].image = [UIImage imageNamed:@"bomb3Valid.png"];
        [bomb4 imageShape].image = [UIImage imageNamed:@"bomb4Valid.png"];
    }
    else if(currentMoney >= 3)
    {
        [bomb1 imageShape].image = [UIImage imageNamed:@"bomb1Valid.png"];
        [bomb2 imageShape].image = [UIImage imageNamed:@"bomb2Valid.png"];
        [bomb3 imageShape].image = [UIImage imageNamed:@"bomb3Valid.png"];
        [bomb4 imageShape].image = [UIImage imageNamed:@"bomb4Invalid.png"];
    }
    else if(currentMoney >= 2)
    {
        [bomb1 imageShape].image = [UIImage imageNamed:@"bomb1Valid.png"];
        [bomb2 imageShape].image = [UIImage imageNamed:@"bomb2Valid.png"];
        [bomb3 imageShape].image = [UIImage imageNamed:@"bomb3Invalid.png"];
        [bomb4 imageShape].image = [UIImage imageNamed:@"bomb4Invalid.png"];
    }
    else if(currentMoney >= 1)
    {
        [bomb1 imageShape].image = [UIImage imageNamed:@"bomb1Valid.png"];
        [bomb2 imageShape].image = [UIImage imageNamed:@"bomb2Invalid.png"];
        [bomb3 imageShape].image = [UIImage imageNamed:@"bomb3Invalid.png"];
        [bomb4 imageShape].image = [UIImage imageNamed:@"bomb4Invalid.png"];
    }
    else
    {
        [bomb1 imageShape].image = [UIImage imageNamed:@"bomb1Invalid.png"];
        [bomb2 imageShape].image = [UIImage imageNamed:@"bomb2Invalid.png"];
        [bomb3 imageShape].image = [UIImage imageNamed:@"bomb3Invalid.png"];
        [bomb4 imageShape].image = [UIImage imageNamed:@"bomb4Invalid.png"];
    }
}
-(void) show
{
    [viewReference addSubview:self];
}
-(void) hide
{
    [self removeFromSuperview];
}

-(void) dealloc
{
    [bomb1 release];
    [bomb2 release];
    [bomb3 release];
    [bomb4 release];
    [super dealloc];
}




@end
