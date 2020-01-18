//
//  OptionsViewController.m
//  Army Defence Free
//
//  Created by Amr Labib on 17/01/2020.
//  Copyright © 2020 amr hamdy. All rights reserved.
//

#import "OptionsViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController

- (IBAction)HomeButton:(id)sender {
    [[self navigationController] popViewControllerAnimated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initOptions];
}

-(id) initOptions
{
    savedTextRef = [[savedText alloc] init];
    
    starURL = @"star.png";
    
    CGRect screenBounds = [[UIScreen mainScreen] bounds];

    CGFloat screenWidth = screenBounds.size.width;
    CGFloat screenHeight = screenBounds.size.height;
    
    if(screenWidth < 1024)
    {
        starURL = @"starSmall.png";
    }
    
    [self addTextAndButtons : screenWidth : screenHeight];
}

-(void) addTextAndButtons : (int) screenWidth : (int) screenHeight
{
    CGSize soundImagesSize;
    soundImagesSize.width = screenWidth*0.25;
    soundImagesSize.height = soundImagesSize.width*0.21;
    
    CGSize diffImageSize;
    diffImageSize.width = screenWidth*0.25;
    diffImageSize.height = diffImageSize.width*0.13;
    
    
    CGSize buttonsSize;
    buttonsSize.width = screenWidth*0.05;
    buttonsSize.height = screenWidth*0.05;
    
    
    
    int xSpace = screenWidth*0.2;
    int ySpace = screenHeight*0.2;
    
    
    int xStart = screenWidth/2 - (diffImageSize.width + xSpace + buttonsSize.width)/2 ;
    int yStart = screenHeight/2 - (diffImageSize.height + ySpace + buttonsSize.height)/2;
    
    
    
    UIImageView *difficultyImage =[[UIImageView alloc]init];
    difficultyImage.frame = CGRectMake(xStart , yStart*1.05 , diffImageSize.width  , diffImageSize.height);
    difficultyImage.image=[UIImage imageNamed:@"difficultyImage.png"];
    [self.view addSubview:difficultyImage];
    
    
    UIImageView *soundImage =[[UIImageView alloc]init];
    soundImage.frame = CGRectMake( xStart, yStart +ySpace , soundImagesSize.width*0.55  , soundImagesSize.height*0.55);
    soundImage.image=[UIImage imageNamed:@"soundImage.png"];
    [self.view addSubview:soundImage];
    
    
    
    UIImageView *musicImage =[[UIImageView alloc]init];
    musicImage.frame = CGRectMake( xStart, yStart +ySpace*2 , soundImagesSize.width*0.55  , soundImagesSize.height*0.55);
    musicImage.image=[UIImage imageNamed:@"musicImage.png"];
    [self.view addSubview:musicImage];
    
    
    
    int soundOnValue =  [savedTextRef getLevelValue:26];
    int musicOnValue =  [savedTextRef getLevelValue:27];

    
    if(soundOnValue == 1)
        soundButton  = [self initButtonAttrCurrent:xStart+ soundImagesSize.width+xSpace :yStart + diffImageSize.height/2 + ySpace - buttonsSize.height/2:buttonsSize.width:buttonsSize.height :@"soundOn.png" ];
    else
        soundButton  = [self initButtonAttrCurrent:xStart+ soundImagesSize.width+xSpace :yStart + diffImageSize.height/2 + ySpace - buttonsSize.height/2 :buttonsSize.width:buttonsSize.height :@"soundOff.png" ];
    
    
    if(musicOnValue == 1)
        musicButton  = [self initButtonAttrCurrent:xStart+ soundImagesSize.width+xSpace :yStart + diffImageSize.height/2 + ySpace*2 - buttonsSize.height/2:buttonsSize.width:buttonsSize.height :@"soundOn.png" ];
    else
        musicButton  = [self initButtonAttrCurrent:xStart+ soundImagesSize.width+xSpace :yStart + diffImageSize.height/2 + ySpace*2 - buttonsSize.height/2 :buttonsSize.width:buttonsSize.height :@"soundOff.png" ];



    
    
    int diffValue =  [savedTextRef getLevelValue:25];

   
    
    star1 = [self initButtonAttrCurrent:xStart+ diffImageSize.width+xSpace - buttonsSize.width :yStart + soundImagesSize.height/2 - buttonsSize.height/2:buttonsSize.width:buttonsSize.height  :starURL ];
    
    if(diffValue >= 2)
        star2 = [self initButtonAttrCurrent:xStart+ diffImageSize.width+xSpace :yStart + soundImagesSize.height/2 - buttonsSize.height/2 :buttonsSize.width:buttonsSize.height  :starURL ];
    else
        star2 = [self initButtonAttrCurrent:xStart+ diffImageSize.width+xSpace :yStart + soundImagesSize.height/2 - buttonsSize.height/2 :buttonsSize.width:buttonsSize.height  :@"emptyStar.png" ];

    if(diffValue ==3)
        star3 = [self initButtonAttrCurrent:xStart+ diffImageSize.width+xSpace + buttonsSize.width:yStart + soundImagesSize.height/2 - buttonsSize.height/2:buttonsSize.width:buttonsSize.height  :starURL];
    else
        star3 = [self initButtonAttrCurrent:xStart+ diffImageSize.width+xSpace   + buttonsSize.width:yStart + soundImagesSize.height/2 - buttonsSize.height/2 :buttonsSize.width:buttonsSize.height  :@"emptyStar.png" ];
    
    
    
    [self.view addSubview:soundButton];
    [self.view addSubview:musicButton];

    [self.view addSubview:star1];
    [self.view addSubview:star2];
    [self.view addSubview:star3];

    
}

