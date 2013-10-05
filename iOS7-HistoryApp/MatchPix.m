//
//  MatchPix.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/19/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

#import "MatchPix.h"
#import "Parallax.h"
#import "LowerCaseLetter.h"

@implementation MatchPix

SKSpriteNode *picForQuestion;
SKSpriteNode *bat;
SKAction *batAnimation;

NSMutableArray *allPicsForQuestions;
NSMutableArray *allLettersSprites;
NSMutableArray *texturesForAnim;


AVAudioPlayer *soundA;
AVAudioPlayer *soundB;
AVAudioPlayer *soundC;
AVAudioPlayer *soundD;
AVAudioPlayer *soundE;
AVAudioPlayer *soundF;
AVAudioPlayer *soundG;


AVAudioPlayer *avSound; // girl voice correct
AVAudioPlayer *awesomeMessage;
AVAudioPlayer *whoopsMessage;
AVAudioPlayer *magicalSweep;
AVAudioPlayer *gameShowLose;

LowerCaseLetter *letterA;
LowerCaseLetter *letterB;
LowerCaseLetter *letterC;
LowerCaseLetter *letterD;
LowerCaseLetter *letterE;
LowerCaseLetter *letterF;
LowerCaseLetter *letterG;
LowerCaseLetter *letterH;
LowerCaseLetter *letterI;
LowerCaseLetter *letterJ;
LowerCaseLetter *letterK;
LowerCaseLetter *letterL;
LowerCaseLetter *letterM;
LowerCaseLetter *letterN;
LowerCaseLetter *letterO;
LowerCaseLetter *letterP;
LowerCaseLetter *letterQ;
LowerCaseLetter *letterR;
LowerCaseLetter *letterS;
LowerCaseLetter *letterT;
LowerCaseLetter *letterU;
LowerCaseLetter *letterV;
LowerCaseLetter *letterW;
LowerCaseLetter *letterX;
LowerCaseLetter *letterY;
LowerCaseLetter *letterZ;

SKSpriteNode *backToMainMenuArrow;

int questionCount;

-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        questionCount = 0;
        
        
        NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
        soundA = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
        
        NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"letter-B-sound" withExtension:@"mp3"];
        soundB = [[AVAudioPlayer alloc]initWithContentsOfURL:letterBurl error:nil];
        
        NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_correct" withExtension:@"wav"];
        avSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
        
        NSURL *incorrectSound  = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_oops_try_again" withExtension:@"wav"];
        whoopsMessage = [[AVAudioPlayer alloc]initWithContentsOfURL:incorrectSound error:nil];
        
        NSURL *hitPoint  = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_awesome" withExtension:@"wav"];
        awesomeMessage = [[AVAudioPlayer alloc]initWithContentsOfURL:hitPoint error:nil];
        
        NSURL *magicalSweepURL  = [[NSBundle mainBundle]URLForResource:@"magical_sweep_01" withExtension:@"wav"];
        magicalSweep = [[AVAudioPlayer alloc]initWithContentsOfURL:magicalSweepURL error:nil];
        
        NSURL *gameShowLoseURL  = [[NSBundle mainBundle]URLForResource:@"game_show_lose_04" withExtension:@"wav"];
        gameShowLose = [[AVAudioPlayer alloc]initWithContentsOfURL:gameShowLoseURL error:nil];
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];
        
        SKLabelNode *testLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        testLabel.text = @"Match Pictures to Sound";
        testLabel.fontSize = 40;
        testLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame)+400);
        
        [self addChild:testLabel];
        
        
        letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-a.png"];
        letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-b.png"];
        letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-c.png"];
        letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-d.png"];
        letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-e.png"];
        letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-f.png"];
        letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-g.png"];
        letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-h.png"];
        letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-i.png"];
        letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-j.png"];
        letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-k.png"];
        letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-l.png"];
        letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-m.png"];
        letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-n.png"];
        letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-o.png"];
        letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-p.png"];
        letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-q.png"];
        letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-r.png"];
        letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-s.png"];
        letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-t.png"];
        letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-u.png"];
        letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-v.png"];
        letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-w.png"];
        letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-x.png"];
        letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-y.png"];
        letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-z.png"];
       
        
        letterA.scale = 0.3;
        letterB.scale = 0.2;
        letterC.scale = 0.3;
        letterD.scale = 0.3;
        letterM.scale = 0.3;
        letterS.scale = 0.3;
        letterT.scale = 0.3;
        
        
        letterA.position = CGPointMake(800, 500);
        letterB.position = CGPointMake(650, 500);
        letterC.position = CGPointMake(500, 500);
        letterM.position = CGPointMake(350, 500);
        letterS.position = CGPointMake(200, 500);
        letterT.position = CGPointMake(50, 500);
        
        letterA.name = @"A";
        letterB.name = @"B";
        letterC.name = @"C";
        letterM.name = @"M";
        letterS.name = @"S";
        letterT.name = @"T";
        
        
        allLettersSprites = [[NSMutableArray alloc]init];
        [allLettersSprites addObject:letterA];
        [allLettersSprites addObject:letterB];
        [allLettersSprites addObject:letterC];
        [allLettersSprites addObject:letterM];
        [allLettersSprites addObject:letterS];
        [allLettersSprites addObject:letterT];
        
        [allLettersSprites addObject:letterD];
        [allLettersSprites addObject:letterE];
        [allLettersSprites addObject:letterF];
        [allLettersSprites addObject:letterG];
        
        
        
        
        [self addChild:letterA];
        [self addChild:letterB];
        [self addChild:letterC];
        [self addChild:letterM];
        [self addChild:letterS];
        [self addChild:letterT];
        
        [self setupHUD];
        
        //self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        
        [self nextQuestion];
        
    }
    
    return self;
    
}

