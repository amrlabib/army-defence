//
//  tutorialClass.h
//  Army Defence
//
//  Created by amr hamdy on 11/6/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DrawableObject.h"



@interface tutorialClass : NSObject
{
    DrawableObject *handShape;
    bool tutRunning;
    NSTimer *tutTimer;
    
    UIView *viewReference;
    
    int screenHeight;
    int screenWidth;
    
    int waitingTime;
    
    


}


-(id) init :(UIView*) vRef : (int) screenWidth : (int) screenHeight;
-(void) stop;
-(void) initTutTimer;
-(void) pause;
-(void) play;

@end
