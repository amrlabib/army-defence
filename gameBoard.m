//
//  gameBoard.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/3/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "gameBoard.h"

@implementation gameBoard

@synthesize  blockSize , xStart , yStart , board  ,bombBoard, cols , rows,endBlocksShapes ;//, startIndex , endIndex ;

-(id) init : (UIView*) ref : (int) screenWidth : (int) screenHeight 
{
    
    endBlocksShapes = [[NSMutableArray alloc] init];
    startBlocksShapes = [[NSMutableArray alloc ] init];
    
    
    
    gridView = [UIView new];
    gridBoard = [[NSMutableArray alloc] init];
    [gridView initWithFrame:CGRectMake(0, 0, screenWidth, screenHeight)];

    viewReference =  ref;
    
    
    cols =  16;
    rows =  12;
    
    blockSize.width =  (int)(screenWidth / cols);
    blockSize.height = (int)(screenHeight / rows);
    
    if(screenWidth == 480) //iphone 4s
    {
        cols =  15;
        rows = 10;
        blockSize.width =  (int)(screenWidth / cols);
        blockSize.height = (int)(screenHeight / rows);
    }
    else if(screenWidth == 568) //iphone 5s
    {
        cols = 17;
        rows = 10;
        blockSize.width = 32;
        blockSize.height = 32;
    }
    else if(screenWidth == 667)  //iphone 7
    {
        cols = 18;
        rows = 10;
        blockSize.width = 37;
        blockSize.height = 37;
    }
    else if(screenWidth == 736)  //iphone 7-plus
    {
        cols = 18;
        rows = 10;
        blockSize.width = 41;
        blockSize.height = 41;
    }
    
    
    xStart = (screenWidth  - (blockSize.width * cols)) / 2;
    yStart = (screenHeight - (blockSize.height * rows)) / 2;
    
    
    [self initBoard ];
    
    [self addWideLines : screenWidth];

    
    
    return self;
}
-(void) drawGatesShapes : (NSMutableArray*) startBlocks : (NSMutableArray*) endBlocks
{
    for(int k =0 ;k < startBlocks.count ; k++)
    {
        NSString *entrance = [[NSString alloc] initWithFormat:@"entranceShape%d.png" , k];
        NSString *exist = [[NSString alloc] initWithFormat:@"exitShape%d.png" , k];

        
        if(k == 0 || k == 2)
            [startBlocksShapes addObject:[[DrawableObject alloc] init:viewReference : blockSize.width * [startBlocks[k] j] - blockSize.width*0.35 : blockSize.height * [startBlocks[k] i] + yStart :blockSize :entrance]];
        else
            [startBlocksShapes addObject:[[DrawableObject alloc] init:viewReference : blockSize.width * [startBlocks[k] j] + blockSize.width*0.35  : blockSize.height * [startBlocks[k] i] + yStart :blockSize :entrance]];

        
        
        [endBlocksShapes addObject:[[DrawableObject alloc] init:viewReference :blockSize.width * [endBlocks[k] j] + xStart : blockSize.height * [endBlocks[k] i] + yStart :blockSize :exist] ];
        
        
        [entrance release];
        [exist release];
    }
    
    
    CGSize stickerSize;
    stickerSize.width = blockSize.width*0.6;
    stickerSize.height = blockSize.height*0.6;
}
-(void) initBoard
{
    
    board = [[NSMutableArray alloc] init];
    bombBoard = [[NSMutableArray alloc] init];
    

    
    CGSize shapesSize;
    shapesSize.width = (int)(blockSize.width*0.95);
    shapesSize.height = (int)(blockSize.height*0.95);
    
    
       
    for(int i=0  ; i < rows ; i++)
    {
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        [board addObject:tempArray];
        [tempArray  release];
        
        
        NSMutableArray *secondTempArray = [[NSMutableArray alloc]init ];
        [bombBoard addObject:secondTempArray];
        [secondTempArray release];
        
        
        NSMutableArray *thirdTempArray = [[NSMutableArray alloc]init ];
        [gridBoard addObject:thirdTempArray];
        [thirdTempArray release];

        
        
        for(int j=0  ;j< cols ; j++)
        {            
            if(i !=0 && i != rows-1)
                gridBoard [i][j] =[[DrawableObject alloc] init:gridView :blockSize.width * j + xStart : blockSize.height * i + yStart  :blockSize :@"gridCells.png"];
            
            
            board[i][j] =  [[Shooter alloc] init ];
            bombBoard[i][j] = [[Bomb alloc] init];
        }
        
    }
    
    [viewReference addSubview:gridView];
    [self hideAndShowGrid];
}

