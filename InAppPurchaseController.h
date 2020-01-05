//
//  InAppPurchaseController.h
//  myOpenGlCode
//
//  Created by amr hamdy on 9/13/14.
//  Copyright (c) 2014 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <StoreKit/StoreKit.h>
#import <UIKit/UIKit.h>
#import "Reachability.h"


@protocol inAppPurchaseDelegateFunction <NSObject>
@required
-(void) updateValuesInMainMenu;
@end



@interface InAppPurchaseController : NSObject < SKProductsRequestDelegate,SKPaymentTransactionObserver>
{
    SKProductsRequest *productsRequest;
    NSArray *validProducts;
    IBOutlet UIButton *purchaseButton;
    UIActivityIndicatorView *activityIndicatorView;
    IBOutlet UILabel *productTitleLabel;
    IBOutlet UILabel *productDescriptionLabel;
    IBOutlet UILabel *productPriceLabel;
    
    
    NSString *productId;
    
    
    
    
    id <inAppPurchaseDelegateFunction> inAppPurchaseDelegate;
    

    bool alreadingMakingPurchase;
    bool productRestored;

}
@property (nonatomic , retain)  NSString * productId;
@property (nonatomic , retain)  NSArray *validProducts ;
@property (nonatomic , retain) Reachability *reachObj;
@property (retain)  id inAppPurchaseDelegate;
@property bool alreadingMakingPurchase;

-(id) init : (UIView *) viewRef ;
- (void)purchaseMyProduct:(SKProduct*)product;
-(void)fetchAvailableProducts;
-(void) restoreMyProduct;
@end
