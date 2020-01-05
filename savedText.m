//
//  savedText.m
//  Army Defence
//
//  Created by amr hamdy on 10/14/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "savedText.h"

@implementation savedText



-(id) init  
{
    [self setTextValue];
    [self setArmyRated];
    [self setLevelsPurchased];
    
    return self;
}

@synthesize armyRated, levelsPurchasedText;

-(void) setTextValue
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    text = [[NSUserDefaults standardUserDefaults] stringForKey:@"levelsText"];
    
    if(text == NULL )
    {
        text = @"0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0-2-1-1";  //25 stars   , 26 sound , 27 music

        [standardUserDefaults setObject: text forKey:@"levelsText"];
        [standardUserDefaults synchronize];
    }
}


-(void) setArmyRated 
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    NSString  *armyRatedString = [[NSUserDefaults standardUserDefaults] stringForKey:@"armyRatedStorage"];
    if(armyRatedString == NULL )
    {
        armyRated = false;
        armyRatedString = @"0";
        [standardUserDefaults setObject: armyRatedString forKey:@"armyRatedStorage"];
        [standardUserDefaults synchronize];
    }
    else
    {
        if([armyRatedString isEqualToString:@"1"])
        {
            armyRated = true;
        }
        else
        {
            armyRated = false;
        }
    }
}
-(void) updateArmyRated :(bool) value
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];


    armyRated = value;

    NSString  *armyRatedString = @"1";
    
    if(!value)
        armyRatedString = @"0";
    
    [standardUserDefaults setObject: armyRatedString forKey:@"armyRatedStorage"];
    [standardUserDefaults synchronize];
    
    

}

-(void) updateLevel : (int) levelNumber : (int) value
{
    
    
    NSString *currentValue = [[NSString alloc] initWithString:[text substringWithRange:NSMakeRange((levelNumber-1) * 2, 1)]];
        
    if([currentValue intValue] < value  || levelNumber > 24)
    {
        
        NSString *part1 = [[NSString alloc] initWithString:[text substringWithRange:NSMakeRange( 0  , ((levelNumber-1) * 2)) ]];
        [currentValue release];
        currentValue = [[NSString alloc] initWithFormat:@"%d" , value];
        NSString *part2 = [[NSString alloc] initWithString:[text substringWithRange:NSMakeRange( ((levelNumber-1) * 2)+1  ,  [text length] - 1 -  [part1 length])]];
        
        NSString *finalText =  [[NSString alloc] initWithString:[[part1 stringByAppendingString: currentValue ] stringByAppendingString:part2 ]];
        text = finalText;
        

        NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
        [standardUserDefaults setObject: text forKey:@"levelsText"];
        [standardUserDefaults synchronize];
        
        
        [part1 release];
        [part2 release];
        
    }
    [currentValue release];
}
-(int) getLevelValue : (int) levelNumber
{
    NSString *currentValue = [[NSString alloc] initWithString:[text substringWithRange:NSMakeRange((levelNumber-1) * 2, 1)]];
    
    int intValue = [currentValue intValue];
    
    [currentValue release];
    
    return intValue;
}



-(void) setLevelsPurchased
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    
    levelsPurchasedText = [[NSUserDefaults standardUserDefaults] stringForKey:@"levelsPurchased"];
    
    if(levelsPurchasedText == NULL)
    {
        levelsPurchasedText = @"0";
        [standardUserDefaults setObject: @"0" forKey:@"levelsPurchased"];
        [standardUserDefaults synchronize];
    }
}

-(void) updateLevelsPurchased : (bool) purchased
{
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
    if(purchased)
    {
        levelsPurchasedText = @"1";
        [standardUserDefaults setObject: @"1" forKey:@"levelsPurchased"];
        [standardUserDefaults synchronize];
    }
}



@end
