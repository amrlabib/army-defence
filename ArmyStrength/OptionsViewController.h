//
//  OptionsViewController.h
//  Army Defence Free
//
//  Created by Amr Labib on 17/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "savedText.h"
#import "soundEffectsHandler.h"

NS_ASSUME_NONNULL_BEGIN

@interface OptionsViewController : UIViewController
{
    UIButton *soundButton , *star1 , *star2 , *star3 , *musicButton;
    savedText *savedTextRef;
    
    NSString *starURL;
}

@property (nonatomic, strong) soundEffectsHandler *soundRef;
@property (nonatomic, strong) NSString *recipeName;

-(id) initOptions;
-(void) addTextAndButtons : (int) screenWidth : (int) screenHeight;
@end

NS_ASSUME_NONNULL_END
