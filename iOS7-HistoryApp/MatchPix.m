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
#import "LetterTrace.h"
#import "LowerCaseLetter.h"
#import "IntroScreen.h"
#import "MontessoriData.h"
#import "SKAction+SKTExtras.h"
#import "SKTTimingFunctions.h"
#import "SKTEffects.h"
#import "MatchImage.h"


@implementation MatchPix

SKSpriteNode *picForQuestion;
SKSpriteNode *firstImageAnimate;
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

UIPanGestureRecognizer *gestureRecognizer;

MontessoriData *sharedData;

SKSpriteNode *backToMainMenuArrow;

BOOL objectSelected;
int questionCount;
int groupNumber;

@synthesize selectedImage, gridPaper;

-(id)initWithSize:(CGSize)size onWhichGroup:(NSNumber *)group {
    
    
    groupNumber = [group intValue];
    NSString *groupNumberKeyVal = [group stringValue];
    
    self = [super initWithSize:size];
    if (self) {
        
        questionCount = 0;
        objectSelected = FALSE;
        
        sharedData = [MontessoriData sharedManager];

        gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"forest-bg.png"];
        gridPaper.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:gridPaper];

        //groupNumber = 1;
        
        /*NSMutableArray *animFrames = [NSMutableArray array];
        SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"goat"];
        
        int numImages = imageAnimationAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"%d",i];
            SKTexture *temp = [imageAnimationAtlas textureNamed:textureName];
            [animFrames addObject:temp];
        }
        texturesForAnim = animFrames;
        
        SKTexture *temp2 = texturesForAnim[0];
        firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:temp2];
        firstImageAnimate.position = CGPointMake(500, 400);
        [self addChild:firstImageAnimate];
        [self setInMotion];*/
        
        NSString *pListData = [[NSBundle mainBundle]pathForResource:@"Letters" ofType:@"plist"];
        allPicsForQuestions = [[NSMutableArray alloc]initWithContentsOfFile:pListData];
        imagesForLetters = [[NSMutableArray alloc]init];
        
        for (NSDictionary *problem in allPicsForQuestions) {
            
            int i = 0;
            for (NSString *key in problem) {
                
                if ([[problem valueForKey:key] isEqualToString:groupNumberKeyVal]) {
                    
                    /*if ([[problem valueForKey:@"animation"]isEqualToString:@"yes"]) {
                        NSLog(@"atlas name: %@",[problem valueForKey:@"phrase"]);
                        
                        NSMutableArray *animFrames = [NSMutableArray array];
                        SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:[problem valueForKey:@"phrase"]];
                        
                        int numImages = imageAnimationAtlas.textureNames.count;
                        for (int i=1; i <= numImages; i++) {
                            NSString *textureName = [NSString stringWithFormat:@"%d",i];
                            SKTexture *temp = [imageAnimationAtlas textureNamed:textureName];
                            [animFrames addObject:temp];
                        }
                        texturesForAnim = animFrames;
                        
                        SKTexture *temp2 = texturesForAnim[0];
                        firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:temp2];
                        firstImageAnimate.position = CGPointMake(500, 400);
                        [self addChild:firstImageAnimate];
                        [self setInMotion];
                        
                    } else {*/
                        SKSpriteNode *imageForSound = [SKSpriteNode spriteNodeWithImageNamed:[problem valueForKey:@"phrase"]];
                        imageForSound.name = [problem valueForKey:@"letter"];
                        NSNumber *numberForScale = [problem valueForKey:@"scale"];
                        imageForSound.scale = [numberForScale floatValue];
                        [imagesForLetters addObject:imageForSound];
                    //}
                    
                    
                    
                }
                
            }
            i++;
        }
        
        if (groupNumber == 1) {
            letterA = [self createLetterA];
            letterB = [self createLetterB];
            letterC = [self createLetterC];
            letterM = [self createLetterM];
            letterS = [self createLetterS];
            letterT = [self createLetterT];
            
            letterA.scale = 0.2;
            letterB.scale = 0.2;
            letterC.scale = 0.2;
            letterM.scale = 0.2;
            letterS.scale = 0.2;
            letterT.scale = 0.2;
            
            letterA.position = CGPointMake(1800, 800);
            letterB.position = CGPointMake(1500, 800);
            letterC.position = CGPointMake(1200, 800);
            letterM.position = CGPointMake(1800, 200);
            letterS.position = CGPointMake(1500, 200);
            letterT.position = CGPointMake(1200, 200);
            
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
            
            [self addChild:letterA];
            [self addChild:letterB];
            [self addChild:letterC];
            [self addChild:letterM];
            [self addChild:letterS];
            [self addChild:letterT];
            
            
            [self setupSounds];
            
            SKAction *delayed = [SKAction waitForDuration:3.0];
            SKAction *moveToPositionWithSound = [SKAction moveByX:-1100 y:0 duration:0.1];
            
            SKAction *firstLetter = [SKAction runBlock:^{
                [letterA runAction:moveToPositionWithSound];
                [letterA playTheSound];
                [letterA fireEmitter];
            }];
            
            SKAction *chainNextLetter = [SKAction runBlock:^{
                [letterB runAction:moveToPositionWithSound];
                [letterB playTheSound];
                [letterB fireEmitter];
            }];
            
            SKAction *chainThirdLetter = [SKAction runBlock:^{
                [letterC runAction:moveToPositionWithSound];
                [letterC playTheSound];
                [letterC fireEmitter];
            }];
            
            SKAction *chainFourthLetter = [SKAction runBlock:^{
                [letterM runAction:moveToPositionWithSound];
                [letterM playTheSound];
                [letterM fireEmitter];
            }];
            
            SKAction *chainFifthLetter = [SKAction runBlock:^{
                [letterS runAction:moveToPositionWithSound];
                [letterS playTheSound];
                [letterS fireEmitter];
                
            }];
            
            SKAction *chainSixthLetter = [SKAction runBlock:^{
                [letterT runAction:moveToPositionWithSound];
                [letterT playTheSound];
                [letterT fireEmitter];
                
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

        } else if (groupNumber == 2) {
            letterG = [self createLetterG];
            letterR = [self createLetterR];
            letterO = [self createLetterO];
            letterF = [self createLetterF];
            letterD = [self createLetterD];
            
            letterG.scale = 0.2;
            letterR.scale = 0.2;
            letterO.scale = 0.2;
            letterF.scale = 0.2;
            letterD.scale = 0.2;
            
            letterG.name = @"G";
            letterR.name = @"R";
            letterO.name = @"O";
            letterF.name = @"F";
            letterD.name = @"D";
            
            letterG.position = CGPointMake(1800, 800);
            letterR.position = CGPointMake(1600, 800);
            letterO.position = CGPointMake(1400, 800);
            letterF.position = CGPointMake(1300, 800);
            letterD.position = CGPointMake(1200, 800);
            
            
            allLettersSprites = [[NSMutableArray alloc]init];
            [allLettersSprites addObject:letterG];
            [allLettersSprites addObject:letterR];
            [allLettersSprites addObject:letterO];
            [allLettersSprites addObject:letterF];
            [allLettersSprites addObject:letterD];
            
            [self addChild:letterG];
            [self addChild:letterR];
            [self addChild:letterO];
            [self addChild:letterF];
            [self addChild:letterD];
            
            SKAction *delayed = [SKAction waitForDuration:3.0];
            SKAction *moveToPositionWithSound = [SKAction moveByX:-1100 y:0 duration:0.1];
            
            SKAction *firstLetter = [SKAction runBlock:^{
                [letterG runAction:moveToPositionWithSound];
                [letterG playTheSound];
                [letterG fireEmitter];
            }];
            
            SKAction *chainNextLetter = [SKAction runBlock:^{
                [letterR runAction:moveToPositionWithSound];
                [letterR playTheSound];
                [letterR fireEmitter];
            }];
            
            SKAction *chainThirdLetter = [SKAction runBlock:^{
                [letterF runAction:moveToPositionWithSound];
                [letterF playTheSound];
                [letterF fireEmitter];
            }];
            
            SKAction *chainFourthLetter = [SKAction runBlock:^{
                [letterD runAction:moveToPositionWithSound];
                [letterD playTheSound];
                [letterD fireEmitter];
            }];

            
            SKAction *chainSixthLetter = [SKAction runBlock:^{
                [letterO runAction:moveToPositionWithSound];
                [letterO playTheSound];
                [letterO fireEmitter];
                
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
                                                          chainSixthLetter
                                                          ]];
            
            [self runAction:sequenceMove];

            [self setupSounds];
            
        } else if (groupNumber == 3) {
            letterH = [self createLetterH];
            letterI = [self createLetterI];
            letterP = [self createLetterP];
            letterN = [self createLetterN];
            letterL = [self createLetterL];
            
            letterH.scale = 0.2;
            letterI.scale = 0.2;
            letterP.scale = 0.2;
            letterN.scale = 0.2;
            letterL.scale = 0.2;
            
            letterH.name = @"G";
            letterI.name = @"R";
            letterP.name = @"O";
            letterN.name = @"F";
            letterL.name = @"D";
            
            letterH.position = CGPointMake(1800, 800);
            letterI.position = CGPointMake(1600, 800);
            letterP.position = CGPointMake(1400, 800);
            letterN.position = CGPointMake(1300, 800);
            letterL.position = CGPointMake(1200, 800);
            
            
            allLettersSprites = [[NSMutableArray alloc]init];
            [allLettersSprites addObject:letterH];
            [allLettersSprites addObject:letterI];
            [allLettersSprites addObject:letterP];
            [allLettersSprites addObject:letterN];
            [allLettersSprites addObject:letterL];
            
            [self addChild:letterH];
            [self addChild:letterI];
            [self addChild:letterP];
            [self addChild:letterN];
            [self addChild:letterL];
            
            SKAction *delayed = [SKAction waitForDuration:3.0];
            SKAction *moveToPositionWithSound = [SKAction moveByX:-1100 y:0 duration:0.1];
            
            SKAction *firstLetter = [SKAction runBlock:^{
                [letterH runAction:moveToPositionWithSound];
                [letterH playTheSound];
                [letterH fireEmitter];
            }];
            
            SKAction *chainNextLetter = [SKAction runBlock:^{
                [letterI runAction:moveToPositionWithSound];
                [letterI playTheSound];
                [letterI fireEmitter];
            }];
            
            SKAction *chainThirdLetter = [SKAction runBlock:^{
                [letterP runAction:moveToPositionWithSound];
                [letterP playTheSound];
                [letterP fireEmitter];
            }];
            
            SKAction *chainFourthLetter = [SKAction runBlock:^{
                [letterN runAction:moveToPositionWithSound];
                [letterN playTheSound];
                [letterN fireEmitter];
            }];
            
            
            SKAction *chainSixthLetter = [SKAction runBlock:^{
                [letterL runAction:moveToPositionWithSound];
                [letterL playTheSound];
                [letterL fireEmitter];
                
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
                                                          chainSixthLetter
                                                          ]];
            
            [self runAction:sequenceMove];
            
            [self setupSounds];
            
        } else if (groupNumber == 4) {
            letterK = [self createLetterK];
            letterE = [self createLetterE];
            letterX = [self createLetterX];
            letterZ = [self createLetterZ];
            letterQ = [self createLetterQ];
            
            letterK.scale = 0.2;
            letterE.scale = 0.2;
            letterX.scale = 0.2;
            letterZ.scale = 0.2;
            letterQ.scale = 0.2;
            
            letterK.name = @"G";
            letterE.name = @"R";
            letterX.name = @"O";
            letterZ.name = @"F";
            letterQ.name = @"D";
            
            letterK.position = CGPointMake(1800, 800);
            letterE.position = CGPointMake(1600, 800);
            letterX.position = CGPointMake(1400, 800);
            letterZ.position = CGPointMake(1300, 800);
            letterQ.position = CGPointMake(1200, 800);
            
            
            allLettersSprites = [[NSMutableArray alloc]init];
            [allLettersSprites addObject:letterK];
            [allLettersSprites addObject:letterE];
            [allLettersSprites addObject:letterX];
            [allLettersSprites addObject:letterZ];
            [allLettersSprites addObject:letterQ];
            
            [self addChild:letterK];
            [self addChild:letterE];
            [self addChild:letterX];
            [self addChild:letterZ];
            [self addChild:letterQ];
            
            SKAction *delayed = [SKAction waitForDuration:3.0];
            SKAction *moveToPositionWithSound = [SKAction moveByX:-1100 y:0 duration:0.1];
            
            SKAction *firstLetter = [SKAction runBlock:^{
                [letterK runAction:moveToPositionWithSound];
                [letterK playTheSound];
                [letterK fireEmitter];
            }];
            
            SKAction *chainNextLetter = [SKAction runBlock:^{
                [letterE runAction:moveToPositionWithSound];
                [letterE playTheSound];
                [letterE fireEmitter];
            }];
            
            SKAction *chainThirdLetter = [SKAction runBlock:^{
                [letterX runAction:moveToPositionWithSound];
                [letterX playTheSound];
                [letterX fireEmitter];
            }];
            
            SKAction *chainFourthLetter = [SKAction runBlock:^{
                [letterZ runAction:moveToPositionWithSound];
                [letterZ playTheSound];
                [letterZ fireEmitter];
            }];
            
            
            SKAction *chainSixthLetter = [SKAction runBlock:^{
                [letterQ runAction:moveToPositionWithSound];
                [letterQ playTheSound];
                [letterQ fireEmitter];
                
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
                                                          chainSixthLetter
                                                          ]];
            
            [self runAction:sequenceMove];
            
            [self setupSounds];
            
        } else if (groupNumber == 5) {
            letterJ = [self createLetterJ];
            letterU = [self createLetterU];
            letterV = [self createLetterV];
            letterW = [self createLetterW];
            letterY = [self createLetterY];
            
            letterJ.scale = 0.2;
            letterU.scale = 0.2;
            letterV.scale = 0.2;
            letterW.scale = 0.2;
            letterY.scale = 0.2;
            
            letterJ.name = @"G";
            letterU.name = @"R";
            letterV.name = @"O";
            letterW.name = @"F";
            letterY.name = @"D";
            
            letterJ.position = CGPointMake(1800, 800);
            letterU.position = CGPointMake(1600, 800);
            letterV.position = CGPointMake(1400, 800);
            letterW.position = CGPointMake(1300, 800);
            letterY.position = CGPointMake(1200, 800);
            
            
            allLettersSprites = [[NSMutableArray alloc]init];
            [allLettersSprites addObject:letterJ];
            [allLettersSprites addObject:letterU];
            [allLettersSprites addObject:letterV];
            [allLettersSprites addObject:letterW];
            [allLettersSprites addObject:letterY];
            
            [self addChild:letterJ];
            [self addChild:letterU];
            [self addChild:letterV];
            [self addChild:letterW];
            [self addChild:letterY];
            
            SKAction *delayed = [SKAction waitForDuration:3.0];
            SKAction *moveToPositionWithSound = [SKAction moveByX:-1100 y:0 duration:0.1];
            
            SKAction *firstLetter = [SKAction runBlock:^{
                [letterJ runAction:moveToPositionWithSound];
                [letterJ playTheSound];
                [letterJ fireEmitter];
            }];
            
            SKAction *chainNextLetter = [SKAction runBlock:^{
                [letterU runAction:moveToPositionWithSound];
                [letterU playTheSound];
                [letterU fireEmitter];
            }];
            
            SKAction *chainThirdLetter = [SKAction runBlock:^{
                [letterV runAction:moveToPositionWithSound];
                [letterV playTheSound];
                [letterV fireEmitter];
            }];
            
            SKAction *chainFourthLetter = [SKAction runBlock:^{
                [letterW runAction:moveToPositionWithSound];
                [letterW playTheSound];
                [letterW fireEmitter];
            }];
            
            
            SKAction *chainSixthLetter = [SKAction runBlock:^{
                [letterY runAction:moveToPositionWithSound];
                [letterY playTheSound];
                [letterY fireEmitter];
                
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
                                                          chainSixthLetter
                                                          ]];
            
            [self runAction:sequenceMove];
            
            [self setupSounds];
            
        } else {

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
        [testLabel runAction:[SKAction fadeAlphaTo:0.0 duration:10.0]];

        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-3.png"];
        backToMainMenuArrow.scale = 0.5;
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];

    }
    
    return self;
    
}

