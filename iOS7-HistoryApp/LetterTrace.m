//
//  LetterTrace.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "LetterTrace.h"
#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "IntroScreen.h"
#import "LowerCaseLetter.h"
#import "MontessoriData.h"
#import "SKTUtils.h"
#import "SKTTimingFunctions.h"
#import "SmoothLineView.h"

@implementation LetterTrace

#define DEFAULT_COLOR [UIColor redColor]
#define CORRECT_COLOR [UIColor redColor]
#define INCORRECT_COLOR [UIColor redColor]
#define DEFAULT_WIDTH 10.0f
#define DEFAULT_ALPHA 0.8f


MontessoriData *sharedData;

NSMutableArray *menuOptions;
NSMutableArray *letterProblems;
NSMutableArray *controlPointSprites;
NSMutableArray *pointsForSprite;
NSMutableArray *pointsForSprite2;
NSMutableArray *spriteFromPoint;
NSMutableArray *controlPoints;
NSMutableArray *shapeNodeObjects;
NSMutableDictionary *arrowObjects;

NSMutableDictionary *shapeNodeObjectForLetter;

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


SKSpriteNode *picForQuestion;

NSMutableArray *allPicsForQuestions;
NSMutableArray *allLettersSprites;
NSMutableArray *spriteFromPoint;
NSMutableArray *spriteFromPoint2;
NSMutableArray *group1Letters;
NSMutableArray *group2Letters;
NSMutableArray *group3Letters;
NSMutableArray *group4Letters;
NSMutableArray *group5Letters;
NSMutableArray *group6Letters;


AVAudioPlayer *soundA;
AVAudioPlayer *soundB;
AVAudioPlayer *soundC;
AVAudioPlayer *soundD;
AVAudioPlayer *soundE;
AVAudioPlayer *soundF;
AVAudioPlayer *soundG;

SKSpriteNode *backToMainMenuArrow;


SKSpriteNode *firstPencil;
SKSpriteNode *secondPencil;
SKSpriteNode *thirdPencil;
SKSpriteNode *fourthPencil;
SKSpriteNode *fifthPencil;
SKEmitterNode *openEffect;
SKSpriteNode *handPointer;

int onWhichQuestion;
int onWhichGroup;
CGPoint deltaPoint;
CGPoint previousPoint;
CGPoint previousPoint2;

BOOL firstPointTest;
BOOL multiStroke;
BOOL firstStrokeComplete;
BOOL arrowAdded;

BOOL separateStroke;


CGPoint midPoint(CGPoint p1, CGPoint p2);


// Group 1: a, b, c, m, s, t
NSMutableArray *groupOneLetters;
// Group 2: g, r, d, f, o
NSMutableArray *groupTwoLetters;
// Group 3: p, n, l, h, i
NSMutableArray *groupThreeLetters;
// Group 4: z, e, x, k, q
NSMutableArray *groupFourLetters;
// Group 5: v, w, j, u, y
NSMutableArray *groupFiveLetters;
SmoothLineView *slv;


NSString *secondStroke;
CGFloat width;
CGFloat height;

@synthesize background, selectedNode;


-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        sharedData = [MontessoriData sharedManager];
        slv = [[SmoothLineView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        
        NSMutableArray *header = [[NSMutableArray alloc]initWithObjects:
                                  @"lower-s.png",
                                  @"lower-o.png",
                                  @"lower-u.png",
                                  @"lower-n.png",
                                  @"lower-d.png",
                                  @"lower-s.png",
                                  nil];
        
        int onLetter = 0;
        
        width = self.size.width;
        height = self.size.height;
        
        for (SKSpriteNode *letter in header) {
            
            NSString *nameOfSpriteFile = [header objectAtIndex:onLetter];
            
            SKSpriteNode *letterSprite = [SKSpriteNode spriteNodeWithImageNamed:nameOfSpriteFile];
            letterSprite.scale = 0.24;
            
            letterSprite.position = CGPointMake(-2400 + onLetter*120, 710);
            SKAction *moveAction = [SKAction moveByX:2600 y:0 duration:1.0];
            [letterSprite runAction:moveAction];
            [self addChild:letterSprite];
            
            
            SKAction *spinLetter = [SKAction rotateByAngle:40 duration:1.2];
            SKAction *spinLetter2 = [SKAction rotateByAngle:-40 duration:1.5];
            [letterSprite runAction:spinLetter];
            [letterSprite runAction:spinLetter2];
            
            onLetter++;
        }
        
        onWhichQuestion = 0;
        onWhichGroup = 0;
        
        firstPointTest = FALSE;
        firstStrokeComplete = FALSE;

        pointsForSprite = [[NSMutableArray alloc]init];
        spriteFromPoint = [[NSMutableArray alloc]init];
        allLettersSprites = [[NSMutableArray alloc]init];
        groupOneLetters = [[NSMutableArray alloc]init];
        groupTwoLetters = [[NSMutableArray alloc]init];
        groupThreeLetters = [[NSMutableArray alloc]init];
        groupFourLetters = [[NSMutableArray alloc]init];
        groupFiveLetters = [[NSMutableArray alloc]init];
        
        shapeNodeObjects = [[NSMutableArray alloc]init];
        shapeNodeObjectForLetter = [[NSMutableDictionary alloc]init];
        
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        SKSpriteNode *gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_wood.jpg"];
        gridPaper.position = CGPointMake(size.width/2, size.height/2-100);
        [self addChild:gridPaper];
        
        letterA = sharedData.letterA;
        
        
        //letterA.position = CGPointMake(400, 200);
        
        letterB = sharedData.letterB;
        letterB.centerStage = FALSE;
        
        letterC = sharedData.letterC;
        letterC.centerStage = FALSE;
        
        letterD = sharedData.letterD;
        letterD.centerStage = FALSE;
        
        letterE = sharedData.letterE;
        letterE.centerStage = FALSE;
        
        letterF = sharedData.letterF;
        letterF.centerStage = FALSE;
        
        letterG = sharedData.letterG;
        letterG.centerStage = FALSE;
        
        letterH = sharedData.letterH;
        letterH.centerStage = FALSE;
        
        letterI = sharedData.letterI;
        letterI.centerStage = FALSE;
        
        letterJ = sharedData.letterJ;
        letterJ.centerStage = FALSE;
        
        letterK = sharedData.letterK;
        letterK.centerStage = FALSE;
        
        letterL = sharedData.letterL;
        letterL.centerStage = FALSE;
        
        letterM = sharedData.letterM;
        letterM.centerStage = FALSE;
        
        letterN = sharedData.letterN;
        letterN.centerStage = FALSE;
        
        letterO = sharedData.letterO;
        letterO.centerStage = FALSE;
        
        letterP = sharedData.letterP;
        letterP.centerStage = FALSE;
        
        letterQ = sharedData.letterQ;
        letterQ.centerStage = FALSE;
        
        letterR = sharedData.letterR;
        letterR.centerStage = FALSE;
        
        letterS = sharedData.letterS;
        letterS.centerStage = FALSE;
        
        letterT = sharedData.letterT;
        letterT.centerStage = FALSE;
        
        letterU = sharedData.letterU;
        letterU.centerStage = FALSE;
        
        letterV = sharedData.letterV;
        letterV.centerStage = FALSE;
        
        letterW = sharedData.letterW;
        letterW.centerStage = FALSE;
        
        letterX = sharedData.letterX;
        letterX.centerStage = FALSE;
        
        letterY = sharedData.letterY;
        letterY.centerStage = FALSE;
        
        letterZ = sharedData.letterZ;
        letterZ.centerStage = FALSE;
        
        [self createLetters];
        
        [groupOneLetters addObject:letterA];
        [groupOneLetters addObject:letterB];
        [groupOneLetters addObject:letterC];
        [groupOneLetters addObject:letterM];
        [groupOneLetters addObject:letterS];
        [groupOneLetters addObject:letterT];
        
        [groupTwoLetters addObject:letterO];
        [groupTwoLetters addObject:letterG];
        [groupTwoLetters addObject:letterR];
        [groupTwoLetters addObject:letterD];
        [groupTwoLetters addObject:letterF];
        
        [groupThreeLetters addObject:letterI];
        [groupThreeLetters addObject:letterP];
        [groupThreeLetters addObject:letterN];
        [groupThreeLetters addObject:letterL];
        [groupThreeLetters addObject:letterH];
        
        [groupFourLetters addObject:letterE];
        [groupFourLetters addObject:letterZ];
        [groupFourLetters addObject:letterX];
        [groupFourLetters addObject:letterK];
        [groupFourLetters addObject:letterQ];
        
        [groupFiveLetters addObject:letterU];
        [groupFiveLetters addObject:letterV];
        [groupFiveLetters addObject:letterW];
        [groupFiveLetters addObject:letterJ];
        [groupFiveLetters addObject:letterY];
    
        [allLettersSprites addObject:letterA];
        [allLettersSprites addObject:letterB];
        [allLettersSprites addObject:letterC];
        [allLettersSprites addObject:letterD];
        [allLettersSprites addObject:letterE];
        [allLettersSprites addObject:letterF];
        [allLettersSprites addObject:letterG];
        [allLettersSprites addObject:letterH];
        [allLettersSprites addObject:letterI];
        [allLettersSprites addObject:letterJ];
        [allLettersSprites addObject:letterK];
        [allLettersSprites addObject:letterL];
        [allLettersSprites addObject:letterM];
        [allLettersSprites addObject:letterN];
        [allLettersSprites addObject:letterO];
        [allLettersSprites addObject:letterP];
        [allLettersSprites addObject:letterQ];
        [allLettersSprites addObject:letterR];
        [allLettersSprites addObject:letterS];
        [allLettersSprites addObject:letterT];
        [allLettersSprites addObject:letterU];
        [allLettersSprites addObject:letterV];
        [allLettersSprites addObject:letterW];
        [allLettersSprites addObject:letterX];
        [allLettersSprites addObject:letterY];
        [allLettersSprites addObject:letterZ];

        
        int i = 1;
        
        for (SKSpriteNode *letterSprite in groupOneLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(900,450 - i);
            [self addChild:letterSprite];
            i += 40;
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupTwoLetters) {
            letterSprite.scale = 0.25;
            letterSprite.position = CGPointMake(50 + i,50);
            [self addChild:letterSprite];
            i += 40;
            
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupThreeLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(550 + i,50);
            [self addChild:letterSprite];
            i += 40;
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupFourLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(300 + i,50);

            [self addChild:letterSprite];
            i += 40;
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupFiveLetters) {
            
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(800+i,50);
 
            [self addChild:letterSprite];
            i += 40;
        
        }
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 725);
        backToMainMenuArrow.scale = 0.5;
        [self addChild:backToMainMenuArrow];
        
        [self nextQuestion];
        
    }
    
    return self;
    
}



