//
//  Wave.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/8/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJIndex.h"
#import "Tank.h"

@interface Wave : NSObject
{
    NSMutableArray *tanksArray , *initialPathArray;
    UIView *viewReference;
    CGSize boardBlockSize;
    
    IJIndex *startBlockIndex ,  *endBlockIndex;
    
    int screenWidth;
    int passedTanks;
    
    
    int waveDifficulty;
}

@property (nonatomic , retain) NSMutableArray *tanksArray;
@property int passedTanks;
@property (nonatomic , retain) IJIndex *startBlockIndex , *endBlockIndex;
@property (nonatomic , retain) NSMutableArray *initialPathArray;

-(id) init : (UIView*) ref : (NSMutableArray*) pathRef : (CGSize) blockSize :  (IJIndex*) startIndex :  (IJIndex*) endIndex : (int) waveNumber : (int)sWidth  : (int) diff;
-(NSString*) getTankNameFromNumber : (int) number;

-(void) addTanksToWave : (CGSize) blockSize : (double) waveNumber;
//-(void) setInitialPath : (NSMutableArray*) path;
//-(void) moveTanks : (int) screenWidth;
-(bool) moveTheTank : (int) i : (int) rightEnd: (int) xStart ;
@end
