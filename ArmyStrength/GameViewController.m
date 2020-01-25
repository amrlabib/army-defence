//
//  GameViewController.m
//  Army Defence Free
//
//  Created by Amr Labib on 18/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import "GameViewController.h"

@interface GameViewController ()

@end

@implementation GameViewController

@synthesize updateLevelDelegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGame];
}

-(void) initGame {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    CGSize windowBounds;
    windowBounds.width  =  screenBounds.size.width;
    windowBounds.height = screenBounds.size.height;
        
    currentGame = [[gameObject alloc] init: self.view :  windowBounds : _savedTextRef  : _soundRef];
    [currentGame setGameObjectDelegate: self];
    [currentGame initializeAttributes : _levelNumber];
    [self.view addSubview: currentGame];
}

-(void) updateLevelButton : (int) l {
    [[self updateLevelDelegate] updateLevelButton:l];
}


@end