-(void) nextQuestion {
    
    pointsForSprite = [[NSMutableArray alloc]init];
    pointsForSprite2 = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    spriteFromPoint2 = [[NSMutableArray alloc]init];
    controlPoints = [[NSMutableArray alloc]init];
    arrowObjects = [[NSMutableDictionary alloc]init];
    
    
    float startPointX;
    float startPointY;
    
    multiStroke = FALSE;
    separateStroke = FALSE;
    firstStrokeComplete = FALSE;
    arrowAdded = FALSE;
    
    if (onWhichQuestion == 0) {

        [letterA playTheSound];
        [self createLetterA];
        
        letterA.position = CGPointMake(500, 300);
        letterA.scale = 1.0;
        letterA.centerStage = TRUE;
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left-green.png"];
        handPointer.position = CGPointMake(660, 425);
        handPointer.scale = 0.5;
        handPointer.zPosition = 10;
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:+10 y:0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleXTo:1.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];

        letterB.scale = 0.1;
        startPointX = 150;
        startPointY = 80;
    
    }
    else if (onWhichQuestion == 1) {

        [self createLetterB];
        [letterB playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self redrawShapeNode];
        
        letterB.centerStage = YES;
        
        SKAction *moveLetterA = [SKAction moveTo:CGPointMake(100, 120) duration:1.0];
        SKAction *scaleLetterA = [SKAction scaleTo:0.1 duration:1.0];
        [letterA runAction:moveLetterA];
        [letterA runAction:scaleLetterA];
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-green-down.png"];
        handPointer.position = CGPointMake(400,730);
        handPointer.scale = 0.5;
        handPointer.zPosition = 10;
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleYTo:1.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        
        
        SKAction *moveLetterB = [SKAction moveTo:CGPointMake(500, 400) duration:1.0];
        letterB.scale = 1.0;
        [letterB runAction:moveLetterB];
        
    
    }
    
    else if (onWhichQuestion == 2) {
    
        [self createLetterC];
        [letterC playTheSound];
        [self cleanUpAndRemoveShapeNode];
        
        
        for (SKShapeNode *theShape in shapeNodeObjects) {
            [theShape removeFromParent];
        }
        
        SKAction *moveLetterB = [SKAction moveTo:CGPointMake(100, 170) duration:1.0];
        SKAction *scaleLetterB = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterB runAction:moveLetterB];
        [letterB runAction:scaleLetterB];
        
        letterC.scale = 1.0;
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left-green.png"];
        handPointer.position = CGPointMake(625, 330);
        handPointer.zPosition = 10;
        handPointer.scale = 0.5;
        handPointer.zRotation = -M_PI/4;
        
        //[handPointer runAction:[SKAction rotateByAngle:-M_PI/25.0 duration:0.5]];
        
        
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:+10 y:0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleXTo:1.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        SKAction *moveLetterC = [SKAction moveTo:CGPointMake(500, 300) duration:1.0];
        [letterC runAction:moveLetterC];
    }
    
    else if (onWhichQuestion == 3) {


        [self createLetterM];
        [letterM playTheSound];
        [self cleanUpAndRemoveShapeNode];
        
        
        
        SKAction *moveLetterC = [SKAction moveTo:CGPointMake(100, 220) duration:1.0];
        SKAction *scaleLetterC = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterC runAction:moveLetterC];
        [letterC runAction:scaleLetterC];
        
        letterM.scale = 1.0;
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

        SKAction *moveLetterM = [SKAction moveTo:CGPointMake(500, 300) duration:1.0];
        [letterM runAction:moveLetterM];
        
    }
    
    else if (onWhichQuestion == 4) {
        
        [self createLetterS];
        [letterS playTheSound];
        [self cleanUpAndRemoveShapeNode];
        
        
        SKAction *moveLetterS = [SKAction moveTo:CGPointMake(100, 270) duration:1.0];
        SKAction *scaleLetterS = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterM runAction:moveLetterS];
        [letterM runAction:scaleLetterS];
        
        letterS.scale = 1.0;
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];


        SKAction *moveLetterD = [SKAction moveTo:CGPointMake(500, 300) duration:1.0];
        [letterS runAction:moveLetterD];
        
    } else if (onWhichQuestion == 5) {
        [self createLetterT];
        [letterT playTheSound];
        [self cleanUpAndRemoveShapeNode];
        
    
        SKAction *moveLetterS = [SKAction moveTo:CGPointMake(100, 320) duration:1.0];
        SKAction *scaleLetterS = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterS runAction:moveLetterS];
        [letterS runAction:scaleLetterS];
        letterT.scale = 1.0;
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        
        SKAction *moveLetterT = [SKAction moveTo:CGPointMake(500, 360) duration:1.0];
        [letterT runAction:moveLetterT];
        
       
    } else if (onWhichQuestion == 6) {
        
        SKAction *moveLetterS = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterS = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterT runAction:moveLetterS];
        [letterT runAction:scaleLetterS];
        
        //[self finishedWithGroup];
        
    } else if (onWhichQuestion == 7) {
        
    } else if (onWhichQuestion == 8) {
        
    } else if (onWhichQuestion == 9) {
        
    } else if (onWhichQuestion == 10) {
        
    } else if (onWhichQuestion == 11) {
        
    } else if (onWhichQuestion == 12) {
        
    } else if (onWhichQuestion == 13) {
        
    } else if (onWhichQuestion == 14) {
        
    } else if (onWhichQuestion == 15) {
        
    } else if (onWhichQuestion == 16) {
        
    } else if (onWhichQuestion == 17) {
        
    } else if (onWhichQuestion == 18) {
        
    } else if (onWhichQuestion == 19) {
        
    } else if (onWhichQuestion == 20) {
        
    } else if (onWhichQuestion == 21) {
        
    } else if (onWhichQuestion == 22) {
        
    } else if (onWhichQuestion == 23) {
        
    } else if (onWhichQuestion == 24) {
        
    } else if (onWhichQuestion == 25) {
        
    }
    
    
    int spritePointCount = 0;
    SKSpriteNode *previousSprite;
    
    SKAction *rotateCircle = [SKAction rotateToAngle:360 duration:60];
    SKAction *keepSpinning = [SKAction repeatActionForever:rotateCircle];
    
    for (NSValue *pointValue in pointsForSprite) {
        
        SKSpriteNode *spritePoint;
        
        if (onWhichQuestion == 0) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        } else if (onWhichQuestion == 1) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        } else if (onWhichQuestion == 2) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        } else if (onWhichQuestion == 3) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        } else if (onWhichQuestion == 4) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        } else if (onWhichQuestion == 5) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        } else {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        }
        
        CGPoint finalLocation = [pointValue CGPointValue];

        [arrowObjects enumerateKeysAndObjectsUsingBlock:^(NSNumber* key, NSNumber *value, BOOL *stop) {
            
            if (spritePointCount == [key integerValue]) {
                NSLog(@"key: %@, val: %f, spritePointCount: %i", key, [value floatValue],spritePointCount);
                spritePoint.zRotation = [value floatValue];
                
                NSLog(@"rotation = %f", spritePoint.zRotation);
                
                
            }
        }];

        //spritePoint.position = CGPointMake(finalLocation.x, finalLocation.y);
        
        spritePoint.position = CGPointMake(finalLocation.x+300, finalLocation.y+400);
        spritePoint.name = @"wheel";
        
        if (spritePointCount == 0) {
            spritePoint.alpha = 1.0;
            spritePoint.scale = 0.5;
        } else {
            spritePoint.alpha = 0.0;
            spritePoint.scale = 0.3;

        }
        
        [self addChild:spritePoint];
        
        //float moveTime = 0.1 * (float)spritePointCount;
        float moveTime = 0.1;
        
        
        SKAction *movePointsX = [SKAction moveToX:finalLocation.x+startPointX duration:moveTime];
        SKAction *movePointsY = [SKAction moveToY:finalLocation.y+startPointY duration:moveTime];
        [spritePoint runAction:movePointsX];
        [spritePoint runAction:movePointsY];
        
        [spriteFromPoint addObject:spritePoint];
        if (spritePointCount == 0) {
            [spritePoint runAction:[SKAction scaleTo:0.8 duration:0.6]];
            [spritePoint runAction:[SKAction scaleTo:0.4 duration:0.6]];
        }
        spritePointCount++;
    }
    
    if (multiStroke == TRUE) {
        NSLog(@"multi-stroke");
        for (NSValue *pointValue2 in pointsForSprite2) {
            SKSpriteNode *spritePoint2 = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
            CGPoint finalLocation = [pointValue2 CGPointValue];
            spritePoint2.position = CGPointMake(finalLocation.x+300, finalLocation.y+400);
            spritePoint2.scale = 0.3;
            spritePoint2.name = @"pixie";
            spritePoint2.alpha = 0.0;
            [self addChild:spritePoint2];
            float moveTime = 0.07 * (float)spritePointCount;
            SKAction *movePointsX = [SKAction moveToX:finalLocation.x+startPointX duration:moveTime];
            SKAction *movePointsY = [SKAction moveToY:finalLocation.y+startPointY duration:moveTime];
            
        
            [arrowObjects enumerateKeysAndObjectsUsingBlock:^(NSNumber* key, NSNumber *value, BOOL *stop) {
            
                NSLog(@"sprite point count: %i, key: %i", spritePointCount, [key integerValue]);
                
                int newSpriteCount = spritePointCount + 1;
                
                if (newSpriteCount == [key integerValue]) {
                    spritePoint2.zRotation = [value floatValue];
                    spritePoint2.zPosition = 1000;
                    NSLog(@"rotation value: %f", spritePoint2.zRotation);
                    
                    
                }
            }];
            
            [spritePoint2 runAction:movePointsX];
            [spritePoint2 runAction:movePointsY];
            [spriteFromPoint2 addObject:spritePoint2];
            spritePointCount++;
        }
    }
    
}

