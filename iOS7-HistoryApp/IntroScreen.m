//
//  IntroScreen.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/27/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "IntroScreen.h"
#import "MainMenu.h"
#import "WorldHistoryMainMenu.h"
#import "MatchPix.h"
#import "LetterTrace.h"
#import "Credits.h"
#import "TeacherParent.h"
#import "Spelling.h"
#import "MontessoriData.h"
#import "FreeWrite.h"
#import "GestureView.h"

@implementation IntroScreen

@synthesize introductionLabel;
@synthesize getStartedButton;
@synthesize myMainMenu;
@synthesize matchingScene;
@synthesize traceScene;
@synthesize credits;
@synthesize teacherReview;
@synthesize spellingScene;
@synthesize freeWriteScene;

AVAudioPlayer *avSound;
SKLabelNode *optionsMenu;
SKLabelNode *dragNDrop;
SKLabelNode *parentTeacher;
SKLabelNode *handwritingScene;
SKLabelNode *tracingScene;
SKLabelNode *creditsScene;
SKLabelNode *spellingLabel;
SKLabelNode *freeTrace;

SKLabelNode *optionsMenu;
SKLabelNode *moveableAlpha;

NSMutableArray *texturesForAnim;

CGFloat width;
CGFloat height;
BOOL isPhone = TRUE;
CGFloat fontSizeForPlatform = 24;


- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        
       /* for (NSString* family in [UIFont familyNames])
        {
            NSLog(@"%@", family);
            
            for (NSString* name in [UIFont fontNamesForFamilyName: family])
            {
                NSLog(@"  %@", name);
            }
        }*/
        
        self.backgroundColor = [SKColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0];

        width = self.size.width;
        height = self.size.height;
        
        SKSpriteNode *lightEffectBg = [SKSpriteNode spriteNodeWithImageNamed:@"light_2"];
        lightEffectBg.position = CGPointMake(width/2-100, height/2+240);
        lightEffectBg.alpha = 1.0;
        [self addChild:lightEffectBg];
        [lightEffectBg runAction:[SKAction fadeAlphaTo:1.0 duration:8.0]];
        
        SKSpriteNode *handEffect = [SKSpriteNode spriteNodeWithImageNamed:@"handprint-lightblue"];
        handEffect.position = CGPointMake(width / 2, height/2.4);
        handEffect.alpha = 0.1;
        [self addChild:handEffect];

        SKSpriteNode *lightEffectBg3 = [SKSpriteNode spriteNodeWithImageNamed:@"blue-light-effect"];
        lightEffectBg3.position = CGPointMake(width/2, height/2);
        lightEffectBg3.alpha = 0.0;
        [self addChild:lightEffectBg3];
        [lightEffectBg3 runAction:[SKAction fadeAlphaTo:0.8 duration:6.0]];
        
        SKSpriteNode *lightEffectBg4 = [SKSpriteNode spriteNodeWithImageNamed:@"light_2"];
        lightEffectBg4.position = CGPointMake(width/2, height/2+50);
        lightEffectBg4.alpha = 0.0;
        [self addChild:lightEffectBg4];
        [lightEffectBg4 runAction:[SKAction fadeAlphaTo:1.0 duration:2.0]];
        
        SKSpriteNode *lightEffectBg2 = [SKSpriteNode spriteNodeWithImageNamed:@"light_2"];
        lightEffectBg2.position = CGPointMake(width/2+150, height/2+240);
        lightEffectBg2.alpha = 1.0;
        [self addChild:lightEffectBg2];
        [lightEffectBg2 runAction:[SKAction fadeAlphaTo:1.0 duration:10.0]];
        
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"Intro-effect" ofType:@"sks"];
        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(500, 500);
        //[self addChild:openEffect];
        
        NSMutableArray *header1 = [[NSMutableArray alloc]initWithObjects:
                                  @"S",
                                  @"T",
                                  @"A",
                                  @"G",
                                  @"E",
                                   nil];
        NSMutableArray *header2 = [[NSMutableArray alloc]initWithObjects:
                                  @"C",
                                  @"L",
                                  @"A",
                                  @"S",
                                  @"S",
                                  @"R",
                                  @"O",
                                  @"O",
                                  @"M",nil];
        
        int onLetter = 0;
        float startX = 2400;
        
        for (NSString *letter in header1) {

            SKLabelNode *letterSprite = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
            
            letterSprite.fontSize = 42;
            letterSprite.fontColor = [UIColor purpleColor];

            letterSprite.text = letter;
            if (onLetter < 5) {
                startX += 30;
            } 
            letterSprite.position = CGPointMake(startX + onLetter*15, height/1.2);

            SKAction *moveAction = [SKAction moveByX:-2200 y:0 duration:2.0];
            [letterSprite runAction:moveAction];
            [self addChild:letterSprite];
            
            
            SKAction *spinLetter = [SKAction rotateByAngle:40 duration:1.2];
            SKAction *spinLetter2 = [SKAction rotateByAngle:-40 duration:1.5];
            [letterSprite runAction:spinLetter];
            [letterSprite runAction:spinLetter2];

            onLetter++;
        }
        
        
        for (NSString *letter in header2) {
            
            SKLabelNode *letterSprite = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
            
            letterSprite.fontSize = 42;
            letterSprite.fontColor = [UIColor purpleColor];
            
            letterSprite.text = letter;
            if (onLetter < 5) {
                startX += 30;
            }
            letterSprite.position = CGPointMake(startX + onLetter*30, height/1.2);
            
            SKAction *moveAction = [SKAction moveByX:-2200 y:0 duration:2.0];
            [letterSprite runAction:moveAction];
            [self addChild:letterSprite];
            
            
            SKAction *spinLetter = [SKAction rotateByAngle:40 duration:1.2];
            SKAction *spinLetter2 = [SKAction rotateByAngle:-40 duration:1.5];
            [letterSprite runAction:spinLetter];
            [letterSprite runAction:spinLetter2];
            
            onLetter++;
        }
        
        SKSpriteNode *backgroundHandWheel = [SKSpriteNode spriteNodeWithImageNamed:@"all-hands"];
        backgroundHandWheel.position = CGPointMake(width / 2, height / 2);
        [self addChild:backgroundHandWheel];
        
        SKAction *rotateHand = [SKAction rotateByAngle:20.0 duration:15];
        SKAction *shrinkIt = [SKAction scaleTo:0.0 duration:15];
        SKAction *fadeIt = [SKAction fadeAlphaTo:0.0 duration:15];
        
        [backgroundHandWheel runAction:rotateHand];
        [backgroundHandWheel runAction:shrinkIt];
        [backgroundHandWheel runAction:fadeIt];
        
        SKLabelNode *presents = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        presents.fontSize = 16;
        presents.fontColor = [UIColor purpleColor];
        presents.position = CGPointMake(width / 2, height/1.4);
        presents.text = @"P R E S E N T S . . . ";
        [self addChild:presents];
        
       
        SKLabelNode *presents2 = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        presents2.fontSize = 56;
        presents2.fontColor = [UIColor purpleColor];
        presents2.position = CGPointMake(width / 2, height/1.7);
        presents2.text = @"  WRITING &";
        presents2.alpha = 0.0;
        [self addChild:presents2];

        SKLabelNode *presents3 = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        presents3.fontSize = 56;
        presents3.fontColor = [UIColor purpleColor];
        presents3.position = CGPointMake(width / 2, height/1.9);
        presents3.text = @"SOUNDS";
        presents3.alpha = 0.0;
        [self addChild:presents3];
        
        SKAction *moveTitle = [SKAction moveTo:CGPointMake(width / 1.5, height / 2.2) duration:1.0];
        [introductionLabel runAction:moveTitle];
        
        
        /*NSMutableArray *wormTextures = [[NSMutableArray alloc]init];
        SKTextureAtlas *wormAtlas = [SKTextureAtlas atlasNamed:@"earthworm"];
        for (int i=0; i < 6; i++) {
            SKTexture *wormTexture =[wormAtlas textureNamed:[NSString stringWithFormat:@"%i.png",i]];

            [wormTextures addObject:wormTexture];
        }
        
        SKSpriteNode *worm = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
        worm.position = CGPointMake(-100, 630);
        SKAction *crawlAnimation = [SKAction animateWithTextures:wormTextures timePerFrame:0.1];
        SKAction *repeatCrawlAnim = [SKAction repeatAction:crawlAnimation count:6];
        SKAction *moveCrawl = [SKAction moveByX:+380 y:0 duration:4.0];
        [worm runAction:repeatCrawlAnim];
        [worm runAction:moveCrawl];*/
        
        //[self addChild:worm];
        
        /*NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"16_30" withExtension:@"mp3"];
        
        avSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        [avSound play];*/
        
        tracingScene = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        tracingScene.fontSize = fontSizeForPlatform;
        tracingScene.text = @"T R A C E";
        tracingScene.fontColor = [UIColor purpleColor];
        tracingScene.position = CGPointMake(width / 2, height / 2.3);
        tracingScene.name = @"trace";
        tracingScene.alpha = 0.0;
        [self addChild:tracingScene];
        
        spellingLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        spellingLabel.fontSize = fontSizeForPlatform;
        spellingLabel.text = @"S P E L L";
        spellingLabel.fontColor = [UIColor purpleColor];
        spellingLabel.position = CGPointMake(width / 2, height / 2.6);
        spellingLabel.name = @"trace";
        spellingLabel.alpha = 0.0;
        [self addChild:spellingLabel];
        
        dragNDrop = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        dragNDrop.fontSize = fontSizeForPlatform;
        dragNDrop.text = @"M A T C H";
        dragNDrop.fontColor = [UIColor purpleColor];
        dragNDrop.position = CGPointMake(width / 2, height / 3.0);
        dragNDrop.name = @"drag";
        dragNDrop.alpha = 0.0;
        [self addChild:dragNDrop];
        
        freeTrace = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        freeTrace.fontSize = fontSizeForPlatform;
        freeTrace.text = @"F R E E  T R A C E";
        freeTrace.fontColor = [UIColor purpleColor];
        freeTrace.position = CGPointMake(width / 2, height / 3.5);
        freeTrace.name = @"review";
        freeTrace.alpha = 0.0;
        [self addChild:freeTrace];
        
        
        parentTeacher = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        parentTeacher.fontSize = fontSizeForPlatform;
        parentTeacher.text = @"R E V I E W";
        parentTeacher.fontColor = [UIColor purpleColor];
        parentTeacher.position = CGPointMake(width / 2, height / 4.3);
        parentTeacher.name = @"review";
        parentTeacher.alpha = 0.0;
        [self addChild:parentTeacher];
        
        
        handwritingScene = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        handwritingScene.fontSize = fontSizeForPlatform;
        handwritingScene.text = @"C R E D I T S";
        handwritingScene.fontColor = [UIColor purpleColor];
        handwritingScene.position = CGPointMake(width / 2, height / 5.0);
        handwritingScene.name = @"handwriting";
        handwritingScene.alpha = 0.0;
        [self addChild:handwritingScene];

        optionsMenu = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        optionsMenu.text = @"AP History";
        optionsMenu.fontSize = fontSizeForPlatform;
        optionsMenu.fontColor = [UIColor whiteColor];
        optionsMenu.position = CGPointMake(width / 2, height / 9.0);
        optionsMenu.name = @"menu";
        [self addChild:optionsMenu];
        
        
        SKAction *fadeInMenu = [SKAction fadeAlphaTo:1.0 duration:15.0];
        SKAction *delayMenu = [SKAction waitForDuration:7.0];
        SKAction *fadeInMenuSeq = [SKAction sequence:@[delayMenu,fadeInMenu]];
        
        SKAction *runFadeIn = [SKAction runBlock:^{
            [presents2 runAction:fadeInMenuSeq];
            [presents3 runAction:fadeInMenuSeq];
            [tracingScene runAction:fadeInMenuSeq];
            [spellingLabel runAction:fadeInMenuSeq];
            [dragNDrop runAction:fadeInMenuSeq];
            [parentTeacher runAction:fadeInMenuSeq];
            [handwritingScene runAction:fadeInMenuSeq];
            [freeTrace runAction:fadeInMenuSeq];
            
            
        }];
        
        SKAction *transitionColor = [SKAction runBlock:^{
            [self runAction:delayMenu];
            //self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        }];
        
        SKAction *entireTransition = [SKAction sequence:@[runFadeIn,transitionColor]];
        
        [self runAction:entireTransition];

        /*NSMutableArray *animFrames = [NSMutableArray array];
        SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"flare"];
        
        int numImages = imageAnimationAtlas.textureNames.count;
        for (int i=1; i < numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"%d",i];
            SKTexture *temp = [imageAnimationAtlas textureNamed:textureName];
            [animFrames addObject:temp];
        }
        texturesForAnim = animFrames;
        SKTexture *flareTexture = texturesForAnim[0];
        SKSpriteNode *flareSprite = [SKSpriteNode spriteNodeWithTexture:flareTexture];
        
        flareSprite.position = CGPointMake(200, 700);
        [self addChild:flareSprite];
        [flareSprite runAction:[SKAction repeatActionForever:
                                  [SKAction animateWithTextures:texturesForAnim
                                                   timePerFrame:0.05
                                                         resize:NO
                                                        restore:YES]]];
        
        [flareSprite runAction:[SKAction moveTo:CGPointMake(800, 100) duration:5.0]];*/
        
        //[imagesForLetters addObject:imageForSound];
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];

    [avSound stop];
    
    if (CGRectContainsPoint(optionsMenu.frame, theTouch)) {
        
        WorldHistoryMainMenu *worldHistory = [[WorldHistoryMainMenu alloc]initWithSize:CGSizeMake(768, 1024)];
        SKView *spriteView;
        spriteView = (SKView *)self.view;
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.1];
        [spriteView presentScene:worldHistory transition:reveal];
        return;
        
    } else {
    
        if (CGRectContainsPoint(dragNDrop.frame, theTouch)){
            int i = 1;
            matchingScene = [[MatchPix alloc]initWithSize:CGSizeMake(768, 1024) onWhichGroup:[NSNumber numberWithInt:i] mode:@"free"];
            SKTransition *overDrag = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            SKView *spriteView;
            spriteView = (SKView*)self.view;
            [spriteView presentScene:matchingScene transition:overDrag];
            
        } else if (CGRectContainsPoint(parentTeacher.frame, theTouch)) {
            teacherReview = [[TeacherParent alloc]initWithSize:CGSizeMake(768, 1024)];
            SKTransition *overDrag = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            SKView *spriteView;

            spriteView = (SKView *)self.view;
            [spriteView presentScene:teacherReview transition:overDrag];
        } else if (CGRectContainsPoint(handwritingScene.frame, theTouch)) {
            credits = [[Credits alloc]initWithSize:CGSizeMake(768, 1024)];
            SKTransition *creditTransition = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
            SKView *spriteView;

            spriteView = (SKView *)self.view;
            [spriteView presentScene:credits transition:creditTransition];
        } else if (CGRectContainsPoint(spellingLabel.frame,theTouch)) {
            spellingScene = [[Spelling alloc]initWithSize:CGSizeMake(1024,768)];
            SKTransition *spellingTransition = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.1];
            SKView *spriteView;

            spriteView = (SKView *)self.view;
            [spriteView presentScene:spellingScene transition:spellingTransition];
            
        } else if (CGRectContainsPoint(freeTrace.frame,theTouch)) {
            freeWriteScene = [[FreeWrite alloc]initWithSize:CGSizeMake(1024, 768)];
            SKTransition *freeWriteTransition = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.1];
            SKView *spriteView;

            spriteView = (SKView *)self.view;
            [spriteView presentScene:freeWriteScene transition:freeWriteTransition];
            
        } else  {
            //myMainMenu = [[MainMenu alloc]initWithSize:CGSizeMake(1024, 768)];
            /*traceScene = [[LetterTrace alloc]initWithSize:CGSizeMake(1024,768) andGroup:[NSNumber numberWithInt:1]];
            SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.1];
            SKView *spriteView;

            spriteView = (SKView*)self.view;
            [spriteView presentScene:traceScene transition:reveal];*/
            
            self.changeSceneBlock(@"traceScene");
            
            
        }
        
    }
    
}


@end
