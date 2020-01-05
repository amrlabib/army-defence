//
//  ImageNumber.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/21/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "ImageNumber.h"

@implementation ImageNumber




-(id) init : (int) len : (int) xStart : (int) yStart : (UIView*) ref : (CGSize) size ;//: (bool )setLeftZ
{
    ImagesArray = [[NSMutableArray alloc] init];
    
    viewReference = ref;
    numberSize = size;
    length = len;
    
    
    [self addImagesToArray :xStart :yStart];
    
    return self;
}

-(void) addImagesToArray :  (int) xStart : (int) yStart
{
    int xStep = numberSize.width*0.9;
    int currentX = xStart;

    for(int i=0 ; i< length ; i++)
    {
        ImagesArray[i] = [[DrawableObject alloc] init:viewReference : currentX :yStart :numberSize :@"0.png" ] ;
        currentX += xStep;
    }
}
-(bool) updateNumberValue : (int) currentNumber
{
    NSString *stringNumber = [[NSString alloc] initWithFormat:@"%d" , currentNumber];
    int count = (int)[stringNumber length]-1;

    if(  count+1 >  length || currentNumber < 0)
    {
        [stringNumber release];
        return false;
    }
    else
    {
        for(int i=length-1 ; i >=0  ; i-- )
        {
            NSString *uri = [[NSString alloc] initWithFormat:@"0.png"];
            if(count >=0)
            {
                [uri release];
                uri = [[NSString alloc] initWithFormat:@"%c.png" ,   [stringNumber characterAtIndex:count]  ];
            }

            [[[ImagesArray objectAtIndex:i] imageShape] setImage:  [UIImage imageNamed:uri] ] ;
            
            count--;
            [uri release];
        }
        [stringNumber release];
        return true;
    }
}
-(void) dealloc
{
    for(int i=0 ; i< length ; i++)
    {
        [ImagesArray[i] release];
    }
    
    [ImagesArray release];
    [super dealloc];
}




@end
