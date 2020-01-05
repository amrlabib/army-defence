//
//  levelAttr.m
//  Army Defence
//
//  Created by amr hamdy on 10/8/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "levelAttr.h"

@implementation levelAttr


@synthesize moveBlocks , wavesCount , levelNumber, entranceCount , startBlocks , endBlocks , startingCash;

-(id) init : (int) level : (int) rows : (int) cols
{
    levelNumber  = level;
    startBlocks = [[NSMutableArray alloc] init];
    endBlocks = [[NSMutableArray alloc] init];

    startingCash = 35; 

    
    [self setAttributes  :  rows : cols];

    return self;
}



-(void) setAttributes : (int) rows : (int ) cols
{
    
    if(levelNumber == 1 || levelNumber == 2 || levelNumber == 3 ||  levelNumber == 13 || levelNumber == 14 || levelNumber == 15)
    {
        startingCash = 35;
        entranceCount = 1;
        wavesCount = 30 * (levelNumber%3);
        if(levelNumber%3 == 0 )
            wavesCount = 30*3;
        
        moveBlocks  = false;
        
        [startBlocks addObject: [[IJIndex alloc] init : 2  : 0 ]];
        [endBlocks addObject: [[IJIndex alloc] init :  rows-3  : cols-1]];
    }
    else if(levelNumber == 4 || levelNumber == 5 || levelNumber == 6 || levelNumber == 16 || levelNumber == 17|| levelNumber == 18 )
    {
        startingCash = 45;

        entranceCount = 2;
        wavesCount = 30 * (levelNumber%3);
        if(levelNumber%3 == 0 )
            wavesCount = 30*3;
        
        
        moveBlocks  = false;
        
        [startBlocks addObject: [[IJIndex alloc] init : 2  : 0 ]];
        [endBlocks addObject: [[IJIndex alloc] init :  rows-3  : cols-1]];
        
        
        [startBlocks addObject : [[IJIndex alloc] init : 2  : cols-1 ]];
        [endBlocks  addObject:  [[IJIndex alloc] init :  rows-3  : 0]];
    }
    else if(levelNumber == 7 || levelNumber == 8 ||levelNumber == 9 || levelNumber == 19 || levelNumber == 20|| levelNumber == 21 )
    {
        startingCash = 55;

        
        entranceCount = 3;
        wavesCount = 30* (levelNumber%3);
        if(levelNumber%3 == 0 )
            wavesCount = 30*3;
        
        moveBlocks  = false;
        
        
        
        
        
        [startBlocks addObject: [[IJIndex alloc] init : 2  : 0 ]];
        [endBlocks addObject: [[IJIndex alloc] init :  rows-3  : cols-1]];
        
        [startBlocks addObject : [[IJIndex alloc] init : 2  : cols-1 ]];
        [endBlocks  addObject:  [[IJIndex alloc] init :  rows-3  : 0]];
        
        
        
        [startBlocks addObject: [[IJIndex alloc] init : (int)rows/2  : 0 ]];
        [endBlocks  addObject:  [[IJIndex alloc] init :  1  : (int)cols/2]];
        

    }
    else if(levelNumber == 10 || levelNumber == 11 ||levelNumber == 12 || levelNumber == 22 || levelNumber == 23|| levelNumber == 24 )
    {
        startingCash = 65;
        
        
        entranceCount = 4;
        wavesCount = 30* (levelNumber%3);
        if(levelNumber%3 == 0 )
            wavesCount = 30*3;
        
        moveBlocks  = false;
        
        
        [startBlocks addObject: [[IJIndex alloc] init : 2  : 0 ]];
        [endBlocks addObject: [[IJIndex alloc] init :  rows-3  : cols-1]];
        
        
        [startBlocks addObject : [[IJIndex alloc] init : 2  : cols-1 ]];
        [endBlocks  addObject:  [[IJIndex alloc] init :  rows-3  : 0]];
        
        
        [startBlocks addObject: [[IJIndex alloc] init : (int)rows/2  : 0 ]];
        [endBlocks  addObject:  [[IJIndex alloc] init :  1  : (int)cols/2]];
        
        
        [startBlocks addObject: [[IJIndex alloc] init : (int)rows/2  : cols-1 ]];
        [endBlocks addObject: [[IJIndex alloc] init :  rows-2 : (int)cols/2 - 1]];
        
        
    }
    
    
    
    
    if(levelNumber > 12)
    {
        startingCash += 20;
        moveBlocks = true;
    }
}
-(void) dealloc
{
    for(int i=0 ; i< startBlocks.count ; i++)
    {
        [startBlocks[i] release];
        [endBlocks[i] release];
    }
    
    [startBlocks release];
    [endBlocks release];
    [super dealloc];
}

@end
