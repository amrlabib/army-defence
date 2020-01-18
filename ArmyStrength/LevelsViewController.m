//
//  LevelsViewController.m
//  Army Defence Free
//
//  Created by Amr Labib on 17/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import "LevelsViewController.h"

@interface LevelsViewController ()

@end

@implementation LevelsViewController
- (IBAction)HomeButton:(id)sender {
    [[self navigationController] popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initLevels];
}

-(id) initLevels
{
    savedTextRef = [[savedText alloc] init];
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    screenWidth = screenBounds.size.width;
    screenHeight = screenBounds.size.height;
    
    
    
    CGSize windowBounds ;
    windowBounds.width  =  screenWidth;
    windowBounds.height = screenHeight;
        
    
    buttonsSize.width = screenHeight*0.13;
    buttonsSize.height = screenHeight*0.13;
    
    
    inAppPurchaseObj = [[InAppPurchaseController alloc] init:self.view ];
    [inAppPurchaseObj setInAppPurchaseDelegate:self];
    
    
    
    [self addButtons ];
    
    
    
    if([[savedTextRef levelsPurchasedText] isEqualToString:[[NSString alloc] initWithString:@"0"]] )
    {
        UIButton *restoreButton = [self initButtonAttr:screenWidth - buttonsSize.width*1.2 :screenHeight - buttonsSize.height*1.2 :buttonsSize.width :buttonsSize.height  :@"restoreButton.png"];
    
        [restoreButton addTarget:self action:@selector(restoreButtonClicked:) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:restoreButton];
    }
    
    return self;
}

-(void) restoreButtonClicked : (id) sender
{
    [_soundRef playMySoundFile:@"buttonSound"];
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
    
    [self.view addSubview:tempButton];
    
    [buttonTittle release];
}
-(void) updateLevelButton : (int) l
{
    // since we have backButton !!
    int levelStatus = [savedTextRef  getLevelValue:l];
    [(UIButton*)[self.view subviews][l+1] setImage: [self mergeImages: [[[NSString alloc] initWithFormat:@"%d" , l ] autorelease] : levelStatus] forState:UIControlStateNormal ];
    
    if(l < 24)
    {
        levelStatus = [savedTextRef  getLevelValue:l+1];
        [(UIButton*)[self.view subviews][l+2] setImage: [self mergeImages: [[[NSString alloc] initWithFormat:@"%d" , l+1 ] autorelease ]: levelStatus] forState:UIControlStateNormal ];
        [(UIButton*)[self.view subviews][l+2] setUserInteractionEnabled:true];
    }
    
}
-(void) levelButtonClickHandler : (id) sender
{
    int buttonNumber = [[(UIButton*)sender currentTitle]  intValue];
    
    
    if( buttonNumber != 1 && buttonNumber != 13 && buttonNumber > 7  &&  ![[savedTextRef levelsPurchasedText] isEqualToString:[[NSString alloc] initWithString:@"1"]] )
    {
        [_soundRef playMySoundFile:@"buttonSound"];
        if( ![inAppPurchaseObj alreadingMakingPurchase])
        {
            [inAppPurchaseObj setProductId:@"allLevels"];
            [inAppPurchaseObj fetchAvailableProducts];
        }
    }
    else
    {
        [_soundRef playMySoundFile:@"buttonSound"];
        [_soundRef stopMySoundFile:@"gameMusic"];
        
        GameViewController *newGameViewController = [[GameViewController alloc] init];
        newGameViewController.levelNumber = buttonNumber;
        newGameViewController.soundRef = _soundRef;
        [[self navigationController] pushViewController:newGameViewController animated:true];
    
        // [currentGame addGameView];
        // [currentGame initializeAttributes : buttonNumber];
    }
}

-(void) updateLevelsButton  : (int) l
{
    int levelStatus = [savedTextRef  getLevelValue:l];
    [(UIButton*)[self.view subviews][l+1] setImage: [self mergeImages: [[[NSString alloc] initWithFormat:@"%d" , l ] autorelease] : levelStatus] forState:UIControlStateNormal ];
    
    
    if( l == 1  || (int)[savedTextRef getLevelValue: l] > 0 || ( l > 1  &&  (int)[savedTextRef getLevelValue:l-1 ] > 0 )  )
        [(UIButton*)[self.view subviews][l+1] setUserInteractionEnabled:true];
    else
        [(UIButton*)[self.view subviews][l+1] setUserInteractionEnabled:false];
}

-(void) updateValuesInMainMenu
{
    [savedTextRef updateLevelsPurchased:true];
    for(int i=1  ; i < 25 ; i++)
    {
        [self updateLevelsButton:i];
    }
}

-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height : (NSString*) name
{
    UIButton* currentButton = [[UIButton alloc] initWithFrame:CGRectMake(x , y, width, height)];
    [currentButton setTitle:name forState:UIControlStateNormal ];
    [currentButton addTarget:self action:@selector(buttonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [currentButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    currentButton.exclusiveTouch =YES;

    return currentButton;
}

@end