- (void)didMoveToView:(SKView *)view {
    
    gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
    
}

- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        [self selectNodeForTouch:touchLocation];
    
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        [self checkCollisions];

    }
}


-(void)moveIt:(UIPanGestureRecognizer *)recognizer {
    float scrollDuration = 0.2;
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    CGPoint pos = [selectedImage position];
    CGPoint p = multPix(velocity, scrollDuration);
    
    CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
    //newPos = [self boundLayerPos:newPos];
    [selectedImage removeAllActions];
    
    SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
    [moveTo setTimingMode:SKActionTimingEaseOut];
    [selectedImage runAction:moveTo];
}

CGPoint multPix(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
}


/*- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[gridPaper size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}*/

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [selectedImage position];
    if([[selectedImage name] isEqualToString:@"A"] ||
       [[selectedImage name] isEqualToString:@"B"] ||
       [[selectedImage name] isEqualToString:@"C"] ||
       [[selectedImage name] isEqualToString:@"D"] ||
       [[selectedImage name] isEqualToString:@"E"] ||
       [[selectedImage name] isEqualToString:@"F"] ||
       [[selectedImage name] isEqualToString:@"G"] ||
       [[selectedImage name] isEqualToString:@"H"] ||
       [[selectedImage name] isEqualToString:@"I"] ||
       [[selectedImage name] isEqualToString:@"J"] ||
       [[selectedImage name] isEqualToString:@"K"] ||
       [[selectedImage name] isEqualToString:@"L"] ||
       [[selectedImage name] isEqualToString:@"M"] ||
       [[selectedImage name] isEqualToString:@"N"] ||
       [[selectedImage name] isEqualToString:@"O"] ||
       [[selectedImage name] isEqualToString:@"P"] ||
       [[selectedImage name] isEqualToString:@"Q"] ||
       [[selectedImage name] isEqualToString:@"R"] ||
       [[selectedImage name] isEqualToString:@"S"] ||
       [[selectedImage name] isEqualToString:@"T"] ||
       [[selectedImage name] isEqualToString:@"U"] ||
       [[selectedImage name] isEqualToString:@"V"] ||
       [[selectedImage name] isEqualToString:@"W"] ||
       [[selectedImage name] isEqualToString:@"X"] ||
       [[selectedImage name] isEqualToString:@"Y"] ||
       [[selectedImage name] isEqualToString:@"Z"]) {
        
        [selectedImage setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    }
    else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
    }
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    
	if(![selectedImage isEqual:touchedNode]) {
		[selectedImage removeAllActions];
		[selectedImage runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
		selectedImage = touchedNode;
        
		if([[touchedNode name] isEqualToString:@"A"] ||
           [[touchedNode name] isEqualToString:@"B"] ||
           [[touchedNode name] isEqualToString:@"C"] ||
           [[touchedNode name] isEqualToString:@"D"] ||
           [[touchedNode name] isEqualToString:@"E"] ||
           [[touchedNode name] isEqualToString:@"F"] ||
           [[touchedNode name] isEqualToString:@"G"] ||
           [[touchedNode name] isEqualToString:@"H"] ||
           [[touchedNode name] isEqualToString:@"I"] ||
           [[touchedNode name] isEqualToString:@"J"] ||
           [[touchedNode name] isEqualToString:@"K"] ||
           [[touchedNode name] isEqualToString:@"L"] ||
           [[touchedNode name] isEqualToString:@"M"] ||
           [[touchedNode name] isEqualToString:@"N"] ||
           [[touchedNode name] isEqualToString:@"O"] ||
           [[touchedNode name] isEqualToString:@"P"] ||
           [[touchedNode name] isEqualToString:@"Q"] ||
           [[touchedNode name] isEqualToString:@"R"] ||
           [[touchedNode name] isEqualToString:@"S"] ||
           [[touchedNode name] isEqualToString:@"T"] ||
           [[touchedNode name] isEqualToString:@"U"] ||
           [[touchedNode name] isEqualToString:@"V"] ||
           [[touchedNode name] isEqualToString:@"W"] ||
           [[touchedNode name] isEqualToString:@"X"] ||
           [[touchedNode name] isEqualToString:@"Y"] ||
           [[touchedNode name] isEqualToString:@"Z"])
        
        {
			SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:20.2 duration:1.6],
													  [SKAction rotateByAngle:20.5 duration:1.6],
													  [SKAction rotateByAngle:20.2 duration:1.6]]];
			[selectedImage runAction:[SKAction repeatActionForever:sequence]];
		}
	}
    
}

