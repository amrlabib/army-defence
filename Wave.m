//
//  Wave.m
//  ArmyStrength
//
//  Created by amr hamdy on 8/8/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "Wave.h"

@implementation Wave


@synthesize tanksArray , passedTanks , initialPathArray , startBlockIndex , endBlockIndex;

-(id) init : (UIView*) ref : (NSMutableArray*) pathRef : (CGSize) blockSize :  (IJIndex*) startIndex :  (IJIndex*) endIndex : (int) waveNumber : (int)sWidth : (int) diff
{
    waveDifficulty = diff;
    viewReference = ref;
    
    screenWidth = sWidth;
    
    tanksArray = [[NSMutableArray alloc] init];
    
    boardBlockSize = blockSize;
    
        
    initialPathArray = pathRef;
    
    startBlockIndex = startIndex;
    endBlockIndex = endIndex;
    
    [self addTanksToWave : blockSize : waveNumber];
    

    passedTanks =  0;
    
    
    return self;
}

-(void) addTanksToWave : (CGSize) blockSize : (double) waveNumber
{
    int maxNumberOfTanksInWave = 15;
    
    
    CGSize tankSize ;
    tankSize.width = boardBlockSize.width ;
    tankSize.height = boardBlockSize.height ;
    
    
    int top = startBlockIndex.i * blockSize.height  + (blockSize.height*0.1)  ;
    
    int left = -blockSize.width*1.4 ;
    if(startBlockIndex.j != 0)
        left =   blockSize.width*1.4;
    
    
    
    double randRange = ((waveNumber / maxNumberOfTanksInWave)  - (int)(waveNumber / maxNumberOfTanksInWave)) * maxNumberOfTanksInWave;
    int tanksCount = randRange;

    int tanksLifeMultiplier = ((int)(waveNumber / maxNumberOfTanksInWave))+1;
    
   
    for(int i=tanksCount-1 ;i >=0  ; i--)
    {
        NSInteger randomNumber = arc4random() % (int)randRange;
        
        NSString *tankName = [self getTankNameFromNumber:(int)randomNumber];

        if(startBlockIndex.j != 0)
        {
            [tanksArray addObject:[[Tank alloc] init:viewReference : screenWidth +  (left * (i+1)) :top :startBlockIndex.i :startBlockIndex.j : tankSize : tankName : tanksLifeMultiplier*waveDifficulty] ];
            
            [tanksArray[tanksArray.count-1] rotateTank:180];
        }
        else
        [tanksArray addObject:[[Tank alloc] init:viewReference :  left * (i+1) :top :startBlockIndex.i :startBlockIndex.j : tankSize : tankName : tanksLifeMultiplier*waveDifficulty] ];
        
        
        
        
        [[tanksArray objectAtIndex:tanksArray.count-1] setTankPath:initialPathArray];
        [[tanksArray objectAtIndex:(int)tanksArray.count-1] setPathCounter:(int)initialPathArray.count-1];
        
    }
}
-(NSString*) getTankNameFromNumber : (int) number
{
    if(number < 5)
    {
       return @"motorBike.png";
    }
    else if(number < 8)
    {
        return @"newHummer.png";

    }
    else if(number < 10)
    {
        return @"tank.png";
    }
    else if(number < 12)
    {
        return @"apache.png";
    }
    else // less than 15
        return @"plane.png";
}


