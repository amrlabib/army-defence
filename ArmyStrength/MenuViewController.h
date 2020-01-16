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
    UIView *viewReference;
    
    
    
    DrawableObject *background;
    DrawableObject *animationImage1 , *animationImage2 , *animationImage3;
    UIButton *playButton , *optionsButton , *helpButton , *aboutButton , *rateButton , *moreButton , *buyButton;
    
    bool activated;
    int touchingButton;
    
    
    
    levelsCanvas *levelsObject;
    optionsCancas *optionsObject;
    aboutCanvas *aboutObject;
    
    
    
    
    CGSize screenSize;
    
    soundEffectsHandler *soundObject;
    
    savedText *saveTextObject;
    
    bool soundEnabled , musicEnabled;
    
    
    

}

@property (nonatomic , retain) DrawableObject *background;
@property (nonatomic , retain) UIButton *playButton , *optionsButton , *helpButton , *aboutButton;
@property bool activated;



-(id) initMenu;
-(void) addButtons ;
-(void) addMainMenu;
-(void) removeMainMenu;


-(void) addAnimationImages;

-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height  : (NSString*) name;
-(void) buttonClickHandler : (id) sender;

@end

NS_ASSUME_NONNULL_END
