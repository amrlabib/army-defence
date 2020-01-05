//
//  savedText.h
//  Army Defence
//
//  Created by amr hamdy on 10/14/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface savedText : NSObject
{
    NSString *text;
    NSString *levelsPurchasedText;
    
    bool armyRated;
}

@property bool armyRated;
@property (retain) NSString *levelsPurchasedText;


-(id) init;
-(void) updateLevel : (int) levelNumber : (int) value;
-(int)  getLevelValue : (int) levelNumber;
-(void) setArmyRated;
-(void) updateArmyRated :(bool) value;
-(void) setLevelsPurchased;
-(void) updateLevelsPurchased : (bool) purchased;
@end
