//
//  gameObject.m
//  Army Defence
//
//  Created by amr hamdy on 10/10/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "gameObject.h"


@implementation gameObject


@synthesize gameObjectDelegate;

-(id) init :(UIView*) vRef :  (CGSize) screenSize : (savedText*) savedText : (soundEffectsHandler*) sound
{
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(pauseTheTimer)
                                                 name:UIApplicationWillResignActiveNotification
                                               object:nil];
    
    viewReference = vRef;
    savedTextRef = savedText;
    currentWindowBounds = screenSize;
    
    
    rateLater = false;
    
    
    soundEffectsObject = sound;
    
    self = [super initWithFrame:CGRectMake(0, 0, currentWindowBounds.width, currentWindowBounds.height)];
    
    return self;
}
-(void) pauseTheTimer
{
    if(gameTimer!=NULL)
    {
        [runPauseWaveButton setImage:[UIImage imageNamed:@"runWaveButton.png"] forState:UIControlStateNormal];
        [runPauseWaveButton setTitle:@"runWaveButton.png" forState:UIControlStateNormal] ;
        [gameTimer invalidate ];
        gameTimer = NULL;
        
        [soundEffectsObject stopLoopingSounds];
    }
}


-(void) initializeAttributes : (int) l
{
    [self addGameBackground];

    bombWeapon = false;
    popUpMessageActivated = false;
    pausedDueToPopUpMessage=  false;
    weaponPressed = false;
    validPosition = false;


    creationCount = 0;
    score = 0 ;
    totalLife = 20;
    currentSpeed = 0.03;
    waveNumber = 0 ;
    
    
    
    difficulty = [savedTextRef getLevelValue:25];
    
    
    
    lastPressedShooterIndex = [[IJIndex alloc] init : -1 :-1 ];
    
    
    
    boardObject = [[gameBoard alloc] init: self :currentWindowBounds.width : currentWindowBounds.height ];
    level = [[levelAttr alloc] init : l : boardObject.rows : boardObject.cols];
    
    [boardObject drawGatesShapes:level.startBlocks :level.endBlocks];
    
    
    
    
    
    
    
    touchMoveImage =  [[UIImageView alloc]init];
    touchMoveImage.frame = CGRectMake(-200, -200, boardObject.blockSize.width , boardObject.blockSize.height);
    touchMoveImage.image=[UIImage imageNamed:@"blackTouchMoveImage.png"];
    [self addSubview:touchMoveImage];
    
    

    
    
    
    
    bulletsArray = [[NSMutableArray alloc] init];
    
    
    currentMoney =  level.startingCash;
    
    [self addShooterWeaponsImages];
    
    
    
    
    
    
    
  
    
    
    [self addTextImages];
    
    [self addGameButtons];
    
    
    
    
    wavesArray = [[NSMutableArray alloc] init];
    
    activeWaveNumber = 0;
    for(int i=0  ;i< level.entranceCount ; i++)
    {
        Dijkstra *pathFinderObject = [[Dijkstra alloc] init:boardObject.board :level.startBlocks[i] :level.endBlocks[i]];
        
        wavesArray[i] = [[Wave alloc] init: self : [pathFinderObject getPathSequence : level.startBlocks[i] :level.endBlocks[i]] : boardObject.blockSize : level.startBlocks[i] :level.endBlocks[i] :waveNumber  : (int)currentWindowBounds.width  : difficulty];
        
        
        [pathFinderObject release];
    }
    
    
    tutPausedDueToMessage = false;
    if(level.levelNumber == 1)
    {
        tutorialObject = [[tutorialClass alloc] init:self :currentWindowBounds.width :currentWindowBounds.height];
    }

}

-(void) releaseOjects
{
    if( level.levelNumber == 1  )
    {
        [tutorialObject release];
    }
    
    for(int i=0  ;i< wavesArray.count ; i++)
    {
        if([wavesArray[i] retainCount] >= 2)
           [wavesArray[i] release];
    }
    
    [wavesArray release];
    
    for(int i=0 ; i< bulletsArray.count ; i++)
        [bulletsArray[i] release];
        
    [bulletsArray release];
    
    [touchMoveImage release];
    [gameBackground release];
    
    
    [boardObject release];
    [lastPressedShooterIndex release];
    [level release];
    
    
    [strongElectricWeapon release];
    [electricWeapon release];
    [starWeapon release];
    [singleArmWeapon release];
    [manWeapon release];
    if(bombViewButton!=NULL)
        [bombViewButton release];
    
    [runPauseWaveButton  release];
    [runFastButton release];
    [gridButton release];
    [homeButton release];
    [resetButton release];
    
    [levelImage release];
    [waveNumberSeparator release];

    
    [levelImageNumber release];
    [waveNumberImage release];
    [waveNumberGoalImage release];
    [totalLifeNumber release];
    
    
    [lifeShape release];
    [moneyDollarShape release];
    [currentMoneyImage release];
    
    [bombViewObject release];
}


-(void) resetGame
{
    [[self subviews] makeObjectsPerformSelector: @selector(removeFromSuperview)];
    [gameTimer invalidate ];
    gameTimer = NULL;
    
    int nextLevel = level.levelNumber;
    
    [self releaseOjects];
    [self initializeAttributes : nextLevel];
    
}
-(void) goToNextLevel
{
    if(level.levelNumber <  7)
    {
        int cLevel = level.levelNumber;
        [level release];
        level = [[levelAttr alloc] init : cLevel+1 : boardObject.rows : boardObject.cols];
        [self resetGame];

    }
    else
    {
        [self levelsButtonHandler];
    }
}
-(void) levelsButtonHandler
{
    [gameTimer invalidate ];
    gameTimer = NULL;
    
    [soundEffectsObject playMySoundFile:@"gameMusic"];
    [self releaseOjects];
    [[[self gameObjectDelegate] navigationController] popViewControllerAnimated:true];
    
    // [self removeFromSuperview];
}


