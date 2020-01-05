//
//  Node.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/7/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "Node.h"

@implementation Node


@synthesize currentWeight , nodeName,  linkFrom , done;

-(id) init : (IJIndex*) name : (IJIndex*) from : (int) weight
{
    nodeName = name;
    linkFrom = from;
    currentWeight = weight;
    
    return self;
}

-(void) setWeight : (int) value
{
    currentWeight = value;
}
-(void) dealloc
{
    [nodeName release];
    [linkFrom release];
    
    [super dealloc];
}
@end