-(UIButton*) initButtonAttrCurrent : (int) x :  (int) y : (int) width : (int) height  : (NSString*) name
{
    UIButton *currentButton = [[UIButton alloc] initWithFrame:CGRectMake(x , y, width, height)];
    [currentButton setTitle:name forState:UIControlStateNormal ];
    [currentButton addTarget:self action:@selector(currentButtonClickHandler:) forControlEvents:UIControlEventTouchUpInside];
    [currentButton setImage:[UIImage imageNamed:name] forState:UIControlStateNormal];
    currentButton.exclusiveTouch =YES;
    
    return currentButton;
}

-(void) currentButtonClickHandler :(id) sender
{
    if((UIButton*)sender == soundButton)
    {
        if([[soundButton currentTitle] isEqualToString: @"soundOn.png" ])
        {
            [soundButton setTitle:@"soundOff.png" forState:UIControlStateNormal];
            [soundButton setImage:[UIImage imageNamed:@"soundOff.png"] forState:UIControlStateNormal];
            [savedTextRef updateLevel:26 :0];
            [_soundRef setSoundEnabled:false];
        }
        else if([[soundButton currentTitle] isEqualToString: @"soundOff.png" ])
        {
            [soundButton setTitle:@"soundOn.png" forState:UIControlStateNormal];
            [soundButton setImage:[UIImage imageNamed:@"soundOn.png"] forState:UIControlStateNormal];
            [savedTextRef updateLevel:26 :1];
            [_soundRef setSoundEnabled:true];
        }
    }
    else if((UIButton*)sender == musicButton)
    {
        if([[musicButton currentTitle] isEqualToString: @"soundOn.png" ])
        {
            [musicButton setTitle:@"soundOff.png" forState:UIControlStateNormal];
            [musicButton setImage:[UIImage imageNamed:@"soundOff.png"] forState:UIControlStateNormal];
            [savedTextRef updateLevel:27 :0];
            [_soundRef stopMySoundFile:@"gameMusic"];
            [_soundRef setMusicEnabled:false];
        }
        else if([[musicButton currentTitle] isEqualToString: @"soundOff.png" ])
        {
            [musicButton setTitle:@"soundOn.png" forState:UIControlStateNormal];
            [musicButton setImage:[UIImage imageNamed:@"soundOn.png"] forState:UIControlStateNormal];
            [savedTextRef updateLevel:27 :1];
            [_soundRef setMusicEnabled:true];
            [_soundRef playMySoundFile:@"gameMusic"];

        }
    }
    else if((UIButton*)sender == star1)
    {
        [star1 setImage:[UIImage imageNamed:starURL] forState:UIControlStateNormal];
        [star2 setImage:[UIImage imageNamed:@"emptyStar.png"] forState:UIControlStateNormal];
        [star3 setImage:[UIImage imageNamed:@"emptyStar.png"] forState:UIControlStateNormal];
        [savedTextRef updateLevel:25 :1];
    }
    else if((UIButton*)sender == star2)
    {
        [star1 setImage:[UIImage imageNamed:starURL] forState:UIControlStateNormal];
        [star2 setImage:[UIImage imageNamed:starURL] forState:UIControlStateNormal];
        [star3 setImage:[UIImage imageNamed:@"emptyStar.png"] forState:UIControlStateNormal];
        [savedTextRef updateLevel:25 :2];

    }
    else if((UIButton*)sender == star3)
    {
        [star1 setImage:[UIImage imageNamed:starURL] forState:UIControlStateNormal];
        [star2 setImage:[UIImage imageNamed:starURL] forState:UIControlStateNormal];
        [star3 setImage:[UIImage imageNamed:starURL] forState:UIControlStateNormal];
        [savedTextRef updateLevel:25 :3];

    }
    [_soundRef playMySoundFile:@"buttonSound"];
}

@end