-(void) addGameBackground
{
    if(currentWindowBounds.width == 1024)
        gameBackground = [[DrawableObject alloc] init: self :0 :0 :currentWindowBounds :@"ipad-game-bg.jpg"];
    else if(currentWindowBounds.width == 480)
        gameBackground = [[DrawableObject alloc] init: self :0 :0 :currentWindowBounds :@"iphone-4s-game-bg.jpg"];
    else if(currentWindowBounds.width == 568)
        gameBackground = [[DrawableObject alloc] init: self :0 :0 :currentWindowBounds :@"iphone-SE-game-bg.jpg"];
    else if (currentWindowBounds.width == 667)
        gameBackground = [[DrawableObject alloc] init: self :0 :0 :currentWindowBounds :@"iphone-7-game-bg.jpg"];
    else //if (currentWindowBounds.width == 736)
        gameBackground = [[DrawableObject alloc] init: self :0 :0 :currentWindowBounds :@"iphone-7-plus-game-bg.jpg"];

}
-(void) addShooterWeaponsImages
{
    CGSize weaponImageSize;
    weaponImageSize.width = boardObject.blockSize.width * 0.95;
    weaponImageSize.height = boardObject.blockSize.height * 0.95;
    
    
    int widthStep = boardObject.blockSize.width *1.1;
    
    strongElectricWeapon = [[DrawableObject alloc] init:self :currentWindowBounds.width -(widthStep * 1.8) - currentWindowBounds.width*0.1:currentWindowBounds.height -weaponImageSize.height  :weaponImageSize :@"strongElectricWithMoney.png" ];
    
    electricWeapon = [[DrawableObject alloc] init:self :currentWindowBounds.width -(widthStep * 2.8) - currentWindowBounds.width*0.1:currentWindowBounds.height -weaponImageSize.height  :weaponImageSize :@"electricWithMoney.png" ];
    
    starWeapon = [[DrawableObject alloc] init:self :currentWindowBounds.width - (widthStep * 3.8) - currentWindowBounds.width*0.1  :currentWindowBounds.height -weaponImageSize.height :weaponImageSize :@"starWithMoney.png" ];
    
    singleArmWeapon = [[DrawableObject alloc] init:self :currentWindowBounds.width - (widthStep * 4.8) - currentWindowBounds.width*0.1  :currentWindowBounds.height -weaponImageSize.height :weaponImageSize :@"singleArmWithMoney.png" ];
    
    manWeapon = [[DrawableObject alloc] init:self :currentWindowBounds.width - (widthStep * 5.8) - currentWindowBounds.width*0.1 :currentWindowBounds.height -weaponImageSize.height :weaponImageSize :@"manShooterWithMoney.png" ];
    
    
    if(level.levelNumber >= 13)
        bombViewButton = [[DrawableObject alloc] init:self :currentWindowBounds.width - (widthStep * 7.3) - currentWindowBounds.width*0.1 :currentWindowBounds.height -weaponImageSize.height :weaponImageSize :@"bombsButton.png" ];
    else
        bombViewButton = NULL;

    
    
    
    CGSize bombViewSize;
    bombViewSize.width = currentWindowBounds.width*0.27;
    bombViewSize.height =  currentWindowBounds.height*0.07;
    
    
    int BombViewX = ([bombViewButton xPosition] + [bombViewButton imageSize].width/2) - bombViewSize.width/2;
    int bombViewY = [bombViewButton yPosition] - bombViewSize.height*1.05;
    bombViewObject = [[BombView alloc] init:self :BombViewX :bombViewY :bombViewSize.width :bombViewSize.height :  currentMoney];
    
    
    [self setWeaponsImages];
    
    
    
    
}
-(void) addGameButtons
{
   
    CGSize buttonsSize;
    buttonsSize.width = [boardObject blockSize].width * 0.8;
    buttonsSize.height = [boardObject blockSize].height * 0.8;
    
    
    int yStart = currentWindowBounds.height - buttonsSize.height*1.1;

    
    
    if(currentWindowBounds.height == 320)
    {
        buttonsSize.width = [boardObject blockSize].width * 0.7;
        buttonsSize.height = [boardObject blockSize].height * 0.7;
        
        yStart  = currentWindowBounds.height - buttonsSize.height*1.2;
    }

    
    runPauseWaveButton = [self initButtonAttr:buttonsSize.width*0.6 : yStart :buttonsSize.width :buttonsSize.height :@"runWaveButton.png"];
    
    runFastButton   = [self initButtonAttr:buttonsSize.width*1 * 2 :yStart :buttonsSize.width :buttonsSize.height :@"runFastButton.png"];
    
    gridButton = [self initButtonAttr:buttonsSize.width*1 * 3.4  :yStart :buttonsSize.width :buttonsSize.height  :@"gridButton.png"];
    
    homeButton = [self initButtonAttr:buttonsSize.width*1 * 4.8 :yStart :buttonsSize.width :buttonsSize.height :@"goToLevelsButton.png"];
    
    resetButton = [self initButtonAttr:buttonsSize.width*1 * 6.2:yStart :buttonsSize.width :buttonsSize.height :@"resetButton.png"];
    
    
    [self addSubview:runPauseWaveButton];
    [self addSubview:runFastButton];
    [self addSubview:gridButton];
    [self addSubview:homeButton];
    [self addSubview:resetButton];
    
}
-(UIButton*) initButtonAttr : (int) x :  (int) y : (int) width : (int) height  : (NSString*) name
{
    CGSize buttonSize;
    buttonSize.width = width;
    buttonSize.height = height;
    
    
    UIButton *currentButton = [[UIButton alloc] initWithFrame:CGRectMake(x , y, width, height)];
    [currentButton setTitle:name forState:UIControlStateNormal ];
    [currentButton addTarget:self action:@selector(buttonsClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [currentButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    currentButton.exclusiveTouch =YES;
    
    return currentButton;
}



-(void) addTextImages
{
    CGSize numberSize;
    numberSize.width = [boardObject blockSize].width * 0.3;
    numberSize.height = [boardObject blockSize].height * 0.3;
    
    CGSize levelImageSize;
    levelImageSize.width = currentWindowBounds.height*0.1;
    levelImageSize.height =  levelImageSize.width*0.3;
    
    levelImage = [[UIImageView alloc] init];
    if((int)currentWindowBounds.width == 1024)
        levelImage.frame = CGRectMake(levelImageSize.width*0.14, levelImageSize.height*0.75, levelImageSize.width, levelImageSize.height);
    else
        levelImage.frame = CGRectMake(levelImageSize.width*0.14, levelImageSize.height*0.9, levelImageSize.width, levelImageSize.height);

    
    levelImage.image = [UIImage imageNamed:@"levelImage.png"];
    [self addSubview:levelImage];
    
    levelImageNumber = [[ImageNumber alloc] init:2 : levelImageSize.width + numberSize.width   : numberSize.height :self :numberSize ];
    [levelImageNumber updateNumberValue:level.levelNumber];
    
    
    
    
    int numberOfDigits=3;
    if( level.wavesCount < 100 )
    {
        numberOfDigits = 2;
    }
    waveNumberImage = [[ImageNumber alloc] init:numberOfDigits : currentWindowBounds.width/2 - numberSize.width *numberOfDigits    : numberSize.height :self :numberSize ];
    
    waveNumberGoalImage = [[ImageNumber alloc] init:numberOfDigits : currentWindowBounds.width/2 +  numberSize.width *numberOfDigits/2    : numberSize.height :self :numberSize ];
    [waveNumberGoalImage updateNumberValue:level.wavesCount];
    
    waveNumberSeparator = [[DrawableObject alloc] init:self : currentWindowBounds.width/2: numberSize.height : numberSize :@"waveNumberSeparator.png" ];
    
    
    
    
    
    
    lifeShape = [[DrawableObject alloc] init:self : currentWindowBounds.width - (numberSize.width*2 ): numberSize.height : numberSize :@"lifeShape.png" ];
    totalLifeNumber = [[ImageNumber alloc] init:2 :currentWindowBounds.width - (numberSize.width * 4)  : numberSize.height :self :numberSize ];
    [totalLifeNumber updateNumberValue:totalLife];
    
    
    moneyDollarShape = [[DrawableObject alloc] init:self : currentWindowBounds.width - (numberSize.width*2 ):currentWindowBounds.height - numberSize.height * 2 : numberSize :@"dollar.png" ];
    currentMoneyImage =  [[ImageNumber alloc] init:3 : currentWindowBounds.width - numberSize.width *5   :currentWindowBounds.height - numberSize.height * 2 :self :numberSize ];
    [currentMoneyImage updateNumberValue:currentMoney];
    
    
}





-(void) ratingFunction
{
    if(!rateLater &&   !savedTextRef.armyRated && level.levelNumber %3 == 0)
    {
        if(gameTimer == NULL)
            ;
        else
        {
            [gameTimer invalidate ];
            gameTimer = NULL;
            [soundEffectsObject stopLoopingSounds];
            pausedDueToPopUpMessage = true;
        }
        
        
        
        popUpMessages *vMessage = [[popUpMessages alloc] init:self :currentWindowBounds :@"rateUsImage.png" : -3 : soundEffectsObject];
        [vMessage setDelegate:self];
        [vMessage addMessage];
        popUpMessageActivated= true;
    }
}
-(void) handleGameRateSubmitted : (bool) value
{
    if(value)
    {
        [savedTextRef updateArmyRated:true];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://appstore.com/armydefencefree"]];
    }
    else
    {
        rateLater = true;
    }
}



-(void) initGameTimer
{
    gameTimer= [NSTimer scheduledTimerWithTimeInterval:currentSpeed target:self selector:@selector(timerTickingHandler) userInfo:nil repeats:YES];
}
-(void) timerTickingHandler
{
    if( wavesArray[activeWaveNumber]  == NULL ||  [[wavesArray[activeWaveNumber] tanksArray] count] == 0)
    {
        waveNumber++;        
        if(waveNumber >  level.wavesCount)
        {
            [self winHandler];
            return ;
        }
        
        
        activeWaveNumber = arc4random() % level.entranceCount;
        
    
        [self moveEndGates];
        
        
        Dijkstra *pathFinderObject = [[Dijkstra alloc] init:boardObject.board :level.startBlocks[activeWaveNumber] :level.endBlocks[activeWaveNumber]];
        
        
        [wavesArray[activeWaveNumber] release];
        wavesArray[activeWaveNumber] = [[Wave alloc] init: self : [pathFinderObject getPathSequence : level.startBlocks[activeWaveNumber] :level.endBlocks[activeWaveNumber]] : boardObject.blockSize : level.startBlocks[activeWaveNumber] :level.endBlocks[activeWaveNumber] :waveNumber : (int)currentWindowBounds.width : difficulty ];
        
        
        ///////// Very imp  when i passed start and end blocks in levelAttr class to getPathSequence from path finder object i
        ///  i used both with new allocations which lead to change in retain count of start and end blocks in levelAttr class which is wronge !!
        ///  take  care
        
    
        [pathFinderObject release];
        
        
        [waveNumberImage updateNumberValue:waveNumber];
        
        
    }
    
    [self moveShootTanksAndRotateShootersToTanks];
    
    if(totalLife <= 0 )
    {
        [self loseHandler];
        return;
    }
    
    
    [self moveBullets];
    
}
-(void) moveEndGates
{
    if(level.moveBlocks)
    {
        Dijkstra *pathFinderObject = [[Dijkstra alloc] init:boardObject.board :level.startBlocks[activeWaveNumber] :level.endBlocks[activeWaveNumber]];
        NSMutableArray *currentValidPath = [pathFinderObject getPathSequence : level.startBlocks[activeWaveNumber] :level.endBlocks[activeWaveNumber]];
        
        
        [pathFinderObject release];
        
        int newEndGateRandIndex =  arc4random() % currentValidPath.count;
        
        if( newEndGateRandIndex <  (currentValidPath.count - 5) )
        {
            bool overLap = false;
            for(int k=0  ;k <  wavesArray.count  ; k++)
            {
                if( [currentValidPath[newEndGateRandIndex] i] == [wavesArray[k] endBlockIndex].i && [currentValidPath[newEndGateRandIndex] j] == [wavesArray[k] endBlockIndex].j && k != activeWaveNumber)
                    overLap = true;
                    
            }
            
            if(!overLap)
            {
                int iValue = [currentValidPath[newEndGateRandIndex] i ];
                int jValue =  [currentValidPath[newEndGateRandIndex] j];
                
                
                if([level.endBlocks[activeWaveNumber] i] != iValue || [level.endBlocks[activeWaveNumber] j] != jValue )
                    [soundEffectsObject playMySoundFile:@"transportationSound"];
                
                
                [level.endBlocks[activeWaveNumber] release];
                level.endBlocks[activeWaveNumber]  = [[IJIndex alloc] init : iValue  : jValue ] ;
                
                [boardObject.endBlocksShapes[activeWaveNumber] setXPosition:jValue*boardObject.blockSize.width + boardObject.xStart ];
                [boardObject.endBlocksShapes[activeWaveNumber] setYPosition:iValue*boardObject.blockSize.height ];
                [boardObject.endBlocksShapes[activeWaveNumber] moveDrawableObject:0 :0];
            }
        }
        
        
    }
}
-(void) moveBullets
{
    for(int i=0 ; i < bulletsArray.count ; i++)
    {
        if([bulletsArray[i] explosionTime] == 3 )
        {
            [bulletsArray[i] setPrevVariables];
            [bulletsArray[i] executeEquation];
            [bulletsArray[i] checkBulletReachedDestination];
            
        }
        else
        {
            [bulletsArray[i] setExplosionTime: [bulletsArray[i] explosionTime]-1];
            if([bulletsArray[i] explosionTime] <= 0)
            {
            
                [[bulletsArray[i] explosionObjectShape] removeDrawableObject];
                [bulletsArray[i] release];
                [bulletsArray removeObjectAtIndex:i];
                
                
            }
        }
    }
}


-(void) loseHandler
{
    [soundEffectsObject  stopLoopingSounds];
    [gameTimer invalidate ];
    gameTimer = NULL;
    
    popUpMessages *vMessage = [[popUpMessages alloc] init:self :currentWindowBounds :@"defeatedImage.png" : 0 : soundEffectsObject];
    [vMessage setDelegate:self];
    [vMessage addMessage];
    popUpMessageActivated= true;
    
    
    [soundEffectsObject playMySoundFile:@"winLoseSound"];
}
-(void) winHandler
{
    [soundEffectsObject stopLoopingSounds];
    [gameTimer invalidate ];
    gameTimer = NULL;
    [savedTextRef updateLevel:level.levelNumber :difficulty];
    // [[self gameObjectDelegate] updateLevelButton : level.levelNumber ];
    
    
    popUpMessages *vMessage = [[popUpMessages alloc] init:self :currentWindowBounds :@"victoryImage.png" : difficulty :soundEffectsObject];
    [vMessage setDelegate:self];
    [vMessage addMessage];
    popUpMessageActivated = true;
    

    [soundEffectsObject playMySoundFile:@"winLoseSound"];
}




-(bool) insideRangeCircle : (int) x : (int) y : (CGSize) tankSize :  (Shooter*) shooterObj
{
    
    
    int xRight = x + (int)tankSize.width*0.7;
    int xLeft = x + (int)tankSize.width*0.3 ;
    
    
    int  yTop = y + (int)tankSize.height*0.3;
    int yBottom = y + (int)tankSize.height*0.7;

    
    
    
    
    int  xCenter = [[shooterObj objectShape] xPosition] + [[shooterObj objectShape] imageSize ].width / 2 ;
    int  yCenter = [[shooterObj objectShape] yPosition] + [[shooterObj objectShape] imageSize ].height / 2 ;
    
    
    if( pow( (xRight - xCenter) , 2 )  + pow((yTop - yCenter), 2)   <  pow(  [shooterObj  range] *0.5  , 2)
       || pow( (xRight - xCenter) , 2 )  + pow((yBottom - yCenter), 2)   <  pow(  [shooterObj  range] *0.5  , 2)
       || pow( (xLeft - xCenter) , 2 )  + pow((yTop - yCenter), 2)   <  pow(  [shooterObj  range] *0.5  , 2)
       || pow( (xLeft - xCenter) , 2 )  + pow((yBottom - yCenter), 2)   <  pow(  [shooterObj  range] *0.5  , 2)
       
       )
    {
        
        return true;
    }
    else
        return false;
}
-(void) createBullets : (Shooter *) currentShooter : (Tank *) currentTank
{    
    int tempXStart = [[currentShooter objectShape ] xPosition ] + [[currentShooter objectShape] imageSize].width/2;
    int tempYStart = [[currentShooter objectShape ] yPosition ]  + [[currentShooter objectShape] imageSize].height/2;
    
    int xEnd = [[currentTank objectShape ] xPosition] +  [[currentTank objectShape ] imageSize].width/2;
    int yEnd = [[currentTank objectShape ] yPosition] +  [[currentTank objectShape ] imageSize].height/2;
    
    
    
    double theta = 360 - ( (atan2( tempXStart-xEnd , tempYStart-yEnd ) * (180 / M_PI) ) + 90 ) - 180;
    int xStart =  tempXStart - ((cos(theta * M_PI/180))   * (boardObject.blockSize.width/2));
    int yStart =  tempYStart - ((sin(theta * M_PI/180))   * (boardObject.blockSize.height/2));
    
    
    
    if([[currentShooter name] isEqualToString:@"manShooter" ])
    {
        [bulletsArray addObject: [[bullet alloc] init: xStart : yStart : xEnd :yEnd :boardObject.blockSize :self :@"bullet1.png" : @"explosion1.png" ] ];        
        [soundEffectsObject  playMySoundFile:@"bullet1" ];
    }
    else if([[currentShooter name] isEqualToString:@"singleArmShooter" ])
    {
        
        [bulletsArray addObject: [[bullet alloc] init: xStart : yStart : xEnd :yEnd :boardObject.blockSize :self :@"bullet2.png" : @"explosion3.png" ] ];
        
        [soundEffectsObject  playMySoundFile:@"bullet2" ];

    }
    else if([[currentShooter name] isEqualToString:@"starShooter" ])
    {
        [bulletsArray addObject: [[bullet alloc] init: xStart : yStart : xEnd :yEnd :boardObject.blockSize :self :@"bullet2.png" : @"explosion2.png" ] ];
        
        [soundEffectsObject  playMySoundFile:@"bullet3" ];

    }
    else if([[currentShooter name] isEqualToString:@"electricShooter" ])
    {
        [bulletsArray addObject: [[bullet alloc] init: xStart : yStart : xEnd :yEnd :boardObject.blockSize :self :@"bullet3.png"  : @"explosion4.png" ] ];
        [soundEffectsObject  playMySoundFile:@"bullet4" ];

    }
    else if([[currentShooter name] isEqualToString:@"strongElectricShooter" ])
    {
        [bulletsArray addObject: [[bullet alloc] init: xStart : yStart : xEnd :yEnd :boardObject.blockSize :self :@"bullet3.png"  : @"explosion4.png" ] ];
        
        [soundEffectsObject  playMySoundFile:@"bullet5" ];

    }
    
    
    
}
-(void) rotateShooters : (Shooter *) currentShooter : (Tank *) currentTank
{
    double xDiff = [[currentShooter objectGunShape ] xPosition ]  - [[currentTank objectShape ] xPosition];
    double yDiff = [[currentShooter objectGunShape ] yPosition ]  - [[currentTank objectShape ] yPosition];
    
    double angle = 360 - ( (atan2( xDiff , yDiff) * (180 / M_PI) ) + 90 ) ;
    
    [currentShooter setBusyShooting:true ];
    
    
    [[currentShooter objectGunShape] rotateDrawableObject: - [[currentShooter objectGunShape ] rotation ] ];
    [[currentShooter objectGunShape ] rotateDrawableObject: angle   ];
}
-(bool) decreaseTankLife : (Shooter *) currentShooter : (Tank *) currentTank
{
    [currentTank setLife:[currentTank life] - [currentShooter power  ]];
    [currentTank setLifeBarWidth];
    
    
    if([currentTank life ] <= 0)
    {
        if(currentMoney + [currentTank killRevenue] <= 999)
            currentMoney += [currentTank killRevenue];
        else
            currentMoney = 999;
        
        [currentMoneyImage updateNumberValue:currentMoney];
        [self setWeaponsImages];
        [bombViewObject updateBombsImages:currentMoney];
        
        
        [currentTank removeTank];
        [currentTank release];
        
        return true;
        
    }
    else
        return false;
}
-(bool) decreaseTankLifeByBomb:(Bomb *)currentBomb :(Tank *)currentTank
{
    [currentTank setLife:[currentTank life] -  [currentTank maxLife]*[currentBomb cost]/4 ];
    [currentTank setLifeBarWidth];
    
    
    
    
    if([currentTank life ] <= 0)
    {
        if(currentMoney + [currentTank killRevenue] <= 999)
            currentMoney += [currentTank killRevenue];
        else
            currentMoney = 999;
        
        [currentMoneyImage updateNumberValue:currentMoney];
        [self setWeaponsImages];
        [bombViewObject updateBombsImages:currentMoney];
        
        
        
        
        [currentTank removeTank];
        [currentTank release];

        
        return true;
        
    }
    else
        return false;
}
-(void) moveShootTanksAndRotateShootersToTanks
{

    bool disableBullet1 = true;
    bool disableMotorCycle = true;
    bool disableHummar = true;
    bool disableTank = true;
    bool disableApache = true;
    bool disablePlane = true;

    NSMutableArray *busyShootingArray= [NSMutableArray new];
    
    int rightEnd = boardObject.xStart +  (int)boardObject.cols * (int)boardObject.blockSize.width;
    
    for(int t=(int)([wavesArray[activeWaveNumber] tanksArray].count)-1 ;t>=0 && t< [wavesArray[activeWaveNumber] tanksArray].count && [wavesArray[activeWaveNumber] moveTheTank:t : rightEnd]  ; t--)
    {
        Tank *currentTank = [wavesArray[activeWaveNumber] tanksArray][t];

        if([[currentTank  name] isEqualToString:@"apache.png"])
        {
            [currentTank setName:@"apache2.png"];
            [[currentTank objectShape] imageShape].image = [UIImage imageNamed:@"apache2.png"];
        }
        else if([[currentTank  name] isEqualToString:@"apache2.png"])
        {
            [currentTank setName:@"apache.png"];
            [[currentTank objectShape] imageShape].image = [UIImage imageNamed:@"apache.png"];
        }
        
        
        if((int)[[ currentTank objectShape] xPosition] + (int)[[currentTank objectShape] imageSize].width  > 0 && (int)[[ currentTank objectShape] xPosition] + (int)[[currentTank objectShape] imageSize].width <= rightEnd)
        {
            
            bool tankDied = false;
            
            
            //sound
            if([[currentTank  name] isEqualToString:@"motorBike.png"])
                disableMotorCycle = false;
            else if([[currentTank  name] isEqualToString:@"newHummer.png"])
                disableHummar = false;
            else if([[currentTank  name] isEqualToString:@"tank.png"])
                disableTank = false;
            else if([[currentTank  name] isEqualToString:@"apache.png"])
                disableApache = false;
            else if([[currentTank  name] isEqualToString:@"plane.png"])
                disablePlane = false;
           
            
            
            
            int j = (int)((int)currentTank.objectShape.xPosition / (int)boardObject.blockSize.width);
            int i = (int)((int)currentTank.objectShape.yPosition / (int)boardObject.blockSize.height);
            
            
            if([boardObject.bombBoard[i][j] bombExist])
            {
                [boardObject.bombBoard[i][j] showExplosion];

                [soundEffectsObject playMySoundFile:@"bullet3"];
                if([self decreaseTankLifeByBomb: boardObject.bombBoard[i][j] :currentTank ] )
                {
                    [[wavesArray[activeWaveNumber] tanksArray] removeObjectAtIndex:t];
                    
                    tankDied = true;
                    [boardObject removeBombObject:i:j];

                    continue;
                }
                else
                    [boardObject removeBombObject:i:j];

            }
    
            
            int startIndexI = i - 2;
            int startIndexJ = j - 2;
            
            if( startIndexI < 0 )
                startIndexI = 0;
            
            if ( startIndexJ < 0 )
                startIndexJ = 0;
            
            
            for(int k = startIndexI ;k>=0 && k < startIndexI + 5 && k < [boardObject.board count] ; k++ )
            {
                for(int g = startIndexJ ;g>=0 && g < startIndexJ + 5  &&  g < [boardObject.board[0] count] ; g++)
                {
                    if([boardObject.board[k][g]  shooterExist] &&
                       [self insideRangeCircle : [[currentTank objectShape] xPosition]  : [[currentTank objectShape] yPosition]  : [currentTank tankSize] : boardObject.board[k][g]  ]
                        &&  ![boardObject.board[k][g] busyShooting])
                    {
                        
                        
                        //sound
                        if([[boardObject.board[k][g] name] isEqualToString:@"manShooter"])
                        {
                            disableBullet1 = false;
                        }
                        
                        
                        
                        [busyShootingArray addObject:[[IJIndex alloc] init : k : g]];
                        [boardObject.board[k][g] setBusyShooting:true ];
                        
                        
                        
                        
                        
                        [boardObject.board[k][g] updateRate ];
                        [self rotateShooters:boardObject.board[k][g] :currentTank];

                        
                        
                    
                        if(![boardObject.board[k][g] reloading] )
                        {

                            [self createBullets:boardObject.board[k][g] :currentTank];
                            
                            if([self decreaseTankLife:boardObject.board[k][g] :currentTank ] )
                            {
                                [[wavesArray[activeWaveNumber] tanksArray] removeObjectAtIndex:t];
                                tankDied = true;
                                break;
                            }
                        }
                        
                    }
                }
                if(tankDied)
                    break;
                
            }
        }
    }
    
    int valuesCount = 0;
    for(int i=0 ; i< busyShootingArray.count ; i++)
    {
        valuesCount++;
        [boardObject.board[[busyShootingArray[i] i]][[busyShootingArray[i] j]] setBusyShooting:false];
        [busyShootingArray[i] release];
    }
    
    
    [busyShootingArray release];
    
    
        
    totalLife  = totalLife -  [wavesArray[activeWaveNumber] passedTanks];
    [wavesArray[activeWaveNumber] setPassedTanks:0];
    [totalLifeNumber updateNumberValue:totalLife];
    
    
    
    if(disableBullet1)
        [soundEffectsObject stopMySoundFile:@"bullet1"];
        
    
    
    if(disableMotorCycle)
        [soundEffectsObject stopMySoundFile:@"motorCycleSound"];
    else
        [soundEffectsObject playMySoundFile:@"motorCycleSound"];
    
    if(disableHummar)
        [soundEffectsObject stopMySoundFile:@"hummarSound"];
    else
        [soundEffectsObject playMySoundFile:@"hummarSound"];
    
    if(disableTank)
        [soundEffectsObject stopMySoundFile:@"tankSound"];
    else
        [soundEffectsObject playMySoundFile:@"tankSound"];
    
    if(disableApache)
        [soundEffectsObject stopMySoundFile:@"apacheSound"];
    else
        [soundEffectsObject playMySoundFile:@"apacheSound"];
    
    if(disablePlane)
        [soundEffectsObject stopMySoundFile:@"planeSound"];
    else
        [soundEffectsObject playMySoundFile:@"planeSound"];    
}




-(bool) checkDefaultPath
{
    
    for(int  i=0 ; i< level.entranceCount ; i++)
    {
        Dijkstra *pathFinderObject = [[Dijkstra alloc] init:boardObject.board :level.startBlocks[i]  :level.endBlocks[i]];
        NSMutableArray *defaultPath = [pathFinderObject getPathSequence:level.startBlocks[i] :level.endBlocks[i]];
        if(defaultPath.count == 0)
        {
            [pathFinderObject release];
            return false;
        }
        else
            [pathFinderObject release];
    }
    
    return true;
}
-(bool) checkToAddShooterAndGetPath
{
    if(![self checkDefaultPath])
    {
        return false;
    }
    
    
    NSMutableArray *tempPaths = [NSMutableArray new];
    NSMutableArray *tempPathsCounters = [NSMutableArray new];
    
    
    int k=  activeWaveNumber;
    Wave  *waveObject = wavesArray[k];
    
    for(int i=0 ; i< [waveObject tanksArray].count ; i++)
    {
        
        
        IJIndex *currentIJIndex = [waveObject.tanksArray[i] tankPath][[waveObject.tanksArray[i] pathCounter]];
        
        int checkResult = -1;
        if(i>0)
        {
            checkResult =   [self checkIfTankInPath:tempPaths[i-1] :currentIJIndex];
            if(checkResult!=-1)
            {
                NSNumber* intValue = [NSNumber numberWithInt:checkResult];
                
                tempPathsCounters[i] = intValue;
                
                tempPaths[i] = tempPaths[i-1];
            }
        }
        
        if( i==0 || checkResult==-1 )
        {
            
            Dijkstra *pathFinderObject = [[Dijkstra alloc] init:boardObject.board :currentIJIndex :level.endBlocks[activeWaveNumber]];
            NSMutableArray *finalPath = [pathFinderObject getPathSequence:currentIJIndex :level.endBlocks[activeWaveNumber]];

            if(finalPath.count == 0)
            {
                [tempPaths release];
                [tempPathsCounters release];
                
                [pathFinderObject release];
                

                return false;
            }
            else
            {
                [tempPaths addObject:finalPath];
                NSNumber* intValue = [NSNumber numberWithInt:(int)finalPath.count-1];
                tempPathsCounters[i] = intValue;
                
                [pathFinderObject release];

            }

        }
    }
    
    
    for(int i=0 ; i< tempPaths.count ; i++)
    {
        [waveObject.tanksArray[i] setTankPath: tempPaths[i]];
        [waveObject.tanksArray[i] setPathCounter: [tempPathsCounters[i] intValue]];
    }
    
    [tempPaths release];
    [tempPathsCounters release];


    return true;
}
-(int)  checkIfTankInPath :(NSMutableArray*) lastPath : (IJIndex*) tankIndex
{
    for(int i=(int)lastPath.count-1  ;i>=0  ; i--)
    {
        if([lastPath[i] i] == tankIndex.i && [lastPath[i] j] == tankIndex.j)
        {
            return i;
        }
    }
    
    return  -1;
}






-(void) setWeaponsImages
{
    if(currentMoney < 60)
    {
        [strongElectricWeapon imageShape].userInteractionEnabled = false;
        [strongElectricWeapon imageShape].image = [UIImage imageNamed:@"strongElectricWithMoneyBlack.png" ];
    }
    else
    {
        [strongElectricWeapon imageShape].userInteractionEnabled = true;
        [strongElectricWeapon imageShape].image = [UIImage imageNamed:@"strongElectricWithMoney.png" ];
    }
    
    if(currentMoney < 40 )
    {
        [electricWeapon imageShape].userInteractionEnabled = false;
        [electricWeapon imageShape].image = [UIImage imageNamed:@"electricWithMoneyBlack.png" ];
    }
    else
    {
        [electricWeapon imageShape].userInteractionEnabled = true;
        [electricWeapon imageShape].image = [UIImage imageNamed:@"electricWithMoney.png" ];
    }
    
    if(currentMoney < 25 )
    {
        [starWeapon imageShape].userInteractionEnabled = false;
        [starWeapon imageShape].image = [UIImage imageNamed:@"starWithMoneyBlack.png" ];
    }
    else
    {
        [starWeapon imageShape].userInteractionEnabled = true;
        [starWeapon imageShape].image = [UIImage imageNamed:@"starWithMoney.png" ];
    }
    
    if(currentMoney < 15 )
    {
        [singleArmWeapon imageShape].userInteractionEnabled = false;
        [singleArmWeapon imageShape].image = [UIImage imageNamed:@"singleArmWithMoneyBlack.png" ];
    }
    else
    {
        [singleArmWeapon imageShape].userInteractionEnabled = true;
        [singleArmWeapon imageShape].image = [UIImage imageNamed:@"singleArmWithMoney.png" ];
    }
    
    
    if(currentMoney < 5 )
    {
        [manWeapon imageShape].userInteractionEnabled = false;
        [manWeapon imageShape].image = [UIImage imageNamed:@"manShooterWithMoneyBlack.png" ];
    }
    else
    {
        [manWeapon imageShape].userInteractionEnabled = true;
        [manWeapon imageShape].image = [UIImage imageNamed:@"manShooterWithMoney.png" ];
    }
    
    
    
    
    
}
-(void) setCurrentPressedWeapon : (UITouch*) touch : (CGPoint) location
{
    if(!weaponPressed)
    {
        if( [touch view] == [strongElectricWeapon imageShape] )
        {
            weaponPressed= true;
            
            currentPressedWeapon = @"strongElectricShooter";
        }
        else if( [touch view] == [electricWeapon imageShape] )
        {
            weaponPressed= true;
            currentPressedWeapon = @"electricShooter";
        }
        else if([touch view] == [starWeapon imageShape])
        {
            weaponPressed = true;
            currentPressedWeapon = @"starShooter";
        }
        else if([touch view] == [singleArmWeapon imageShape])
        {
            weaponPressed = true;
            currentPressedWeapon = @"singleArmShooter";
        }
        else if([touch view] == [manWeapon imageShape])
        {
            weaponPressed = true;
            currentPressedWeapon = @"manShooter";
        }
    }
    
    
}
-(void) setAddShootersRangeCircle : (CGPoint) location
{
    int j = (int)((int)location.x / (int)boardObject.blockSize.width);
    int i = (int)((int)location.y / (int)boardObject.blockSize.height);
    
    if(i >= 0 && i <= boardObject.rows-1 && j>=0 && j<= boardObject.cols-1)
    {
        if(lastPressedShooterIndex.i != -1 && lastPressedShooterIndex.j !=-1)
        {
            [boardObject.board[lastPressedShooterIndex.i][lastPressedShooterIndex.j] addAndRemoveRangeCircle];
            lastPressedShooterIndex.i = -1;
            lastPressedShooterIndex.j = -1;
        }
        
        if([[boardObject.board[i][j] objectShape ] imageShape])
        {
            [soundEffectsObject playMySoundFile:@"buttonSound"];
            [boardObject.board[i][j] addAndRemoveRangeCircle];
            lastPressedShooterIndex.i = i;
            lastPressedShooterIndex.j = j;
        }
    }
}
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [ touches anyObject ];
    CGPoint location = [ touch locationInView: self ];
  
    if(!popUpMessageActivated)
    {
        if(![bombViewObject activated] )
            [self handleSallingShooter :touch : location];

        
        [self setCurrentPressedWeapon:touch :location];

        
        if( bombViewButton !=NULL)
        [self handleBombViewClicks:touch : location];


        if(weaponPressed)
        {
            [soundEffectsObject playMySoundFile:@"getSound"];
        }
    }
}
-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [ touches anyObject ];
    CGPoint location = [ touch locationInView: self ];
    
    if(weaponPressed && !popUpMessageActivated )
    {
        
        int j = (int)((int)location.x / (int)boardObject.blockSize.width);
        int i = (int)((int)location.y / (int)boardObject.blockSize.height);
        
        if(i >= 0 && i <= boardObject.rows-1 && j>=0 && j<= boardObject.cols-1)
        {
            
            int xStartInBlock = (int)((boardObject.blockSize.width*0.2) / 2);
            int yStartInBlock = (int)((boardObject.blockSize.height*0.2) / 2);
            
            
            if(i!=0 && i!=boardObject.rows-1)
                touchMoveImage.frame = CGRectMake(boardObject.blockSize.width* j + boardObject.xStart +xStartInBlock  , boardObject.blockSize.height * i + boardObject.yStart + yStartInBlock, boardObject.blockSize.width*0.8  , boardObject.blockSize.height*0.8  );
        
        }
        else
        {
            weaponPressed = false;
            touchMoveImage.frame = CGRectMake(-200, -200, boardObject.blockSize.width, boardObject.blockSize.height);
            [currentPressedWeapon release];
        }
    }
}
-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [ touches anyObject ];
    CGPoint location = [ touch locationInView: self ];
    if(weaponPressed && !popUpMessageActivated)
    {
        touchMoveImage.frame = CGRectMake(-200, -200, boardObject.blockSize.width, boardObject.blockSize.height);
        
        int j = (int)((int)location.x / (int)boardObject.blockSize.width);
        int i = (int)((int)location.y / (int)boardObject.blockSize.height);
        
        if(i >= 0 && i <= boardObject.rows-1 && j>=0 && j<= boardObject.cols-1)
        {
            if(![boardObject.board [i][j] shooterExist]  && ![boardObject.bombBoard[i][j] bombExist] )
            {
                bool donePutting = true;
                
                if(bombWeapon)
                {
                    if( [self checkStartBlocks:i :j] && !(i == 0 || i==boardObject.rows-1) )
                    {
                        if(![boardObject addBombObject:i :j :currentPressedWeapon])
                            donePutting = false;
                    }
                    else
                        donePutting = false;
                }
                else
                {
                    if( ![boardObject addShooterObject:i :j : currentPressedWeapon])
                        donePutting = false;
                    
                    
                    if(  ![self checkStartBlocks:i :j] || (i == 0 || i==boardObject.rows-1) || ![self checkToAddShooterAndGetPath] )
                    {
                        [boardObject removeShooterObject : i :j];
                        donePutting = false;
                    }
                }
                
                
                if(donePutting)
                {
                    if(level.levelNumber == 1 )
                    {
                        [tutorialObject stop];
                    }
                    
                    if(bombWeapon)
                        currentMoney -= [boardObject.bombBoard[i][j]  cost];
                    else
                        currentMoney -= [boardObject.board[i][j]  cost];
                    
                    
                
                    
                    [currentMoneyImage updateNumberValue:currentMoney];
                    [bombViewObject updateBombsImages:currentMoney];
                    
                    [soundEffectsObject playMySoundFile:@"putSound"];
                    
                    [self setWeaponsImages];
                }
                else
                {
                    [soundEffectsObject playMySoundFile:@"rejectSound"];
                }
            }
            else
            {
                [soundEffectsObject playMySoundFile:@"rejectSound"];
            }
        }
        
        [currentPressedWeapon  release];
    
    }

    weaponPressed = false;
    bombWeapon = false;
}


