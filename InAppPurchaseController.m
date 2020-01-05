//
//  InAppPurchaseController.m
//  myOpenGlCode
//
//  Created by amr hamdy on 9/13/14.
//  Copyright (c) 2014 amr hamdy. All rights reserved.
//

#import "InAppPurchaseController.h"

@implementation InAppPurchaseController


@synthesize validProducts , productId , inAppPurchaseDelegate , alreadingMakingPurchase ;

-(id) init : (UIView *) viewRef
{
    alreadingMakingPurchase = false;
    productRestored = false;
    
    activityIndicatorView = [[UIActivityIndicatorView alloc]
                             initWithActivityIndicatorStyle:  UIActivityIndicatorViewStyleWhiteLarge];
    activityIndicatorView.center = viewRef.center;
    activityIndicatorView.frame = CGRectMake(viewRef.frame.size.width/2-50, viewRef.frame.size.height/2, 100, 100);
    [activityIndicatorView hidesWhenStopped];
    
    [viewRef addSubview:activityIndicatorView];

    
    
    return self;
}





-(void)fetchAvailableProducts
{
    
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus internetStatus = [reachability currentReachabilityStatus];
    if (internetStatus != NotReachable) {
        alreadingMakingPurchase = true;
        
        [activityIndicatorView startAnimating];
        
        NSSet *productIdentifiers = [NSSet setWithObjects:productId,nil];
        productsRequest = [[SKProductsRequest alloc] initWithProductIdentifiers:productIdentifiers];
        productsRequest.delegate = self;
        [productsRequest start];
    }
    else {
        NSString *temp  = [[NSString alloc] initWithFormat:@"Please check your internet Connection !"];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection Error"
                                                        message:temp
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        
        [alert show];
        [alert release];
    }
}

- (BOOL)canMakePurchases
{
    return [SKPaymentQueue canMakePayments];
}

- (void)purchaseMyProduct:(SKProduct*)product{
    if ([self canMakePurchases]) {
        SKPayment *payment = [SKPayment paymentWithProduct:product];
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] addPayment:payment];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
        
        alreadingMakingPurchase = false;
    }
}
-(IBAction)purchase:(id)sender{
    [self purchaseMyProduct:[validProducts objectAtIndex:0]];
    purchaseButton.enabled = NO;
}

#pragma mark StoreKit Delegate
-(void)paymentQueue:(SKPaymentQueue *)queue updatedTransactions:(NSArray *)transactions {
    for (SKPaymentTransaction *transaction in transactions) {
        switch (transaction.transactionState) {
            case SKPaymentTransactionStatePurchasing:
                alreadingMakingPurchase = true;
                break;
            case SKPaymentTransactionStatePurchased:
                if ([transaction.payment.productIdentifier
                     isEqualToString:productId]) {
                    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                              @"Purchase is completed succesfully" message:nil delegate:
                                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
                    [alertView show];
                    

                    [self handleProductAddition];
                    alreadingMakingPurchase = false;
                }
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                alreadingMakingPurchase = false;
                break;
            case SKPaymentTransactionStateRestored:
                productRestored = true;
                [[SKPaymentQueue defaultQueue] finishTransaction:transaction];
                [[self inAppPurchaseDelegate] updateValuesInMainMenu];
                alreadingMakingPurchase = false;
                break;
            case SKPaymentTransactionStateFailed:
                alreadingMakingPurchase = false;
                break;
            default:
                alreadingMakingPurchase = false;
                break;
        }
    }
}



-(void)productsRequest:(SKProductsRequest *)request
    didReceiveResponse:(SKProductsResponse *)response
{
    SKProduct *validProduct = nil;
    int count = (int)[response.products count];
    if (count>0) {
        validProducts = response.products;
        validProduct = [response.products objectAtIndex:0];
        if ([validProduct.productIdentifier
             isEqualToString:productId]) {
            [productTitleLabel setText:[NSString stringWithFormat:
                                        @"Product Title: %@",validProduct.localizedTitle]];
            [productDescriptionLabel setText:[NSString stringWithFormat:
                                              @"Product Desc: %@",validProduct.localizedDescription]];
            [productPriceLabel setText:[NSString stringWithFormat:
                                        @"Product Price: %@",validProduct.price]];
        }
        
        [self purchaseMyProduct:validProduct];
    } else {
        UIAlertView *tmp = [[UIAlertView alloc]
                            initWithTitle:@"Not Available"
                            message:@"No products to purchase"
                            delegate:self
                            cancelButtonTitle:nil
                            otherButtonTitles:@"Ok", nil];
        [tmp show];
        alreadingMakingPurchase = false;
    }
    [activityIndicatorView stopAnimating];
    purchaseButton.hidden = NO;
}



-(void) handleProductAddition
{
    if([productId  isEqualToString:@"allLevels"])
    {
        [[self inAppPurchaseDelegate] updateValuesInMainMenu];
    }
}



-(void) restoreMyProduct
{
    if ([self canMakePurchases]) {
        [[SKPaymentQueue defaultQueue] addTransactionObserver:self];
        [[SKPaymentQueue defaultQueue] restoreCompletedTransactions];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Purchases are disabled in your device" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        
        [alertView show];
        alreadingMakingPurchase = false;
    }
}

- (void)paymentQueueRestoreCompletedTransactionsFinished:(SKPaymentQueue *)queue
{
    if(productRestored)
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"Restored Successfully" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
    else
    {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                                  @"No Purchases to be restored" message:nil delegate:
                                  self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)paymentQueue:(SKPaymentQueue *)queue restoreCompletedTransactionsFailedWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:
                              @"Error While restoring purchases" message:nil delegate:
                              self cancelButtonTitle:@"Ok" otherButtonTitles: nil];
    [alertView show];
}
@end
