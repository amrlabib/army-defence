//
//  gameBoard.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/3/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJIndex.h"
#import "Shooter.h"
#import "Bomb.h"

@interface gameBoard : NSObject
{
    UIView *viewReference;
    UIView *gridView;
    NSMutableArray *board;
    NSMutableArray *bombBoard;
    NSMutableArray *gridBoard;
    
    CGSize blockSize;
    double rows , cols;
    // int xStart , yStart;
    
    
    NSMutableArray *endBlocksShapes;
    NSMutableArray *startBlocksShapes;

    
    
}

@property CGSize blockSize;
@property int xStart, yStart ;
@property double cols ,rows;
@property (nonatomic , retain) NSMutableArray *board ,*bombBoard , *endBlocksShapes;


-(id) init : (UIView*) ref : (int) screenWidth : (int) screenHeight  : (int) xMargin : (int) yMargin ;
-(void) drawGatesShapes : (NSMutableArray*) startBlocks : (NSMutableArray*) endBlocks ;
-(void) addWideLines :(int) screenWidth;
-(bool) addShooterObject : (int) iIndex : (int) jIndex : (NSString*) shooterName;
-(void) initBoard;
-(void) hideAndShowGrid;
-(void) removeShooterObject : (int) iIndex : (int) jIndex;


-(bool) addBombObject : (int) iIndex : (int) jIndex : (NSString*) bombName;
-(void) removeBombObject : (int) iIndex : (int) jIndex;

-(void) dealloc;
@end