-(bool) checkStartBlocks : (int ) iIndex : (int) jIndex
{
    for(int i=0 ; i< level.entranceCount  ; i++)
    {
        if([level.startBlocks[i] i] == iIndex  &&   [level.startBlocks[i] j] == jIndex)
            return false;
        else if([level.endBlocks[i] i] == iIndex  &&   [level.endBlocks[i] j] == jIndex)
            return false;
    }
    return true;
}




-(void) buttonsClickHandler : (id) sender
{
    if(!popUpMessageActivated)
    {
        [soundEffectsObject playMySoundFile:@"buttonSound"];
        if( [[(UIButton*)sender currentTitle] isEqualToString: @"runWaveButton.png" ]  )
        {            
            [(UIButton*) sender setImage:[UIImage imageNamed:@"pauseButton.png"] forState:UIControlStateNormal];
            [(UIButton*) sender setTitle:@"pauseButton.png" forState:UIControlStateNormal] ;
            [gameTimer invalidate ];
            gameTimer = NULL;
            [self initGameTimer];
            
            
            
            [self ratingFunction];

        }
        else if([[(UIButton*)sender currentTitle] isEqualToString: @"pauseButton.png" ])
        {
            [(UIButton*) sender setImage:[UIImage imageNamed:@"runWaveButton.png"] forState:UIControlStateNormal];
            [(UIButton*) sender setTitle:@"runWaveButton.png" forState:UIControlStateNormal] ;
            [gameTimer invalidate ];
            gameTimer = NULL;
            
            
            [soundEffectsObject stopLoopingSounds];
            
        }
        else if([[(UIButton*)sender currentTitle] isEqualToString: @"runFastButton.png" ] ||  [[(UIButton*)sender currentTitle] isEqualToString: @"runFastButton2.png" ] )
        {
            if( fabsf( currentSpeed - (float)0.03)  < 0.000001)
            {
                [(UIButton*) sender setImage:[UIImage imageNamed:@"runFastButton2.png"] forState:UIControlStateNormal];
                [(UIButton*) sender setTitle:@"runFastButton2.png" forState:UIControlStateNormal] ;
                currentSpeed = 0.015;
            }
            else if( fabsf( currentSpeed  - (float)0.015)  < 0.000001 )
            {
                [(UIButton*) sender setImage:[UIImage imageNamed:@"runFastButton.png"] forState:UIControlStateNormal];
                [(UIButton*) sender setTitle:@"runFastButton.png" forState:UIControlStateNormal] ;
                currentSpeed = 0.03;
            }
            
            
            if(gameTimer!=NULL)
            {
                [gameTimer invalidate ];
                gameTimer = NULL;
                [self initGameTimer];
            }
        }
        else if((UIButton*)sender == gridButton)
        {
            [boardObject hideAndShowGrid];
            [soundEffectsObject stopLoopingSounds];
            
        }
        else if((UIButton*)sender == homeButton )
        {
            if(level.levelNumber == 1)
            {
                [tutorialObject pause];

                tutPausedDueToMessage = true;
            }
            
            
            
            if(gameTimer == NULL)
                ;
            else
            {
                [gameTimer invalidate];
                gameTimer = NULL;
                [soundEffectsObject stopLoopingSounds];
                pausedDueToPopUpMessage = true;
            }
            
            
            popUpMessages *vMessage = [[popUpMessages alloc] init:self :currentWindowBounds :@"confirmationImage.png" : -1 : soundEffectsObject];
            [vMessage setDelegate:self];
            [vMessage addMessage];
            popUpMessageActivated= true;
        }
        
        else if((UIButton*)sender == resetButton)
        {
            if(level.levelNumber ==1 )
            {
                [tutorialObject pause];
                
                tutPausedDueToMessage = true;
            }
            
            
            
            
            if(gameTimer == NULL)
                ;
            else
            {
                [gameTimer invalidate ];
                gameTimer = NULL;
                [soundEffectsObject stopLoopingSounds];
                pausedDueToPopUpMessage = true;
            }
            
            popUpMessages *vMessage = [[popUpMessages alloc] init:self :currentWindowBounds :@"confirmationImage.png" : -2 : soundEffectsObject];
            [vMessage setDelegate:self];
            [vMessage addMessage];
            popUpMessageActivated= true;
        }
    }
    
}


