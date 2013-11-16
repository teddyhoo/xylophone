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
#import "MontessoriData.h"

#import "SKAction+SKTExtras.h"
#import "SKTTimingFunctions.h"
#import "SKTEffects.h"

@implementation MatchPix

static NSString* const kAnimalNodeName = @"movable";

SKSpriteNode *picForQuestion;
SKSpriteNode *bat;
SKAction *batAnimation;
SKEmitterNode *openEffect;


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


MontessoriData *sharedData;

SKSpriteNode *backToMainMenuArrow;
SKSpriteNode *selectedNode;
BOOL objectSelected;


int questionCount;

-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        questionCount = 0;
        objectSelected = FALSE;
        
        sharedData = [MontessoriData sharedManager];

        SKSpriteNode *gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_wood.jpg"];
        gridPaper.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:gridPaper];
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"displayLetter"
                                                                     ofType:@"sks"];
        
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(300, 300);
        //[self addChild:openEffect];
        
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
        testLabel.fontColor = [UIColor blueColor];
        testLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame));
        
        [self addChild:testLabel];
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        letterA = sharedData.letterA;  //[LowerCaseLetter spriteNodeWithImageNamed:@"lower-a.png"];
        letterB = sharedData.letterB;  //[LowerCaseLetter spriteNodeWithImageNamed:@"lower-b.png"];
        letterC = sharedData.letterC;  //[LowerCaseLetter spriteNodeWithImageNamed:@"lower-c.png"];
        letterD = sharedData.letterD;
        letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-e.png"];
        letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-f.png"];
        letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-g.png"];
        letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-h.png"];
        letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-i.png"];
        letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-j.png"];
        letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-k.png"];
        letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-l.png"];
        letterM = sharedData.letterM;
        letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-n.png"];
        letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-o.png"];
        letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-p.png"];
        letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-q.png"];
        letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-r.png"];
        letterS = sharedData.letterS;
        letterT = sharedData.letterT;
        letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-u.png"];
        letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-v.png"];
        letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-w.png"];
        letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-x.png"];
        letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-y.png"];
        letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-z.png"];
       
        
        letterA.scale = 0.2;
        letterB.scale = 0.2;
        letterC.scale = 0.2;
        letterD.scale = 0.2;
        letterM.scale = 0.2;
        letterS.scale = 0.2;
        letterT.scale = 0.2;
        
        
        letterA.position = CGPointMake(1800, 700);
        letterB.position = CGPointMake(1650, 700);
        letterC.position = CGPointMake(1500, 700);
        letterM.position = CGPointMake(1350, 700);
        letterS.position = CGPointMake(1200, 700);
        letterT.position = CGPointMake(1050, 700);

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
        //letterA.physicsBody.restitution = 1.0;
        //letterA.physicsBody.affectedByGravity = NO;
        
        //letterB.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterB.physicsBody.restitution = 1.0;
        //letterB.physicsBody.affectedByGravity = NO;
        
        //letterC.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterC.physicsBody.restitution = 1.0;
        //letterC.physicsBody.affectedByGravity = NO;
        
        //letterM.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterM.physicsBody.restitution = 1.0;
        //letterM.physicsBody.affectedByGravity = NO;
        
        //letterS.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterS.physicsBody.restitution = 1.0;
        //letterS.physicsBody.affectedByGravity = NO;
        
        //letterT.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:letterB.size];
        //letterT.physicsBody.restitution = 1.0;
        //letterT.physicsBody.affectedByGravity = NO;
        
        //SKAction *shake = [SKAction moveByX:0 y:10 duration:0.05];
        
        
        //[self runAction:[SKAction repeatAction:[SKAction sequence:@[shake, [shake reversedAction]]]count:5]];
        
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

        
        SKAction *delayed = [SKAction waitForDuration:0.1];
        SKAction *moveToPositionWithSound = [SKAction moveByX:-900 y:0 duration:1.0];
        
        SKAction *firstLetter = [SKAction runBlock:^{
            [letterA runAction:moveToPositionWithSound];
            [letterA playTheSound];
        }];
        
        SKAction *chainNextLetter = [SKAction runBlock:^{
            [letterB runAction:moveToPositionWithSound];
            [letterB playTheSound];
        }];
        
        SKAction *chainThirdLetter = [SKAction runBlock:^{
            [letterC runAction:moveToPositionWithSound];
            [letterC playTheSound];
        }];
        
        SKAction *chainFourthLetter = [SKAction runBlock:^{
            [letterM runAction:moveToPositionWithSound];
            [letterM playTheSound];
        }];
        
        SKAction *chainFifthLetter = [SKAction runBlock:^{
            [letterS runAction:moveToPositionWithSound];
            [letterS playTheSound];
            
        }];
        
        SKAction *chainSixthLetter = [SKAction runBlock:^{
            [letterT runAction:moveToPositionWithSound];
            [letterT playTheSound];
            [self nextQuestion];
        }];
        
        SKAction *sequenceMove = [SKAction sequence:@[firstLetter,
                                                      delayed,
                                                      chainNextLetter,
                                                      delayed,
                                                      chainThirdLetter,
                                                      delayed,
                                                      chainFourthLetter,
                                                      delayed,
                                                      chainFifthLetter,
                                                      delayed,
                                                      chainSixthLetter
                                                      ]];
        
        [self runAction:sequenceMove];
        
    }
    
    return self;
    
}

