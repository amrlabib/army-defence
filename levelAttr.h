//
//  levelAttr.h
//  Army Defence
//
//  Created by amr hamdy on 10/8/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJIndex.h"

@interface levelAttr : NSObject
{
    int levelNumber;
    int wavesCount;
    int entranceCount;
    int startingCash;
    bool moveBlocks;
    NSMutableArray *startBlocks , *endBlocks;
}

@property int wavesCount , entranceCount , levelNumber , startingCash;
@property bool moveBlocks;
@property (nonatomic , retain) NSMutableArray * startBlocks , *endBlocks;

-(id) init : (int) level : (int) rows : (int) cols;
-(void) setAttributes : (int) rows : (int ) cols;
@end
