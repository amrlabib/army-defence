//
//  levelsCanvas.m
//  Army Defence
//
//  Created by amr hamdy on 10/10/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "levelsCanvas.h"

@implementation levelsCanvas

-(id) init : (UIView*)ref :   (int) sWidth : (int) sHeight : (soundEffectsHandler*) sound  : (savedText*)text 
{
    self = [ super init: ref : sWidth : sHeight : sound ];
    
    
    soundObject = sound;
    
    screenWidth = sWidth;
    screenHeight = sHeight;
    
    
    savedTextRef = text;
    
    
    
    
    buttonsSize.width = screenHeight*0.13;
    buttonsSize.height = screenHeight*0.13;
    
    
    inAppPurchaseObj = [[InAppPurchaseController alloc] init:ref ];
    [inAppPurchaseObj setInAppPurchaseDelegate:self];
    
    
    
    [self addButtons ];
    
    
    CGSize windowBounds ;
    windowBounds.width  =  screenWidth;
    windowBounds.height = screenHeight;
    
    currentGame = [[gameObject alloc] init:ref :  windowBounds : savedTextRef  :  soundObject];
    [currentGame setGameObjectDelegate:self];
    
    
    
    if([[savedTextRef levelsPurchasedText] isEqualToString:[[NSString alloc] initWithString:@"0"]] )
    {
        UIButton *restoreButton = [self initButtonAttr:screenWidth - buttonsSize.width*1.2 :screenHeight - buttonsSize.height*1.2 :buttonsSize.width :buttonsSize.height  :@"restoreButton.png"];
    
        [restoreButton addTarget:self action:@selector(restoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        [self addSubview:restoreButton];
    }
    
    return self;
}

-(void) restoreButtonClicked : (id) sender
{
    [soundObject playMySoundFile:@"buttonSound"];
    if( ![inAppPurchaseObj alreadingMakingPurchase])
    {
        [inAppPurchaseObj restoreMyProduct];
    }
}

-(void) addButtons {
    
    for(int i =1 ; i <= 4 ; i++)
    {
        for(int j = 1  ; j <= 6 ; j++)
        {
            [self addSingleButton:i :j ];
        }
    }
}
-(UIImage*) mergeImages : (NSString*) levelNum : (int) levelStatus
{
    CGSize numberSize;
    numberSize.width = buttonsSize.width*0.25;
    numberSize.height = buttonsSize.height*0.25;
    
    

    int numberOfStars=levelStatus;
    
    bool locked = true;
    if( [levelNum intValue] == 1 || [levelNum intValue] == 13  ||  levelStatus > 0 ||   [savedTextRef getLevelValue:[levelNum intValue]-1] > 0)
        locked = false;
    

    
    bool levelLocked = true;
    if([levelNum intValue] <= 7  ||  [levelNum intValue] == 13  ||  [[savedTextRef levelsPurchasedText] isEqualToString:[[NSString alloc] initWithString:@"1"]]  )
        levelLocked = false;
        

    
    if(levelNum.length  == 1 )
    {

        NSString *numberString = [[NSString alloc] initWithString:[levelNum substringToIndex:1]];
        UIImage *numberImage = [UIImage imageNamed:[numberString stringByAppendingFormat:@".png"]];
        UIImage *starImage = [UIImage imageNamed:@"starSmall.png"];
        UIImage *lockImage = [UIImage imageNamed:@"levelLock.png"];
        UIImage *buyFullVersion = [UIImage imageNamed:@"levelsUnlock.png"];



        UIImage *background = [UIImage imageNamed:@"menuLevelsBackground.png"];
        
        
        UIGraphicsBeginImageContextWithOptions(buttonsSize, NO, 0);

        
        
        [background drawInRect:CGRectMake(0,0,buttonsSize.width,buttonsSize.height)];
        [numberImage drawInRect:CGRectMake(buttonsSize.width/2 - numberSize.width/2,buttonsSize.height/2 - numberSize.height,numberSize.width,numberSize.height) ];
        
    
        
        for(int i=0 ; i<numberOfStars && !levelLocked ; i++)
        {
            [starImage drawInRect:CGRectMake(buttonsSize.width*(0.085 + (i*0.28)),buttonsSize.height*0.66,numberSize.width,numberSize.height) ];
        }

        
        if(locked && !levelLocked)
            [lockImage drawInRect:CGRectMake(0,0,buttonsSize.width,buttonsSize.height)];
        
        if(levelLocked)
            [buyFullVersion drawInRect:CGRectMake(0,0,buttonsSize.width,buttonsSize.height)];

        

        UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        [numberString release];
        
        return newImage;

    }
    else
    {
        NSString *numberString = [[NSString alloc] initWithString:[levelNum substringToIndex:1]];
        NSString *numberString2 = [[NSString alloc] initWithString:[levelNum substringWithRange:NSMakeRange(1, 1)]];

        UIImage *numberImage = [UIImage imageNamed:[numberString stringByAppendingFormat:@".png"]];
        UIImage *numberImage2 = [UIImage imageNamed:[numberString2 stringByAppendingFormat:@".png"]];
        UIImage *starImage = [UIImage imageNamed:@"starSmall.png"];
        UIImage *lockImage = [UIImage imageNamed:@"levelLock.png"];
        UIImage *buyFullVersion = [UIImage imageNamed:@"levelsUnlock.png"];

        
        
        UIImage *background = [UIImage imageNamed:@"menuLevelsBackground.png"];
        
        
        UIGraphicsBeginImageContextWithOptions(buttonsSize, NO, 0);
        
        
        
        [background drawInRect:CGRectMake(0,0,buttonsSize.width,buttonsSize.height)];
        [numberImage drawInRect:CGRectMake(buttonsSize.width/2 - numberSize.width*0.8,buttonsSize.height/2 - numberSize.height,numberSize.width,numberSize.height) ];
        [numberImage2 drawInRect:CGRectMake(buttonsSize.width/2 - numberSize.width*0.2,buttonsSize.height/2 - numberSize.height,numberSize.width,numberSize.height) ];

        
        for(int i=0 ; i<numberOfStars && !levelLocked ; i++)
        {
            [starImage drawInRect:CGRectMake(buttonsSize.width*(0.085 + (i*0.28)),buttonsSize.height*0.66,numberSize.width,numberSize.height) ];
        }
        
        
        if(locked && !levelLocked)
            [lockImage drawInRect:CGRectMake(0,0,buttonsSize.width,buttonsSize.height)];
        

        if(levelLocked)
            [buyFullVersion drawInRect:CGRectMake(0,0,buttonsSize.width,buttonsSize.height)];
        

        
        
        
        UIImage *newImage =UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        
        [numberString release];
        [numberString2 release];
        
        return newImage;
    }
    
    
    
}
-(void) addSingleButton : (int) i : (int) j  
{
    
    int xStart = screenWidth /2 - buttonsSize.width*1.2*3;
    int yStart = screenHeight/2 - buttonsSize.height*1.2*1.3;
    
    int levelNum = j + (6*(i-1));
    int levelStatus = [savedTextRef  getLevelValue:levelNum];
    
    
    UIButton *tempButton = [[UIButton alloc] initWithFrame:CGRectMake( xStart + (j-1) * buttonsSize.width*1.2 ,yStart +  (i-1) * buttonsSize.height*1.2, buttonsSize.width, buttonsSize.height)];
    
    
    NSString *buttonTittle = [[NSString alloc] initWithFormat:@"%d"  , levelNum];
    [tempButton setTitle:buttonTittle forState:UIControlStateNormal];
    
    
    [tempButton setImage:[self mergeImages: [[[NSString alloc] initWithFormat:@"%d" ,  levelNum] autorelease] : levelStatus ]forState:UIControlStateNormal];
    
    
    [tempButton addTarget:self action:@selector(levelButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    tempButton.exclusiveTouch =YES;
    
    if([[savedTextRef levelsPurchasedText] isEqualToString:[[NSString alloc] initWithString:@"0"]])
    {
        if( levelNum != 1 && levelNum != 13  &&  levelStatus == 0  && [savedTextRef getLevelValue:levelNum-1] == 0 &&  levelNum<=7  )
            tempButton.userInteractionEnabled = false;
    }
    else
    {
        if( levelNum != 1  &&  levelNum != 13 && levelStatus == 0  && [savedTextRef getLevelValue:levelNum-1] == 0 )
            tempButton.userInteractionEnabled = false;
    }
    
    [self addSubview:tempButton];
    
    [buttonTittle release];
}
-(void) updateLevelButton : (int) l
{
    // since we have backButton !!    
    int levelStatus = [savedTextRef  getLevelValue:l];
    [(UIButton*)[self subviews][l+1] setImage: [self mergeImages: [[[NSString alloc] initWithFormat:@"%d" , l ] autorelease] : levelStatus] forState:UIControlStateNormal ];
    
    if(l < 24)
    {
        levelStatus = [savedTextRef  getLevelValue:l+1];
        [(UIButton*)[self subviews][l+2] setImage: [self mergeImages: [[[NSString alloc] initWithFormat:@"%d" , l+1 ] autorelease ]: levelStatus] forState:UIControlStateNormal ];
        [(UIButton*)[self subviews][l+2] setUserInteractionEnabled:true];
    }
    
}
-(void) levelButtonClickHandler : (id) sender
{
    int buttonNumber = [[(UIButton*)sender currentTitle]  intValue];
    
    
    if( buttonNumber != 1 && buttonNumber != 13 && buttonNumber > 7  &&  ![[savedTextRef levelsPurchasedText] isEqualToString:[[NSString alloc] initWithString:@"1"]] )
    {
        [soundObject playMySoundFile:@"buttonSound"];
        if( ![inAppPurchaseObj alreadingMakingPurchase])
        {
            [inAppPurchaseObj setProductId:@"allLevels"];
            [inAppPurchaseObj fetchAvailableProducts];
        }
    }
    else
    {
        [soundObject playMySoundFile:@"buttonSound"];
        [soundObject stopMySoundFile:@"gameMusic"];
        [currentGame addGameView];
        [currentGame initializeAttributes : buttonNumber];
    }
}

-(void) updateLevelsButton  : (int) l
{
    int levelStatus = [savedTextRef  getLevelValue:l];
    [(UIButton*)[self subviews][l+1] setImage: [self mergeImages: [[[NSString alloc] initWithFormat:@"%d" , l ] autorelease] : levelStatus] forState:UIControlStateNormal ];
    
    
    if( l == 1  || (int)[savedTextRef getLevelValue: l] > 0 || ( l > 1  &&  (int)[savedTextRef getLevelValue:l-1 ] > 0 )  )
        [(UIButton*)[self subviews][l+1] setUserInteractionEnabled:true];
    else
        [(UIButton*)[self subviews][l+1] setUserInteractionEnabled:false];
}

-(void) updateValuesInMainMenu
{
    [savedTextRef updateLevelsPurchased:true];
    for(int i=1  ; i < 25 ; i++)
    {
        [self updateLevelsButton:i];
    }
}

@end