-(void)didMoveToView:(SKView *)view {
    
    //UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handlePanFrom:)];
    //[[self view] addGestureRecognizer:gestureRecognizer];
}


-(void)introLetter:(LowerCaseLetter *)letter {
    
    
}

-(void) setupSounds {
    
    
    NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"a" withExtension:@"aiff"];
    soundA = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
    
    NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"b" withExtension:@"aiff"];
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
    //picForQuestion.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:picForQuestion.size];
    //picForQuestion.physicsBody.restitution = 0.0;
    //picForQuestion.physicsBody.affectedByGravity = NO;
    [picForQuestion setName:kAnimalNodeName];
    
    
    
    picForQuestion.position = CGPointMake(500, 400);
    picForQuestion.alpha = 0.1;
    
    SKAction *moveTheImage = [SKAction moveByX:-600 y:0 duration:0.5];
    SKAction *fadeIn = [SKAction fadeAlphaTo:1.0 duration:1.0];
    [self addChild:picForQuestion];
    
    //SKAction *placeNewImage = [SKAction runBlock:^{
        [picForQuestion runAction:fadeIn];
        self.userInteractionEnabled = YES;
    //} ];


    
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
    CGPoint positionInScene = [touch locationInNode:self];
    
    [self selectedNodeForTouch:positionInScene];
    
    //CGPoint previousPosition = [touch previousLocationInNode:self];
    //CGPoint translation = CGPointMake(positionInScene.x - positionInScene.y, positionInScene.x - positionInScene.y);
    //[self panForTranslation:translation];
    
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

    
    objectSelected = FALSE;
    
    
}


-(void)selectedNodeForTouch:(CGPoint)touchLocation {
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    if(![selectedNode isEqual:touchedNode]) {
        [selectedNode removeAllActions];
        [selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        selectedNode = touchedNode;
        if([[touchedNode name] isEqualToString:kAnimalNodeName]) {
            
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
        
        SKAction *flyBatAway = [SKAction moveTo:CGPointMake(letterA.position.x, letterA.position.y - 500) duration:0.4];
        [tempPicForQ runAction:flyBatAway];
        //[picForQuestion removeFromParent];
        
        questionCount++;
        
        [self nextQuestion];
        
        
    } else if (CGRectIntersectsRect(letterB.frame, picForQuestion.frame)) {
        //else if (CGRectIntersectsRect(letterB.frame, picForQuestion.frame) && [picForQuestion.name isEqualToString:@"B"]) {
        NSLog(@"collison with B");
        self.userInteractionEnabled = NO;
        [picForQuestion removeAllActions];
        SKAction *scaleTheLetter = [SKAction scaleTo:.5 duration:0.5];
        scaleTheLetter.timingMode = SKActionTimingEaseOut;
        SKAction *scaleDownTheLetter = [SKAction scaleTo:.1 duration:0.5];
        scaleTheLetter.timingMode = SKActionTimingEaseIn;
        SKAction *sequenceUpDown = [SKAction sequence:@[scaleTheLetter, scaleDownTheLetter]];
        
        [letterB runAction:sequenceUpDown];
        
        [avSound play];
        
        
        SKSpriteNode *tempPicForQ = [SKSpriteNode alloc];
        tempPicForQ = picForQuestion;
        tempPicForQ.userInteractionEnabled = NO;
        //[picForQuestion removeFromParent];

        SKAction *waitBegin = [SKAction waitForDuration:0.2];
        SKAction *flyBatAway = [SKAction moveTo:CGPointMake(letterB.position.x, letterB.position.y - 500) duration:0.4];
        flyBatAway.timingMode = SKActionTimingEaseIn;
        SKAction *waitToLoad = [SKAction waitForDuration:1.0];
        SKAction *loadNextImage = [SKAction runBlock:^{
            [self nextQuestion];
        }];
        SKAction *sequenceLoad = [SKAction sequence:@[waitBegin,flyBatAway,waitToLoad,loadNextImage]];
        
        SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:picForQuestion duration:1.0
                                                    startPosition:picForQuestion.position
                                                      endPosition:CGPointMake(picForQuestion.position.x, picForQuestion.position.y - 400) ];
        
        actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
        
        SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
        
        SKAction *tumbleScreen = [SKAction skt_screenTumbleWithNode:picForQuestion angle:40 oscillations:10 duration:1.0];
        [self runAction:tumbleScreen];
        
        [picForQuestion runAction:actionWithEffect];
        
        SKAction *zoomEffect = [SKAction skt_screenZoomWithNode:letterB amount:CGPointMake(500, 500) oscillations:5 duration:1.0];
        [self runAction:zoomEffect];
        
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