-(SKAction *)createPathForLetter:(CGPoint)start e:(CGPoint)end   {
    
    CGMutablePathRef cgpath = CGPathCreateMutable();
    
    CGPoint cp1 = CGPointMake(start.x/2, start.y/2);
    CGPoint cp2 = CGPointMake(end.x/2, end.y/2);
    CGPathMoveToPoint(cgpath, NULL, start.x, start.y);
    CGPathAddCurveToPoint(cgpath, NULL, cp1.x, cp1.y, cp2.x, cp2.y, end.x, end.y);
    SKAction *thePath = [SKAction followPath:cgpath asOffset:NO orientToPath:YES duration:0.2];
    return thePath;
    
}

-(void) moveLetterFromCenterStage:(LowerCaseLetter *)letterOff display:(LowerCaseLetter *)letterOn {
    
    
}



////////////////////
//
// SHAPE NODE
//
////////////////////

-(void) cleanUpAndRemoveShapeNode {
    for (SKShapeNode *theShape in shapeNodeObjects) {
        //SKAction *moveShape = [SKAction moveByX:-300 y:0 duration:1.0];
        //[theShape runAction:moveShape];
        [theShape removeAllActions];
        [theShape removeFromParent];
    }
    
    
}

-(void) letterShapeNode:(CGPoint)point {
    
    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(-5.0f,-5.0f, 5.0f, 5.0f)];
    
    SKShapeNode *shapeNode = [SKShapeNode node];
    shapeNode.path = path.CGPath;
    shapeNode.position = point;
    if (firstStrokeComplete && multiStroke) {
       shapeNode.strokeColor = SKColorWithRGBA(255, 255, 255, 250);
    } else {
       shapeNode.strokeColor = SKColorWithRGBA(255, 255, 255, 120);
    }
    shapeNode.lineWidth = 1;
    shapeNode.antialiased = NO;
    [self addChild:shapeNode];
    [shapeNodeObjects addObject:shapeNode];
    
    
    const NSTimeInterval Duration = 0.6;
    SKAction *scaleAction = [SKAction scaleTo:6.0f duration:Duration];
    scaleAction.timingMode = SKActionTimingEaseOut;
    
    [shapeNode runAction:scaleAction];


}

