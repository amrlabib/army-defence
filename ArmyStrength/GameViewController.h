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

@protocol levelObjectDelegateFunctions <NSObject>
@required
-(void) updateLevelButton : (int) l;
@end


@interface GameViewController : UIViewController <UIApplicationDelegate>
{
    gameObject *currentGame;
}

@property (nonatomic, strong) soundEffectsHandler *soundRef;
@property (nonatomic, strong) savedText *savedTextRef;
@property int levelNumber;

@property  (retain) id updateLevelDelegate;

-(void) updateLevelButton : (int) l;

@end

NS_ASSUME_NONNULL_END