-(bool) moveTheTank : (int) i  : (int) rightEnd
{
    int tankWidth = [tanksArray[i] tankSize].width ;
    int tankHeight = [tanksArray[i] tankSize].height ;
    
    IJIndex *currentIJIndex = [[IJIndex alloc] init : [[tanksArray[i] tankPath][[tanksArray[i] pathCounter]] i] : [[tanksArray[i] tankPath][[tanksArray[i] pathCounter]] j] ];//pathArray[ [tanksArray[i]  pathCounter] ] ;
    IJIndex *nextIJIndex = [[IJIndex alloc] init : [[tanksArray[i] tankPath][[tanksArray[i] pathCounter]-1] i] : [[tanksArray[i] tankPath][[tanksArray[i] pathCounter]-1] j] ];// [tanksArray[i] tankPath]x[[tanksArray[i] pathCounter]-1];  ;//pathArray[ [tanksArray[i]  pathCounter]+1 ];
    

    
    int c = [[tanksArray[i] currentNode] j] ;//(int)((int)([[tanksArray[i]  objectShape ]  xPosition  ] ) / (int)boardBlockSize.width);
    int r = [[tanksArray[i] currentNode] i]; //(int)((int)([[tanksArray[i]  objectShape ]  yPosition  ] ) / (int)boardBlockSize.height);
    
    
    int step = (int)[(Tank*)tanksArray[i]  speed];
    
    
    if([[tanksArray[i] objectShape] xPosition ] < 0)
    {
        [tanksArray[i] moveTank:step : 0 ];
    }
    else if([[tanksArray[i] objectShape] xPosition ] + tankWidth  >  rightEnd)
    {
        [tanksArray[i] moveTank:-step : 0 ];
    }
    else
    {
        if( nextIJIndex.i >  currentIJIndex.i )
        {
            [tanksArray[i] moveTank:0 :step];
            
        }
        else if(nextIJIndex.i <  currentIJIndex.i )
        {
            [tanksArray[i] moveTank:0 :-step];
        }
        else if( nextIJIndex.j >  currentIJIndex.j )
        {
            [tanksArray[i] moveTank:step :0];
        }
        else if(nextIJIndex.j <  currentIJIndex.j )
        {
            [tanksArray[i] moveTank:-step :0];
        }
        int r1 = (int)((int)([[tanksArray[i]  objectShape ]  yPosition  ] ) / (int)boardBlockSize.height);
        int c1 = (int)((int)([[tanksArray[i]  objectShape ]  xPosition  ] ) / (int)boardBlockSize.width);

        
        int r2 = (int)((int)([[tanksArray[i]  objectShape ]  yPosition  ] + tankHeight ) / (int)boardBlockSize.height);
        int c2 = (int)((int)([[tanksArray[i]  objectShape ]  xPosition  ] + tankWidth ) / (int)boardBlockSize.width);
        

        
        
        

        
        
        [self rotateTank :i  : currentIJIndex : nextIJIndex];
        
        
        
        if(r1 == r2 )
        {
            r = r1;
        }
        
        if(c1 == c2)
        {
            c = c2; // or c1 !
        }
                
        IJIndex *currentNodeValue = [[IJIndex alloc] init : r : c];
        
    
        if(currentNodeValue.i != currentIJIndex.i || currentNodeValue.j != currentIJIndex.j)
            [tanksArray[i]  setPathCounter:[tanksArray[i]  pathCounter]-1];
        


        [tanksArray[i] setCurrentNode:[[[IJIndex alloc] init : currentNodeValue.i : currentNodeValue.j] autorelease]];
        
        

        
        
        [currentNodeValue release];
        
        
        
        
        if(c == endBlockIndex.j && r == endBlockIndex.i)
        {
            passedTanks++;
            [tanksArray[i] removeTank];
            [tanksArray[i] release];
            [tanksArray removeObjectAtIndex:i];
            
            [currentIJIndex release];
            [nextIJIndex release];
            
            return false;
        }


    }
    
    
    [currentIJIndex release];
    [nextIJIndex release];
   
    
    
    return true;
}
-(void) rotateTank : (int) i : (IJIndex*) currentIJIndex : (IJIndex*) nextIJIndex
{
    [tanksArray[i] rotateTank : - [[tanksArray[i] objectShape] rotation] ] ;
    
    
    if ( nextIJIndex.i >  currentIJIndex.i )
    {
        [tanksArray[i] rotateTank:90];
    }
    else if(nextIJIndex.i <  currentIJIndex.i )
    {
        [tanksArray[i] rotateTank:-90];
    }
    else if( nextIJIndex.j >  currentIJIndex.j )
    {
        [tanksArray[i] rotateTank:0];        
    }
    else if(nextIJIndex.j <  currentIJIndex.j )
    {
        [tanksArray[i] rotateTank:180];
    }
}
-(void) dealloc
{
    for(int i=0 ; i< tanksArray.count ; i++)
    {
        [tanksArray[i] release];
    }
    [tanksArray release];

    [super dealloc];
}

@end