-(void)nextQuestion {
    if (questionCount < [imagesForLetters count]) {

        picForQuestion = (SKSpriteNode *)[imagesForLetters objectAtIndex:questionCount];
        picForQuestion.position = CGPointMake(500, 400);
        picForQuestion.alpha = 1.0;
        [self addChild:picForQuestion];

        self.userInteractionEnabled = YES;
    } else {
        groupNumber++;
        
        [self removeAllChildren];
        [[self view] removeGestureRecognizer:gestureRecognizer];
        LetterTrace *traceScene = [[LetterTrace alloc]initWithSize:CGSizeMake(1024,768) andGroup:[NSNumber numberWithInt:groupNumber ]];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
        SKView *spriteView = (SKView*)self.view;
        [spriteView presentScene:traceScene transition:reveal];
        
    }
}

-(void)selectedImageForTouch:(CGPoint)touchLocation {
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    if(![selectedImage isEqual:touchedNode]) {
        [selectedImage removeAllActions];
        [selectedImage runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        selectedImage = touchedNode;
        if([[touchedNode name] isEqualToString:@"A"] ||
           [[touchedNode name] isEqualToString:@"B"] ||
           [[touchedNode name] isEqualToString:@"C"] ||
           [[touchedNode name] isEqualToString:@"D"] ||
           [[touchedNode name] isEqualToString:@"F"] ||
           [[touchedNode name] isEqualToString:@"G"] ||
           [[touchedNode name] isEqualToString:@"H"] ||
           [[touchedNode name] isEqualToString:@"I"] ||
           [[touchedNode name] isEqualToString:@"J"] ||
           [[touchedNode name] isEqualToString:@"K"] ||
           [[touchedNode name] isEqualToString:@"L"] ||
           [[touchedNode name] isEqualToString:@"M"] ||
           [[touchedNode name] isEqualToString:@"N"] ||
           [[touchedNode name] isEqualToString:@"O"] ||
           [[touchedNode name] isEqualToString:@"P"] ||
           [[touchedNode name] isEqualToString:@"Q"] ||
           [[touchedNode name] isEqualToString:@"R"] ||
           [[touchedNode name] isEqualToString:@"S"] ||
           [[touchedNode name] isEqualToString:@"T"] ||
           [[touchedNode name] isEqualToString:@"U"] ||
           [[touchedNode name] isEqualToString:@"V"] ||
           [[touchedNode name] isEqualToString:@"W"] ||
           [[touchedNode name] isEqualToString:@"X"] ||
           [[touchedNode name] isEqualToString:@"Y"] ||
           [[touchedNode name] isEqualToString:@"Z"])
        {

            SKAction *sequence = [SKAction sequence:@[[SKAction rotateByAngle:18.5  duration:0.1],
                                                      [SKAction rotateByAngle:0.0 duration:0.1],
                                                      [SKAction rotateByAngle:18.7 duration:0]]];
            
            [touchedNode runAction:sequence];
        }
    }
    
    
}


-(void)setUpAnimationFrames {
    
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"matchImages"];
    
    int numImages = imageAnimationAtlas.textureNames.count;
    for (int i=1; i <= numImages; i++) {
        NSString *textureName = [NSString stringWithFormat:@"image%d",i];
        SKTexture *temp = [imageAnimationAtlas textureNamed:textureName];
        [animFrames addObject:temp];
    }
    texturesForAnim = animFrames;
    
    SKTexture *temp2 = texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:temp2];
    firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self setInMotion];
    
}