-(void) redrawShapeNode {
    
    for (SKShapeNode *myShape in shapeNodeObjects) {
        [self addChild:myShape];
        SKAction *moveShape = [SKAction moveByX:-300 y:0 duration:1.0];
        [myShape runAction:moveShape];

        
    }
}
//////////////////////////
//
// HELP ARROW DIRECTIONAL
//
//////////////////////////

-(void)arrowPointerToDraw:(NSString *)direction location:(CGPoint)pointForArrow {
    
    SKAction *moveUp;
    SKAction *moveDown;
    SKAction *repeatmoveUpDown;
    SKAction *repeatmoveUpDown2;
    
    if ([direction isEqualToString:@"down"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-green-down.png"];
        handPointer.scale = 0.5;
        
        moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"up"]) {
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-green-up.png"];
        handPointer.scale = 0.5;
        moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"left"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left-green.png"];
        handPointer.scale = 0.5;
        moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        moveDown = [SKAction moveByX:10 y:0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"right"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-right-green.png"];
        handPointer.scale = 0.5;
        moveUp = [SKAction moveByX:10 y:0 duration:0.3];
        moveDown = [SKAction moveByX:-10 y:0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    }
    
    
    handPointer.position = pointForArrow;
    handPointer.zPosition = 10;
    [self addChild:handPointer];
    
    SKAction *scaleUp = [SKAction scaleYTo:.7 duration:0.6];
    SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
    [handPointer runAction:sequenceArrow];
    
}


-(void)finishedWithGroup {

    NSLog(@"finished level");
    
    SKLabelNode *finishedLevel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    finishedLevel.text = @"Congatulations, you finished the Orange Level";
    finishedLevel.fontColor = [UIColor redColor];
    finishedLevel.position = CGPointMake(-100, 400);
    [self addChild:finishedLevel];
    SKAction *moveAction = [SKAction moveToX:500 duration:1.5];
    [finishedLevel runAction:moveAction];
    [firstPencil runAction:moveAction];
    SKAction *rotatePencil = [SKAction rotateByAngle:45 duration:1.5];
    [firstPencil runAction:rotatePencil];
    
    SKAction *waitToTransition = [SKAction waitForDuration:0.5];
    SKAction *transitionToBlocks = [SKAction runBlock:^{
        MatchPix *newBlocksScene = [[MatchPix alloc]initWithSize:CGSizeMake(1024, 768)];
        SKTransition *goToBlocks = [SKTransition flipVerticalWithDuration:0.4];
        [self.view presentScene:newBlocksScene transition:goToBlocks];
        
    }];
    SKAction *sequenceToScene = [SKAction sequence:@[waitToTransition,transitionToBlocks]];
    [self runAction:sequenceToScene];
    [self removeAllChildren];
    
    
    
    
                  
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    //[self selectedNodeForTouch:theTouch];
    
    
    for (LowerCaseLetter *tapLetter in allLettersSprites) {
        
        if (CGRectContainsPoint(tapLetter.frame,theTouch) && (theTouch.x > 800) && tapLetter.centerStage == NO) {
            //if (tapLetter.centerStage) {
            [tapLetter playTheSound];
        
            SKAction *popUp = [SKAction scaleYTo:0.3 duration:0.5];
            SKAction *backDown = [SKAction scaleYTo:0.1 duration:1.5];
            SKAction *sequence = [SKAction sequence:@[popUp, backDown]];
            
            //[tapLetter runAction:sequence];
            
            
            NSLog(@"question counter: %i", onWhichQuestion);
            
            [self nextQuestion];
            //} else {

            //}
            
            
        }
    }
   
    
    if (CGRectContainsPoint(backToMainMenuArrow.frame, theTouch)) {
        SKView *spriteView = (SKView *)self.view;
        IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];
        [self removeAllChildren];
    }
 
}


static inline CGFloat RandomRange(CGFloat min,
                                  CGFloat max)
{
    return ((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min;
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    previousPoint2 = previousPoint;
    previousPoint = [touch previousLocationInNode:self];
    deltaPoint = CGPointSubtract(theTouch, previousPoint);
    
    [self letterShapeNode:theTouch];

    if(pointsForSprite != NULL) {
        NSValue *pointForFirstSpriteNSV = [pointsForSprite objectAtIndex:0];
        CGPoint spritePoint = [pointForFirstSpriteNSV CGPointValue];
        CGRect spritePointRect = CGRectMake(spritePoint.x-30, spritePoint.y-30, 160, 160);
        
        if (CGRectContainsPoint (spritePointRect, theTouch)) {
            firstPointTest = TRUE;
            NSLog(@"first point test");
        }
        
    }

    
    int onWhichPoint = 0;
    
    for (SKSpriteNode *pointHit in spriteFromPoint) {

        onWhichPoint++;
        
        SKAction *lightUp = [SKAction fadeAlphaTo:1.5 duration:0.01];
        SKAction *lightUp2 = [SKAction fadeAlphaTo:0.8 duration:0.1];
        SKAction *lightUp3 = [SKAction fadeAlphaTo:0.7 duration:0.2];
        SKAction *lightUp4 = [SKAction fadeAlphaTo:0.5 duration:0.3];
        
        SKAction *scaleUp1 = [SKAction scaleTo:0.5 duration:0.1];
        SKAction *scaleUp2 = [SKAction scaleTo:0.4 duration:0.2];
        SKAction *scaleUp3 = [SKAction scaleTo:0.3 duration:0.3];
        
        CGFloat shakes = 10.0;
        scaleUp1.timingMode = SKActionTimingEaseOut;
        scaleUp2.timingMode = SKActionTimingEaseOut;
        scaleUp3.timingMode = SKActionTimingEaseOut;

        CGRect myControlPoint = CGRectMake(pointHit.position.x-20, pointHit.position.y-20, 35, 35);

        
        if (CGRectContainsPoint(myControlPoint, theTouch)) {
            
            SKAction *upAction = [SKAction moveByX:-10.90f y:20.0f duration:0.2];
            upAction.timingMode = SKActionTimingEaseOut;
            SKAction *downAction = [SKAction moveByX:-400.0f y:0.0f duration:0.2];
            downAction.timingMode = SKActionTimingEaseIn;
            
            if ([spriteFromPoint count] == onWhichPoint) {
                firstStrokeComplete = TRUE;
                for (SKSpriteNode *secondPointHit in spriteFromPoint2) {
                    secondPointHit.alpha = 1.0;
                }
            }
            
            SKAction *remove = [SKAction removeFromParent];
            [pointHit runAction:[SKAction sequence:@[upAction,downAction,remove]]];
            
            if (onWhichPoint < [spriteFromPoint count]) {
                SKSpriteNode *nextOne = [spriteFromPoint objectAtIndex:onWhichPoint];
                [nextOne runAction:lightUp];
                [nextOne runAction:scaleUp1];
                
                effectNode = [SKEffectNode node];
                [nextOne removeFromParent];
                [effectNode addChild:nextOne];
                [self addChild:effectNode];
                
                filter = [CIFilter filterWithName:@"CIHueAdjust"];
                [filter setValue:@0 forKey:@"inputAngle"];
                effectNode.filter = filter;
                effectNode.shouldEnableEffects = YES;
                float randVal = RandomRange(0, 6.14);
                [filter setValue:[NSNumber numberWithFloat:randVal] forKey:@"inputAngle"];
                

            }
            if (onWhichPoint+1 < [spriteFromPoint count]) {

                SKSpriteNode *nextTwo = [spriteFromPoint objectAtIndex:onWhichPoint + 1];
                [nextTwo runAction:lightUp2];
                [nextTwo runAction:scaleUp2];
                
                effectNode = [SKEffectNode node];
                [nextTwo removeFromParent];
                [effectNode addChild:nextTwo];
                [self addChild:effectNode];
                
                filter = [CIFilter filterWithName:@"CIHueAdjust"];
                [filter setValue:@0 forKey:@"inputAngle"];
                effectNode.filter = filter;
                effectNode.shouldEnableEffects = YES;
                float randVal = RandomRange(0, 6.14);
                [filter setValue:[NSNumber numberWithFloat:randVal] forKey:@"inputAngle"];
            }
            
            if (onWhichPoint + 2 < [spriteFromPoint count]) {
                SKSpriteNode *nextThree = [spriteFromPoint objectAtIndex:onWhichPoint + 2];
                [nextThree runAction:lightUp3];
                [nextThree runAction:scaleUp3];
                
                effectNode = [SKEffectNode node];
                [nextThree removeFromParent];
                [effectNode addChild:nextThree];
                [self addChild:effectNode];
                
                filter = [CIFilter filterWithName:@"CIHueAdjust"];
                [filter setValue:@0 forKey:@"inputAngle"];
                effectNode.filter = filter;
                effectNode.shouldEnableEffects = YES;
                float randVal = RandomRange(0, 6.14);
                [filter setValue:[NSNumber numberWithFloat:randVal] forKey:@"inputAngle"];
                
            }
            
            if (onWhichPoint + 3 < [spriteFromPoint count]) {
                SKSpriteNode *nextFour = [spriteFromPoint objectAtIndex:onWhichPoint + 3];
                [nextFour runAction:lightUp4];
                
                effectNode = [SKEffectNode node];
                [nextFour removeFromParent];
                [effectNode addChild:nextFour];
                [self addChild:effectNode];
                
                filter = [CIFilter filterWithName:@"CIHueAdjust"];
                [filter setValue:@0 forKey:@"inputAngle"];
                effectNode.filter = filter;
                effectNode.shouldEnableEffects = YES;
                float randVal = RandomRange(0, 6.14);
                [filter setValue:[NSNumber numberWithFloat:randVal] forKey:@"inputAngle"];
            }
            
            
        }
        
    }
 
    
    if (multiStroke && firstStrokeComplete) {
        
        int secondSpritePointCount = [spriteFromPoint count];
        
        for (SKSpriteNode *pointHit in spriteFromPoint2) {
        
            CGRect myControlPoint = CGRectMake(pointHit.position.x-20, pointHit.position.y-20, 35, 35);
        
            if (CGRectContainsPoint(myControlPoint, theTouch)) {
            
                [arrowObjects enumerateKeysAndObjectsUsingBlock:^(NSNumber* key, NSNumber *value, BOOL *stop) {
                    
                    if (secondSpritePointCount == [key integerValue]) {
                        pointHit.zRotation = [value floatValue];
                    }
                }];
            

                

                SKAction *upAction = [SKAction moveByX:0.0f y:10.0f duration:0.1];
                upAction.timingMode = SKActionTimingEaseOut;
                SKAction *downAction = [SKAction moveByX:-10.0f y:-10.0 duration:0.1];
                downAction.timingMode = SKActionTimingEaseOut;

            
                SKAction *remove = [SKAction removeFromParent];
                [pointHit runAction:[SKAction sequence:@[upAction,downAction,remove]]];
                
                secondSpritePointCount++;

            }
        }
    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self removeSpriteFromScene];

    [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:@"letterA"];
    

    
    if (firstPointTest) {
        NSLog(@"first point test true");
        for (SKSpriteNode *spritePoint in spriteFromPoint) {
        
            SKAction *moveTest = [SKAction moveTo:CGPointMake(0, 0) duration:0.1];
            [spritePoint removeFromParent];
            //[spritePoint runAction:moveTest];
        }
    
        if (multiStroke) {
            for (SKSpriteNode *pinWheel in spriteFromPoint2) {
                [pinWheel removeFromParent];
            }
        }

        firstPointTest = FALSE;
        onWhichQuestion++;
        if (onWhichQuestion < 7) {
        //    [self nextQuestion];
        }
    }
    
}

-(void)update:(NSTimeInterval)currentTime {
    
    if (multiStroke && firstStrokeComplete && arrowAdded == FALSE) {
        
        
        if ([secondStroke isEqualToString:@"up"]) {
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.y -= 40;
            
            [self arrowPointerToDraw:@"up" location:arrowPointCG];

            
        } else if ([secondStroke isEqualToString:@"down"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            CGPoint dropPoint = [theArrowPoint CGPointValue];
            
            [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
            
        } else if ([secondStroke isEqualToString:@"left"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
            
            
        } else if ([secondStroke isEqualToString:@"right"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            [self arrowPointerToDraw:@"right" location:[theArrowPoint CGPointValue]];
            
            
        }

        arrowAdded = TRUE;

    }
}

-(void) removeSpriteFromScene {

    SKSpriteNode *currentLetterFinish = [allLettersSprites objectAtIndex:onWhichQuestion];
    [currentLetterFinish removeFromParent];
    SKAction *moveToFinish = [SKAction moveToX:-300 duration:0.1];
    SKAction *scaleDown = [SKAction scaleTo:0.3 duration:0.1];
    [currentLetterFinish runAction:moveToFinish];
    [currentLetterFinish runAction:scaleDown];
    
}


-(void) createLetterA {
    
    float beginx = 500;
    float beginy = 300;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx-60, beginy+40);

    CGPoint letterAvalue5 = CGPointMake(beginx - 180, beginy + 40);
    CGPoint letterAvalue6 = CGPointMake(beginx - 210, beginy +25);
    CGPoint letterAvalue7 = CGPointMake(beginx - 230, beginy);
    CGPoint letterAvalue8 = CGPointMake(beginx - 237, beginy - 20);
    CGPoint letterAvalue9 = CGPointMake(beginx - 245, beginy - 45);
    CGPoint letterAvalue10 = CGPointMake(beginx - 245, beginy - 65);
    CGPoint letterAvalue11 = CGPointMake(beginx - 245, beginy - 125);
    CGPoint letterAvalue12 = CGPointMake(beginx - 245, beginy - 125);
    CGPoint letterAvalue13 = CGPointMake(beginx - 237, beginy - 140);
    CGPoint letterAvalue14 = CGPointMake(beginx - 215, beginy - 170);
    CGPoint letterAvalue15 = CGPointMake(beginx - 175, beginy - 190);
    CGPoint letterAvalue16 = CGPointMake(beginx - 135, beginy - 190);
    CGPoint letterAvalue17 = CGPointMake(beginx - 110, beginy - 180);
    CGPoint letterAvalue18 = CGPointMake(beginx-60, beginy - 140);
    CGPoint letterAvalue19 = CGPointMake(beginx-60, beginy - 90);
    CGPoint letterAvalue20 = CGPointMake(beginx-60, beginy - 60);
    CGPoint letterAvalue23 = CGPointMake(beginx-50, beginy + 20);
    CGPoint letterAvalue24 = CGPointMake(beginx-50, beginy - 60);
    CGPoint letterAvalue25 = CGPointMake(beginx-50, beginy - 140);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.9] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"2"];
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.1] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.7] forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.9] forKey:@"9"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"11"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"12"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.7] forKey:@"13"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23] forKey:@"14"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"15"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"16"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"17"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"18"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"19"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"20"];
    



    
}



