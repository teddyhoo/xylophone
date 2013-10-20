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
#import "IntroScreen.h"

@implementation MatchPix

SKSpriteNode *picForQuestion;
SKSpriteNode *bat;
SKAction *batAnimation;

NSMutableArray *allPicsForQuestions;
NSMutableArray *allLettersSprites;
NSMutableArray *imagesForLetters;
NSMutableArray *texturesForAnim;

NSTimeInterval lastUpdateTime;
NSTimeInterval dt;

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
SKSpriteNode *selectedNode;
BOOL objectSelected;


int questionCount;

-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        questionCount = 0;
        objectSelected = FALSE;
       
        NSString *pListData = [[NSBundle mainBundle]pathForResource:@"Letters" ofType:@"plist"];
        allPicsForQuestions = [[NSMutableArray alloc]initWithContentsOfFile:pListData];
        imagesForLetters = [[NSMutableArray alloc]init];
        
        for (NSDictionary *problem in allPicsForQuestions) {
            int i = 0;
            
            for (NSString *key in problem) {
                
                if ([key isEqualToString:@"image"]) {
                    
                    SKSpriteNode *imageForSound = [SKSpriteNode spriteNodeWithImageNamed:[problem valueForKey:key]];
                    imageForSound.name = [problem valueForKey:@"letter"];
                    imageForSound.scale = 0.5;
                    [imagesForLetters addObject:imageForSound];
                    
                }
                
            }
            i++;
        }
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];
        
        SKLabelNode *testLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        testLabel.text = @"Match Pictures to Sound";
        testLabel.fontSize = 40;
        testLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame)+300);
        
        [self addChild:testLabel];
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
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
        
        
        letterA.position = CGPointMake(1600, 500);
        letterB.position = CGPointMake(1450, 500);
        letterC.position = CGPointMake(1300, 500);
        letterM.position = CGPointMake(1150, 200);
        letterS.position = CGPointMake(1000, 200);
        letterT.position = CGPointMake(850, 200);
        
        SKAction *moveToPositionWithSound = [SKAction moveByX:-600 y:0 duration:3.0];
        SKAction *playSound = [SKAction playSoundFileNamed:@"letterAsound.mp3" waitForCompletion:YES];
        
        SKAction *delayed = [SKAction waitForDuration:2.0];
        SKAction *sequenceMove = [SKAction sequence:@[moveToPositionWithSound,playSound,delayed]];
        [letterA runAction:sequenceMove];
        
        SKAction *transitionToBlocks = [SKAction runBlock:^{
        
            
        }];
        [letterA runAction:sequenceMove];
        [letterB runAction:sequenceMove];
        [letterC runAction:sequenceMove];
        [letterM runAction:sequenceMove];
        [letterS runAction:sequenceMove];
        [letterT runAction:sequenceMove];
        
        
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
        
        //letterA.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterA.size];
        //letterA.physicsBody.restitution = 0.2;
        
        //letterB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterB.physicsBody.restitution = 0.3;
        
        
        //letterC.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterC.physicsBody.restitution = 0.1;
        
        
        //letterM.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterM.physicsBody.restitution = 0.3;
        
        //letterS.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterS.physicsBody.restitution = 0.4;
        
        //letterT.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterT.physicsBody.restitution = 0.5;
        
        SKAction *shake = [SKAction moveByX:0 y:10 duration:0.05];
        
        
        [self runAction:[SKAction repeatAction:[SKAction sequence:@[shake, [shake reversedAction]]]count:5]];
        
        [self addChild:letterA];
        [self addChild:letterB];
        [self addChild:letterC];
        [self addChild:letterM];
        [self addChild:letterS];
        [self addChild:letterT];
        [self setupSounds];
        [self setupHUD];
        
        //self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];

        [self nextQuestion];
        
    }
    
    return self;
    
}


