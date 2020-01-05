//
//  soundEffectsHandler.m
//  Army Defence
//
//  Created by amr hamdy on 10/21/13.
//  Copyright (c) 2013 amr hamdy. All rights reserved.
//

#import "soundEffectsHandler.h"

@implementation soundEffectsHandler
//  /usr/bin/afconvert -f caff -d LEI16@44100 /Users/amrhamdy/Desktop/bullet2.mp3 /Users/amrhamdy/Desktop/bullet2.caf


@synthesize  soundEnabled , musicEnabled;

-(id) init : (bool ) sEnabled : (bool) mEnabled
{
    soundEnabled = sEnabled;
    musicEnabled = mEnabled;
    
    openALDevice = alcOpenDevice(NULL);
    openALContext = alcCreateContext(openALDevice, NULL);
    alcMakeContextCurrent(openALContext);
    
    
    outputSource1 =  [self initSound:@"bullet1" ] ;
    outputSource2 =  [self initSound:@"bullet2" ] ;
    outputSource3 =  [self initSound:@"bullet2" ] ;
    outputSource4 =  [self initSound:@"bullet4" ] ;
    outputSource5 =  [self initSound:@"bullet4" ] ;
    
    
    
    outputSource6 =  [self initSound:@"motorCycleSound" ] ;
    outputSource7 =  [self initSound:@"motorCycleSound" ] ;
    outputSource8 =  [self initSound:@"tankSound" ] ;
    outputSource9 =  [self initSound:@"apacheSound" ] ;
    outputSource10 = [self initSound:@"planeSound" ] ;
    
    
    
    outputSource11 = [self initSound:@"getSound" ];
    outputSource12 = [self initSound:@"putSound" ];
    outputSource13 = [self initSound:@"getSound" ];
    outputSource14 = [self initSound:@"saleSound" ];
    outputSource15 = [self initSound:@"buttonSound" ];
    
    
    outputSource16 = [self initSound:@"winSound" ];
    outputSource17 = [self initSound:@"transportationSound"];
    outputSource18 = [self initSound:@"rejectSound" ];
    outputSource19 = [self initSound:@"gameMusic" ];




    
    return self;
}


-(ALuint) initSound: (NSString*) name
{
    bool loopStatus  = false;
    
    float volumeMultiplier = 9;
    float newVolume = 0.1f*volumeMultiplier;

    
    if(  [name isEqualToString:@"motorCycleSound"]   || [name isEqualToString:@"hummarSound"]   )
    {
        newVolume = 0.004f*volumeMultiplier;
        loopStatus = true;
    }
    else if( [name isEqualToString:@"planeSound"])
    {
        newVolume = 0.01f*volumeMultiplier;

        loopStatus = true;

    }
    else if([name isEqualToString:@"bullet1"] ||  [name isEqualToString:@"apacheSound"]  ||   [name isEqualToString:@"tankSound"]  || [name isEqualToString:@"gameMusic"] )
    {
        loopStatus = true;
    }
    else if([name isEqualToString:@"winLoseSound"]  )
    {
        newVolume = 0.8f*volumeMultiplier;
    }
    
    
    if([name isEqualToString:@"bullet1"] ||  [name isEqualToString:@"bullet4"] ||  [name isEqualToString:@"bullet5"] || [name isEqualToString:@"transportationSound"] )
    {
        newVolume = 0.05f*volumeMultiplier;
    }
    
    ALuint outputSource;
    
    
    ALenum error = alGetError();
    if (AL_NO_ERROR != error) {
        ;//NSLog(@"Error %d when attemping to open device", error, operation);
    }
    
    
    
    
    
    //ALuint outputSource;
    alGenSources(1, &outputSource);
    
    alSourcef(outputSource, AL_PITCH, 1.0f);
    alSourcef(outputSource, AL_GAIN, 1.0f);
    
    
    ALuint outputBuffer;
    alGenBuffers(1, &outputBuffer);
    
    
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"caf"];
    NSURL* fileUrl = [NSURL fileURLWithPath:filePath];
    
    
    
    AudioFileID afid;
    OSStatus openResult = AudioFileOpenURL((__bridge CFURLRef)fileUrl, kAudioFileReadPermission, 0, &afid);
    
    if (0 != openResult) {
        NSLog(@"An error occurred when attempting to open the audio file %@: %d", filePath, (int)openResult);
        //return;
    }
    
    
    
    
    UInt64 fileSizeInBytes = 0;
    UInt32 propSize = sizeof(fileSizeInBytes);
    
    OSStatus getSizeResult = AudioFileGetProperty(afid, kAudioFilePropertyAudioDataByteCount, &propSize, &fileSizeInBytes);
    
    if (0 != getSizeResult) {
        NSLog(@"An error occurred when attempting to determine the size of audio file %@: %d", filePath, (int)getSizeResult);
    }
    
    UInt32 bytesRead = (UInt32)fileSizeInBytes;
    
    
    void* audioData = malloc(bytesRead);
    
    
    
    OSStatus readBytesResult = AudioFileReadBytes(afid, false, 0, &bytesRead, audioData);
    
    if (0 != readBytesResult) {
        NSLog(@"An error occurred when attempting to read data from audio file %@: %d", filePath, (int)readBytesResult);
    }
    
    
    AudioFileClose(afid);
    
    alBufferData(outputBuffer, AL_FORMAT_STEREO16, audioData, bytesRead, 44100);
    
    if (audioData) {
        free(audioData);
        audioData = NULL;
    }
    

    
    alSourcef(outputSource, AL_GAIN, newVolume);
    
    alSourcei(outputSource, AL_BUFFER, outputBuffer);
    
    
    
    alSourcei (outputSource, AL_LOOPING,  loopStatus  );
    
    
    return outputSource;
    
}

