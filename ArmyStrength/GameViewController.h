//
//  GameViewController.h
//  Army Defence Free
//
//  Created by Amr Labib on 18/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "gameObject.h"

NS_ASSUME_NONNULL_BEGIN

@interface GameViewController : UIViewController
{
    gameObject *currentGame;
    savedText *savedTextRef;
}

@property (nonatomic, strong) soundEffectsHandler *soundRef;
@property int levelNumber;

@end

NS_ASSUME_NONNULL_END
