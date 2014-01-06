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

@implementation IntroScreen

@synthesize introductionLabel;
@synthesize getStartedButton;
@synthesize myMainMenu;
@synthesize matchingScene;
@synthesize traceScene;
@synthesize credits;
@synthesize teacherReview;

AVAudioPlayer *avSound;
SKLabelNode *optionsMenu;
SKLabelNode *dragNDrop;
SKLabelNode *parentTeacher;
SKLabelNode *handwritingScene;
SKLabelNode *tracingScene;
SKLabelNode *creditsScene;


CGFloat width;
CGFloat height;
BOOL isPhone = TRUE;
CGFloat fontSizeForPlatform = 20;


- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        
        width = self.size.width;
        height = self.size.height;
        
        
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

            SKLabelNode *letterSprite = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            
            letterSprite.fontSize = 26;
            letterSprite.fontColor = [UIColor purpleColor];

            letterSprite.text = letter;
            if (onLetter < 5) {
                startX += 30;
            } 
            letterSprite.position = CGPointMake(startX + onLetter*15, height/1.2);

            SKAction *moveAction = [SKAction moveByX:-2100 y:0 duration:1.0];
            [letterSprite runAction:moveAction];
            [self addChild:letterSprite];
            
            
            SKAction *spinLetter = [SKAction rotateByAngle:40 duration:1.2];
            SKAction *spinLetter2 = [SKAction rotateByAngle:-40 duration:1.5];
            [letterSprite runAction:spinLetter];
            [letterSprite runAction:spinLetter2];

            onLetter++;
        }
        
        
        for (NSString *letter in header2) {
            
            SKLabelNode *letterSprite = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            
            letterSprite.fontSize = 26;
            letterSprite.fontColor = [UIColor purpleColor];
            
            letterSprite.text = letter;
            if (onLetter < 5) {
                startX += 30;
            }
            letterSprite.position = CGPointMake(startX + onLetter*25, height/1.3);
            
            SKAction *moveAction = [SKAction moveByX:-2200 y:0 duration:1.0];
            [letterSprite runAction:moveAction];
            [self addChild:letterSprite];
            
            
            SKAction *spinLetter = [SKAction rotateByAngle:40 duration:1.2];
            SKAction *spinLetter2 = [SKAction rotateByAngle:-40 duration:1.5];
            [letterSprite runAction:spinLetter];
            [letterSprite runAction:spinLetter2];
            
            onLetter++;
        }
        
        SKLabelNode *presents = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        presents.fontSize = 16;
        presents.fontColor = [UIColor purpleColor];
        presents.position = CGPointMake(width / 2, height/1.5);
        presents.text = @"P R E S E N T S . . . ";
        [self addChild:presents];
        
        
        SKLabelNode *presents2 = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        presents2.fontSize = 24;
        presents2.fontColor = [UIColor purpleColor];
        presents2.position = CGPointMake(width / 2, height/1.8);
        presents2.text = @"LEARNING MONTESSORI KID STUFF ";
        [self addChild:presents2];

        
        SKAction *moveTitle = [SKAction moveTo:CGPointMake(width / 1.5, height / 2.2) duration:1.0];
        [introductionLabel runAction:moveTitle];
        
        
        NSMutableArray *wormTextures = [[NSMutableArray alloc]init];
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
        [worm runAction:moveCrawl];
        
        [self addChild:worm];
        
        NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"16_30" withExtension:@"mp3"];
        
        avSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        //[avSound play];
        
        tracingScene = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        tracingScene.fontSize = fontSizeForPlatform;
        tracingScene.text = @"T R A C E";
        tracingScene.fontColor = [UIColor orangeColor];
        tracingScene.position = CGPointMake(width / 2, height / 2.1);
        tracingScene.name = @"trace";
        [self addChild:tracingScene];
        
        dragNDrop = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        dragNDrop.fontSize = fontSizeForPlatform;
        dragNDrop.text = @"M A T C H";
        dragNDrop.fontColor = [UIColor orangeColor];
        dragNDrop.position = CGPointMake(width / 2, height / 2.4);
        dragNDrop.name = @"drag";
        [self addChild:dragNDrop];
        
        parentTeacher = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        parentTeacher.fontSize = fontSizeForPlatform;
        parentTeacher.text = @"R E V I E W";
        parentTeacher.fontColor = [UIColor orangeColor];
        parentTeacher.position = CGPointMake(width / 2, height / 2.8);
        parentTeacher.name = @"review";
        [self addChild:parentTeacher];
        
        handwritingScene = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        handwritingScene.fontSize = fontSizeForPlatform;
        handwritingScene.text = @"C R E D I T S";
        handwritingScene.fontColor = [UIColor orangeColor];
        handwritingScene.position = CGPointMake(width / 2, height / 3.3);
        handwritingScene.name = @"handwriting";
        [self addChild:handwritingScene];

        optionsMenu = [SKLabelNode labelNodeWithFontNamed:@"StalinistOne-Regular"];
        optionsMenu.text = @"AP History";
        optionsMenu.fontSize = fontSizeForPlatform;
        optionsMenu.fontColor = [UIColor orangeColor];
        optionsMenu.position = CGPointMake(width / 2, height / 4.0);
        optionsMenu.name = @"menu";
        [self addChild:optionsMenu];
        
        /*NSMutableArray *frogHopTextures = [[NSMutableArray alloc]init];
        SKTextureAtlas *frogHopAtlas = [SKTextureAtlas atlasNamed:@"frog2.atlas"];
        for (int fr = 0; fr < 8; fr++) {
            SKTexture *frogHopTexture = [frogHopAtlas textureNamed:[NSString stringWithFormat:@"frog_frame_%i.png",fr]];
            [frogHopTextures addObject:frogHopTexture];
        }*/
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];

    [avSound stop];
    
    if (CGRectContainsPoint(optionsMenu.frame, theTouch)) {
        
        WorldHistoryMainMenu *worldHistory = [[WorldHistoryMainMenu alloc]initWithSize:CGSizeMake(768, 1024)];
        spriteView = (SKView *)self.view;
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:2.0];
        [spriteView presentScene:worldHistory transition:reveal];
        return;
        
    } else {
    
        if (CGRectContainsPoint(dragNDrop.frame, theTouch)){
            matchingScene = [[MatchPix alloc]initWithSize:CGSizeMake(1024, 768)];
            SKTransition *overDrag = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            spriteView = (SKView*)self.view;
            [spriteView presentScene:matchingScene transition:overDrag];
            
        } else if (CGRectContainsPoint(parentTeacher.frame, theTouch)) {
            teacherReview = [[TeacherParent alloc]initWithSize:CGSizeMake(1024, 768)];
            SKTransition *overDrag = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            spriteView = (SKView *)self.view;
            [spriteView presentScene:teacherReview transition:overDrag];
        } else if (CGRectContainsPoint(handwritingScene.frame, theTouch)) {
            credits = [[Credits alloc]initWithSize:CGSizeMake(1024, 768)];
            SKTransition *creditTransition = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
            spriteView = (SKView *)self.view;
            [spriteView presentScene:credits transition:creditTransition];
        } else {
            //myMainMenu = [[MainMenu alloc]initWithSize:CGSizeMake(1024, 768)];
            traceScene = [[LetterTrace alloc]initWithSize:CGSizeMake(1024,768) andGroup:[NSNumber numberWithInt:1]];
            SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            spriteView = (SKView*)self.view;
            [spriteView presentScene:traceScene transition:reveal];
        }
        
    }
    
}


@end