-(void) createLetterB {

    float beginx = 400;
    float beginy = 650;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy-25);
    //CGPoint letterAvalue2 = CGPointMake(beginx, beginy-45);
    //CGPoint letterAvalue3 = CGPointMake(beginx, beginy-75);
    //CGPoint letterAvalue4 = CGPointMake(beginx, beginy-105);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-135);
    //CGPoint letterAvalue6 = CGPointMake(beginx, beginy-165);
    //CGPoint letterAvalue7 = CGPointMake(beginx, beginy-195);
    //CGPoint letterAvalue8 = CGPointMake(beginx, beginy-225);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-265);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-295);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-325);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy-365);
    CGPoint letterAvalue13 = CGPointMake(beginx, beginy-400);
    CGPoint letterAvalue14 = CGPointMake(beginx, beginy-450);
    
    // Second stroke
    CGPoint letterAvalue15 = CGPointMake(beginx + 40, beginy - 375);
    CGPoint letterAvalue16 = CGPointMake(beginx+ 40, beginy - 350);
    CGPoint letterAvalue17 = CGPointMake(beginx+ 40, beginy - 325);
    CGPoint letterAvalue18 = CGPointMake(beginx+ 40, beginy - 300);
    CGPoint letterAvalue19 = CGPointMake(beginx+ 40, beginy - 275);
    CGPoint letterAvalue20 = CGPointMake(beginx+ 80, beginy - 220);
    CGPoint letterAvalue21 = CGPointMake(beginx+ 120, beginy - 220);
    CGPoint letterAvalue22 = CGPointMake(beginx+ 160, beginy - 250);
    CGPoint letterAvalue23 = CGPointMake(beginx+ 180, beginy - 280);
    CGPoint letterAvalue24 = CGPointMake(beginx+ 180, beginy - 360);
    CGPoint letterAvalue25 = CGPointMake(beginx+ 160, beginy - 430);
    CGPoint letterAvalue26 = CGPointMake(beginx+ 120, beginy - 450);
    CGPoint letterAvalue27 = CGPointMake(beginx+ 80, beginy - 460);
    CGPoint letterAvalue28 = CGPointMake(beginx+ 50, beginy - 440);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"14"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"15"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"16"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"17"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"18"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"19"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"20"];
}

