//
//  Node.h
//  ArmyStrength
//
//  Created by amr hamdy on 8/7/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IJIndex.h"

@interface Node : NSObject
{
    IJIndex *nodeName;
    IJIndex *linkFrom;
    bool done;
    int currentWeight;
    
}

@property (nonatomic , retain) IJIndex *nodeName , *linkFrom;
@property int currentWeight;
@property bool done;


-(id) init : (IJIndex*) name : (IJIndex*) from : (int) weight;
-(void) setWeight : (int) value;


@end