-(void) setPopUpMessageActivated
{
    popUpMessageActivated = false;
    if(pausedDueToPopUpMessage)
    {
        pausedDueToPopUpMessage = false;
        [self initGameTimer];
    }
    
    if(tutPausedDueToMessage)
    {
        tutPausedDueToMessage = false;
        [tutorialObject play];
    }
}






-(bool) inImageRange : (int) currentX : (int) currentY : (DrawableObject*) image
{
    int  bombViewX = (int) [bombViewObject frame].origin.x;
    int  bombViewY = (int) [bombViewObject frame].origin.y;
    
    if( currentX >=  bombViewX + [image xPosition]
       &&  currentX <=  bombViewX + [image xPosition] + [image imageSize].width
       &&  currentY >=  bombViewY + [image yPosition]
       && currentY <=  bombViewY + [image yPosition] + [image imageSize].height
       )
    {
        return true;
    }
    else
        return false;
}
-(void) handleBombViewClicks : (UITouch*) touch : (CGPoint) location
{
 
    if([bombViewObject activated])
    {
        
        if([self inImageRange:location.x :location.y :[bombViewObject bomb1] ]  &&  currentMoney >=1)
        {
            bombWeapon = true;
            weaponPressed = true;
            currentPressedWeapon = @"bomb1";
        }
        else if([self inImageRange:location.x :location.y :[bombViewObject bomb2] ] &&  currentMoney >=2)
        {
            bombWeapon = true;
            weaponPressed = true;
            currentPressedWeapon = @"bomb2";
        }
        else if([self inImageRange:location.x :location.y :[bombViewObject bomb3] ] &&  currentMoney >=3)
        {
            bombWeapon = true;
            weaponPressed = true;
            currentPressedWeapon = @"bomb3";
        }
        else if([self inImageRange:location.x :location.y :[bombViewObject bomb4] ] &&  currentMoney >=4)
        {
            bombWeapon = true;
            weaponPressed = true;
            currentPressedWeapon = @"bomb4";
        }
    }
    
    
    if([bombViewObject activated])
    {
        [bombViewObject hide];
        [bombViewObject setActivated:false];
    }
    else if( [touch view] == [bombViewButton imageShape] && ![bombViewObject activated] )
    {
        [soundEffectsObject playMySoundFile:@"getSound"];
        
        [bombViewObject show];
        [bombViewObject setActivated:true];
    
    }
}


-(void) handleSallingShooter : (UITouch*) touch :(CGPoint) location
{
    bool selling = false;
    
    
    if(lastPressedShooterIndex.i !=-1 && lastPressedShooterIndex.j!=-1)
    {
        if( [touch view] == [[boardObject.board[lastPressedShooterIndex.i][lastPressedShooterIndex.j]  dollarShape] imageShape ] )
        {
            [soundEffectsObject playMySoundFile:@"saleSound"];
            
            currentMoney += (int)([boardObject.board[lastPressedShooterIndex.i][lastPressedShooterIndex.j] cost] * 0.8);
            [currentMoneyImage updateNumberValue:currentMoney];
            
            [self setWeaponsImages];
            [bombViewObject updateBombsImages: currentMoney];
            
            [boardObject removeShooterObject:lastPressedShooterIndex.i :lastPressedShooterIndex.j];
            
            
            lastPressedShooterIndex.i = -1;
            lastPressedShooterIndex.j = -1;
            selling =true;
            
            
            [self checkToAddShooterAndGetPath];
            
        }
        
    }
    if(!selling)
        [self setAddShootersRangeCircle:location];
}



































@end