-(void)setInMotion {
    
    [firstImageAnimate runAction:[SKAction repeatActionForever:
                                  [SKAction animateWithTextures:texturesForAnim
                                                   timePerFrame:0.1
                                                         resize:NO
                                                        restore:YES]]withKey:@"walkInPlace"];
    
    return;
    
}

-(void)update:(CFTimeInterval)currentTime {
    
    

}


-(void) checkCollisions {
    
    for (LowerCaseLetter *letterHit in allLettersSprites) {
        if(CGRectIntersectsRect(letterHit.frame, picForQuestion.frame)) {

            [picForQuestion removeAllActions];
            if ([letterHit.whichLetter isEqualToString:picForQuestion.name]) {
                SKAction *scaleDown = [SKAction scaleTo:0.1 duration:0.1];
                SKAction *fadeIt = [SKAction fadeAlphaBy:0.5 duration:0.2];
                if ([letterHit.whichLetter isEqualToString:@"A"] ||
                    [letterHit.whichLetter isEqualToString:@"B"] ||
                    [letterHit.whichLetter isEqualToString:@"C"]) {
                    
                    SKAction *moveToLetter = [SKAction moveTo:CGPointMake(letterHit.position.x,letterHit.position.y+150) duration:0.2];
                    SKAction *delayIt = [SKAction waitForDuration:0.2];
                    SKAction *nextLetterBlock = [SKAction runBlock:^{
                        
                        questionCount++;
                        [self nextQuestion];
                        
                    }];
                    SKAction *sequenceNextLetter = [SKAction sequence:@[scaleDown,fadeIt,moveToLetter,delayIt,nextLetterBlock]];
                    
                    picForQuestion.color = [UIColor colorWithHue:3.5 saturation:2.2 brightness:1.0 alpha:1.0];
                    picForQuestion.colorBlendFactor = 1.0;
                    [picForQuestion runAction:sequenceNextLetter];
                    
                    SKAction *moveLetterDown = [SKAction moveTo:CGPointMake(letterHit.position.x, letterHit.position.y - 70) duration:0.1];
                    [letterHit runAction:moveLetterDown];
                } else {
                    SKAction *moveToLetter = [SKAction moveTo:CGPointMake(letterHit.position.x,letterHit.position.y-50) duration:0.2];
                    SKAction *delayIt = [SKAction waitForDuration:0.2];
                    SKAction *nextLetterBlock = [SKAction runBlock:^{
                        
                        questionCount++;
                        [self nextQuestion];
                        
                    }];
                    SKAction *sequenceNextLetter = [SKAction sequence:@[scaleDown,fadeIt,moveToLetter,delayIt,nextLetterBlock]];
                    
                    picForQuestion.color = [UIColor colorWithHue:3.5 saturation:2.2 brightness:1.0 alpha:1.0];
                    picForQuestion.colorBlendFactor = 1.0;
                    [picForQuestion runAction:sequenceNextLetter];
                    
                    SKAction *moveLetterUp = [SKAction moveTo:CGPointMake(letterHit.position.x, letterHit.position.y + 70) duration:0.1];
                    [letterHit runAction:moveLetterUp];
                }
                
            }
        }
        
    }
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



-(LowerCaseLetter *) createLetterA {
    
    letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"a_blue_600x600.png"];
    NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"a" withExtension:@"aiff"];
    letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
    letterA.name = @"A";
    letterA.whichLetter = @"A";
    return letterA;
}

