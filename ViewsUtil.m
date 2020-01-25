//
//  ViewsUtil.m
//  Army Defence Free
//
//  Created by Amr Labib on 24/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import "ViewsUtil.h"

@implementation ViewsUtil

+ (bool)isIpad {
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        return true;
    }
    return false;
}

+ (UIColor*) getScaledUIColorImage:(UIImage*) targetImage : (UIView *)targetView {
    UIGraphicsBeginImageContextWithOptions(targetView.frame.size, NO, 0.f);
    [targetImage drawInRect:CGRectMake(0.f, 0.f, targetView.frame.size.width, targetView.frame.size.height)];
    UIImage * resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return  [[UIColor alloc] initWithPatternImage: resultImage];
}

+ (UIColor *) getGreenBackground: (UIView *)targetView {
    NSString *greenBackground =  [[NSString alloc] initWithString: @"ipad-game-bg.jpg"];
    UIColor *background = [ViewsUtil getScaledUIColorImage:[UIImage imageNamed:greenBackground] : targetView];
    return background;
}

+ (UIView *) getViewBackgroundFromLaunchScreen: (UIView *)targetView {
    CGRect screenBounds = [[UIScreen mainScreen] bounds];
    
    int width = screenBounds.size.width;
    int height = screenBounds.size.height;
    
    UIStoryboard *menu = [UIStoryboard storyboardWithName: @"LaunchScreen" bundle:nil];
    UIViewController *menuViewController = [menu instantiateViewControllerWithIdentifier: @"backgroundStoryBoard"];
    menuViewController.view.frame = CGRectMake(0, 0, width, height);
    return menuViewController.view;
}

@end