-(BOOL)checkCollision:(CGPoint)begX :(CGPoint)begY {
    
    
    return FALSE;
    
}

-(BOOL)checkCollisionEnd:(CGPoint)begX :(CGPoint)begY {
    
    return FALSE;
    
}


-(void)setupHUD {
    
    
}

-(void)nextQuestion {
    
    if (questionCount == 0) {
        picForQuestion = [SKSpriteNode spriteNodeWithImageNamed:@"apple.png"];
        picForQuestion.position = CGPointMake(700, 300);
        picForQuestion.name = @"A";
        SKAction *moveTheImage = [SKAction moveByX:-300 y:0 duration:1.0];
        [self addChild:picForQuestion];
        [picForQuestion runAction:moveTheImage];
    }

    
    else if (questionCount == 1) {
        
        picForQuestion = [SKSpriteNode spriteNodeWithImageNamed:@"bat1.png"];
        picForQuestion.position = CGPointMake(300,300);
        picForQuestion.name = @"B";
        [self addChild:picForQuestion];
        
        
        texturesForAnim = [NSMutableArray arrayWithCapacity:7];
        
        for (int i = 1; i < 7; i++) {
            
            NSString *textureName = [NSString stringWithFormat:@"bat%d",i];
            SKTexture *texture = [SKTexture textureWithImageNamed:textureName];
            [texturesForAnim addObject:texture];
            
            batAnimation = [SKAction animateWithTextures:texturesForAnim timePerFrame:0.1];
            [picForQuestion runAction:[SKAction repeatActionForever:batAnimation]];
            
        }
        
    }
    
    else if (questionCount == 2) {
        self.userInteractionEnabled = YES;
        picForQuestion = [SKSpriteNode spriteNodeWithImageNamed:@"balloons.png"];
        picForQuestion.position = CGPointMake(700, 300);
        picForQuestion.name = @"B";
        SKAction *moveTheImage = [SKAction moveByX:-300 y:0 duration:1.0];
        [self addChild:picForQuestion];
        [picForQuestion runAction:moveTheImage];

    }
    
    else if (questionCount == 3) {
        self.userInteractionEnabled = YES;
        picForQuestion = [SKSpriteNode spriteNodeWithImageNamed:@"bell.png"];
        picForQuestion.position = CGPointMake(700, 300);
        picForQuestion.name = @"A";
        SKAction *moveTheImage = [SKAction moveByX:-300 y:0 duration:1.0];
        [self addChild:picForQuestion];
        [picForQuestion runAction:moveTheImage];
        
    }
    
    else if (questionCount == 4) {
        
        
    }
    
    else if (questionCount == 5) {
        
        
    }
    
    else if (questionCount == 6) {
        
        
    }
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    if (CGRectContainsPoint(picForQuestion.frame, theTouch)) {
        //[picForQuestion removeAllActions];
        //NSLog(@"touched cat");
        
    } else if (CGRectContainsPoint(bat.frame, theTouch)) {
        
    }
    
    if (CGRectContainsPoint(letterA.frame, theTouch)) {
        [soundA play];
        
    } else if (CGRectContainsPoint(letterB.frame, theTouch)) {
        
        [soundB play];
        
    } else if (CGRectContainsPoint(letterC.frame, theTouch)) {
        
    } else if (CGRectContainsPoint(letterM.frame, theTouch)) {
        
    } else if (CGRectContainsPoint(letterS.frame, theTouch)) {
        
    } else if (CGRectContainsPoint(letterT.frame, theTouch)) {
        
    }
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    NSLog(@"touches moved:%f, %f",theTouch.x, theTouch.y);

    bat.position = theTouch;
    picForQuestion.position = theTouch;
    
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    for (LowerCaseLetter *theLetter in allLettersSprites) {
        
        if (CGRectContainsPoint(letterA.frame, theTouch) && ([letterA.name isEqualToString:picForQuestion.name])) {
            
            NSLog(@"match A");
            SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
            SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
            SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
            
            [letterA runAction:sequenceUpDown];
            
            [avSound play];
            
            SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
            [picForQuestion runAction:flyBatAway];
            questionCount++;
            
            [self nextQuestion];

            
        } else if (CGRectContainsPoint(letterB.frame, theTouch) && ([letterB.name isEqualToString:picForQuestion.name])) {
            
            NSLog (@"match B");
            
            SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
            SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
            SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
            
            [letterB runAction:sequenceUpDown];
            
            [avSound play];
            
            SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
            self.userInteractionEnabled = NO;
            [picForQuestion runAction:flyBatAway];
            questionCount++;
            
            [self nextQuestion];
            
            
        } else {
            
            //[gameShowLose play];
            
            
        
        }
        
    }
    
    
}


-(void)update:(NSTimeInterval)currentTime {
    
    
    
    /*for (SKSpriteNode *theLetter in allLettersSprites) {
        float coordForSpriteX = theLetter.position.x;
        float coordForSpriteY = theLetter.position.y;
        SKAction *rotateCircle;
        
        if (coordForSpriteX > 600) {
            rotateCircle = [SKAction moveByX:coordForSpriteX+0.01 y:coordForSpriteY+5 duration:0.1];
        } else {
            rotateCircle = [SKAction moveByX:coordForSpriteX-0 y:coordForSpriteY-5 duration:0.1];
        }
        
        
        [theLetter runAction:rotateCircle];
        
    }*/


}


@end
