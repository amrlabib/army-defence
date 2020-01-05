//
//  Dijkstra.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/6/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "Dijkstra.h"

@implementation Dijkstra



-(id) init : (NSMutableArray*) board : (IJIndex*) startIndex : (IJIndex*) endIndex
{
    finalPath = [[NSMutableArray alloc] init];

    
    boardRef = board;
    
    [self initFinalPath : startIndex];
    [self getFinalShortestPath];
    
    
    return self;
}
-(void) initFinalPath  : (IJIndex*) startIndex;
{
    
    int rows = (int)[boardRef count];
    int cols = (int)[boardRef[0] count];
    
    
    int count = 0;
    
    for(int i=0  ;i < rows ; i++)
    {
        for(int j=0 ; j<cols ; j++)
        {            
            finalPath[count] = [[Node alloc] init:  [[IJIndex alloc] init:i :j]    : [[IJIndex alloc] init : -1 : -1 ] :-1 ];
            count ++;
        }
    }
    
    [finalPath[[self getNumFromIJ:startIndex]] setWeight:1];
    
    [self setStartingNode : startIndex ];

}
-(void) setStartingNode  : (IJIndex*) startNode
{
    
    IJIndex *leftNode  = [[IJIndex alloc] init:startNode.i :startNode.j-1];
    IJIndex *rightNode = [[IJIndex alloc] init:startNode.i :startNode.j+1];
    IJIndex *upperNode = [[IJIndex alloc] init:startNode.i - 1 :startNode.j];
    IJIndex *lowerNode = [[IJIndex alloc] init:startNode.i + 1 :startNode.j];

    
    [self setNextNodes:startNode :leftNode];
    [self setNextNodes:startNode :rightNode];
    [self setNextNodes:startNode :upperNode];
    [self setNextNodes:startNode :lowerNode];
    
    
    [leftNode release];
    [rightNode release];
    [upperNode release];
    [lowerNode release];
    
}
-(void) setNextNodes : (IJIndex*) current : (IJIndex*) next
{
    if( [self trueIndex: next ] && ![boardRef[next.i][next.j] shooterExist ] )
    {
        if([finalPath[[self getNumFromIJ: next]]  currentWeight]  > [finalPath[[self getNumFromIJ: current]]  currentWeight] +1  || [finalPath[[self getNumFromIJ: next]]  currentWeight] == -1 )
        {
            [ finalPath[[self getNumFromIJ: next] ] setWeight:[finalPath[[self getNumFromIJ: current]]  currentWeight] +1];
            [ finalPath[[self getNumFromIJ: next] ] setLinkFrom:current];
        }
    }
}



-(void) getFinalShortestPath
{
    if([[self getMinWeight] i] != -1 && [[self getMinWeight] j] != -1)
    {
        [self getFinalShortestPath];
    }
}
-(IJIndex*) getMinWeight
{
    int cols = (int)[boardRef[0] count];

    
    
    int minWeight = 1000;
    IJIndex* minNodeIndex  = [[[IJIndex alloc] init:-1 :-1] autorelease];
    for(int i= cols ; i< finalPath.count  - cols ; i++)    /// skip the first and last rows
    {
        if([finalPath[i]  currentWeight] != -1  &&  [finalPath[i]  currentWeight]  < minWeight && ![finalPath[i] done])
        {
            minWeight = [finalPath[i] currentWeight];
            minNodeIndex =  [finalPath[i] nodeName];
        }
    }
    
    if(minWeight !=  1000)
    {
        [finalPath[[self getNumFromIJ:minNodeIndex]] setDone : true];
        [self setStartingNode: minNodeIndex];
    }
    
    return minNodeIndex;
}



-(NSMutableArray*) getPathSequence : (IJIndex*) start : (IJIndex*) end
{
    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
    
    bool noPath = false;
    
    IJIndex *tempIndex= [[IJIndex alloc] init:end.i : end.j ];//end;
    while((tempIndex.i != start.i  || tempIndex.j != start.j ) )
    {
        if(tempIndex !=nil && tempIndex.i !=-1 && tempIndex.j!=-1 )
        {
            [tempArray addObject:tempIndex];
            [tempIndex release];
        }
        else
        {
            noPath = true;
            break;
        }
        
        
        tempIndex =[[IJIndex alloc] init :  [finalPath[[self getNumFromIJ:tempIndex]] linkFrom].i : [finalPath[[self getNumFromIJ:tempIndex]] linkFrom].j  ] ;
        
    }
    IJIndex *startIndex = [[IJIndex alloc] init : start.i : start.j ] ;
    [tempArray addObject:startIndex ];
    [startIndex release];
    
    
    [tempIndex release];

    
    [tempArray autorelease];
    
    if(noPath)
       [tempArray  removeAllObjects];
    
    
    return tempArray;
}






-(bool) trueIndex : (IJIndex*) index
{
    if(index.i >= 0 && index.i <  boardRef.count && index.j >=0 && index.j < [boardRef[0] count])
        return true;
    else
        return false;
}
-(int) getNumFromIJ : (IJIndex*) index
{
    int cols =(int)[boardRef[0] count];
    
    return ( index.i * cols ) +  index.j;
}

-(void) dealloc
{
    int count = 0;
    int rows = (int)[boardRef count];
    int cols = (int)[boardRef[0] count];
    

    for(int i=0  ;i < rows ; i++)
    {
        for(int j=0 ; j<cols ; j++)
        {
            [finalPath[count] release];
            count ++;
        }
    }
    [finalPath release];
    
    [super dealloc];
}


@end