-(LowerCaseLetter *) createLetterB {
    
    letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"b_1.png"];
    NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"b" withExtension:@"aiff"];
    letterB.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterBurl error:nil];
    letterB.name = @"B";
    letterB.whichLetter = @"B";
    letterB.centerStage = FALSE;
    return letterB;
}

-(LowerCaseLetter *) createLetterC {
    
    letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"c_600x600.png"];
    NSURL *letterCurl = [[NSBundle mainBundle]URLForResource:@"c" withExtension:@"aiff"];
    letterC.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterCurl error:nil];
    letterC.name = @"C";
    letterC.whichLetter = @"C";
    return letterC;
}

-(LowerCaseLetter *) createLetterD {
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"d_1000x600.png"];
    letterD.anchorPoint = CGPointMake(1.0, 0.4);
    NSURL *letterDurl = [[NSBundle mainBundle]URLForResource:@"d" withExtension:@"aiff"];
    letterD.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterDurl error:nil];
    letterD.name = @"D";
    letterD.whichLetter = @"D";
    return letterD;
}

-(LowerCaseLetter *) createLetterE {
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"e_600x600.png"];
    letterE.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterEurl = [[NSBundle mainBundle]URLForResource:@"e" withExtension:@"aiff"];
    letterE.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterEurl error:nil];
    letterE.name = @"E";
    letterE.whichLetter = @"E";
    return letterE;
}

