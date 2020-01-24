//
//  LevelsViewController.h
//  Army Defence Free
//
//  Created by Amr Labib on 17/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "savedText.h"
#import "InAppPurchaseController.h"
#import "GameViewController.h"
#import "ViewsUtil.h"

NS_ASSUME_NONNULL_BEGIN

@interface LevelsViewController : UIViewController
{
    CGSize buttonsSize;
    savedText *savedTextRef;
    
    InAppPurchaseController *inAppPurchaseObj;
    int screenWidth , screenHeight;
}

@property (nonatomic, strong) soundEffectsHandler *soundRef;

-(id) initLevels;
-(void) addButtons ;
-(UIImage*) mergeImages : (NSString*) num : (int) levelStatus;
-(void) addSingleButton : (int) i : (int) j;
-(void) updateLevelButton : (int) l;
-(void) levelButtonClickHandler : (id) sender;
-(void) updateValuesInMainMenu;
@end

NS_ASSUME_NONNULL_END
