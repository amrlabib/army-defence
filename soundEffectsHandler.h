//
//  soundEffectsHandler.h
//  Army Defence
//
//  Created by amr hamdy on 10/21/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <OpenAl/al.h>
#import <OpenAl/alc.h>
#include <AudioToolbox/AudioToolbox.h>



@interface soundEffectsHandler : NSObject
{
    ALCcontext* openALContext;
    ALCdevice* openALDevice;
    
    
    bool bullet1Busy , motorCycleBusy , hummarBusy , tankBusy , apacheBusy , planeBusy , gameMusicBusy;
    
    bool soundEnabled ;
    bool musicEnabled;
    
    ALuint outputSource1;
    ALuint outputSource2;
    ALuint outputSource3;
    ALuint outputSource4;
    ALuint outputSource5;
    
    
    ALuint outputSource6;
    ALuint outputSource7;
    ALuint outputSource8;
    ALuint outputSource9;
    ALuint outputSource10;
    
    
    ALuint outputSource11;
    ALuint outputSource12;
    ALuint outputSource13;
    ALuint outputSource14;
    ALuint outputSource15;
    
    ALuint outputSource16;
    ALuint outputSource17;
    ALuint outputSource18;
    ALuint outputSource19;





    
}

@property bool soundEnabled , musicEnabled;


-(id) init : (bool) sEnabled : (bool )mEnabled;
-(ALuint) initSound: (NSString*) name;

-(void) stopMySoundFile : (NSString*) name;
-(void) playMySoundFile: (NSString*) name;

-(void) stopLoopingSounds;
@end