-(LowerCaseLetter *) createLetterF {
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"f_850x600.png"];
    letterF.anchorPoint = CGPointMake(1.0, 0.5);
    NSURL *letterFurl = [[NSBundle mainBundle]URLForResource:@"f2" withExtension:@"aiff"];
    letterF.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterFurl error:nil];
    letterF.name = @"F";
    letterF.whichLetter = @"F";
    return letterF;
    
}

-(LowerCaseLetter *) createLetterG {
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"g_1000x600.png"];
    NSURL *letterGurl = [[NSBundle mainBundle]URLForResource:@"g" withExtension:@"aiff"];
    letterG.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterGurl error:nil];
    letterG.name = @"G";
    letterG.whichLetter = @"G";
    letterG.anchorPoint = CGPointMake(1.0,0.8);
    return letterG;
    
}

-(LowerCaseLetter *) createLetterH {
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"h_1000x600.png"];
    letterH.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterHurl = [[NSBundle mainBundle]URLForResource:@"h2" withExtension:@"aiff"];
    letterH.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterHurl error:nil];
    letterH.name = @"H";
    letterH.whichLetter = @"H";
    return letterH;
}

-(LowerCaseLetter *) createLetterI {
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"i_850x600.png"];
    NSURL *letterIurl = [[NSBundle mainBundle]URLForResource:@"i2" withExtension:@"aiff"];
    letterI.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterIurl error:nil];
    letterI.name = @"I";
    letterI.whichLetter = @"I";
    return letterI;
}