-(void) createLetterC {

    float beginx = 580;
    float beginy = 380;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx-40, beginy+40);
    CGPoint letterAvalue4 = CGPointMake(beginx-90, beginy+45);
    CGPoint letterAvalue5 = CGPointMake(beginx-140, beginy+20);
    CGPoint letterAvalue6 = CGPointMake(beginx-160, beginy-20);
    CGPoint letterAvalue7 = CGPointMake(beginx-160, beginy-60);
    CGPoint letterAvalue8 = CGPointMake(beginx-160, beginy-100);
    CGPoint letterAvalue9 = CGPointMake(beginx-150, beginy-140);
    CGPoint letterAvalue10 = CGPointMake(beginx-120, beginy-180);
    CGPoint letterAvalue11 = CGPointMake(beginx-60, beginy-190);
    CGPoint letterAvalue12 = CGPointMake(beginx-10, beginy - 170);

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18] forKey:@"0"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.0] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.0] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"9"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];

}

-(void) createLetterD {
    
}

-(void) createLetterE {
    
}

-(void) createLetterF {
    
}

-(void) createLetterG {
    
}

-(void) createLetterH {
    
}

-(void) createLetterI {
    
}

-(void) createLetterJ {
    
}

-(void) createLetterK {
    
}

-(void) createLetterL {
    
}

-(void) createLetterM {
    
    float beginx = 320;
    float beginy = 470;
    
    multiStroke = TRUE;
    secondStroke  = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx-10, beginy-30);
    CGPoint letterAvalue2 = CGPointMake(beginx-10, beginy-90);
    CGPoint letterAvalue3 = CGPointMake(beginx-10, beginy-150);
    CGPoint letterAvalue4 = CGPointMake(beginx-10, beginy-210);
    CGPoint letterAvalue5 = CGPointMake(beginx-10, beginy-270);
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-310);
    CGPoint letterAvalue9 = CGPointMake(beginx+10, beginy-255);
    CGPoint letterAvalue10 = CGPointMake(beginx+10, beginy-225);
    CGPoint letterAvalue11 = CGPointMake(beginx+10, beginy-200);
    CGPoint letterAvalue12 = CGPointMake(beginx+10, beginy-150);
    CGPoint letterAvalue13 = CGPointMake(beginx+10, beginy-100);
    CGPoint letterAvalue14 = CGPointMake(beginx+25, beginy-70);
    CGPoint letterAvalue15 = CGPointMake(beginx+50, beginy-20);
    CGPoint letterAvalue16 = CGPointMake(beginx+155, beginy-70);
    CGPoint letterAvalue17 = CGPointMake(beginx+155, beginy-100);
    CGPoint letterAvalue18 = CGPointMake(beginx+155, beginy-150);
    CGPoint letterAvalue19 = CGPointMake(beginx+155, beginy-225);
    CGPoint letterAvalue20 = CGPointMake(beginx-153, beginy+10);
    CGPoint letterAvalue21 = CGPointMake(beginx-156, beginy+5);
    CGPoint letterAvalue22 = CGPointMake(beginx-159, beginy+0);
    CGPoint letterAvalue23 = CGPointMake(beginx-161, beginy-5);
    CGPoint letterAvalue24 = CGPointMake(beginx-163, beginy-10);
    CGPoint letterAvalue25 = CGPointMake(beginx-163, beginy-10);
    CGPoint letterAvalue26 = CGPointMake(beginx-163, beginy-10);
    CGPoint letterAvalue27 = CGPointMake(360, 345);
    CGPoint letterAvalue28 = CGPointMake(370, 350);
    CGPoint letterAvalue29 = CGPointMake(380, 355);
    CGPoint letterAvalue30 = CGPointMake(390, 360);
    CGPoint letterAvalue31 = CGPointMake(400, 380);
    CGPoint letterAvalue32 = CGPointMake(402, 400);
    CGPoint letterAvalue33 = CGPointMake(405, 420);
    CGPoint letterAvalue34 = CGPointMake(407, 460);
    CGPoint letterAvalue35 = CGPointMake(410, 500);
    CGPoint letterAvalue36 = CGPointMake(410, 490);
    CGPoint letterAvalue37 = CGPointMake(412, 460);
    CGPoint letterAvalue38 = CGPointMake(414, 420);
    CGPoint letterAvalue39 = CGPointMake(415, 400);
    CGPoint letterAvalue40 = CGPointMake(425, 380);
    CGPoint letterAvalue41 = CGPointMake(430, 360);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    /*[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue25]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue26]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue27]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue28]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue29]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue30]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue31]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue32]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue33]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue34]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue35]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue36]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue37]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue38]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue39]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue40]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue41]];
     */
 
}

