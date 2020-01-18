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

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initGame];
}

-(void) initGame {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    CGSize windowBounds;
    windowBounds.width  =  screenBounds.size.width;
    windowBounds.height = screenBounds.size.height;
        
    savedTextRef = [[savedText alloc] init];
    
    currentGame = [[gameObject alloc] init: self.view :  windowBounds : savedTextRef  : _soundRef];
    [currentGame setGameObjectDelegate: self];
    [currentGame initializeAttributes : _levelNumber];
    [self.view addSubview: currentGame];
}


@end
