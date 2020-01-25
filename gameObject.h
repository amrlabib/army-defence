//
//  gameObject.h
//  Army Defence
//
//  Created by amr hamdy on 10/10/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>
#import "Shooter.h"
#import "Tank.h"
#import "gameBoard.h"
#import "IJIndex.h"
#import "Dijkstra.h"
#import "Wave.h"
#import "bullet.h"
#import "ImageNumber.h"
#import "levelAttr.h"
#import "savedText.h"
#import "popUpMessages.h"
#import "soundEffectsHandler.h" 
#import "BombView.h"
#import "tutorialClass.h"
#import "ViewsUtil.h"


@protocol gameObjectDelegateFunctions <NSObject>
@required
-(void) updateLevelButton : (int) l;
@end




@interface gameObject : UIView <UIApplicationDelegate, delegateFunctions>
{
    CGSize currentWindowBounds;
    CGSize currentWindowBoundsFull;
    NSTimer *gameTimer;
    gameBoard *boardObject;
    
    
    DrawableObject *strongElectricWeapon , *electricWeapon , *starWeapon , *singleArmWeapon , *manWeapon , *bombViewButton;
    DrawableObject *lifeShape , *moneyDollarShape;
    UIButton *runPauseWaveButton,*runFastButton , *homeButton , *gridButton , *resetButton;
    UIImageView *touchMoveImage;
    
    NSString *currentPressedWeapon;
    
    
    IJIndex *lastPressedShooterIndex;
    
    
    
    levelAttr *level;
    
    
    bool weaponPressed;
    
    
    
    
    //Dijkstra *pathFinderObject;
    
    
    int activeWaveNumber;
    NSMutableArray *wavesArray;
    
    
    NSMutableArray *bulletsArray;
    
    
    
    soundEffectsHandler *soundEffectsObject;
    
    
    ImageNumber *levelImageNumber , *totalLifeNumber , *waveNumberImage , *waveNumberGoalImage , *currentMoneyImage;
    
    
    DrawableObject *waveNumberSeparator;
    
    int score;
    int totalLife;
    
    
    float currentSpeed ;
    
    
    
    
    int waveNumber;
    
    
    int currentMoney;
    
    
    bool validPosition;
    
    
    UIView *viewReference;
    
    
    savedText *savedTextRef;
    int difficulty;
    
    
    
    // id <gameObjectDelegateFunctions> gameObjectDelegate;
    
    
    
    
    int creationCount;
    
    
    bool popUpMessageActivated;
    bool pausedDueToPopUpMessage;
    
    BombView *bombViewObject;
    
    
    bool bombWeapon;
    
    
    UIImageView *levelImage;
    
    
    DrawableObject *gameBackground;
    
    
    tutorialClass *tutorialObject;
    bool tutPausedDueToMessage;
    
    
    bool rateLater;
    
    int bottomSafeArea;
    int topSafeArea;
    int rightSafeaArea;
    int leftSafeArea;
}

@property  (retain) id gameObjectDelegate;


-(id) init :(UIView*) vRef :  (CGSize) screenSize : (savedText*) savedText  : (soundEffectsHandler*) sound ;
-(void) addGameView;
-(void) initializeAttributes : (int) l;
-(void) addGameBackground;
-(void) addShooterWeaponsImages;
-(void) addGameButtons;
-(void) addTextImages;


-(void) resetGame;

-(bool) insideRangeCircle : (int) x : (int) y : (CGSize) tankSize :  (Shooter*) shooterObj;
-(void) createBullets : (Shooter *) currentShooter : (Tank *) currentTank;
-(void) rotateShooters : (Shooter *) currentShooter : (Tank *) currentTank;
-(bool) decreaseTankLife : (Shooter *) currentShooter : (Tank *) currentTank ;
-(void) moveShootTanksAndRotateShootersToTanks;


-(void) initGameTimer;
-(void) timerTickingHandler;


-(bool) checkDefaultPath;
-(bool) checkToAddShooterAndGetPath;



-(void) setCurrentPressedWeapon : (UITouch*) touch : (CGPoint) location;
-(void) setAddShootersRangeCircle : (CGPoint) location;

-(void) setSafeAreaValues;


@end