-(void) createLetterN {
    
}

-(void) createLetterO {
    
}

-(void) createLetterP {
    
}

-(void) createLetterQ {
    
}

-(void) createLetterR {
    
}

-(void) createLetterS {
    
    float beginx = 580;
    float beginy = 400;
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx-30, beginy+20);
    CGPoint letterAvalue3 = CGPointMake(beginx-60, beginy+30);
    CGPoint letterAvalue4 = CGPointMake(beginx-90, beginy+30);
    CGPoint letterAvalue5 = CGPointMake(beginx-120, beginy+20);
    CGPoint letterAvalue6 = CGPointMake(beginx-140, beginy+10);
    CGPoint letterAvalue7 = CGPointMake(beginx-150, beginy-10);
    CGPoint letterAvalue8 = CGPointMake(beginx-160, beginy-30);
    CGPoint letterAvalue9 = CGPointMake(beginx-150, beginy-60);
    CGPoint letterAvalue10 = CGPointMake(beginx-120, beginy-90);
    CGPoint letterAvalue11 = CGPointMake(beginx-90, beginy-100);
    CGPoint letterAvalue12 = CGPointMake(beginx-60, beginy-110);
    CGPoint letterAvalue13 = CGPointMake(beginx-30, beginy-120);
    CGPoint letterAvalue14 = CGPointMake(beginx-10, beginy-130);
    CGPoint letterAvalue15 = CGPointMake(beginx+5, beginy-140);
    CGPoint letterAvalue16 = CGPointMake(beginx+5, beginy-150);
    CGPoint letterAvalue17 = CGPointMake(beginx-15, beginy-160);
    CGPoint letterAvalue18 = CGPointMake(beginx-25, beginy-170);
    CGPoint letterAvalue19 = CGPointMake(beginx-35, beginy-180);
    CGPoint letterAvalue20 = CGPointMake(beginx-45, beginy-190);
    CGPoint letterAvalue21 = CGPointMake(beginx-55, beginy-200);
    CGPoint letterAvalue22 = CGPointMake(beginx-65, beginy-210);
    CGPoint letterAvalue23 = CGPointMake(beginx-75, beginy-220);
    CGPoint letterAvalue24 = CGPointMake(beginx-163, beginy-230);
    CGPoint letterAvalue25 = CGPointMake(beginx-163, beginy-240);
    CGPoint letterAvalue26 = CGPointMake(beginx-163, beginy-160);
    CGPoint letterAvalue27 = CGPointMake(360, 345);
    CGPoint letterAvalue28 = CGPointMake(370, 350);
    CGPoint letterAvalue29 = CGPointMake(380, 355);
    CGPoint letterAvalue30 = CGPointMake(390, 360);
    CGPoint letterAvalue31 = CGPointMake(400, 380);
    CGPoint letterAvalue32 = CGPointMake(402, 400);
    CGPoint letterAvalue33 = CGPointMake(405, 420);
    CGPoint letterAvalue34 = CGPointMake(407, 460);
    CGPoint letterAvalue35 = CGPointMake(410, 500);
    CGPoint letterAvalue36 = CGPointMake(410, 490);
    CGPoint letterAvalue37 = CGPointMake(412, 460);
    CGPoint letterAvalue38 = CGPointMake(414, 420);
    CGPoint letterAvalue39 = CGPointMake(415, 400);
    CGPoint letterAvalue40 = CGPointMake(425, 380);
    CGPoint letterAvalue41 = CGPointMake(430, 360);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.0] forKey:@"0"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.5] forKey:@"1"];

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.0] forKey:@"2"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.5] forKey:@"3"];

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.7] forKey:@"4"];

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.2] forKey:@"5"];

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21] forKey:@"6"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"7"];

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18] forKey:@"0"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    /*[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue25]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue26]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue27]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue28]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue29]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue30]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue31]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue32]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue33]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue34]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue35]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue36]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue37]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue38]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue39]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue40]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue41]];
     */

    
}

-(void) createLetterT {
    
    float beginx = 500;
    float beginy = 400;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy+25);
    CGPoint letterAvalue2 = CGPointMake(beginx-10, beginy+35);
    CGPoint letterAvalue3 = CGPointMake(beginx-20, beginy+40);
    CGPoint letterAvalue4 = CGPointMake(beginx-30, beginy+45);
    CGPoint letterAvalue5 = CGPointMake(beginx-40, beginy+48);
    CGPoint letterAvalue6 = CGPointMake(beginx-50, beginy+50);
    CGPoint letterAvalue7 = CGPointMake(beginx-60, beginy+52);
    CGPoint letterAvalue8 = CGPointMake(beginx-70, beginy+54);
    CGPoint letterAvalue9 = CGPointMake(beginx-80, beginy+54);
    CGPoint letterAvalue10 = CGPointMake(beginx-90, beginy+52);
    CGPoint letterAvalue11 = CGPointMake(beginx-100, beginy+50);
    CGPoint letterAvalue12 = CGPointMake(beginx-110, beginy+48);
    CGPoint letterAvalue13 = CGPointMake(beginx-120, beginy+45);
    CGPoint letterAvalue14 = CGPointMake(beginx-125, beginy+40);
    CGPoint letterAvalue15 = CGPointMake(beginx-130, beginy+35);
    CGPoint letterAvalue16 = CGPointMake(beginx-135, beginy+30);
    CGPoint letterAvalue17 = CGPointMake(beginx-140, beginy+25);
    CGPoint letterAvalue18 = CGPointMake(beginx-145, beginy+20);
    CGPoint letterAvalue19 = CGPointMake(beginx-150, beginy+15);
    CGPoint letterAvalue20 = CGPointMake(beginx-153, beginy+10);
    CGPoint letterAvalue21 = CGPointMake(beginx-156, beginy+5);
    CGPoint letterAvalue22 = CGPointMake(beginx-159, beginy+0);
    CGPoint letterAvalue23 = CGPointMake(beginx-161, beginy-5);
    CGPoint letterAvalue24 = CGPointMake(beginx-163, beginy-10);
    CGPoint letterAvalue25 = CGPointMake(beginx-163, beginy-10);
    CGPoint letterAvalue26 = CGPointMake(beginx-163, beginy-10);
    CGPoint letterAvalue27 = CGPointMake(360, 345);
    CGPoint letterAvalue28 = CGPointMake(370, 350);
    CGPoint letterAvalue29 = CGPointMake(380, 355);
    CGPoint letterAvalue30 = CGPointMake(390, 360);
    CGPoint letterAvalue31 = CGPointMake(400, 380);
    CGPoint letterAvalue32 = CGPointMake(402, 400);
    CGPoint letterAvalue33 = CGPointMake(405, 420);
    CGPoint letterAvalue34 = CGPointMake(407, 460);
    CGPoint letterAvalue35 = CGPointMake(410, 500);
    CGPoint letterAvalue36 = CGPointMake(410, 490);
    CGPoint letterAvalue37 = CGPointMake(412, 460);
    CGPoint letterAvalue38 = CGPointMake(414, 420);
    CGPoint letterAvalue39 = CGPointMake(415, 400);
    CGPoint letterAvalue40 = CGPointMake(425, 380);
    CGPoint letterAvalue41 = CGPointMake(430, 360);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    /*[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue25]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue26]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue27]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue28]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue29]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue30]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue31]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue32]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue33]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue34]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue35]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue36]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue37]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue38]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue39]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue40]];
     [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue41]];
     */

}