-(LowerCaseLetter *) createLetterJ {
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"j_1000x600.png"];
    letterJ.anchorPoint = CGPointMake(1.0, 0.8);
    NSURL *letterJurl = [[NSBundle mainBundle]URLForResource:@"j2" withExtension:@"aiff"];
    letterJ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterJurl error:nil];
    letterJ.name = @"J";
    letterJ.whichLetter = @"J";
    return letterJ;
}

-(LowerCaseLetter *) createLetterK {
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"k_1000x600.png"];
    letterK.anchorPoint = CGPointMake(1.0, 0.4);
    NSURL *letterKurl = [[NSBundle mainBundle]URLForResource:@"k" withExtension:@"aiff"];
    letterK.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterKurl error:nil];
    letterK.name = @"K";
    letterK.whichLetter = @"K";
    return letterK;
}

-(LowerCaseLetter *)createLetterL {
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"l_1000x600.png"];
    letterL.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterLurl = [[NSBundle mainBundle]URLForResource:@"l" withExtension:@"aiff"];
    letterL.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterLurl error:nil];
    letterL.name = @"L";
    letterL.whichLetter = @"L";
    return letterL;
}

-(LowerCaseLetter *)createLetterM {
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"m_600x850.png"];
    NSURL *letterMurl = [[NSBundle mainBundle]URLForResource:@"m" withExtension:@"aiff"];
    letterM.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterMurl error:nil];
    letterM.name = @"M";
    letterM.whichLetter = @"M";
    return letterM;
}

