//
//  IntroScreen.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/27/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "IntroScreen.h"
#import "MainMenu.h"
#import "WorldHistoryMainMenu.h"
#import <AVFoundation/AVFoundation.h>
#import "MatchPix.h"
#import "LetterTrace.h"

@implementation IntroScreen

@synthesize introductionLabel;
@synthesize getStartedButton;
@synthesize myMainMenu;
@synthesize matchingScene;
@synthesize traceScene;

AVAudioPlayer *avSound;
SKLabelNode *optionsMenu;
SKLabelNode *dragNDrop;
SKLabelNode *waveExercises;
SKLabelNode *handwritingScene;

CGFloat width;
CGFloat height;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        
        width = self.size.width;
        height = self.size.height;
        
        
        NSMutableArray *header = [[NSMutableArray alloc]initWithObjects:
                                  @"cartoon-m.png",
                                  @"cartoon-letter-O.png",
                                  @"cartoon-n.png",
                                  @"cartoon-t.png",
                                  @"cartoon-e.png",
                                  @"cartoon-S",
                                  @"cartoon-S",
                                  @"cartoon-letter-O.png",
                                  @"cartoon-r.png",
                                  @"cartoon-i.png",nil];
        
        int onLetter = 0;
        
        for (SKSpriteNode *letter in header) {
            
            NSString *nameOfSpriteFile = [header objectAtIndex:onLetter];
            
            SKSpriteNode *letterSprite = [SKSpriteNode spriteNodeWithImageNamed:nameOfSpriteFile];
            
            letterSprite.position = CGPointMake(2400 + onLetter*55, height/1.8);
            SKAction *moveAction = [SKAction moveByX:-2300 y:0 duration:1.0];
            [letterSprite runAction:moveAction];
            [self addChild:letterSprite];
            
            
            SKAction *spinLetter = [SKAction rotateByAngle:40 duration:1.2];
            SKAction *spinLetter2 = [SKAction rotateByAngle:-40 duration:1.5];
            [letterSprite runAction:spinLetter];
            [letterSprite runAction:spinLetter2];

            onLetter++;
        }
        
        
        SKSpriteNode *cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud.png"];
        cloud1.position = CGPointMake(width/1.3, height/1.3);
        [self addChild:cloud1];
        
        SKSpriteNode *cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"sign.png"];
        cloud2.position = CGPointMake(600, 200);
        [self addChild:cloud2];
        
        SKLabelNode *credit1 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        credit1.text = @"ms. mary frances stage";
        credit1.fontSize = 20;
        credit1.fontColor = [UIColor orangeColor];
        credit1.position = CGPointMake(2400, 1000);
        [self addChild:credit1];
        
        SKLabelNode *credit2 = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        credit2.text = @"mr. ted hooban";
        credit2.fontSize = 20;
        credit2.fontColor = [UIColor redColor];
        credit2.position = CGPointMake(-1200, 900);
        [self addChild:credit2];
        
        SKAction *moveTitle = [SKAction moveTo:CGPointMake(width / 1.5, height / 2.2) duration:1.0];
        [introductionLabel runAction:moveTitle];
        
        SKAction *moveCredit = [SKAction moveTo:CGPointMake(width / 2.5, height / 2.7) duration:1.2];
        [credit1 runAction:moveCredit];
        
        SKAction *moveCredit2 = [SKAction moveTo:CGPointMake(width / 3.0, height / 2.9) duration:0.7];
        [credit2 runAction:moveCredit2];
        
        NSMutableArray *wormTextures = [[NSMutableArray alloc]init];
        SKTextureAtlas *wormAtlas = [SKTextureAtlas atlasNamed:@"earthworm.atlas"];
        for (int i=0; i < 6; i++) {
            SKTexture *wormTexture =[wormAtlas textureNamed:[NSString stringWithFormat:@"%i.png",i]];
            [wormTextures addObject:wormTexture];
        }
        
        SKSpriteNode *worm = [SKSpriteNode spriteNodeWithImageNamed:@"0.png"];
        worm.position = CGPointMake(100, 650);
        SKAction *crawlAnimation = [SKAction animateWithTextures:wormTextures timePerFrame:0.1];
        SKAction *repeatCrawlAnim = [SKAction repeatAction:crawlAnimation count:6];
        SKAction *moveCrawl = [SKAction moveByX:+1200 y:0 duration:6.0];
        [worm runAction:repeatCrawlAnim];
        [worm runAction:moveCrawl];
        
        [self addChild:worm];
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"];
        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(700, 600);
        openEffect.targetNode = self.scene;
        
        [self addChild:openEffect];
        
        NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"sesame-street" withExtension:@"mp3"];
        
        avSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        //[avSound play];
        
        dragNDrop = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        dragNDrop.fontSize = 30;
        dragNDrop.text = @"Pictures and Letters";
        dragNDrop.fontColor = [UIColor orangeColor];
        dragNDrop.position = CGPointMake(200, 200);
        dragNDrop.name = @"drag";
        [self addChild:dragNDrop];
        
        waveExercises = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        waveExercises.fontSize = 8;
        waveExercises.text = @"Wave Exercises";
        waveExercises.fontColor = [UIColor orangeColor];
        waveExercises.position = CGPointMake(200, 150);
        waveExercises.name = @"wave";
        [self addChild:waveExercises];
        
        handwritingScene = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        handwritingScene.fontSize = 8;
        handwritingScene.text = @"Handwriting";
        handwritingScene.fontColor = [UIColor orangeColor];
        handwritingScene.position = CGPointMake(200, 100);
        handwritingScene.name = @"handwriting";
        [self addChild:handwritingScene];
        
        
        
        optionsMenu = [SKLabelNode labelNodeWithFontNamed:@"StalinistOne-Regular"];
        optionsMenu.text = @"History";
        optionsMenu.fontColor = [UIColor greenColor];
        optionsMenu.position = CGPointMake(500,20);
        optionsMenu.name = @"menu";
        //[self addChild:optionsMenu];
        
        NSMutableArray *frogHopTextures = [[NSMutableArray alloc]init];
        SKTextureAtlas *frogHopAtlas = [SKTextureAtlas atlasNamed:@"frog2.atlas"];
        for (int fr = 0; fr < 8; fr++) {
            SKTexture *frogHopTexture = [frogHopAtlas textureNamed:[NSString stringWithFormat:@"frog_frame_%i.png",fr]];
            [frogHopTextures addObject:frogHopTexture];
        }
        
        SKSpriteNode *hopFrog =[SKSpriteNode spriteNodeWithImageNamed:@"frog_frame_1.png"];
        
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];

    //[avSound stop];
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
            
        } else {
            //myMainMenu = [[MainMenu alloc]initWithSize:CGSizeMake(1024, 768)];
            
            traceScene = [[LetterTrace alloc]initWithSize:CGSizeMake(1024,768)];
            
            SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            spriteView = (SKView*)self.view;
            [spriteView presentScene:traceScene transition:reveal];
        }
        
    }
    
}


@end