-(void) createLetterU {
    
}

-(void) createLetterV {
    
}

-(void) createLetterW {
    
}

-(void) createLetterX {
    
}

-(void) createLetterY {
    
}

-(void) createLetterZ {
    
}

-(void)createLetters {
    /*letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-c.png"];
    NSURL *letterCurl = [[NSBundle mainBundle]URLForResource:@"letterCsound" withExtension:@"mp3"];
    letterC.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterCurl error:nil];
    letterC.name = @"C";
    letterC.scale = 0.2;
    
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-d.png"];
    NSURL *letterDurl = [[NSBundle mainBundle]URLForResource:@"letterDsound" withExtension:@"mp3"];
    letterD.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterDurl error:nil];
    letterD.name = @"D";
    letterD.scale = 0.2;
    
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-e.png"];
    NSURL *letterEurl = [[NSBundle mainBundle]URLForResource:@"letterEsound" withExtension:@"mp3"];
    letterE.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterEurl error:nil];
    letterE.name = @"E";
    
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-f.png"];
    NSURL *letterFurl = [[NSBundle mainBundle]URLForResource:@"letterFsound" withExtension:@"mp3"];
    letterF.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterFurl error:nil];
    letterF.name = @"F";
    
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-g.png"];
    NSURL *letterGurl = [[NSBundle mainBundle]URLForResource:@"letterGsound" withExtension:@"mp3"];
    letterG.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterGurl error:nil];
    letterG.name = @"G";
    
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-h.png"];
    NSURL *letterHurl = [[NSBundle mainBundle]URLForResource:@"letterHsound" withExtension:@"mp3"];
    letterH.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterHurl error:nil];
    letterH.name = @"H";
    
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-i.png"];
    NSURL *letterIurl = [[NSBundle mainBundle]URLForResource:@"letterIsound" withExtension:@"mp3"];
    letterI.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterIurl error:nil];
    letterI.name = @"I";
    
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-j.png"];
    NSURL *letterJurl = [[NSBundle mainBundle]URLForResource:@"letterJsound" withExtension:@"mp3"];
    letterJ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterJurl error:nil];
    letterJ.name = @"J";
    
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-k.png"];
    NSURL *letterKurl = [[NSBundle mainBundle]URLForResource:@"letterKsound" withExtension:@"mp3"];
    letterK.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterKurl error:nil];
    letterK.name = @"K";
    
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-l.png"];
    NSURL *letterLurl = [[NSBundle mainBundle]URLForResource:@"letterLsound" withExtension:@"mp3"];
    letterL.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterLurl error:nil];
    letterL.name = @"L";
    
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"cartoon-m.png"];
    NSURL *letterMurl = [[NSBundle mainBundle]URLForResource:@"letterMsound" withExtension:@"mp3"];
    letterM.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterMurl error:nil];
    letterM.name = @"M";
    letterM.scale = 0.2;
    [self createLetterM];
    
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-n.png"];
    NSURL *letterNurl = [[NSBundle mainBundle]URLForResource:@"letterNsound" withExtension:@"mp3"];
    letterN.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterNurl error:nil];
    letterN.name = @"N";
    
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-o.png"];
    NSURL *letterOurl = [[NSBundle mainBundle]URLForResource:@"letterOsound" withExtension:@"mp3"];
    letterO.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterOurl error:nil];
    letterO.name = @"O";
    
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-p.png"];
    NSURL *letterPurl = [[NSBundle mainBundle]URLForResource:@"letterPsound" withExtension:@"mp3"];
    letterP.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterPurl error:nil];
    letterP.name = @"P";
    
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-q.png"];
    NSURL *letterQurl = [[NSBundle mainBundle]URLForResource:@"letterQsound" withExtension:@"mp3"];
    letterQ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterQurl error:nil];
    letterQ.name = @"Q";
    
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-r.png"];
    NSURL *letterRurl = [[NSBundle mainBundle]URLForResource:@"letterRsound" withExtension:@"mp3"];
    letterR.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterRurl error:nil];
    letterR.name = @"R";
    
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"letter-S.png"];
    NSURL *letterSurl = [[NSBundle mainBundle]URLForResource:@"letterSsound" withExtension:@"mp3"];
    letterS.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterSurl error:nil];
    letterS.name = @"S";
    letterS.scale = 0.2;
    [self createLetterS];
    
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"letter-t.png"];
    NSURL *letterTurl = [[NSBundle mainBundle]URLForResource:@"letterTsound" withExtension:@"mp3"];
    letterT.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterTurl error:nil];
    letterT.name = @"T";
    letterT.scale = 0.2;
    [self createLetterT];
    
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-u.png"];
    NSURL *letterUurl = [[NSBundle mainBundle]URLForResource:@"letterUsound" withExtension:@"mp3"];
    letterU.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterUurl error:nil];
    letterU.name = @"U";
    
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-v.png"];
    NSURL *letterVurl = [[NSBundle mainBundle]URLForResource:@"letterVsound" withExtension:@"mp3"];
    letterV.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterVurl error:nil];
    letterV.name = @"V";
    
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-w.png"];
    NSURL *letterWurl = [[NSBundle mainBundle]URLForResource:@"letterWsound" withExtension:@"mp3"];
    letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterWurl error:nil];
    letterA.name = @"W";
    
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-x.png"];
    NSURL *letterXurl = [[NSBundle mainBundle]URLForResource:@"letterXsound" withExtension:@"mp3"];
    letterX.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterXurl error:nil];
    letterX.name = @"X";
    
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-y.png"];
    NSURL *letterYurl = [[NSBundle mainBundle]URLForResource:@"letterYsound" withExtension:@"mp3"];
    letterY.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterYurl error:nil];
    letterY.name = @"Y";
    
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-z.png"];
    NSURL *letterZurl = [[NSBundle mainBundle]URLForResource:@"letterZsound" withExtension:@"mp3"];
    letterZ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterZurl error:nil];
    letterZ.name = @"Z";*/

}

@end
