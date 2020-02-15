//
//  ViewsUtil.h
//  Army Defence Free
//
//  Created by Amr Labib on 24/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ViewsUtil : NSObject
+ (bool)isIpad;
+ (UIColor*) getScaledUIColorImage: (UIImage*)targetImage : (UIView *)targetView;
+ (UIColor *) getGreenBackground: (UIView *)targetView;
+ (UIView*) getViewBackgroundFromLaunchScreen;
@end

NS_ASSUME_NONNULL_END