-(LowerCaseLetter *)createLetterN {
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"n_600x600.png"];
    letterN.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterNurl = [[NSBundle mainBundle]URLForResource:@"n" withExtension:@"aiff"];
    letterN.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterNurl error:nil];
    letterN.name = @"N";
    letterN.whichLetter = @"N";
    return letterN;
}

-(LowerCaseLetter *)createLetterO {
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"o_600x600.png"];
    letterO.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterOurl = [[NSBundle mainBundle]URLForResource:@"o" withExtension:@"aiff"];
    letterO.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterOurl error:nil];
    letterO.name = @"O";
    letterO.whichLetter = @"O";
    return letterO;
}

-(LowerCaseLetter *)createLetterP {
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"p_1000x600.png"];
    letterP.anchorPoint = CGPointMake(1.0, 0.8);
    
    NSURL *letterPurl = [[NSBundle mainBundle]URLForResource:@"p" withExtension:@"aiff"];
    letterP.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterPurl error:nil];
    letterP.name = @"P";
    letterP.whichLetter = @"P";
    return letterP;
}

-(LowerCaseLetter *)createLetterQ {
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"q_1000x620.png"];
    letterQ.anchorPoint = CGPointMake(1.0, 0.8);
    NSURL *letterQurl = [[NSBundle mainBundle]URLForResource:@"q" withExtension:@"aiff"];
    letterQ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterQurl error:nil];
    letterQ.name = @"Q";
    letterQ.whichLetter = @"Q";
    return letterQ;
}

-(LowerCaseLetter *)createLetterR {
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"r_600x600.png"];
    letterR.anchorPoint = CGPointMake(1.0,0.65);
    
    NSURL *letterRurl = [[NSBundle mainBundle]URLForResource:@"r" withExtension:@"aiff"];
    letterR.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterRurl error:nil];
    letterR.name = @"R";
    letterR.whichLetter = @"R";
    return letterR;
}

-(LowerCaseLetter *)createLetterS {
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"s_600x600.png"];
    NSURL *letterSurl = [[NSBundle mainBundle]URLForResource:@"s" withExtension:@"aiff"];
    letterS.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterSurl error:nil];
    letterS.name = @"S";
    letterS.whichLetter = @"S";
    return letterS;
}

-(LowerCaseLetter *)createLetterT {
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"t_850x600.png"];
    NSURL *letterTurl = [[NSBundle mainBundle]URLForResource:@"t2" withExtension:@"aiff"];
    letterT.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterTurl error:nil];
    letterT.name = @"T";
    letterT.whichLetter = @"T";
    return letterT;
}

-(LowerCaseLetter *)createLetterU {
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"u_600x600.png"];
    NSURL *letterUurl = [[NSBundle mainBundle]URLForResource:@"u" withExtension:@"aiff"];
    letterU.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterUurl error:nil];
    letterU.name = @"U";
    letterU.whichLetter = @"U";
    return letterU;
}

-(LowerCaseLetter *)createLetterV {
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"v_600x600.png"];
    NSURL *letterVurl = [[NSBundle mainBundle]URLForResource:@"v" withExtension:@"aiff"];
    letterV.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterVurl error:nil];
    letterV.name = @"V";
    letterV.whichLetter = @"V";
    return letterV;
}

-(LowerCaseLetter *)createLetterW {
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"w_600x850.png"];
    NSURL *letterWurl = [[NSBundle mainBundle]URLForResource:@"w" withExtension:@"aiff"];
    letterW.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterWurl error:nil];
    letterW.name = @"W";
    letterW.whichLetter = @"W";
    return letterW;
}

-(LowerCaseLetter *)createLetterX {
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"x_600x600.png"];
    letterX.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterXurl = [[NSBundle mainBundle]URLForResource:@"x" withExtension:@"aiff"];
    letterX.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterXurl error:nil];
    letterX.name = @"X";
    letterX.whichLetter = @"X";
    return letterX;
}

-(LowerCaseLetter *) createLetterY {
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"y_1000x600.png"];
    letterY.anchorPoint = CGPointMake(1.0, 0.8);
    NSURL *letterYurl = [[NSBundle mainBundle]URLForResource:@"y" withExtension:@"aiff"];
    letterY.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterYurl error:nil];
    letterY.name = @"Y";
    letterY.whichLetter = @"Y";
    return letterY;
}

-(LowerCaseLetter *)createLetterZ {
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"z_600x600.png"];
    letterZ.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterZurl = [[NSBundle mainBundle]URLForResource:@"z" withExtension:@"aiff"];
    letterZ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterZurl error:nil];
    letterZ.name = @"Z";
    letterZ.whichLetter = @"Z";
    return letterZ;
}

@end