-(void) playMySoundFile  : (NSString*) name
{
    if(soundEnabled)
    {
        if([name isEqualToString:@"bullet1"] && !bullet1Busy)
        {
            bullet1Busy = true;
            alSourcePlay(outputSource1);
        }
        else if([name isEqualToString:@"bullet2"])
        {
            ALint state;
            alGetSourcei( outputSource2, AL_SOURCE_STATE, &state);
            if (state != AL_PLAYING)
            {
                alSourcePlay(outputSource2);
                
            }
        }
        else if([name isEqualToString:@"bullet3"])
        {
            ALint state;
            alGetSourcei( outputSource3, AL_SOURCE_STATE, &state);
            if (state != AL_PLAYING)
            {
                alSourcePlay(outputSource3);
                
            }
        }
        else if([name isEqualToString:@"bullet4"])
        {
            ALint state;
            alGetSourcei( outputSource4, AL_SOURCE_STATE, &state);
            if (state != AL_PLAYING)
            {
                alSourcePlay(outputSource4);
                
            }
        }
        else if([name isEqualToString:@"bullet5"])
        {
            ALint state;
            alGetSourcei( outputSource5, AL_SOURCE_STATE, &state);
            if (state != AL_PLAYING)
            {
                alSourcePlay(outputSource5);
                
            }
        }
        
        
        else if([name isEqualToString:@"motorCycleSound"] &&  !motorCycleBusy)
        {
            motorCycleBusy = true;
            alSourcePlay(outputSource6);
        }
        else if([name isEqualToString:@"hummarSound"] && !hummarBusy)
        {
            hummarBusy = true;
            alSourcePlay(outputSource7);
        }
        else if([name isEqualToString:@"tankSound"] &&  !tankBusy)
        {
            tankBusy = true;
            alSourcePlay(outputSource8);
        }
        else if([name isEqualToString:@"apacheSound"] && !apacheBusy)
        {
            apacheBusy = true;
            alSourcePlay(outputSource9);
        }
        else if([name isEqualToString:@"planeSound"] && !planeBusy)
        {
            planeBusy = true;
            alSourcePlay(outputSource10);
        }
        
        
        
        else if([name isEqualToString:@"getSound"] )
        {
            alSourcePlay(outputSource11);
        }
        else if([name isEqualToString:@"putSound"] )
        {
            alSourcePlay(outputSource12);
        }
        else if([name isEqualToString:@"falsePutSound"] )
        {
            alSourcePlay(outputSource13);
        }
        else if([name isEqualToString:@"saleSound"] )
        {
            alSourcePlay(outputSource14);
        }
        else if([name isEqualToString:@"buttonSound"] )
        {
            alSourcePlay(outputSource15);
        }
        
        
        else if([name isEqualToString:@"winLoseSound"] )
        {
            alSourcePlay(outputSource16);
        }
        else if([name isEqualToString:@"transportationSound"] )
        {
            alSourcePlay(outputSource17);
        }
        
        
        else if([name isEqualToString:@"rejectSound"] )
        {
            alSourcePlay(outputSource18);
        }
        
    }
    if(musicEnabled)
    {
        if([name isEqualToString:@"gameMusic"] )
        {
            alSourcePlay(outputSource19);
        }
        
    }
}
-(void) stopMySoundFile : (NSString*) name
{
    if(soundEnabled)
    {
        if([name isEqualToString:@"bullet1"] )
        {
            bullet1Busy = false;
            alSourcePause(outputSource1);
        }
        else if([name isEqualToString:@"bullet2"])
        {
            alSourcePause(outputSource2);
        }
        else if([name isEqualToString:@"bullet3"])
            alSourcePause(outputSource3);
        else if([name isEqualToString:@"bullet4"])
        {
            alSourcePause(outputSource4);
        }
        else if([name isEqualToString:@"bullet5"])
            alSourcePause(outputSource5);
        
        
        else if([name isEqualToString:@"motorCycleSound"] )
        {
            motorCycleBusy = false;
            alSourcePause(outputSource6);
        }
        else if([name isEqualToString:@"hummarSound"] )
        {
            hummarBusy = false;
            alSourcePause(outputSource7);
        }
        else if([name isEqualToString:@"tankSound"] )
        {
            tankBusy = false;
            alSourcePause(outputSource8);
        }
        else if([name isEqualToString:@"apacheSound"] )
        {
            apacheBusy = false;
            alSourcePause(outputSource9);
        }
        else if([name isEqualToString:@"planeSound"] )
        {
            planeBusy = false;
            alSourcePause(outputSource10);
        }
        
        
        
        else if([name isEqualToString:@"getSound"] )
        {
            alSourcePause(outputSource11);
        }
        else if([name isEqualToString:@"putSound"] )
        {
            alSourcePause(outputSource12);
        }
        else if([name isEqualToString:@"falsePutSound"] )
        {
            alSourcePause(outputSource13);
        }
        else if([name isEqualToString:@"saleSound"] )
        {
            alSourcePause(outputSource14);
        }
        else if([name isEqualToString:@"buttonSound"] )
        {
            alSourcePause(outputSource15);
        }
        
        
        else if([name isEqualToString:@"winLoseSound"] )
        {
            alSourcePlay(outputSource16);
        }
        else if([name isEqualToString:@"transportationSound"] )
        {
            alSourcePlay(outputSource16);
        }
        
        else if([name isEqualToString:@"rejectSound"] )
        {
            alSourcePlay(outputSource18);
        }
        
    }
    
    if(musicEnabled)
    {
        if([name isEqualToString:@"gameMusic"] )
        {
            gameMusicBusy = false;
            alSourceStop(outputSource19);
        }
    }
    

    
}
-(void) stopLoopingSounds
{
    if(soundEnabled)
    {
        bullet1Busy  =false;
        alSourcePause(outputSource1);
        
        
        motorCycleBusy = false;
        alSourcePause(outputSource6);
        hummarBusy=false;
        alSourcePause(outputSource7);
        tankBusy  = false;
        alSourcePause(outputSource8);
        apacheBusy = false;
        alSourcePause(outputSource9);
        planeBusy = false;
        alSourcePause(outputSource10);
        
        
    }
    
    
    if(musicEnabled)
    {
        gameMusicBusy = false;
        alSourceStop(outputSource19);
    }
    
}
@end