-(void) addWideLines  : (int ) screenWidth
{
    CGSize wideSize;
    wideSize.width = screenWidth;
    if(screenWidth == 768)
        wideSize.height = 3;
    else
        wideSize.height = 1;
        
    [[[DrawableObject alloc] init:viewReference :0 : blockSize.height * (rows-1) + yStart  :wideSize :@"wideLine.png"] autorelease];
    [[[DrawableObject alloc] init:viewReference :0 : blockSize.height * 1 + yStart - (int)wideSize.height  :wideSize :@"wideLine.png"] autorelease];
}
-(void) hideAndShowGrid
{
    if(gridView.hidden )
        gridView.hidden = false;
    else
        gridView.hidden = true;
}
-(bool) addShooterObject : (int) iIndex : (int) jIndex : (NSString*) shooterName
{
    CGSize shapesSize;
    shapesSize.width = (int)(blockSize.width*0.99);
    shapesSize.height = (int)(blockSize.height*0.99);
    
    
    int xStartInBlock = (int)((blockSize.width - shapesSize.width) / 2);
    int yStartInBlock = (int)((blockSize.height- shapesSize.height) / 2);
    
    
    if( ![board[iIndex][jIndex] shooterExist ])
    {
        [board[iIndex][jIndex] release];
        board[iIndex][jIndex] = [[Shooter alloc] init:viewReference : blockSize.width * jIndex + xStart + xStartInBlock :blockSize.height * iIndex + yStart + yStartInBlock : shapesSize : shooterName];
        
        return true;
    }
    else
        return false;
}
-(void) removeShooterObject : (int) iIndex : (int) jIndex
{
    [board[iIndex][jIndex] removeShooter];
    [board[iIndex][jIndex] release];

    board[iIndex][jIndex] = [[Shooter alloc] init];
}


-(bool) addBombObject : (int) iIndex : (int) jIndex : (NSString*) bombName
{
    CGSize shapesSize;
    shapesSize.width = (int)(blockSize.width*0.9);
    shapesSize.height = (int)(blockSize.height*0.9);
    
    
    int xStartInBlock = (int)((blockSize.width - shapesSize.width) / 2);
    int yStartInBlock = (int)((blockSize.height- shapesSize.height) / 2);
    
    if( ![bombBoard[iIndex][jIndex] bombExist ])
    {
        [bombBoard[iIndex][jIndex] release];
        bombBoard[iIndex][jIndex] = [[Bomb alloc] init:viewReference : blockSize.width * jIndex + xStart + xStartInBlock :blockSize.height * iIndex + yStart + yStartInBlock : shapesSize : bombName] ;
        
        return true;
    }
    else
        return false;
    
}
-(void) removeBombObject : (int) iIndex : (int) jIndex
{
    [bombBoard[iIndex][jIndex] removeBomb];
    [bombBoard[iIndex][jIndex] release];
    bombBoard[iIndex][jIndex] = [[Bomb alloc] init];
}


-(void) dealloc
{    
    for(int i=0 ;  i < rows ; i++)
    {
        for(int j=0 ; j<  cols ; j++)
        {
            [board[i][j] release];
            [bombBoard[i][j] release];
            
            if(i !=0 && i != rows-1)
                [gridBoard[i][j] release];
        }
    }
    [gridBoard release];
    [board release];
    [bombBoard release];
    for(int i=0  ;i < endBlocksShapes.count ; i++)
    {
        [startBlocksShapes[i] release];
        [endBlocksShapes[i] release];
    }
    
    [startBlocksShapes release];
    [endBlocksShapes release];
    
   
    
    [gridView release];
    
    
    [super dealloc];
}

@end
