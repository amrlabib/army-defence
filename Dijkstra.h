//
//  Dijkstra.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/6/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJIndex.h"
#import "Shooter.h"
#import "Node.h"

@interface Dijkstra : NSObject
{
    NSMutableArray *finalPath;
    NSMutableArray *boardRef;
    
    
    
    
}

-(id) init : (NSMutableArray*) board : (IJIndex*) startIndex : (IJIndex*) endIndex;
-(void) initFinalPath  : (IJIndex*) startIndex;


-(void) setStartingNode  : (IJIndex*) startNode;
-(void) setNextNodes : (IJIndex*) current : (IJIndex*) next;
-(void) getFinalShortestPath;
-(IJIndex*) getMinWeight;


-(NSMutableArray*) getPathSequence : (IJIndex*) start : (IJIndex*) end;

-(int) getNumFromIJ : (IJIndex*) index ;
-(bool) trueIndex : (IJIndex*) index;



@end