-(void) setupSounds {
    
    
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
    
    picForQuestion = (SKSpriteNode *)[imagesForLetters objectAtIndex:questionCount];
    picForQuestion.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:picForQuestion.size];
    picForQuestion.physicsBody.restitution = 0.5;
    
    
    picForQuestion.position = CGPointMake(1000, 400);
    SKAction *moveTheImage = [SKAction moveByX:-600 y:0 duration:0.5];
    [self addChild:picForQuestion];
    [picForQuestion runAction:moveTheImage];
    
    
    self.userInteractionEnabled = YES;

    
    /*else if (questionCount == 6) {
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
        
    }*/
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {

    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    if (CGRectContainsPoint(backToMainMenuArrow.frame, theTouch)) {
        SKView *spriteView = (SKView *)self.view;
        IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];
    }
    
    
    if (CGRectContainsPoint(picForQuestion.frame, theTouch)) {
        
        objectSelected = TRUE;
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

    if (objectSelected) {
        picForQuestion.position = theTouch;
    }
    
    
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    
    //[self selectedNodeForTouch:theTouch];
    
    objectSelected = FALSE;
    
    
}


-(void)selectedNodeForTouch:(CGPoint)touchLocation {
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    if(![selectedNode isEqual:touchedNode]) {
        [selectedNode removeAllActions];
        [selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        selectedNode = touchedNode;
        if([[touchedNode name] isEqualToString:@"A"]) {
            
            SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:degToRad(-4.0f)  duration:0.1],
                                                      [SKAction rotateByAngle:0.0 duration:0.1],
                                                      [SKAction rotateByAngle:degToRad(4.0) duration:0]]];
            
            
        }
    }
    
    
}


-(void) removeSpriteFromScene {
    
   /* SKSpriteNode *currentLetterFinish = [allLettersSprites objectAtIndex:onWhichQuestion];
    [currentLetterFinish removeFromParent];
    SKAction *moveToFinish = [SKAction moveToX:-300 duration:0.1];
    SKAction *scaleDown = [SKAction scaleTo:0.3 duration:0.1];
    [currentLetterFinish runAction:moveToFinish];
    [currentLetterFinish runAction:scaleDown];*/
    
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [selectedNode position];
    if([[selectedNode name] isEqualToString:@"M"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [self setPosition:[self boundLayerPos:newPos]];
    }
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[self size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}


float degToRad(float degree) {
    return degree/180.0f * M_PI;
}


-(void)update:(NSTimeInterval)currentTime {
    
    
    
    if (dt < 0.3) {
        dt = currentTime - lastUpdateTime + dt;
        
    } else {
        dt = 0;
        [self checkCollisions];
    }
    
    lastUpdateTime = currentTime;
    
    

}


-(void) checkCollisions {
    
   /* [self enumerateChildNodesWithName:@"A" usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *letterAlocal = (SKSpriteNode *)node;
        if (CGRectIntersectsRect(letterAlocal.frame, picForQuestion.frame)) {
            [picForQuestion removeFromParent];
        }
    }];*/
    
    
    if (CGRectIntersectsRect(letterA.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"A"]) {
        self.userInteractionEnabled = NO;
        
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterA runAction:sequenceUpDown];
        
        [avSound play];
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        [picForQuestion removeFromParent];
        
        questionCount++;
        
        [self nextQuestion];
        
        
    } else if (CGRectIntersectsRect(letterB.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"B"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.5 duration:0.1];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.1 duration:0.1];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];

        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
        
        
    } else if (CGRectIntersectsRect(letterC.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"C"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterD.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"D"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterE.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"E"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    }  else if (CGRectIntersectsRect(letterF.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"F"]) {
            
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
            
        [avSound play];
            
            
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
            
        [self nextQuestion];
    }  else if (CGRectIntersectsRect(letterG.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"G"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterI.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"I"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterJ.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"J"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterK.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"K"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterL.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"L"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterH.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"M"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterH.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"N"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterN.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"N"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterO.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"O"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterP.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"P"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterQ.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"Q"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterR.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"R"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterS.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"S"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterT.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"T"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterU.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"U"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterV.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"V"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterW.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"W"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterX.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"X"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterY.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"Y"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    } else if (CGRectIntersectsRect(letterZ.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"Z"]) {
        
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.9 duration:0.3];
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.2 duration:0.3];
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        [picForQuestion removeFromParent];
        
        SKAction *flyBatAway = [SKAction moveByX:+500 y:-1000 duration:1.0];
        [tempPicForQ runAction:flyBatAway];
        
        questionCount++;
        
        [self nextQuestion];
    }
    
}

@end
