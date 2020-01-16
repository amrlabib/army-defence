//
//  MenuViewController.h
//  Army Defence Free
//
//  Created by Amr Labib on 16/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawableObject.h"

#import "aboutCanvas.h"
#import "optionsCancas.h"
#import "levelsCanvas.h"
#import "soundEffectsHandler.h"
#import "savedText.h"
#import "bullet.h"

NS_ASSUME_NONNULL_BEGIN

@interface MenuViewController : UIViewController
{
    CGSize screenSize;
    soundEffectsHandler *soundObject;
    savedText *saveTextObject;
    bool soundEnabled , musicEnabled;
}
@property bool activated;
-(id) initMenu;

@end

NS_ASSUME_NONNULL_END
