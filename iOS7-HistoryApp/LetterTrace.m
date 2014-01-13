//
//  LetterTrace.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//


#import <AVFoundation/AVFoundation.h>
#import <QuartzCore/QuartzCore.h>
#import "IntroScreen.h"
#import "LowerCaseLetter.h"
#import "MontessoriData.h"
#import "LetterTrace.h"
#import "RedrawLetter.h"
#import "GroupLetterNode.h"
#import "ArrowWithEmitter.h"
#import "Matching.h"
#import "RecordSound.h"

#import "SKTUtils.h"
#import "SKAction+SKTExtras.h"
#import "SKTTimingFunctions.h"
#import "SKTEffects.h"


@import CoreImage;

@implementation LetterTrace

#define SHOW_FIRST_ARROWS TRUE
#define SHOW_SECOND_ARROWS TRUE
#define ARROW_EMITTERS FALSE
#define FIRST_ARROW_ALPHA 0.0
#define SECOND_ARROW_ALPHA 0.0

MontessoriData *sharedData;

NSMutableArray *menuOptions;
NSMutableArray *letterProblems;         // SKSpriteNode
NSMutableArray *pointsForSprite;        // NSValue
NSMutableArray *pointsForSprite2;       // NSValue
NSMutableArray *controlPoints;
NSMutableArray *shapeNodeObjects;

NSMutableDictionary *arrowObjects;

NSMutableArray *traceThePath;
NSMutableArray *finishedLevelText;
NSMutableArray *timeToDrawLetter;
NSMutableArray *allPicsForQuestions;
NSMutableArray *allLettersSprites;
NSMutableArray *spriteFromPoint;
NSMutableArray *spriteFromPoint2;
NSMutableArray *allEffectNodes;
NSMutableArray *pointsHit;
NSMutableArray *pointsHit2;
NSMutableArray *group1Letters;
NSMutableArray *group2Letters;
NSMutableArray *group3Letters;
NSMutableArray *group4Letters;
NSMutableArray *group5Letters;
NSMutableArray *group6Letters;
NSMutableArray *listOfIncorrectSprites;
NSMutableArray *listOfTrailSprites;
NSMutableDictionary *shapeNodeObjectForLetter;

LowerCaseLetter *currentLetter;
LowerCaseLetter *previousLetter;
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


SKSpriteNode *replayTrace;

SKSpriteNode *picForQuestion;
SKSpriteNode *backToMainMenuArrow;
SKSpriteNode *fingerTrace;
SKSpriteNode *handPointer;
SKLabelNode *timeDisplay;

RecordSound *recordDisplay;

int numberOfPoints;
int onWhichQuestion;
int onWhichGroup;
int onWhichPoint;

CGPoint deltaPoint;
CGPoint previousPoint;
CGPoint previousPoint2;
CGPoint currentPoint;
CGPoint lastTrailPoint;
CGMutablePathRef cgpath;

BOOL firstPointTest;
BOOL multiStroke;
BOOL firstStrokeComplete;
BOOL arrowAdded;
BOOL strokeLetterBegin;
BOOL separateStroke;
BOOL arrowColor;

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


NSMutableArray *letterSegments;

SKAction *lightUp;
SKAction *lightUp2;
SKAction *lightUp3;
SKAction *lightUp4;
SKAction *scaleUp1;
SKAction *scaleUp2;
SKAction *scaleUp3;
SKAction *scaleDown;
SKAction *scaleDown2;
SKAction *scaleDown3;
SKAction *sequenceActions;
SKAction *sequenceActions2;
SKAction *sequenceActions3;
SKAction *removeSprite;

NSString *secondStroke;
CGFloat width;
CGFloat height;
float letterBeginX = 0;
float letterBeginY = 0;
int timerForLetter = 0;

SKLabelNode *groupOne;
SKLabelNode *groupTwo;
SKLabelNode *groupThree;
SKLabelNode *groupFour;
SKLabelNode *groupFive;
SKLabelNode *finishedLetters;

SKLabelNode *firstPointsLabel;
SKLabelNode *secondPointsLabel;
SKSpriteNode *gridPaper;

BOOL isIphone;
NSNumber *lastPoint;
NSNumber *twoPointBefore;
int lastPointHit;
int twoPointBeforeHit;
int currentPointHit;
int groupSequence;

@synthesize background, selectedNode, timeForQuestion, audioRecorder, audioPlayer;


-(id)initWithSize:(CGSize)size andGroup:(NSNumber *)groupID {
    
    self = [super initWithSize:size];
    
    
    if (self) {
                
        sharedData = [MontessoriData sharedManager];

        //
        //
        // ACTIONS FOR GUIDING ARROWS
        //
        //
        
        lightUp = [SKAction fadeAlphaTo:1.0 duration:0.2];
        lightUp2 = [SKAction fadeAlphaTo:1.0 duration:0.2];
        lightUp3 = [SKAction fadeAlphaTo:1.0 duration:0.3];
        lightUp4 = [SKAction fadeAlphaTo:1.0 duration:0.4];
        
        scaleUp1 = [SKAction scaleTo:0.5 duration:0.05];
        scaleUp2 = [SKAction scaleTo:0.4 duration:0.2];
        scaleUp3 = [SKAction scaleTo:0.3 duration:0.3];
        scaleUp1.timingMode = SKActionTimingEaseOut;
        scaleUp2.timingMode = SKActionTimingEaseOut;
        scaleUp3.timingMode = SKActionTimingEaseOut;
        
        scaleDown = [SKAction scaleTo:0.4 duration:0.05];
        scaleDown2 = [SKAction scaleTo:0.2 duration:0.1];
        scaleDown3 = [SKAction scaleTo:0.2 duration:0.1];
        scaleDown.timingMode = SKActionTimingEaseIn;
        scaleDown.timingMode = SKActionTimingEaseIn;
        scaleDown.timingMode = SKActionTimingEaseIn;
        
        SKAction *removeFirstArrow = [SKAction removeFromParent];
        sequenceActions = [SKAction sequence:@[lightUp,scaleUp1,scaleDown,removeFirstArrow]];
        sequenceActions2 = [SKAction sequence:@[lightUp2,scaleUp1,removeFirstArrow]];
        sequenceActions3 = [SKAction sequence:@[lightUp3,scaleUp3,removeFirstArrow]];
        
        removeSprite = [SKAction removeFromParent];
        

        //
        // ************************************
        
        NSString *deviceType = [UIDevice currentDevice].model;
        if([deviceType isEqualToString:@"iPhone"]) {
            isIphone = TRUE;
        } else {
            
            isIphone = FALSE;
        }
        
        
        width = self.size.width;
        height = self.size.height;
        
        onWhichQuestion = 0;
        onWhichGroup = [groupID intValue];
        groupSequence = [groupID intValue];
        numberOfPoints = 0;
        
        firstPointTest = FALSE;
        firstStrokeComplete = FALSE;
        strokeLetterBegin = FALSE;
        
        listOfTrailSprites = [[NSMutableArray alloc]init];
        pointsForSprite = [[NSMutableArray alloc]init];
        pointsForSprite2 = [[NSMutableArray alloc]init];
        spriteFromPoint = [[NSMutableArray alloc]init];
        arrowObjects = [[NSMutableDictionary alloc]init];

        allLettersSprites = [[NSMutableArray alloc]init];
        groupOneLetters = [[NSMutableArray alloc]init];
        groupTwoLetters = [[NSMutableArray alloc]init];
        groupThreeLetters = [[NSMutableArray alloc]init];
        groupFourLetters = [[NSMutableArray alloc]init];
        groupFiveLetters = [[NSMutableArray alloc]init];
        group1Letters = [[NSMutableArray alloc]init];
        group2Letters = [[NSMutableArray alloc]init];
        group3Letters = [[NSMutableArray alloc]init];
        group4Letters = [[NSMutableArray alloc]init];
        group5Letters = [[NSMutableArray alloc]init];
        
        
        timeToDrawLetter = [[NSMutableArray alloc]init];
        
        pointsHit = [[NSMutableArray alloc]init];
        pointsHit2 = [[NSMutableArray alloc]init];
        
        shapeNodeObjects = [[NSMutableArray alloc]init];
        shapeNodeObjectForLetter = [[NSMutableDictionary alloc]init];
        allEffectNodes = [[NSMutableArray alloc]init];
        listOfIncorrectSprites = [[NSMutableArray alloc]init];

        self.userInteractionEnabled = YES;

        
        gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_wood.jpg"];
        
        if (isIphone) {
            gridPaper.scale = 1.3;
        }
        
        gridPaper.position = CGPointMake(size.width/2, size.height/2);
        gridPaper.name = @"bg";
        [self addChild:gridPaper];

        letterA = sharedData.letterA;
        letterA.whichLetter = @"A";
        
        letterB = sharedData.letterB;
        letterB.whichLetter = @"B";
        
        letterC = sharedData.letterC;
        letterC.whichLetter = @"C";
        
        letterD = sharedData.letterD;
        letterD.whichLetter = @"D";
        letterE = sharedData.letterE;
        letterE.whichLetter = @"E";
        letterF = sharedData.letterF;
        letterF.whichLetter = @"F";
        letterG = sharedData.letterG;
        letterG.whichLetter = @"G";
        letterH = sharedData.letterH;
        letterH.whichLetter = @"H";
        letterI = sharedData.letterI;
        letterI.whichLetter = @"I";
        letterJ = sharedData.letterJ;
        letterJ.whichLetter = @"J";
        letterK = sharedData.letterK;
        letterK.whichLetter = @"K";
        letterL = sharedData.letterL;
        letterL.whichLetter = @"L";
        letterM = sharedData.letterM;
        letterM.whichLetter = @"M";
        letterN = sharedData.letterN;
        letterN.whichLetter = @"N";
        letterO = sharedData.letterO;
        letterO.whichLetter = @"O";
        letterP = sharedData.letterP;
        letterP.whichLetter = @"P";
        letterQ = sharedData.letterQ;
        letterQ.whichLetter = @"Q";
        letterR = sharedData.letterR;
        letterR.whichLetter = @"R";
        letterS = sharedData.letterS;
        letterS.whichLetter = @"S";
        letterT = sharedData.letterT;
        letterT.whichLetter = @"T";
        letterU = sharedData.letterU;
        letterU.whichLetter = @"U";
        letterV = sharedData.letterV;
        letterV.whichLetter = @"V";
        letterW = sharedData.letterW;
        letterW.whichLetter = @"W";
        letterX = sharedData.letterX;
        letterX.whichLetter = @"X";
        letterY = sharedData.letterY;
        letterY.whichLetter = @"Y";
        letterZ = sharedData.letterZ;
        letterZ.whichLetter = @"Z";
        
        [groupOneLetters addObject:letterS];
        [groupOneLetters addObject:letterM];
        [groupOneLetters addObject:letterB];
        [groupOneLetters addObject:letterA];
        [groupOneLetters addObject:letterT];
        [groupOneLetters addObject:letterC];

        [groupTwoLetters addObject:letterG];
        [groupTwoLetters addObject:letterR];
        [groupTwoLetters addObject:letterO];
        [groupTwoLetters addObject:letterF];
        [groupTwoLetters addObject:letterD];
        
        [groupThreeLetters addObject:letterH];
        [groupThreeLetters addObject:letterI];
        [groupThreeLetters addObject:letterP];
        [groupThreeLetters addObject:letterN];
        [groupThreeLetters addObject:letterL];
    
        [groupFourLetters addObject:letterK];
        [groupFourLetters addObject:letterE];
        [groupFourLetters addObject:letterX];
        [groupFourLetters addObject:letterZ];
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

        for (LowerCaseLetter *letter in allLettersSprites) {
            
            letter.position = CGPointMake(0,-1000);
            letter.alpha = 0.0;
            letter.scale = 0.1;
            letter.centerStage = FALSE;
            [self addChild:letter];
        }
        
        for (int i = 0; i < 1500; i++) {
            SKSpriteNode *trailSprite =[SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
            //trailSprite.scale = 0.3;
            trailSprite.alpha = 0.0;
            trailSprite.position = CGPointMake(500, 500);
            [self addChild:trailSprite];
            [listOfTrailSprites addObject:trailSprite];
        }
        
        [self resetShapeNodePool];
        
        

        groupOne = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        groupOne.text = @"PURPLE";
        groupOne.name = @"group1";
        groupOne.fontColor = [UIColor purpleColor];
        groupOne.fontSize = 30;
        groupOne.position = CGPointMake(200, 50);
        [self addChild:groupOne];
        
        
        groupTwo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        groupTwo.text = @"YELLOW";
        groupTwo.name = @"group2";
        groupTwo.fontColor = [UIColor yellowColor];
        groupTwo.fontSize = 30;
        groupTwo.position = CGPointMake(350, 50);
        [self addChild:groupTwo];
        
        groupThree = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        groupThree.text = @"PINK";
        groupThree.name = @"group3";
        groupThree.fontColor = [UIColor orangeColor];
        groupThree.fontSize = 30;
        groupThree.position = CGPointMake(500, 50);
        [self addChild:groupThree];
        
        groupFour = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        groupFour.text = @"GREEN";
        groupFour.name = @"group4";
        groupFour.fontColor = [UIColor greenColor];
        groupFour.fontSize = 30;
        groupFour.position = CGPointMake(650, 50);
        [self addChild:groupFour];
        
        
        groupFive = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        groupFive.text = @"BLUE";
        groupFive.name = @"group5";
        groupFive.fontColor = [UIColor blueColor];
        groupFive.fontSize = 30;
        groupFive.position = CGPointMake(800, 50);
        
        firstPointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        
        NSString *labelString = [NSString stringWithFormat:@"Points1: 0/%i",[pointsForSprite count]];
        
        firstPointsLabel.text = labelString;
        firstPointsLabel.fontColor = [UIColor magentaColor];
        firstPointsLabel.fontSize = 16;
        firstPointsLabel.position = CGPointMake(275, 750);
        [self addChild:firstPointsLabel];
        
        secondPointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        NSString *labelString2 = [NSString stringWithFormat:@"Points2: 0/%i",[pointsForSprite2 count]];
        
        secondPointsLabel.text = labelString2;
        secondPointsLabel.fontColor = [UIColor magentaColor];
        secondPointsLabel.fontSize = 16;
        secondPointsLabel.position = CGPointMake(375, 750);
        [self addChild:secondPointsLabel];
        
        finishedLetters = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        finishedLetters.text = @"Letter Box";
        finishedLetters.fontColor = [UIColor magentaColor];
        finishedLetters.fontSize = 20;
        finishedLetters.position = CGPointMake(120, 740);
        //[self addChild:finishedLetters];
        
        [self addChild:groupFive];
        
        recordDisplay = [[RecordSound alloc]initWithPosition:CGPointMake(0, 0)];
        recordDisplay.position = CGPointMake(0, 400);
        [self addChild:recordDisplay];
        
        replayTrace = [SKSpriteNode spriteNodeWithImageNamed:@"question-icon.png"];
        replayTrace.scale = 0.5;
        replayTrace.position = CGPointMake(180,670);
        [self addChild:replayTrace];
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-3.png"];
        backToMainMenuArrow.position = CGPointMake(80, 670);
        backToMainMenuArrow.scale = 0.5;
        [self addChild:backToMainMenuArrow];
        

    }
    
    return self;
    
}


-(void) letterShapeNode:(CGPoint)point {
    
    numberOfPoints++;
    SKSpriteNode *trailNode = [listOfTrailSprites objectAtIndex:numberOfPoints];
    trailNode.position = point;
    trailNode.alpha = 1.0;
    trailNode.zPosition = 5;
    [shapeNodeObjects addObject:trailNode];
        
}


-(void) missedNode:(CGPoint)point {
    
    numberOfPoints++;
    SKSpriteNode *trailNode = [SKSpriteNode spriteNodeWithImageNamed:@"Incorrect.png"];
    trailNode.position = point;
    trailNode.alpha = 0.7;
    trailNode.zPosition = 5;
    [shapeNodeObjects addObject:trailNode];
}


-(void) resetShapeNodePool {
    
    for (SKSpriteNode *trailSpriteRemove in listOfTrailSprites) {
        [trailSpriteRemove removeFromParent];
        
    }

    listOfTrailSprites = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 1500; i++) {
        SKSpriteNode *trailSprite =[SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
        //trailSprite.scale = 0.3;
        trailSprite.alpha = 0.0;
        trailSprite.position = CGPointMake(500, 500);
        [self addChild:trailSprite];
        [listOfTrailSprites addObject:trailSprite];
    }
    
}


-(void) cleanUpAndRemoveShapeNode {
    
    NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
    
    RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]initWithPosition:CGPointMake(0, 0) withKey:letterOn];
    redrawLetterNode.representGroup = [NSString stringWithFormat:@"group%i",onWhichGroup];
    
    NSDate *now = [[NSDate alloc]init];
    NSNumber *firstPointHit = [NSNumber numberWithInt:[pointsHit count]];
    NSNumber *secondPointHit = [NSNumber numberWithInt:[pointsHit2 count]];
     
    for (SKSpriteNode *shapeSprite in shapeNodeObjects) {
            SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
            newCloud.position = shapeSprite.position;
            newCloud.scale = 0.4;
            [redrawLetterNode addPointToNode:newCloud];
    }
        
    [group1Letters addObject:redrawLetterNode];

    for (SKSpriteNode *myNodesForLetter in shapeNodeObjects) {
        [myNodesForLetter removeFromParent];
    }
    for (SKSpriteNode *myTrailForLetter in spriteFromPoint) {
        [myTrailForLetter removeFromParent];
    }
    for (SKEffectNode* displayedEffectNode in allEffectNodes) {
        [displayedEffectNode removeFromParent];
    }
    
    allEffectNodes = [[NSMutableArray alloc]init];
    
    for (SKSpriteNode *incorrectSprite in listOfIncorrectSprites) {
        [incorrectSprite removeFromParent];
    }
    
}

-(void)storeShapeDrawn {
    
    RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]initWithPosition:CGPointMake(0, 0) withLetter:currentLetter];
    redrawLetterNode.representGroup = [NSString stringWithFormat:@"group%i",onWhichGroup];
    redrawLetterNode.representLetter = currentLetter.whichLetter;
    
    NSDate *now = [[NSDate alloc]init];
    
    for (SKSpriteNode *shapeSprite in shapeNodeObjects) {
        SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
        newCloud.position = shapeSprite.position;
        [redrawLetterNode addPointToNode:newCloud];
    }
    
    NSNumber *firstPointHit = [NSNumber numberWithInt:[pointsHit count]];
    NSNumber *secondPointHit = [NSNumber numberWithInt:[pointsHit2 count]];
    
    [sharedData archiveShapeDrawn:shapeNodeObjects
                            onDay:now
                        firstLine:firstPointHit
                       secondLine:secondPointHit
                      whichLetter:redrawLetterNode.representLetter];
    
    [group1Letters addObject:redrawLetterNode];
    
    
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
        handPointer.scale = 0.3;
        pointForArrow.y += 50;
        moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"up"]) {
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-green-up.png"];
        handPointer.scale = 0.3;
        moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"left"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left-green.png"];
        handPointer.scale = 0.3;
        pointForArrow.x += 100;
        moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        moveDown = [SKAction moveByX:10 y:0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"right"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-right-green.png"];
        handPointer.scale = 0.3;
        moveUp = [SKAction moveByX:10 y:0 duration:0.3];
        moveDown = [SKAction moveByX:-10 y:0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    }
    
    
    handPointer.position = pointForArrow;
    handPointer.zPosition = 10;
    handPointer.userInteractionEnabled = NO;
    [self addChild:handPointer];
    
    SKAction *scaleUp = [SKAction scaleYTo:.5 duration:0.6];
    SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
    [handPointer runAction:sequenceArrow];
    
}


-(void) traceTutorial {
    
    //SKSpriteNode *fingerTrace = [SKSpriteNode spriteNodeWithImageNamed:@"hand-point-45-degrees-left.png"];
    SKSpriteNode *fingerTrace = [SKSpriteNode spriteNodeWithImageNamed:@"finger_point.png"];
    
    fingerTrace.position = CGPointMake(letterBeginX, letterBeginY);
    fingerTrace.scale = 0.7;
    fingerTrace.alpha = 0.0;
    fingerTrace.zPosition = 100;
    fingerTrace.name = @"finger";
    fingerTrace.anchorPoint = CGPointMake(0.5,0.0);
    
    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart2" ofType:@"sks"];
    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
    openEffect.position = CGPointMake(100, 0);
    [fingerTrace addChild:openEffect];
    
    [self addChild:fingerTrace];
    
    SKLabelNode *directions = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    directions.text = @"WATCH HAND";
    directions.fontColor = [UIColor blueColor];
    directions.position = CGPointMake(620,670);
    directions.fontSize = 24;
    directions.zPosition = 100;
    
    SKLabelNode *directions2 = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    directions2.text = @"DO THE SAME";
    directions2.fontColor = [UIColor blueColor];
    directions2.position = CGPointMake(620,640);
    directions2.fontSize = 24;
    directions2.zPosition = 100;
    
    [self addChild:directions];
    [self addChild:directions2];
    
    SKAction *removeText = [SKAction removeFromParent];
    SKAction *delayText = [SKAction waitForDuration:3.5];
    SKAction *delayHand = [SKAction waitForDuration:1.5];
    SKAction *tutorHandAction = [SKAction followPath:cgpath asOffset:NO orientToPath:NO duration:5.0];
    tutorHandAction.timingMode = SKActionTimingEaseInEaseOut;
    SKAction *removeHand = [SKAction removeFromParent];
    SKAction *sequenceHand = [SKAction sequence:@[delayHand,tutorHandAction,removeHand,removeText]];
    
    
    [fingerTrace runAction:sequenceHand];
    fingerTrace.alpha = 1.0;
    SKAction *sequenceRemove = [SKAction sequence:@[delayText,removeText]];
    [directions runAction:sequenceRemove];
    [directions2 runAction:sequenceRemove];
    
    //CGPathRelease(cgpath);
    
    
}

-(CIFilter *)blurFilter
{
    CIFilter* boxBlurFilter = [CIFilter filterWithName:@"CIBoxBlur"];
    [boxBlurFilter setDefaults];
    [boxBlurFilter setValue:[NSNumber numberWithFloat:100] forKey:@"inputRadius"] ;
    return boxBlurFilter;
}


-(CIFilter *)brightContrastFilter {
    CIFilter *brightnesContrastFilter = [CIFilter filterWithName:@"CIColorControls"];
    [brightnesContrastFilter setDefaults];
    [brightnesContrastFilter setValue: [NSNumber numberWithFloat:5.5f]
                               forKey:@"inputBrightness"];
    [brightnesContrastFilter setValue: [NSNumber numberWithFloat:0.5f]
                               forKey:@"inputContrast"];
    return brightnesContrastFilter;
    
}

-(void) pickQuestion:(LowerCaseLetter *)letterOn letterOff:(LowerCaseLetter *)letterMoveOff {

    
    pointsForSprite = [[NSMutableArray alloc]init];
    pointsForSprite2 = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    spriteFromPoint2 = [[NSMutableArray alloc]init];
    controlPoints = [[NSMutableArray alloc]init];
    arrowObjects = [[NSMutableDictionary alloc]init];
    pointsHit = [[NSMutableArray alloc]init];
    pointsHit2 = [[NSMutableArray alloc]init];
    
    multiStroke = FALSE;
    separateStroke = FALSE;
    firstStrokeComplete = FALSE;
    arrowAdded = FALSE;

    for (SKSpriteNode *segment in letterSegments) {
        [segment removeFromParent];
    }

    SKAction *moveSoundPanel = [SKAction moveTo:CGPointMake(0, 400) duration:0.5];
    [recordDisplay runAction:moveSoundPanel];
    
    
    if ([letterOn.name isEqual: @"A"]) {
        [self createLetterA];
        [letterA playTheSound];
        letterA.position = CGPointMake(500,400);
        [self createActionForCenterStage:letterA centerPoint:CGPointMake(500, 400) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        
        for (SKSpriteNode *letterAseg in letterSegments) {
            [letterAseg setPosition:CGPointMake(500, 400)];
            [self addChild:letterAseg];
        }
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        
    } else if ([letterOn.name isEqual: @"B"]) {

        [self createLetterB];
        [letterB playTheSound];
        [self createActionForCenterStage:letterB centerPoint:CGPointMake(500, 480) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        for (SKSpriteNode *letterBseg in letterSegments) {
            
            [letterBseg setPosition:CGPointMake(500,480)];
            [self addChild:letterBseg];
        }
        letterB.alpha = 0.0;

        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        
    } else if ([letterOn.name isEqual: @"C"]) {

        [self createLetterC];
        [letterC playTheSound];
        letterC.alpha = 0.0;
        [self createActionForCenterStage:letterC centerPoint:CGPointMake(500, 400) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        
        for (SKSpriteNode *letterCseg in letterSegments) {
            
            [letterCseg setPosition:CGPointMake(500,400)];
            [self addChild:letterCseg];
        }
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        
    } else if ([letterOn.name isEqual: @"D"]) {
        
        [self createLetterD];
        [letterD playTheSound];
        [self createActionForCenterStage:letterD centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        
    } else if ([letterOn.name isEqual: @"E"]) {
        
        [self createLetterE];
        [letterE playTheSound];
        [self createActionForCenterStage:letterE centerPoint:CGPointMake(600, 440) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"right" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        
    } else if ([letterOn.name isEqual: @"F"]) {
        [self createLetterF];
        [letterF playTheSound];
        [self createActionForCenterStage:letterF centerPoint:CGPointMake(550, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];

    } else if ([letterOn.name isEqual: @"G"]) {
        
        [self createLetterG];
        [letterG playTheSound];
        [self createActionForCenterStage:letterG centerPoint:CGPointMake(600, 460) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
    
    } else if ([letterOn.name isEqual: @"H"]) {
        
        [self createLetterH];
        [letterH playTheSound];
        [self createActionForCenterStage:letterH centerPoint:CGPointMake(650, 550) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        
    } else if ([letterOn.name isEqual: @"I"]) {
        
        [self createLetterI];
        [letterI playTheSound];
        [self createActionForCenterStage:letterI centerPoint:CGPointMake(510, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
       
    } else if ([letterOn.name isEqual: @"J"]) {
        
        [self createLetterJ];
        [letterJ playTheSound];
        [self createActionForCenterStage:letterJ centerPoint:CGPointMake(600, 550) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

        
    } else if ([letterOn.name isEqual: @"K"]) {
        
        [self createLetterK];
        [letterK playTheSound];
        [self createActionForCenterStage:letterK centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

        
    } else if ([letterOn.name isEqual: @"L"]) {
        
        [self createLetterL];
        [letterL playTheSound];
        [self createActionForCenterStage:letterL centerPoint:CGPointMake(650, 525) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

        
    } else if ([letterOn.name isEqual: @"M"]) {
        
        [self createLetterM];
        [letterM playTheSound];
        letterM.alpha = 0.0;
        [self createActionForCenterStage:letterM centerPoint:CGPointMake(500, 380) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        
        for (SKSpriteNode *letterMseg in letterSegments) {
            
            [letterMseg setPosition:CGPointMake(500,380)];
            [self addChild:letterMseg];
        }
        
    } else if ([letterOn.name isEqual: @"N"]) {
        
        [self createLetterN];
        [letterN playTheSound];
        [self createActionForCenterStage:letterN centerPoint:CGPointMake(650, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

    } else if ([letterOn.name isEqual: @"O"]) {
        
        [self createLetterO];
        [letterO playTheSound];
        [self createActionForCenterStage:letterO centerPoint:CGPointMake(640, 440) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"P"]) {
        
        [self createLetterP];
        [letterP playTheSound];
        [self createActionForCenterStage:letterP centerPoint:CGPointMake(650, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        [self traceTutorial];
        
    } else if ([letterOn.name isEqual: @"Q"]) {
        
        [self createLetterQ];
        [letterQ playTheSound];
        [self createActionForCenterStage:letterQ centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"R"]) {
        
        [self createLetterR];
        [letterR playTheSound];
        [self createActionForCenterStage:letterR centerPoint:CGPointMake(600, 490) letterOff:CGPointMake(100, 420) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"S"]) {
        [self createLetterS];
        [letterS playTheSound];
        [self createActionForCenterStage:letterS centerPoint:CGPointMake(500, 380) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        [self traceTutorial];
        [self createSpotlight];
    } else if ([letterOn.name isEqual: @"T"]) {

        [self createLetterT];
        [letterT playTheSound];
        [self createActionForCenterStage:letterT centerPoint:CGPointMake(500, 440) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];

        
    } else if ([letterOn.name isEqual: @"U"]) {
        [self createLetterU];
        [letterU playTheSound];
        [self createActionForCenterStage:letterU centerPoint:CGPointMake(550, 400) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
    } else if ([letterOn.name isEqual: @"V"]) {
        
        [self createLetterV];
        [letterV playTheSound];
        [self createActionForCenterStage:letterV centerPoint:CGPointMake(550, 400) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"W"]) {
        
        [self createLetterW];
        [letterW playTheSound];
        [self createActionForCenterStage:letterW centerPoint:CGPointMake(550, 400) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"X"]) {
        
        [self createLetterX];
        [letterX playTheSound];
        [self createActionForCenterStage:letterX centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"right" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"Y"]) {
        
        [self createLetterY];
        [letterY playTheSound];
        [self createActionForCenterStage:letterY centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
        
    } else if ([letterOn.name isEqual: @"Z"]) {
        
        [self createLetterZ];
        [letterZ playTheSound];
        [self createActionForCenterStage:letterZ centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(500,-300) offStageLetter:letterMoveOff];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"right" location:[theArrowPoint CGPointValue]];
        [self createSpotlight];
    }

    [self addStrokeArrows];
    
}


-(void)createSpotlight {
    
   /* gridPaper.alpha = 0.5;
    self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
    SKEffectNode* spotlightEffect =[[SKEffectNode alloc]init];
    SKSpriteNode* light = [SKSpriteNode spriteNodeWithImageNamed:@"spotlight-10.jpg"];
    [spotlightEffect addChild:light];
    
    spotlightEffect.filter=[self blurFilter];
    spotlightEffect.blendMode=SKBlendModeMultiply;
    spotlightEffect.alpha = 0.7;
    spotlightEffect.zPosition = 3;
    spotlightEffect.position = CGPointMake(550,550);
    [self addChild:spotlightEffect];
    
    SKAction *fadeLight = [SKAction fadeAlphaTo:0.0 duration:4.0];
    [spotlightEffect runAction:fadeLight];
    
    SKAction *fadeGrid = [SKAction fadeAlphaTo:1.0 duration:4.0];
    [gridPaper runAction:fadeGrid];*/
    
}

-(void)createActionForCenterStage:(LowerCaseLetter *)letterToCenter
                            centerPoint:(CGPoint)moveToCenter
                              letterOff:(CGPoint)moveOffCenter
                         offStageLetter:(LowerCaseLetter *)letterToMoveOff
{
    
    numberOfPoints = 0;
    lastPointHit = 0;
    twoPointBeforeHit = 0;
    currentPointHit = 0;
    lastPoint = [NSNumber numberWithBool:FALSE];
    twoPointBefore = [NSNumber numberWithBool:FALSE];

    letterToCenter.centerStage = TRUE;
    letterToCenter.scale = 1.0;
    
    [self cleanUpAndRemoveShapeNode];
    [self resetShapeNodePool];
    [handPointer removeFromParent];
    
    SKAction *moveLetterOn = [SKAction moveTo:moveToCenter duration:1.0];
    [letterToCenter runAction:moveLetterOn];
    SKAction *moveLetterOff = [SKAction moveTo:moveOffCenter duration:1.0];
    SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:0.3];
    [letterToMoveOff runAction:moveLetterOff];
    [letterToMoveOff runAction:scaleLetterDown];
    
    int numberOfPointsFirst = [pointsForSprite count];
    int numberOfPointsSecond = [pointsForSprite2 count];
    
    
    for(int i = 0; i < numberOfPointsFirst; i++) {
        NSNumber *pointBool = [NSNumber numberWithBool:FALSE];
        [pointsHit addObject:pointBool];
        
    }
    
    for(int p=0; p < numberOfPointsSecond; p++) {
        
        NSNumber *secondPointBool = [NSNumber numberWithBool:FALSE];
        [pointsHit2 addObject:secondPointBool];
        
    }
    
}


-(void) addStrokeArrows {
    
    shapeNodeObjects = [[NSMutableArray alloc]init];
    
    int spritePointCount = 0;
    
    for (NSValue *pointValue in pointsForSprite) {

        NSString *directionArrow = [arrowObjects objectForKey:[NSString stringWithFormat:@"%i",spritePointCount]];
        ArrowWithEmitter *spritePoint = [[ArrowWithEmitter alloc]initWithDirection:directionArrow];
        CGPoint finalLocation = [pointValue CGPointValue];

        spritePoint.position = CGPointMake(finalLocation.x, finalLocation.y);
        spritePoint.name = @"firstLine";
        
        if (spritePointCount == 0) {
            spritePoint.alpha = 1.0;
        } else {
            spritePoint.alpha = FIRST_ARROW_ALPHA;
        }
        
        [self addChild:spritePoint];
        [spriteFromPoint addObject:spritePoint];
        
        if (spritePointCount == 0) {
            [spritePoint runAction:[SKAction scaleTo:2.0 duration:0.6]];
            [spritePoint runAction:[SKAction scaleTo:1.5 duration:0.6]];
        }
        
        spritePointCount++;
    }
    
    if (multiStroke == TRUE) {
        
        for (NSValue *pointValue2 in pointsForSprite2) {
            NSString *directionArrow = [arrowObjects objectForKey:[NSString stringWithFormat:@"%i",spritePointCount]];
            ArrowWithEmitter *spritePoint2 = [[ArrowWithEmitter node]initWithDirection:directionArrow];
            
            //ArrowWithEmitter *spritePoint2 = [ArrowWithEmitter node];
            CGPoint finalLocation = [pointValue2 CGPointValue];
            spritePoint2.position = CGPointMake(finalLocation.x, finalLocation.y);
            spritePoint2.name = @"secondLine";
            spritePoint2.alpha = SECOND_ARROW_ALPHA;
            [self addChild:spritePoint2];
            [spriteFromPoint2 addObject:spritePoint2];
            spritePointCount++;
        }
    }

    
    if (onWhichQuestion > 0) {
        
        [firstPointsLabel removeFromParent];
        [secondPointsLabel removeFromParent];
        [finishedLetters removeFromParent];
        
        firstPointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        
        NSString *labelString = [NSString stringWithFormat:@"Points1: 0/%i",[pointsForSprite count]];
        
        firstPointsLabel.text = labelString;
        firstPointsLabel.fontColor = [UIColor magentaColor];
        firstPointsLabel.fontSize = 16;
        firstPointsLabel.position = CGPointMake(275, 750);
        [self addChild:firstPointsLabel];
        
        secondPointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        NSString *labelString2 = [NSString stringWithFormat:@"Points2: 0/%i",[pointsForSprite2 count]];
        
        secondPointsLabel.text = labelString2;
        secondPointsLabel.fontColor = [UIColor magentaColor];
        secondPointsLabel.fontSize = 16;
        secondPointsLabel.position = CGPointMake(375, 750);
        [self addChild:secondPointsLabel];

        finishedLetters = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        finishedLetters.text = @"Letter Box";
        finishedLetters.fontColor = [UIColor magentaColor];
        finishedLetters.fontSize = 24;
        finishedLetters.position = CGPointMake(120, 740);
        //[self addChild:finishedLetters];
        
    }
    

    
}

////////////////////////////////
//
// SHAPE NODE
//
////////////////////////////////


-(void)showActivity {
    
    /*timerForLetter++;
    
    NSString *currentTime = [NSString stringWithFormat:@"%d seconds", timerForLetter];
    
    if ([self childNodeWithName:@"timer"]) {
        
        [timeDisplay removeFromParent];
        
    }
    
    timeDisplay = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    timeDisplay.name = @"timer";
    timeDisplay.text = currentTime;
    timeDisplay.fontSize = 14;
    timeDisplay.fontColor = [UIColor blackColor];
    timeDisplay.position = CGPointMake(500, 750);
    [self addChild:timeDisplay];*/
    
    
    
}

-(LowerCaseLetter *)currentLetter {
    
    LowerCaseLetter *letterOn;
    
    for (LowerCaseLetter *getLetter in allLettersSprites) {
        if(getLetter.centerStage == YES) {
            letterOn = getLetter;
        }
    }
    return letterOn;
    
    
}


-(void)closePreviousGroup:(NSNumber*)whichGroupClose {
    
    if ([whichGroupClose intValue] == 1) {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupOne.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupOneLetters) {
            [openLetterBox runAction:closeLetters];
        }
    } else if ([whichGroupClose intValue] == 2){
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupTwo.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupTwoLetters) {
            [openLetterBox runAction:closeLetters];
        }

    } else if ([whichGroupClose intValue] == 3) {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupThree.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupThreeLetters) {
            [openLetterBox runAction:closeLetters];
        }
        
    } else if ([whichGroupClose intValue] == 4)  {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupFour.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupFourLetters) {
            [openLetterBox runAction:closeLetters];
        }
    } else if ([whichGroupClose intValue] == 5) {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupFive.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupFiveLetters) {
            [openLetterBox runAction:closeLetters];
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    /*timeForQuestion = [NSTimer scheduledTimerWithTimeInterval:0.5
                                                       target:self
                                                     selector:@selector(showActivity)
                                                     userInfo:Nil
                                                      repeats:YES];*/
    
    /*if (onWhichQuestion > 0) {
        [timeDisplay removeFromParent];
    }*/

    if(CGRectContainsPoint(replayTrace.frame,theTouch)) {
        [currentLetter playTheSound]; 
        [self traceTutorial];
    }
    
    for (LowerCaseLetter *tapLetter in allLettersSprites) {
        self.userInteractionEnabled = NO;
        if (CGRectContainsPoint(tapLetter.frame,theTouch) && tapLetter.centerStage == NO) {
            [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];
            [self pickQuestion:tapLetter letterOff:currentLetter];
            currentLetter = tapLetter;

        }
        self.userInteractionEnabled = YES;
    }
    
    if(CGRectContainsPoint(finishedLetters.frame, theTouch)) {
        
        for (RedrawLetter *finishedLetter in group1Letters) {
            
            SKAction *finishReview = [SKAction moveTo:groupOne.position duration:1.0];
            SKAction *shrinkReview = [SKAction scaleTo:0.0 duration:1.0];
            SKAction *sequence = [SKAction sequence:@[finishReview,shrinkReview]];
            [finishedLetter runAction:sequence];
            
        }
        
    }
    
    if(CGRectContainsPoint(groupOne.frame, theTouch)) {
        
        int i = 100;
        
        if (onWhichGroup != 1) {
            
            [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];
            
            for (LowerCaseLetter *openLetterBox in groupOneLetters) {
                int newX = groupOne.position.x;
                int newY = groupOne.position.y + i;
                openLetterBox.position = groupOne.position;
                
                SKTMoveEffect *moveLetter = [SKTMoveEffect effectWithNode:openLetterBox
                                                                 duration:0.3
                                                            startPosition:groupOne.position
                                                              endPosition:CGPointMake(newX,newY)];
                
                moveLetter.timingFunction = SKTTimingFunctionBounceEaseOut;
                SKAction *actionWithEffectForLetter = [SKAction actionWithEffect:moveLetter];
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:actionWithEffectForLetter];
                
                i += 70;
            }
            
            onWhichGroup = 1;
            
        } else {
            
            onWhichGroup = 0;
            
            SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupOne.position.x, -500) duration:0.5];

            for (LowerCaseLetter *openLetterBox in groupOneLetters) {
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:closeLetters];

            }
        }
        
    } else if(CGRectContainsPoint(groupTwo.frame, theTouch)) {

        
        int i = 100;
        
        if (onWhichGroup != 2) {

            [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            for (LowerCaseLetter *openLetterBox in groupTwoLetters) {
                int newX = groupTwo.position.x - i + 50;
                int newY = groupTwo.position.y + i;
                openLetterBox.position = groupTwo.position;
                
                SKTMoveEffect *moveLetter = [SKTMoveEffect effectWithNode:openLetterBox
                                                                   duration:0.3
                                                              startPosition:groupTwo.position
                                                                endPosition:CGPointMake(newX,newY)];
                
                moveLetter.timingFunction = SKTTimingFunctionBounceEaseOut;
                SKAction *actionWithEffectForLetter = [SKAction actionWithEffect:moveLetter];
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:actionWithEffectForLetter];
                
                i += 70;
            }
            
            onWhichGroup = 2;
            
        } else {
            
            onWhichGroup = 0;
            
            SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupTwo.position.x, -500) duration:0.5];
            SKAction *scaleDown = [SKAction scaleTo:0.0 duration:1.0];
            
            for (LowerCaseLetter *openLetterBox in groupTwoLetters) {
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:closeLetters];
                //[openLetterBox runAction:scaleDown];

            }
        }
        
        
        
    } else if(CGRectContainsPoint(groupThree.frame, theTouch)) {
        int i = 100;
        
        if (onWhichGroup != 3) {
            [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];
            for (LowerCaseLetter *openLetterBox in groupThreeLetters) {

                int newX = groupThree.position.x + i - 10 ;
                int newY = groupThree.position.y + i;
                openLetterBox.position = groupThree.position;
                SKTMoveEffect *moveLetter = [SKTMoveEffect effectWithNode:openLetterBox
                                                                 duration:0.3
                                                            startPosition:groupThree.position
                                                              endPosition:CGPointMake(newX,newY)];
                
                moveLetter.timingFunction = SKTTimingFunctionBounceEaseOut;
                SKAction *actionWithEffectForLetter = [SKAction actionWithEffect:moveLetter];
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:actionWithEffectForLetter];
                i += 70;
            }
            
            onWhichGroup = 3;
            
        } else {
            
            onWhichGroup = 0;
            
            SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupThree.position.x, -500) duration:0.2];
            SKAction *scaleDown = [SKAction scaleTo:0.0 duration:1.0];
            
            for (LowerCaseLetter *openLetterBox in groupThreeLetters) {
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:closeLetters];
                //[openLetterBox runAction:scaleDown];
                
            }
        }
        
        
    } else if(CGRectContainsPoint(groupFour.frame, theTouch)) {
        int i = 100;
        
        if (onWhichGroup != 4) {
            [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            
            for (LowerCaseLetter *openLetterBox in groupFourLetters) {
                int newX = groupFour.position.x + i - 40;
                int newY = groupFour.position.y + i;
                openLetterBox.position = groupFour.position;
                SKTMoveEffect *moveLetter = [SKTMoveEffect effectWithNode:openLetterBox
                                                                 duration:0.3
                                                            startPosition:groupFour.position
                                                              endPosition:CGPointMake(newX,newY)];
                
                moveLetter.timingFunction = SKTTimingFunctionBounceEaseOut;
                SKAction *actionWithEffectForLetter = [SKAction actionWithEffect:moveLetter];
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:actionWithEffectForLetter];
                
                i += 70;
            }
            
            onWhichGroup = 4;
            
        } else {
            
            onWhichGroup = 0;
            
            SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupFour.position.x, -500) duration:0.2];
            for (LowerCaseLetter *openLetterBox in groupFourLetters) {
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:closeLetters];
            }
        }
        
    } else if(CGRectContainsPoint(groupFive.frame, theTouch)) {
        int i = 100;
        
        if (onWhichGroup != 5) {
            [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            for (LowerCaseLetter *openLetterBox in groupFiveLetters) {
                int newX = groupFive.position.x;
                int newY = groupFive.position.y + i;
                openLetterBox.position = groupFive.position;
                SKTMoveEffect *moveLetter = [SKTMoveEffect effectWithNode:openLetterBox
                                                                 duration:0.3
                                                            startPosition:groupFive.position
                                                              endPosition:CGPointMake(newX,newY)];
                
                moveLetter.timingFunction = SKTTimingFunctionBounceEaseOut;
                SKAction *actionWithEffectForLetter = [SKAction actionWithEffect:moveLetter];
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:actionWithEffectForLetter];
                i += 70;
            }
            
            onWhichGroup = 5;
            
        } else {
            onWhichGroup = 0;
            SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupFive.position.x, -500) duration:0.2];

            for (LowerCaseLetter *openLetterBox in groupFiveLetters) {
                openLetterBox.alpha = 1.0;
                [openLetterBox runAction:closeLetters];
                
            }
        }
        
    }
   
    
    if (CGRectContainsPoint(backToMainMenuArrow.frame, theTouch)) {
        
        [self resetOnExit];
        [self removeAllChildren];
    
        SKView *spriteView = (SKView *)self.view;
        IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.2];
        introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];

    }
 
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    currentPoint = theTouch;
    previousPoint2 = previousPoint;
    
    previousPoint = [touch previousLocationInNode:self];
    deltaPoint = CGPointSubtract(theTouch, previousPoint);
    
    
    if(currentLetter != nil) {
        [self letterShapeNode:theTouch];
    }
    [self updatePointSpriteLabelsFirstLine];

    if([pointsForSprite count] > 0) {
        
        ArrowWithEmitter *firstPointSprite;
        
        if(spriteFromPoint !=nil) {
            firstPointSprite = [spriteFromPoint objectAtIndex:0];
        }
        
        if (CGRectContainsPoint (firstPointSprite.frame, theTouch)) {
            firstPointTest = TRUE;
            strokeLetterBegin = TRUE;
            //[firstPointSprite runAction:[SKAction removeFromParent]];
        }
        
    }
    
   
}

-(void) updatePointSpriteLabelsFirstLine {
    
    int hitPoints1 = 0;
    for (NSNumber *hitVal1 in pointsHit) {
        if ([hitVal1 boolValue]) {
            hitPoints1++;
        }
    }
    
    [firstPointsLabel removeFromParent];
    firstPointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    NSString *labelString = [NSString stringWithFormat:@"Points1: %i/%i",hitPoints1,[pointsForSprite count]];
    
    firstPointsLabel.text = labelString;
    firstPointsLabel.fontColor = [UIColor magentaColor];
    firstPointsLabel.fontSize = 16;
    firstPointsLabel.position = CGPointMake(120, 750);
    [self addChild:firstPointsLabel];
}

-(void) updatePointSpriteLabelsSecondLine {
    
    int hitPoints = 0;
    for (NSNumber *hitVal in pointsHit2) {
        if ([hitVal boolValue]) {
            hitPoints++;
        }
    }
    
    [secondPointsLabel removeFromParent];
    
    secondPointsLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    NSString *labelString2 = [NSString stringWithFormat:@"Points2: %i/%i",hitPoints,[pointsForSprite2 count]];
    
    secondPointsLabel.text = labelString2;
    secondPointsLabel.fontColor = [UIColor magentaColor];
    secondPointsLabel.fontSize = 16;
    secondPointsLabel.position = CGPointMake(375, 750);
    [self addChild:secondPointsLabel];
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[timeForQuestion invalidate];

    if (firstPointTest && strokeLetterBegin && !separateStroke) {
        for(LowerCaseLetter *onLetter in allLettersSprites) {
            if (onLetter.centerStage && firstPointTest) {
                SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:1.5];
                SKAction *scaleBackToNormal = [SKAction scaleTo:0.1 duration:2.5];
                [onLetter runAction:fadeOut];
                [onLetter runAction:scaleBackToNormal];
                onLetter.timeForTrace = [NSNumber numberWithInt:timerForLetter];
                onWhichGroup = 0;
                    
            }
        }
        
        for (NSNumber *pointHitSeg in pointsHit2) {
            if ([pointHitSeg isEqualToNumber:[NSNumber numberWithBool:0]]) {
                
            }
        }
        
        for (ArrowWithEmitter *spritePoint in spriteFromPoint) {
            [spritePoint removeFromParent];
        }

        if (multiStroke) {
            for (ArrowWithEmitter *pinWheel in spriteFromPoint2) {
                [pinWheel removeFromParent];
            }
        }
        
        SKAction *fadeSeg = [SKAction fadeAlphaTo:0.0 duration:0.4];
        
        for (SKSpriteNode *segSprite in letterSegments) {
            [segSprite runAction:fadeSeg];
        }

        firstPointTest = FALSE;
        onWhichQuestion++;
        [currentLetter playTheSound];
        
        if (onWhichQuestion == 6) { // GROUP ONE COMPLETED

            NSNumber *theGroupID = [NSNumber numberWithInt:groupSequence];
            [self resetOnExit];
            MatchPix *matchingScene = [[MatchPix alloc]initWithSize:CGSizeMake(768,1024) onWhichGroup:theGroupID];
            SKTransition *overDrag = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            SKView *spriteView = (SKView*)self.view;
            [spriteView presentScene:matchingScene transition:overDrag];
                
        } else if (onWhichQuestion == 5 && groupSequence == 2) {
            NSNumber *theGroupID = [NSNumber numberWithInt:groupSequence];
            [self resetOnExit];
            MatchPix *matchingScene = [[MatchPix alloc]initWithSize:CGSizeMake(768,1024) onWhichGroup:theGroupID];
            SKTransition *overDrag = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:1.0];
            SKView *spriteView = (SKView*)self.view;
            [spriteView presentScene:matchingScene transition:overDrag];
        }
        timerForLetter = 0;
        
        if(strokeLetterBegin) {
            strokeLetterBegin = TRUE;
            
        }
        
        [self storeShapeDrawn];
        [self soundRecorder];

    }
}

-(void)soundRecorder {
    
    recordDisplay = [[RecordSound alloc]initWithPosition:CGPointMake(0, 0)];
    recordDisplay.position = CGPointMake(0, 400);
    [self addChild:recordDisplay];
    SKAction *moveSoundPanel = [SKAction moveTo:CGPointMake(0, 0) duration:0.5];
    [recordDisplay runAction:moveSoundPanel];
}

-(void)resetOnExit {

    for (SKSpriteNode *letterRemove in allLettersSprites) {
        [letterRemove removeFromParent];
    }

    onWhichQuestion = 0;
    onWhichGroup = 0;
    numberOfPoints = 0;
    
    firstPointTest = FALSE;
    firstStrokeComplete = FALSE;
    strokeLetterBegin = FALSE;
    
    listOfTrailSprites = [[NSMutableArray alloc]init];
    pointsForSprite = [[NSMutableArray alloc]init];
    pointsForSprite2 = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    allLettersSprites = [[NSMutableArray alloc]init];
    groupOneLetters = [[NSMutableArray alloc]init];
    groupTwoLetters = [[NSMutableArray alloc]init];
    groupThreeLetters = [[NSMutableArray alloc]init];
    groupFourLetters = [[NSMutableArray alloc]init];
    groupFiveLetters = [[NSMutableArray alloc]init];
    timeToDrawLetter = [[NSMutableArray alloc]init];
    pointsHit = [[NSMutableArray alloc]init];
    
    shapeNodeObjects = [[NSMutableArray alloc]init];
    shapeNodeObjectForLetter = [[NSMutableDictionary alloc]init];
    allEffectNodes = [[NSMutableArray alloc]init];
    
}


-(void)moveGroupLabelToTop:(SKLabelNode*)groupLabel destination:(CGPoint)dest start:(CGPoint)begin {
    
    
    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"displayLetter" ofType:@"sks"];
    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
    [groupLabel addChild:openEffect];
    SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:groupLabel
                                                     duration:4.0
                                                startPosition:begin
                                                  endPosition:dest];
    
    actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
    SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
    [groupLabel runAction:actionWithEffect];
    SKAction *scaleIt = [SKAction scaleTo:2.0 duration:4.0];
    SKAction *scaleItBack = [SKAction scaleTo:0.8 duration:2.0];
    SKAction *moveToClose = [SKAction moveByX:0 y:0 duration:1.0];
    SKAction *sequenceScaleGroup = [SKAction sequence:@[scaleIt,scaleItBack,moveToClose]];
    [groupLabel runAction:sequenceScaleGroup];

    
    SKSpriteNode *doneWithGroupImage;
    
    if ([groupLabel.name  isEqualToString: @"group1"]) {
        doneWithGroupImage = [SKSpriteNode spriteNodeWithImageNamed:@"apple.png"];
        doneWithGroupImage.scale = 0.1;
        doneWithGroupImage.position = CGPointMake(-75, 5);
        [groupLabel addChild:doneWithGroupImage];
    } else if ([groupLabel.name isEqualToString:@"group2"]) {
        doneWithGroupImage = [SKSpriteNode spriteNodeWithImageNamed:@"ostrich.png"];
        doneWithGroupImage.scale = 0.1;
        doneWithGroupImage.position = CGPointMake(-75, 5);
        [groupLabel addChild:doneWithGroupImage];
    } else if ([groupLabel.name isEqualToString:@"group3"]) {
        doneWithGroupImage = [SKSpriteNode spriteNodeWithImageNamed:@"igloo.png"];
        doneWithGroupImage.scale = 0.1;
        doneWithGroupImage.position = CGPointMake(-75, 5);
        [groupLabel addChild:doneWithGroupImage];
    } else if([groupLabel.name isEqualToString:@"group4"]) {
        doneWithGroupImage = [SKSpriteNode spriteNodeWithImageNamed:@"elephant.png"];
        doneWithGroupImage.scale = 0.1;
        doneWithGroupImage.position = CGPointMake(-75, 5);
        [groupLabel addChild:doneWithGroupImage];
    } else if([groupLabel.name isEqualToString:@"group5"]) {
        doneWithGroupImage = [SKSpriteNode spriteNodeWithImageNamed:@"volcano.png"];
        doneWithGroupImage.scale = 0.1;
        doneWithGroupImage.position = CGPointMake(-75, 5);
        [groupLabel addChild:doneWithGroupImage];
    }

}

-(void)redrawTheLetterShapeNode:(NSString *)whichGroup {
    
    int xposition = -250;
    int yposition = 280;

    for (RedrawLetter *letterToRedraw in group1Letters) {
        if([letterToRedraw.representGroup isEqualToString:whichGroup]) {
            NSMutableArray *spritesToDraw = [letterToRedraw drawMyself];
            for (SKSpriteNode *drawSprite in spritesToDraw) {
                SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
                newCloud.position = drawSprite.position;
                newCloud.scale = 0.25;
                [letterToRedraw addChild:newCloud];
            }
            [self addChild:letterToRedraw];
            
            letterToRedraw.position = CGPointMake(xposition, yposition);
            letterToRedraw.scale = 0.35;
            
            xposition += 145;
            
        }
    }
}





-(void)completedFirstGroup {
    
    
    [self moveGroupLabelToTop:groupOne
                  destination:CGPointMake(100,700)
                        start:groupOne.position];
    
    [self cleanUpAndRemoveShapeNode];
    [self redrawTheLetterShapeNode:@"group1"];

    int i = 0;
    
    for (SKSpriteNode *letterSprite in groupTwoLetters) {
        letterSprite.scale = 0.2;
        letterSprite.position = groupTwo.position;
        
        SKAction *fadeLetterIn = [SKAction fadeAlphaTo:1.0 duration:2.0];
        SKAction *scaleLetterIn = [SKAction scaleTo:0.2 duration:1.0];
        
        SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:letterSprite duration:2.0
                                                    startPosition:letterSprite.position
                                                      endPosition:CGPointMake(950, 650 - i)];
        
        actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
        
        SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
        
        [letterSprite runAction:actionWithEffect];
        [letterSprite runAction:fadeLetterIn];
        [letterSprite runAction:scaleLetterIn];
        
        [self addChild:letterSprite];
        i += 100;
    }

}


-(void)completedSecondGroup {
    
    [self moveGroupLabelToTop:groupTwo
                  destination:CGPointMake(100, 660)
                        start:groupTwo.position];
    [self cleanUpAndRemoveShapeNode];
    [self redrawTheLetterShapeNode:@"group2"];

    int i=0;
    
    for (SKSpriteNode *letterSprite in groupThreeLetters) {
        letterSprite.scale = 0.2;
        letterSprite.position = groupThree.position;
        SKAction *fadeLetterIn = [SKAction fadeAlphaTo:1.0 duration:2.0];
        SKAction *scaleLetterIn = [SKAction scaleTo:0.2 duration:1.0];
        
        SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:letterSprite duration:4.0
                                                    startPosition:letterSprite.position
                                                      endPosition:CGPointMake(950, 650 - i)];
        
        actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
        
        SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
        
        [letterSprite runAction:actionWithEffect];
        [letterSprite runAction:fadeLetterIn];
        [letterSprite runAction:scaleLetterIn];
        
        [self addChild:letterSprite];
        
        i += 100;
    }

    
}

-(void)completedThirdGroup {
    
    [self moveGroupLabelToTop:groupThree
                  destination:CGPointMake(100, 620)
                        start:groupThree.position];
    
    [self cleanUpAndRemoveShapeNode];
    
    [self redrawTheLetterShapeNode:@"group3"];
    
    
    int i = 0;
    for (SKSpriteNode *letterSprite in groupFourLetters) {
        letterSprite.scale = 0.2;
        letterSprite.position = CGPointMake(950, 650 - i);
        [self addChild:letterSprite];
        i += 100;
    }
    
}

-(void)completeFourthGroup {
    
    [self moveGroupLabelToTop:groupFour
                  destination:CGPointMake(100, 580)
                        start:groupFour.position];
    
    [self cleanUpAndRemoveShapeNode];
    
    [self redrawTheLetterShapeNode:@"group4"];
    
    
    
    int i = 0;
    for (SKSpriteNode *letterSprite in groupFiveLetters) {
        letterSprite.scale = 0.2;
        letterSprite.position = CGPointMake(950, 650 - i);
        [self addChild:letterSprite];
        i += 100;
    }
    

}

-(void)completeFifthGroup {
    
    [self moveGroupLabelToTop:groupFive
                  destination:CGPointMake(100,540)
                        start:groupFive.position];
    
    [self cleanUpAndRemoveShapeNode];
    
    [self redrawTheLetterShapeNode:@"group5"];

}


-(void)update:(NSTimeInterval)currentTime {
  
    
    if (multiStroke && firstStrokeComplete && arrowAdded == FALSE) {
        
        
        if ([secondStroke isEqualToString:@"up"]) {
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.y -= 100;
            [self arrowPointerToDraw:@"up" location:arrowPointCG];
            
            float fadeTime = 0.05;
                                           
            for(ArrowWithEmitter *theSprite in spriteFromPoint2) {
                SKAction *fadeToShow = [SKAction fadeAlphaTo:1.0 duration:fadeTime];
                SKAction *fadeToHide = [SKAction fadeAlphaTo:0.0 duration:fadeTime];
                SKAction *delayBetweenFade = [SKAction waitForDuration:0.05];
                SKAction *sequenceFadeOnOff = [SKAction sequence:@[fadeToShow,delayBetweenFade,fadeToHide]];
                [theSprite runAction:sequenceFadeOnOff];
                fadeTime += 0.01;
            }

            
        } else if ([secondStroke isEqualToString:@"down"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.y += 100;
            [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
            
            float fadeTime = 0.05;

            for(ArrowWithEmitter *theSprite in spriteFromPoint2) {
                SKAction *fadeToShow = [SKAction fadeAlphaTo:1.0 duration:fadeTime];
                SKAction *fadeToHide = [SKAction fadeAlphaTo:0.0 duration:fadeTime];
                SKAction *delayBetweenFade = [SKAction waitForDuration:0.05];
                SKAction *sequenceFadeOnOff = [SKAction sequence:@[fadeToShow,delayBetweenFade,fadeToHide]];
                [theSprite runAction:sequenceFadeOnOff];
                fadeTime += 0.01;
            }
            
        } else if ([secondStroke isEqualToString:@"left"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.x -= 200;
            [self arrowPointerToDraw:@"left" location:arrowPointCG];
            
            float fadeTime = 0.05;
            
            for(ArrowWithEmitter *theSprite in spriteFromPoint2) {
                SKAction *fadeToShow = [SKAction fadeAlphaTo:1.0 duration:fadeTime];
                SKAction *fadeToHide = [SKAction fadeAlphaTo:0.0 duration:fadeTime];
                SKAction *delayBetweenFade = [SKAction waitForDuration:0.05];
                SKAction *sequenceFadeOnOff = [SKAction sequence:@[fadeToShow,delayBetweenFade,fadeToHide]];
                [theSprite runAction:sequenceFadeOnOff];
                fadeTime += 0.01;
            }
            
        } else if ([secondStroke isEqualToString:@"right"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.x -= 150;
            [self arrowPointerToDraw:@"right" location:arrowPointCG];
            
            float fadeTime = 0.05;
            
            for(ArrowWithEmitter *theSprite in spriteFromPoint2) {
                SKAction *fadeToShow = [SKAction fadeAlphaTo:1.0 duration:fadeTime];
                SKAction *fadeToHide = [SKAction fadeAlphaTo:0.0 duration:fadeTime];
                SKAction *delayBetweenFade = [SKAction waitForDuration:0.05];
                SKAction *sequenceFadeOnOff = [SKAction sequence:@[fadeToShow,delayBetweenFade,fadeToHide]];
                [theSprite runAction:sequenceFadeOnOff];
                fadeTime += 0.01;
            }
            
        }

        arrowAdded = TRUE;

    }
    
    int onWhichPoint = 0;
    
    if (currentLetter != nil)
    {
    for (ArrowWithEmitter *pointHit in spriteFromPoint) {
        
        onWhichPoint++;
        
        if (CGRectContainsPoint(pointHit.frame,currentPoint) && !firstStrokeComplete) {
            
            if ([spriteFromPoint count] == onWhichPoint) {
                firstStrokeComplete = TRUE;
            }

            if ([currentLetter.name isEqualToString:@"A"]) {
 
                SKSpriteNode *letterAsegToFade = [[SKSpriteNode alloc]init];
                
                if (onWhichPoint < [letterSegments count]) {
                    letterAsegToFade = [letterSegments objectAtIndex:[letterSegments count]-onWhichPoint];
                    [letterAsegToFade runAction:removeSprite];
                }
            } else if ([currentLetter.name isEqualToString:@"B"]) {
   
                SKSpriteNode *letterBsegToFade = [[SKSpriteNode alloc]init];
                
                if (onWhichPoint < [letterSegments count]) {
                    letterBsegToFade = [letterSegments objectAtIndex:[letterSegments count]-onWhichPoint];
                    [letterBsegToFade runAction:removeSprite];
                }
            } else if ([currentLetter.name isEqualToString:@"C"]) {

                SKSpriteNode *letterCsegToFade = [[SKSpriteNode alloc]init];
                
                if (onWhichPoint < [letterSegments count]) {
                    letterCsegToFade = [letterSegments objectAtIndex:[letterSegments count]-onWhichPoint];
                    [letterCsegToFade runAction:removeSprite];
                }
            } else if ([currentLetter.name isEqualToString:@"M"]) {
  
                SKSpriteNode *letterMsegToFade = [[SKSpriteNode alloc]init];
                
                if (onWhichPoint < [letterSegments count]) {
                    letterMsegToFade = [letterSegments objectAtIndex:[letterSegments count]-onWhichPoint];
                    [letterMsegToFade runAction:removeSprite];
                }
            }
            
            if (onWhichPoint < [spriteFromPoint count]) {
                
                ArrowWithEmitter *nextOne = [spriteFromPoint objectAtIndex:onWhichPoint];
                nextOne.alpha = 1.0;
                [nextOne fireEmitter];
                CGPoint nextPos;

                if(onWhichPoint + 1 < [spriteFromPoint count]) {
                    ArrowWithEmitter *nextSprite = [spriteFromPoint objectAtIndex:onWhichPoint+1];
                    nextSprite.alpha = 1.0;
                    nextPos = nextSprite.position;
                    [nextSprite fireEmitter];
                    SKAction *remove = [SKAction removeFromParent];
                    SKTMoveEffect *moveHitArrow = [SKTMoveEffect effectWithNode:pointHit
                                                                       duration:0.3
                                                                  startPosition:currentPoint
                                                                    endPosition:nextPos];
                    moveHitArrow.timingFunction = SKTTimingFunctionSmoothstep;
                    SKAction *actionWithEffectForHitArrow = [SKAction actionWithEffect:moveHitArrow];
                    SKAction *sequenceActionPointHit = [SKAction sequence:@[actionWithEffectForHitArrow,remove]];
                    [pointHit runAction:sequenceActionPointHit];
                } else {
                    //[pointHit fireEmitter];
                    //[pointHit removeFromParent];

                }
                
                if (onWhichPoint+1 < [spriteFromPoint count]){
                    
                    SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.4];
                    SKAction *moveBack = [SKAction moveTo:pointHit.position duration:0.2];
                    SKAction *removeTheArrow = [SKAction removeFromParent];
                    SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,moveBack,moveToNextArrow,removeTheArrow]];
                    [nextOne runAction:moveToNextArrow];
                    //[nextOne runAction:sequenceArrow];
                    //[nextOne runAction:sequenceActions];
                }
                
            }
            
            if (onWhichPoint+1 < [spriteFromPoint count]) {
                
                ArrowWithEmitter *nextTwo = [spriteFromPoint objectAtIndex:onWhichPoint + 1];
                [nextTwo fireEmitter];
                if(ARROW_EMITTERS) {
                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                    [self addChild:openEffect];
                    openEffect.position = nextTwo.position;
                    
                }
                
                if (onWhichPoint+2 < [spriteFromPoint count]){
                    ArrowWithEmitter *nextSprite = [spriteFromPoint objectAtIndex:onWhichPoint+2];
                    CGPoint nextPos = nextSprite.position;
                    SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.6];
                    SKAction *moveBack2 = [SKAction moveTo:pointHit.position duration:0.3];
                    SKAction *removeTheArrow = [SKAction removeFromParent];
                    SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow, removeTheArrow]];
                    [nextTwo runAction:moveToNextArrow];
                    //[nextTwo runAction:sequenceArrow];
                }
            }
            
            if (onWhichPoint + 2 < [spriteFromPoint count]) {
                ArrowWithEmitter *nextThree = [spriteFromPoint objectAtIndex:onWhichPoint + 2];
                [nextThree fireEmitter];
                [nextThree runAction:sequenceActions3];
                
                if (ARROW_EMITTERS) {
                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                    [self addChild:openEffect];
                    openEffect.position = nextThree.position;
                    
                }
                
                if (onWhichPoint+3 < [spriteFromPoint count]){
                    ArrowWithEmitter *nextSprite = [spriteFromPoint objectAtIndex:onWhichPoint+3];
                    CGPoint nextPos = nextSprite.position;
                    SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.9];
                    SKAction *removeTheArrow = [SKAction removeFromParent];
                    SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                    [nextThree runAction:moveToNextArrow];
                    //[nextThree runAction:sequenceArrow];
                }
                
            }
            
            if (onWhichPoint + 3 < [spriteFromPoint count]) {
                ArrowWithEmitter *nextFour = [spriteFromPoint objectAtIndex:onWhichPoint + 3];
                
                if (ARROW_EMITTERS) {
                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                    //[self addChild:openEffect];
                    openEffect.position = nextFour.position;
                }
 
            }
            
/* 
 --------------------------------
            Second stroke        |
 -------------------------------- */

        } else if (multiStroke && firstStrokeComplete && !separateStroke ) {

            int secondSpritePointCount = 0;
            int pointIndexArray = 0;
            int totalCountOfSprites = onWhichPoint + secondSpritePointCount;
            ArrowWithEmitter *firstOne = [spriteFromPoint2 objectAtIndex:0];
            firstOne.alpha = 1.0;
            [firstOne runAction:[SKAction scaleXTo:1.4 duration:0.1]];
            [firstOne runAction:[SKAction scaleYTo:1.2 duration:0.3]];
            
            
                
                for (ArrowWithEmitter *pointHit in spriteFromPoint2) {
                    
                    if (CGRectContainsPoint(pointHit.frame, currentPoint)) {
                        if ([currentLetter.name isEqualToString:@"A"]) {
                            SKSpriteNode *letterAsegToFade = [[SKSpriteNode alloc]init];
                            
                            if (totalCountOfSprites < [letterSegments count]) {
                                letterAsegToFade = [letterSegments objectAtIndex:[letterSegments count]-totalCountOfSprites];
                                [letterAsegToFade runAction:removeSprite];
                            }
                        } else if ([currentLetter.name isEqualToString:@"B"]) {
                            SKSpriteNode *letterBsegToFade = [[SKSpriteNode alloc]init];
                            
                            if (totalCountOfSprites < [letterSegments count]) {
                                letterBsegToFade = [letterSegments objectAtIndex:[letterSegments count]-totalCountOfSprites];
                                [letterBsegToFade runAction:removeSprite];
                            }
                        } else if ([currentLetter.name isEqualToString:@"C"]) {
                            SKSpriteNode *letterCsegToFade = [[SKSpriteNode alloc]init];
                            
                            if (totalCountOfSprites < [letterSegments count]) {
                                letterCsegToFade = [letterSegments objectAtIndex:[letterSegments count]-totalCountOfSprites];
                                [letterCsegToFade runAction:removeSprite];
                            }
                        } else if ([currentLetter.name isEqualToString:@"M"]) {
                            SKSpriteNode *letterMsegToFade = [[SKSpriteNode alloc]init];
                            
                            if (totalCountOfSprites < [letterSegments count]) {
                                letterMsegToFade = [letterSegments objectAtIndex:[letterSegments count]-totalCountOfSprites];
                                [letterMsegToFade runAction:removeSprite];
                            }
                        }

 
                        if (secondSpritePointCount == [spriteFromPoint2 count]) {
                            ArrowWithEmitter *lastSprite = [spriteFromPoint2 lastObject];
                            [lastSprite removeFromParent];

                            
                        } else {
                            if (secondSpritePointCount + 1 < [spriteFromPoint2 count]) {
                                
                                ArrowWithEmitter *nextOne = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+1];
                                SKAction *moveToNext = [SKAction moveTo:nextOne.position duration:0.2];
                                SKAction *sequenceFirstArrow = [SKAction sequence:@[lightUp,scaleUp1,scaleDown,[SKAction removeFromParent]]];
                                [pointHit runAction:sequenceFirstArrow];
                                [pointHit runAction:moveToNext];
                                
                                if(ARROW_EMITTERS) {
                                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                                    [self addChild:openEffect];
                                    openEffect.position = nextOne.position;
                                }
                            }
                            
                            
                        }

                        if (secondSpritePointCount+1 < [spriteFromPoint2 count]) {
                            
                            ArrowWithEmitter *nextTwo = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 1];
                            [nextTwo runAction:sequenceActions2];
                            
                            //[self createEffectForArrow:nextTwo valueForColor:2.8];
                            
                            if(ARROW_EMITTERS) {
                                NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                                SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                                [self addChild:openEffect];
                                openEffect.position = nextTwo.position;
                            }
                            
                            if (secondSpritePointCount+2 < [spriteFromPoint2 count]){
                                ArrowWithEmitter *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+2];
                                CGPoint nextPos = nextSprite.position;
                                SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.2];
                                SKAction *removeTheArrow = [SKAction removeFromParent];
                                SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                                //[nextTwo runAction:moveToNextArrow];
                                [nextTwo runAction:sequenceArrow];
                            }
                        }
                        
                        if (secondSpritePointCount+2 < [spriteFromPoint2 count]) {
                            
                            ArrowWithEmitter *nextTwo = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 2];
                            [nextTwo runAction:sequenceActions2];
                            
                            //[self createEffectForArrow:nextTwo valueForColor:2.8];
                            if(ARROW_EMITTERS) {
                                NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                                SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                                [self addChild:openEffect];
                                openEffect.position = nextTwo.position;
                            }
                            if (secondSpritePointCount+3 < [spriteFromPoint2 count]){
                                ArrowWithEmitter *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+3];
                                CGPoint nextPos = nextSprite.position;
                                SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.5];
                                SKAction *removeTheArrow = [SKAction removeFromParent];
                                SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                                //[nextTwo runAction:moveToNextArrow];
                                [nextTwo runAction:sequenceArrow];
                            }
                        }
                        
                        if (secondSpritePointCount + 3 < [spriteFromPoint2 count]) {
                            ArrowWithEmitter *nextThree = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 3];
                            [nextThree runAction:sequenceActions3];
                            //[self createEffectForArrow:nextThree valueForColor:1.8];
                            if(ARROW_EMITTERS) {
                                NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                                SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                                [self addChild:openEffect];
                                openEffect.position = nextThree.position;
                            }

                            if (secondSpritePointCount+4 < [spriteFromPoint2 count]){
                                ArrowWithEmitter *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+4];
                                CGPoint nextPos = nextSprite.position;
                                SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.7];
                                SKAction *removeTheArrow = [SKAction removeFromParent];
                                SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                                //[nextThree runAction:moveToNextArrow];
                                [nextThree runAction:sequenceArrow];
                            }
                        }
                            
                        /*    if (secondSpritePointCount+4 < [spriteFromPoint2 count]){
                                SKSpriteNode *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+4];
                                CGPoint nextPos = nextSprite.position;
                                SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.5];
                                SKAction *removeTheArrow = [SKAction removeFromParent];
                                SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                                //[nextFour runAction:moveToNextArrow];
                                [nextFour runAction:sequenceArrow];
                        }*/
                        
                       
                    }
                    secondSpritePointCount++;
                    totalCountOfSprites++;
                    pointIndexArray++;
                }
            
        } else if (separateStroke && multiStroke && firstStrokeComplete) {

            int secondSpritePointCount = 0;
            int totalCountOfSprites = onWhichPoint + secondSpritePointCount;
            ArrowWithEmitter *firstOne = [spriteFromPoint2 objectAtIndex:0];
            firstOne.alpha = 1.0;
            [firstOne runAction:[SKAction scaleXTo:1.4 duration:0.1]];
            [firstOne runAction:[SKAction scaleYTo:1.2 duration:0.3]];
            
            for (ArrowWithEmitter *pointHit in spriteFromPoint2) {
                if (CGRectContainsPoint(pointHit.frame, currentPoint)) {
                    if (secondSpritePointCount+1 == [spriteFromPoint2 count]) {
                        separateStroke = FALSE;
                        [pointHit removeFromParent];
                    }
                    if (secondSpritePointCount+1 < [spriteFromPoint2 count]) {
                        [pointHit removeFromParent];
                        separateStroke = FALSE;
                        CGPoint nextPos;
                        if (secondSpritePointCount-1 == [spriteFromPoint2 count]) {
                            [pointHit removeFromParent];
                        }/* else if (secondSpritePointCount + 1 < [spriteFromPoint2 count]) {
                            ArrowWithEmitter *nextSprite = [spriteFromPoint2 objectAtIndex:onWhichPoint+1];
                            nextPos = nextSprite.position;
                            nextSprite.alpha = 1.0;
                            SKAction *remove = [SKAction removeFromParent];
                            SKTMoveEffect *moveHitArrow = [SKTMoveEffect effectWithNode:pointHit
                                                                               duration:0.8
                                                                          startPosition:currentPoint
                                                                            endPosition:nextPos];
                            moveHitArrow.timingFunction = SKTTimingFunctionSmoothstep;
                            SKAction *actionWithEffectForHitArrow = [SKAction actionWithEffect:moveHitArrow];
                            SKAction *sequenceActionPointHit = [SKAction sequence:@[actionWithEffectForHitArrow,lightUp,remove]];
                            [pointHit runAction:sequenceActionPointHit];
                        } else if (secondSpritePointCount <= [spriteFromPoint2 count]) {
                            
                            ArrowWithEmitter *nextSprite = [spriteFromPoint2 objectAtIndex:onWhichPoint+1];
                            nextPos = nextSprite.position;
                            SKAction *remove = [SKAction removeFromParent];
                            SKTMoveEffect *moveHitArrow = [SKTMoveEffect effectWithNode:pointHit
                                                                               duration:0.8
                                                                          startPosition:currentPoint
                                                                            endPosition:nextPos];
                            moveHitArrow.timingFunction = SKTTimingFunctionSmoothstep;
                            SKAction *actionWithEffectForHitArrow = [SKAction actionWithEffect:moveHitArrow];
                            SKAction *sequenceActionPointHit = [SKAction sequence:@[actionWithEffectForHitArrow,remove]];
                            [pointHit runAction:sequenceActionPointHit];
                        }*/
                        secondSpritePointCount++;
                        totalCountOfSprites++;
                        
                    }
                    
                }
            
            }
   
        }
    }
        
    }

    if (deltaPoint.x > 0 || deltaPoint.x < 0 || deltaPoint.y > 0 || deltaPoint.y < 0) {
        //[self letterShapeNode:currentPoint];
        
    }
    
}


static inline CGFloat RandomRange(CGFloat min,
                                  CGFloat max)
{
    return ((double)arc4random() / ARC4RANDOM_MAX) * (max - min) + min;
}

-(void) removeSpriteFromScene {

    SKSpriteNode *currentLetterFinish = [allLettersSprites objectAtIndex:onWhichQuestion];
    [currentLetterFinish removeFromParent];
    
}


-(void) createLetterA {

    float beginx = 660;
    float beginy = 450;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx-100, beginy+60);
    CGPoint letterAvalue2 = CGPointMake(beginx - 200, beginy + 55);
    CGPoint letterAvalue3 = CGPointMake(beginx - 242, beginy - 20);
    CGPoint letterAvalue4 = CGPointMake(beginx - 245, beginy - 125);
    CGPoint letterAvalue5 = CGPointMake(beginx - 150, beginy - 160);
    CGPoint letterAvalue6 = CGPointMake(beginx - 80, beginy - 110);
    CGPoint letterAvalue7 = CGPointMake(beginx-80, beginy - 70);
    CGPoint letterAvalue8 = CGPointMake(beginx-80, beginy + 30);
    CGPoint letterAvalue9 = CGPointMake(beginx-50, beginy - 50);
    CGPoint letterAvalue10 = CGPointMake(beginx-50, beginy - 50);
    CGPoint letterAvalue11 = CGPointMake(beginx-50, beginy - 120);
    
    letterSegments = [[NSMutableArray alloc]init];
    /*[letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_17.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_16.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_15.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_13.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_12.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_11.png"]];*/
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_10.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_9.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_8.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_7.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_6.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_5.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_4.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_3.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_2.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_1.png"]];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"left" forKey:@"0"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down-left" forKey:@"1"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-right" forKey:@"3"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"right" forKey:@"4"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"right" forKey:@"5"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up-left" forKey:@"6"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"down" forKey:@"8"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"down" forKey:@"9"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down" forKey:@"10"];

    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y,
                          letterAvalue3.x,letterAvalue3.y,
                          letterAvalue5.x, letterAvalue5.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue5.x, letterAvalue5.y,
                          letterAvalue7.x, letterAvalue7.y,
                          letterAvalue9.x, letterAvalue9.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue9.x, letterAvalue9.y,
                          letterAvalue10.x, letterAvalue10.y,
                          letterAvalue11.x, letterAvalue11.y);

}



-(void) createLetterB {

    float beginx = 410;
    float beginy = 720;
    
    letterBeginX  = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy-25);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-85);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-135);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-235);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-285);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-385);
    
    // Second stroke
    CGPoint letterAvalue7 = CGPointMake(beginx + 10, beginy - 425);
    CGPoint letterAvalue8 = CGPointMake(beginx+ 10, beginy - 350);
    CGPoint letterAvalue9 = CGPointMake(beginx+ 10, beginy - 270);
    CGPoint letterAvalue10 = CGPointMake(beginx+ 40, beginy - 200);
    CGPoint letterAvalue11 = CGPointMake(beginx+ 80, beginy - 180);
    CGPoint letterAvalue12 = CGPointMake(beginx+ 140, beginy - 180);
    CGPoint letterAvalue13 = CGPointMake(beginx+ 180, beginy - 260);
    CGPoint letterAvalue14 = CGPointMake(beginx+ 180, beginy - 320);
    CGPoint letterAvalue15 = CGPointMake(beginx+ 150, beginy - 420);
    CGPoint letterAvalue16 = CGPointMake(beginx+ 110, beginy - 430);

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up" forKey:@"8"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up-right" forKey:@"9"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"right" forKey:@"10"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"right" forKey:@"11"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down-right" forKey:@"12"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down" forKey:@"13"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"down-left" forKey:@"14"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:@"left" forKey:@"15"];
    
    
    letterSegments = [[NSMutableArray alloc]init];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_16.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_15.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_14.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_13.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_12.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_11.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_10.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_9.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_8.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_7.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_6.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_5.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_4.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_3.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_2.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"b_1.png"]];

    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y,
                          letterAvalue3.x,letterAvalue3.y,
                          letterAvalue6.x, letterAvalue6.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y,
                          letterAvalue11.x, letterAvalue11.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue11.x, letterAvalue11.y,
                          letterAvalue14.x, letterAvalue14.y,
                          letterAvalue16.x, letterAvalue16.y);
}

-(void) createLetterC {

    float beginx = 590;
    float beginy = 460;
    
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx-40, beginy+60);
    CGPoint letterAvalue3 = CGPointMake(beginx-110, beginy+40);
    CGPoint letterAvalue4 = CGPointMake(beginx-160, beginy-20);
    CGPoint letterAvalue5 = CGPointMake(beginx-160, beginy-70);
    CGPoint letterAvalue6 = CGPointMake(beginx-155, beginy-130);
    CGPoint letterAvalue7 = CGPointMake(beginx-120, beginy-170);
    CGPoint letterAvalue8 = CGPointMake(beginx-60, beginy-180);
    CGPoint letterAvalue9 = CGPointMake(beginx-10, beginy - 160);

    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y,
                          letterAvalue2.x,letterAvalue2.y,
                          letterAvalue4.x, letterAvalue4.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue4.x, letterAvalue4.y,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue7.x, letterAvalue7.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue7.x, letterAvalue7.y,
                          letterAvalue8.x, letterAvalue8.y,
                          letterAvalue9.x, letterAvalue9.y);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"up-left" forKey:@"0"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"left" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-left" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down-right" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"right" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up-right" forKey:@"8"];
    
    letterSegments = [[NSMutableArray alloc]init];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_9.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_8.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_7.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_6.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_5.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_4.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_3.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_2.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"c_1.png"]];

}

-(void) createLetterD {
    float beginx = 540;
    float beginy = 700;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-390);
    
    
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-410);
    CGPoint letterAvalue7 = CGPointMake(beginx-10, beginy-310);
    CGPoint letterAvalue8 = CGPointMake(beginx-10, beginy-220);
    CGPoint letterAvalue9 = CGPointMake(beginx-50, beginy-190);
    CGPoint letterAvalue10 = CGPointMake(beginx-100, beginy-170);
    CGPoint letterAvalue11 = CGPointMake(beginx-170, beginy-230);
    CGPoint letterAvalue12 = CGPointMake(beginx-180, beginy-290);
    CGPoint letterAvalue13 = CGPointMake(beginx-170, beginy-360);
    CGPoint letterAvalue14 = CGPointMake(beginx-120, beginy-400);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue3.x,letterAvalue3.y-40,
                          letterAvalue5.x, letterAvalue5.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue5.x, letterAvalue5.y,
                          letterAvalue9.x, letterAvalue9.y,
                          letterAvalue11.x, letterAvalue11.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,letterAvalue11.x, letterAvalue11.y,
                          letterAvalue12.x-100, letterAvalue12.y-100,
                          letterAvalue14.x+100, letterAvalue14.y-100);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up" forKey:@"5"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up-left" forKey:@"8"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"left" forKey:@"9"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down-left" forKey:@"10"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down" forKey:@"11"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down-right" forKey:@"12"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"right" forKey:@"13"];
    
}

-(void) createLetterE {
    float beginx = 370;
    float beginy = 400;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = FALSE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);

    CGPoint letterAvalue2 = CGPointMake(beginx+90, beginy);

    CGPoint letterAvalue3 = CGPointMake(beginx+170, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx+140, beginy+90);
    CGPoint letterAvalue5 = CGPointMake(beginx+90, beginy+110);
    CGPoint letterAvalue6 = CGPointMake(beginx+20, beginy+70);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-80);
    CGPoint letterAvalue8 = CGPointMake(beginx+30, beginy-110);
    CGPoint letterAvalue9 = CGPointMake(beginx+80, beginy-120);
    CGPoint letterAvalue10 = CGPointMake(beginx+150, beginy-110);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue3.x+50,letterAvalue3.y-40,
                          letterAvalue5.x-50, letterAvalue5.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue5.x-50, letterAvalue5.y-40,
                          letterAvalue7.x-150, letterAvalue7.y-60,
                          letterAvalue10.x-40, letterAvalue10.y-100);

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"right" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"right" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"right" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"up-left" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"left" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down-left" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"down-right" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"right" forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up-right" forKey:@"9"];

}

-(void) createLetterF {
    float beginx = 440;
    float beginy = 630;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    separateStroke = TRUE;
    secondStroke = @"right";

    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx-40, beginy-50);
    CGPoint letterAvalue3 = CGPointMake(beginx-40, beginy-120);
    CGPoint letterAvalue4 = CGPointMake(beginx-40, beginy-190);
    CGPoint letterAvalue5 = CGPointMake(beginx-40, beginy-260);
    CGPoint letterAvalue6 = CGPointMake(beginx-40, beginy-310);
    CGPoint letterAvalue7 = CGPointMake(beginx-40, beginy-360);
    CGPoint letterAvalue8 = CGPointMake(beginx-120, beginy-120);
    CGPoint letterAvalue9 = CGPointMake(beginx-80, beginy-120);
    CGPoint letterAvalue10 = CGPointMake(beginx+40, beginy-120);

    
    /*cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue6.x+40, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x+40, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-30,
                          letterAvalue12.x, letterAvalue12.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down-left" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"right" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"right" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"right" forKey:@"9"];

}


-(void) createLetterG {
    
    float beginx = 500;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx-50, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx-100, beginy-15);
    CGPoint letterAvalue4 = CGPointMake(beginx-130, beginy-50);
    CGPoint letterAvalue5 = CGPointMake(beginx-140, beginy-100);
    CGPoint letterAvalue6 = CGPointMake(beginx-140, beginy-150);
    CGPoint letterAvalue7 = CGPointMake(beginx-130, beginy-215);
    CGPoint letterAvalue8 = CGPointMake(beginx-50, beginy-245);
    CGPoint letterAvalue9 = CGPointMake(beginx-10, beginy-235);
    CGPoint letterAvalue10 = CGPointMake(beginx+40, beginy-200);
    CGPoint letterAvalue11 = CGPointMake(beginx+40, beginy-150);
    CGPoint letterAvalue12 = CGPointMake(beginx+40, beginy-100);
    CGPoint letterAvalue13 = CGPointMake(beginx+40, beginy-50);
    
    
    // Second Line
    CGPoint letterAvalue14 = CGPointMake(beginx+50, beginy+10);
    CGPoint letterAvalue15 = CGPointMake(beginx+50, beginy-40);
    CGPoint letterAvalue16 = CGPointMake(beginx+50, beginy-90);
    CGPoint letterAvalue17 = CGPointMake(beginx+50, beginy-140);
    CGPoint letterAvalue18 = CGPointMake(beginx+50, beginy-190);
    CGPoint letterAvalue19 = CGPointMake(beginx+50, beginy-240);
    CGPoint letterAvalue20 = CGPointMake(beginx+50, beginy-290);
    
    CGPoint letterAvalue21 = CGPointMake(beginx+40, beginy-360);
    CGPoint letterAvalue22 = CGPointMake(beginx-10, beginy-430);
    CGPoint letterAvalue23 = CGPointMake(beginx-50, beginy-440);
    CGPoint letterAvalue24 = CGPointMake(beginx-120, beginy-400);
    
    
    
    
    /*cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue7.x, letterAvalue7.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue7.x, letterAvalue7.y,
                          letterAvalue9.x, letterAvalue9.y-30,
                          letterAvalue10.x, letterAvalue10.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue10.x, letterAvalue10.y-80,
                          letterAvalue12.x, letterAvalue12.y-80,
                          letterAvalue14.x, letterAvalue14.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue14.x, letterAvalue14.y-80,
                          letterAvalue16.x, letterAvalue16.y-80,
                          letterAvalue19.x, letterAvalue19.y-80);
    */
    
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"left" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"left" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-left" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-left" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down-right" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"right" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"right" forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up-right" forKey:@"9"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"up" forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"up" forKey:@"11"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"up" forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down" forKey:@"13"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"down" forKey:@"14"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:@"down" forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:@"down" forKey:@"16"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:@"down" forKey:@"17"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:@"down" forKey:@"18"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:@"down" forKey:@"19"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:@"down" forKey:@"20"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:@"down-left" forKey:@"21"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:@"left" forKey:@"22"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:@"up-left" forKey:@"23"];
}

-(void) createLetterH {
    
    float beginx = 400;
    float beginy = 670;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-400);
    
    // second point
    CGPoint letterAvalue6 = CGPointMake(beginx+10, beginy-400);
    CGPoint letterAvalue7 = CGPointMake(beginx+10, beginy-350);
    CGPoint letterAvalue8 = CGPointMake(beginx+10, beginy-270);
    CGPoint letterAvalue9 = CGPointMake(beginx+50, beginy-200);
    CGPoint letterAvalue10 = CGPointMake(beginx+90, beginy-170);
    CGPoint letterAvalue11 = CGPointMake(beginx+160, beginy-180);
    CGPoint letterAvalue12 = CGPointMake(beginx+180, beginy-250);
    CGPoint letterAvalue13 = CGPointMake(beginx+190, beginy-290);
    CGPoint letterAvalue14 = CGPointMake(beginx+190, beginy-350);
    CGPoint letterAvalue15 = CGPointMake(beginx+190, beginy-400);

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up" forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up-right" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"right" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down-right" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down" forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down" forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"down" forKey:@"14"];
    
    
}

-(void) createLetterI {
    
    float beginx = 510;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    separateStroke = TRUE;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-230);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy+100);
    
    /*cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue8.x+40, letterAvalue8.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x+40, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-30,
                          letterAvalue12.x, letterAvalue12.y-80);*/
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"right" forKey:@"6"];

}

-(void) createLetterJ {
    float beginx = 480;
    float beginy = 580;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    separateStroke = TRUE;
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy-70);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-120);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-170);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-220);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-270);
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-350);
    CGPoint letterAvalue7 = CGPointMake(beginx-40, beginy-380);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy+20);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue8.x+40, letterAvalue8.y-40);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue6.x+40, letterAvalue6.y,
     letterAvalue9.x, letterAvalue9.y-30,
     letterAvalue12.x, letterAvalue12.y-80);*/
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down-left" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down-left" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"right" forKey:@"7"];
    
}

-(void) createLetterK {
    float beginx = 360;
    float beginy = 690;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-250);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-350);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-400);
    
    //second line
    CGPoint letterAvalue10 = CGPointMake(beginx+10, beginy-380);
    CGPoint letterAvalue11 = CGPointMake(beginx+10, beginy-330);
    CGPoint letterAvalue12 = CGPointMake(beginx+70, beginy-250);
    CGPoint letterAvalue13 = CGPointMake(beginx+180, beginy-200);
    CGPoint letterAvalue14 = CGPointMake(beginx+150, beginy-300);
    CGPoint letterAvalue15 = CGPointMake(beginx+160, beginy-200);
    CGPoint letterAvalue16 = CGPointMake(beginx+250, beginy-410);
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"down" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"down" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"up" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"up-right" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"up-right" forKey:@"12"];
    
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down-left" forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"right" forKey:@"14"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:@"right" forKey:@"15"];
}

-(void) createLetterL {
    float beginx = 505;
    float beginy = 680;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = FALSE;
    separateStroke = FALSE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-400);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-440);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    
   
}

-(void) createLetterM {
    
    float beginx = 320;
    float beginy = 550;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke  = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy-30);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-210);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-270);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-310);
    
    // Line 2
    CGPoint letterAvalue6 = CGPointMake(beginx+10, beginy-275);
    CGPoint letterAvalue7 = CGPointMake(beginx+10, beginy-225);
    CGPoint letterAvalue8 = CGPointMake(beginx+10, beginy-175);
    CGPoint letterAvalue9 = CGPointMake(beginx+10, beginy-125);
    CGPoint letterAvalue10 = CGPointMake(beginx+45, beginy-70);
    CGPoint letterAvalue11 = CGPointMake(beginx+90, beginy-50);
    CGPoint letterAvalue12 = CGPointMake(beginx+140, beginy-70);
    CGPoint letterAvalue13 = CGPointMake(beginx+175, beginy-170);
    CGPoint letterAvalue14 = CGPointMake(beginx+175, beginy-275);
    CGPoint letterAvalue15 = CGPointMake(beginx+190, beginy-275);
    CGPoint letterAvalue16 = CGPointMake(beginx+190, beginy-220);
    CGPoint letterAvalue17 = CGPointMake(beginx+190, beginy-170);
    CGPoint letterAvalue18 = CGPointMake(beginx+230, beginy-80);
    CGPoint letterAvalue19 = CGPointMake(beginx+270, beginy-50);
    CGPoint letterAvalue20 = CGPointMake(beginx+340, beginy-80);
    CGPoint letterAvalue21 = CGPointMake(beginx+350, beginy-150);
    CGPoint letterAvalue22 = CGPointMake(beginx+350, beginy-210);
    CGPoint letterAvalue23 = CGPointMake(beginx+350, beginy-270);
    
    letterSegments = [[NSMutableArray alloc]init];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_21.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_20.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_19.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_18.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_17.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_16.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_15.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_14.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_13.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_12.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_11.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_9.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_10.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_8.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_7.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_6.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_5.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_4.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_3.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_2.png"]];
    [letterSegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"m_1.png"]];

    /*cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue9.x,letterAvalue9.y-40,
                          letterAvalue10.x, letterAvalue10.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue10.x, letterAvalue10.y-40,
                          letterAvalue12.x, letterAvalue12.y-40,
                          letterAvalue14.x, letterAvalue14.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue14.x+20, letterAvalue14.y-40,
                          letterAvalue15.x+20, letterAvalue15.y-40,
                          letterAvalue17.x+20, letterAvalue17.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue17.x+20, letterAvalue17.y-80,
                          letterAvalue20.x+20, letterAvalue20.y-80,
                          letterAvalue24.x+20, letterAvalue24.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue24.x+80, letterAvalue24.y-80,
                          letterAvalue25.x+80, letterAvalue25.y-80,
                          letterAvalue29.x+80, letterAvalue29.y-80);
     */

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down"  forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down"  forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down"  forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up"  forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
   
    // Line 2
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up-right" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"right" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down-right" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down" forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down" forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"up" forKey:@"14"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:@"up" forKey:@"15"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:@"up" forKey:@"16"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:@"up-right" forKey:@"17"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:@"right" forKey:@"18"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:@"down-right" forKey:@"19"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:@"down" forKey:@"20"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:@"down" forKey:@"21"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:@"down" forKey:@"22"];

    

    /*[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    [arrowObjects setObject:@"right" forKey:@"24"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue28]];
    [arrowObjects setObject:@"right" forKey:@"25"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue29]];
    [arrowObjects setObject:@"right" forKey:@"26"];*/

 
}

-(void) createLetterN {
    float beginx = 400;
    float beginy = 560;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy - 100);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy - 200);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy - 300);
    CGPoint letterAvalue5 = CGPointMake(beginx+20, beginy-240);
    CGPoint letterAvalue6 = CGPointMake(beginx+20, beginy-140);
    CGPoint letterAvalue7 = CGPointMake(beginx+20, beginy-60);
    CGPoint letterAvalue8 = CGPointMake(beginx+80, beginy-30);
    CGPoint letterAvalue9 = CGPointMake(beginx+140, beginy-20);
    CGPoint letterAvalue10 = CGPointMake(beginx+180, beginy-80);
    CGPoint letterAvalue11 = CGPointMake(beginx+190, beginy-150);
    CGPoint letterAvalue12 = CGPointMake(beginx+190, beginy-230);
    CGPoint letterAvalue13 = CGPointMake(beginx+190, beginy-280);

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"up" forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up" forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up-right" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"right" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"down-right" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down" forKey:@"12"];
    
  }

-(void) createLetterO {
 
    secondStroke = @"up";
    
    float beginx = 480;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = FALSE;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy+10);
    CGPoint letterAvalue2 = CGPointMake(beginx-60, beginy-30);
    CGPoint letterAvalue3 = CGPointMake(beginx-80, beginy-80);
    CGPoint letterAvalue4 = CGPointMake(beginx-80, beginy-140);
    CGPoint letterAvalue5 = CGPointMake(beginx-40, beginy-220);
    CGPoint letterAvalue6 = CGPointMake(beginx+50, beginy-210);
    CGPoint letterAvalue7 = CGPointMake(beginx+100, beginy-130);
    CGPoint letterAvalue8 = CGPointMake(beginx+100, beginy-60);
    CGPoint letterAvalue9 = CGPointMake(beginx+80, beginy-20);

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"left" forKey:@"0"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down-left" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down-right" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up-right" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up-left" forKey:@"8"];
    
}

-(void) createLetterP {
    float beginx = 400;
    float beginy = 550;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-400);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-450);
    
    // second point

    CGPoint letterAvalue7 = CGPointMake(beginx+20, beginy-470);
    CGPoint letterAvalue8 = CGPointMake(beginx+20, beginy-370);
    CGPoint letterAvalue9 = CGPointMake(beginx+20, beginy-270);
    CGPoint letterAvalue10 = CGPointMake(beginx+20, beginy-170);
    CGPoint letterAvalue11 = CGPointMake(beginx+50, beginy-60);


    CGPoint letterAvalue12 = CGPointMake(beginx+100, beginy-30);
    CGPoint letterAvalue13 = CGPointMake(beginx+170, beginy-50);
    CGPoint letterAvalue14 = CGPointMake(beginx+190, beginy-100);
    CGPoint letterAvalue15 = CGPointMake(beginx+190, beginy-150);
    CGPoint letterAvalue16 = CGPointMake(beginx+190, beginy-200);
    CGPoint letterAvalue17 = CGPointMake(beginx+150, beginy-250);
    CGPoint letterAvalue18 = CGPointMake(beginx+100, beginy-260);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y,
                          letterAvalue3.x,letterAvalue3.y,
                          letterAvalue6.x, letterAvalue6.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y,
                          letterAvalue11.x, letterAvalue11.y);
    
    CGPathAddCurveToPoint(cgpath, NULL, letterAvalue11.x, letterAvalue11.y,
                          letterAvalue14.x, letterAvalue14.y,
                          letterAvalue18.x, letterAvalue18.y);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"up-right" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"right" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"right" forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down-right" forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"down" forKey:@"14"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:@"down" forKey:@"15"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:@"down-left" forKey:@"16"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:@"left" forKey:@"17"];
    
    

    
    
}

-(void) createLetterQ {
    float beginx = 490;
    float beginy = 480;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx-30, beginy+20);
    CGPoint letterAvalue2 = CGPointMake(beginx-90, beginy+45);
    CGPoint letterAvalue3 = CGPointMake(beginx-160, beginy-60);
    CGPoint letterAvalue4 = CGPointMake(beginx-150, beginy-140);
    CGPoint letterAvalue5 = CGPointMake(beginx-120, beginy-180);
    CGPoint letterAvalue6 = CGPointMake(beginx-60, beginy-190);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy - 100);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy - 50);
    
    //second line
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue10 = CGPointMake(beginx+10, beginy - 100);
    CGPoint letterAvalue11 = CGPointMake(beginx+10, beginy - 200);
    CGPoint letterAvalue12 = CGPointMake(beginx+10, beginy - 300);
    CGPoint letterAvalue13 = CGPointMake(beginx+50, beginy - 400);
    
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"left" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"left" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down-right" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"right" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"down" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"down" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down-right" forKey:@"12"];
    
    
}

-(void) createLetterR {
    float beginx = 540;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx-170, beginy+25);
    CGPoint letterAvalue2 = CGPointMake(beginx-170, beginy-20);
    CGPoint letterAvalue3 = CGPointMake(beginx-170, beginy-70);
    CGPoint letterAvalue4 = CGPointMake(beginx-170, beginy-120);
    CGPoint letterAvalue5 = CGPointMake(beginx-170, beginy-170);
    CGPoint letterAvalue6 = CGPointMake(beginx-170, beginy-220);
    
    //second line
    CGPoint letterAvalue7 = CGPointMake(beginx-160, beginy-220);
    CGPoint letterAvalue8 = CGPointMake(beginx-160, beginy-170);
    CGPoint letterAvalue9 = CGPointMake(beginx-160, beginy-120);
    CGPoint letterAvalue10 = CGPointMake(beginx-160, beginy-70);
    CGPoint letterAvalue11 = CGPointMake(beginx-160, beginy-20);
    CGPoint letterAvalue12 = CGPointMake(beginx-120, beginy);
    CGPoint letterAvalue13 = CGPointMake(beginx-90, beginy+20);
    CGPoint letterAvalue14 = CGPointMake(beginx-40, beginy+25);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue6.x+40, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x+40, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-30,
                          letterAvalue12.x, letterAvalue12.y-80);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down"  forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down"  forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down"  forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up"  forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up"  forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"up" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"right" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"right" forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"right" forKey:@"13"];

    
}

-(void) createLetterS {
    
    float beginx = 580;
    float beginy = 480;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = FALSE;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx-90, beginy+20);
    CGPoint letterAvalue3 = CGPointMake(beginx-155, beginy-30);
    CGPoint letterAvalue4 = CGPointMake(beginx-110, beginy-85);
    CGPoint letterAvalue5 = CGPointMake(beginx-60, beginy-100);
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-150);
    CGPoint letterAvalue7 = CGPointMake(beginx-65, beginy-210);
    CGPoint letterAvalue8 = CGPointMake(beginx-155, beginy-180);

    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue2.x+40,letterAvalue2.y-40,
                          letterAvalue3.x+40, letterAvalue3.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue3.x+40, letterAvalue3.y-40,
                          letterAvalue4.x+40, letterAvalue4.y-40,
                          letterAvalue5.x+40, letterAvalue5.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue5.x+40, letterAvalue5.y-80,
                          letterAvalue6.x+40, letterAvalue6.y-80,
                          letterAvalue7.x+40, letterAvalue7.y-80);
    

    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"up-left" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"left" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-right" forKey:@"3"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"right" forKey:@"4"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down-right" forKey:@"5"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"left" forKey:@"6"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up-left" forKey:@"7"];

}

-(void) createLetterT {
    
    float beginx = 490;
    float beginy = 560;
    letterBeginX = beginx;
    letterBeginY = beginy;
    separateStroke = TRUE;
    multiStroke = TRUE;
    secondStroke = @"right";
    
    CGPoint letterAvalue1 = CGPointMake(beginx-10, beginy+40);
    CGPoint letterAvalue2 = CGPointMake(beginx-10, beginy-35);
    CGPoint letterAvalue3 = CGPointMake(beginx-10, beginy-80);
    CGPoint letterAvalue4 = CGPointMake(beginx-10, beginy-125);
    CGPoint letterAvalue5 = CGPointMake(beginx-10, beginy-180);
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-225);
    CGPoint letterAvalue7 = CGPointMake(beginx+20, beginy-270);
    CGPoint letterAvalue8 = CGPointMake(beginx+50, beginy-310);
    CGPoint letterAvalue9 = CGPointMake(beginx-50, beginy-50);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue11 = CGPointMake(beginx+50, beginy-50);

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down" forKey:@"2"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down" forKey:@"3"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down" forKey:@"4"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down" forKey:@"5"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down" forKey:@"6"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"down-right" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"right" forKey:@"8"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"right" forKey:@"9"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"right" forKey:@"10"];
    
}

-(void) createLetterU {
    float beginx = 470;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-170);
    CGPoint letterAvalue4 = CGPointMake(beginx+100, beginy-210);
    CGPoint letterAvalue5 = CGPointMake(beginx+140, beginy-200);
    CGPoint letterAvalue6 = CGPointMake(beginx+180, beginy-180);
    CGPoint letterAvalue7 = CGPointMake(beginx+180, beginy-120);
    CGPoint letterAvalue8 = CGPointMake(beginx+180, beginy - 70);
    CGPoint letterAvalue9 = CGPointMake(beginx+180, beginy - 10);
    CGPoint letterAvalue10 = CGPointMake(beginx+180, beginy+40);
    CGPoint letterAvalue11 = CGPointMake(beginx+180, beginy - 50);
    CGPoint letterAvalue12 = CGPointMake(beginx+180, beginy - 100);
    CGPoint letterAvalue13 = CGPointMake(beginx+ 180, beginy - 220);
    
    /*cgpath = CGPathCreateMutable();
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-right"  forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"right"  forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"up-right" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up" forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"up" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down" forKey:@"12"];
    
    
}

-(void) createLetterV {
    float beginx = 470;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx+10, beginy-50);
    CGPoint letterAvalue3 = CGPointMake(beginx+20, beginy-100);
    CGPoint letterAvalue4 = CGPointMake(beginx+70, beginy-150);
    CGPoint letterAvalue5 = CGPointMake(beginx+80, beginy-200);
    CGPoint letterAvalue6 = CGPointMake(beginx+100, beginy-150);
    CGPoint letterAvalue7 = CGPointMake(beginx+120, beginy-100);
    CGPoint letterAvalue8 = CGPointMake(beginx+140, beginy-50);
    CGPoint letterAvalue9 = CGPointMake(beginx+160, beginy);
    

    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down-right" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down-right" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-right" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-right" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"up-right" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up-right" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up-right" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up-right" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up-right" forKey:@"8"];
}

-(void) createLetterW {
    float beginx = 380;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx+10, beginy-50);
    CGPoint letterAvalue3 = CGPointMake(beginx+30, beginy-100);
    CGPoint letterAvalue4 = CGPointMake(beginx+70, beginy-150);
    CGPoint letterAvalue5 = CGPointMake(beginx+90, beginy-200);
    CGPoint letterAvalue6 = CGPointMake(beginx+120, beginy-150);
    CGPoint letterAvalue7 = CGPointMake(beginx+140, beginy-100);
    CGPoint letterAvalue8 = CGPointMake(beginx+160, beginy-50);
    CGPoint letterAvalue9 = CGPointMake(beginx+180, beginy);
    
    
    
    CGPoint letterAvalue10 = CGPointMake(beginx+200, beginy-50);
    CGPoint letterAvalue11 = CGPointMake(beginx+210, beginy-100);
    CGPoint letterAvalue12 = CGPointMake(beginx+230, beginy-150);
    CGPoint letterAvalue13 = CGPointMake(beginx+270, beginy-200);
    CGPoint letterAvalue14 = CGPointMake(beginx+280, beginy-230);
    CGPoint letterAvalue15 = CGPointMake(beginx+300, beginy-150);
    CGPoint letterAvalue16 = CGPointMake(beginx+320, beginy-100);
    CGPoint letterAvalue17 = CGPointMake(beginx+340, beginy-500);
    CGPoint letterAvalue18 = CGPointMake(beginx+360, beginy);
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down-right" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down-right" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-right" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-right" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"up-right" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up-right" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up-right" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up-right" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"up-right" forKey:@"8"];
    
    
   
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"down-right" forKey:@"9"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down-right" forKey:@"10"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"down-right" forKey:@"11"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down-right" forKey:@"12"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"up-right" forKey:@"13"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:@"up-right" forKey:@"14"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:@"up-right" forKey:@"15"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:@"up-right" forKey:@"16"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:@"up-right" forKey:@"17"];

    
}

-(void) createLetterX {
    float beginx = 360;
    float beginy = 520;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx+40, beginy-55);
    CGPoint letterAvalue3 = CGPointMake(beginx+110, beginy-140);
    CGPoint letterAvalue4 = CGPointMake(beginx+140, beginy-180);
    CGPoint letterAvalue5 = CGPointMake(beginx+190, beginy-240);
    CGPoint letterAvalue6 = CGPointMake(beginx+110, beginy-110);
    CGPoint letterAvalue7 = CGPointMake(beginx+200, beginy);
    CGPoint letterAvalue8 = CGPointMake(beginx+150, beginy-120);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-360);
    CGPoint letterAvalue11 = CGPointMake(beginx+240, beginy-10);
    CGPoint letterAvalue12 = CGPointMake(beginx+140, beginy-30);
    CGPoint letterAvalue13 = CGPointMake(beginx+80, beginy-150);
    CGPoint letterAvalue14 = CGPointMake(beginx, beginy-280);
    //CGPoint letterAvalue16 = CGPointMake(beginx+40, beginy-30);
    
    /*cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down-right" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down-right" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-right" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-right" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down-right" forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"up-left" forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"up-left" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"up-right" forKey:@"7"];
    
    /*[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"down-left" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"right" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"right" forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:@"right" forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:@"down-left" forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:@"down-left" forKey:@"13"];*/
    
}

-(void) createLetterY {
    float beginx = 370;
    float beginy = 540;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx+10, beginy-70);
    CGPoint letterAvalue3 = CGPointMake(beginx+40, beginy-135);
    CGPoint letterAvalue4 = CGPointMake(beginx+100, beginy-210);
    CGPoint letterAvalue5 = CGPointMake(beginx+140, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx+190, beginy-30);
    CGPoint letterAvalue7 = CGPointMake(beginx+110, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx+80, beginy-290);
    CGPoint letterAvalue9 = CGPointMake(beginx+70, beginy-340);
    CGPoint letterAvalue10 = CGPointMake(beginx+40, beginy- 400);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy - 450);
    
   
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"down-right" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"down-right" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-right" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"up-right" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"up-right" forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"down-left" forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"down-left" forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"down-left" forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"down-left" forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:@"down-left" forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:@"down-left" forKey:@"10"];
}

-(void) createLetterZ {
    float beginx = 370;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx+90, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx+170, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx+110, beginy-80);
    CGPoint letterAvalue5 = CGPointMake(beginx+60, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-240);
    CGPoint letterAvalue7 = CGPointMake(beginx+60, beginy-240);
    CGPoint letterAvalue8 = CGPointMake(beginx+120, beginy-240);
    CGPoint letterAvalue9 = CGPointMake(beginx+170, beginy - 240);


    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:@"right" forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:@"right" forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:@"down-left" forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:@"down-left" forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:@"down-left" forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:@"right" forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:@"right" forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:@"right" forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:@"right" forKey:@"8"];
    
}



//if (tapLetter.centerStage) {
/*if([tapLetter.name isEqualToString:@"A"]) {
 
 onWhichQuestion = 0;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 
 } else if ([tapLetter.name isEqualToString:@"B"]) {
 
 
 for (SKSpriteNode *letterAseg in letterAsegments) {
 [letterAseg removeFromParent];
 }
 
 onWhichQuestion = 1;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self createLetterB];
 [letterB playTheSound];
 [self moveLetterFromCenterStage:letterB centerPoint:CGPointMake(500, 400) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 
 } else if ([tapLetter.name isEqualToString:@"C"]) {
 
 onWhichQuestion = 2;
 [self createLetterC];
 [letterC playTheSound];
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterC centerPoint:CGPointMake(500, 380) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 
 } else if ([tapLetter.name isEqualToString:@"M"]) {
 
 onWhichQuestion = 3;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterM centerPoint:CGPointMake(500, 440) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 
 } else if ([tapLetter.name isEqualToString:@"S"]) {
 
 onWhichQuestion = 4;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterS centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 
 } else if ([tapLetter.name isEqualToString:@"T"]) {
 
 onWhichQuestion = 5;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterT centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"O"]) {
 
 onWhichQuestion = 6;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"G"]) {
 
 onWhichQuestion = 7;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"R"]) {
 
 onWhichQuestion = 8;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"D"]) {
 
 onWhichQuestion = 9;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"F"]) {
 
 onWhichQuestion = 10;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"I"]) {
 
 onWhichQuestion = 11;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"P"]) {
 
 onWhichQuestion = 12;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"N"]) {
 
 onWhichQuestion = 13;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"L"]) {
 
 onWhichQuestion = 14;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"H"]) {
 
 onWhichQuestion = 15;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"E"]) {
 
 onWhichQuestion = 16;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"Z"]) {
 
 onWhichQuestion = 17;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"X"]) {
 
 onWhichQuestion = 18;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"K"]) {
 
 onWhichQuestion = 19;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"Q"]) {
 
 onWhichQuestion = 20;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"U"]) {
 
 onWhichQuestion = 21;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"V"]) {
 
 onWhichQuestion = 22;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"W"]) {
 
 onWhichQuestion = 23;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"J"]) {
 
 onWhichQuestion = 24;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 } else if ([tapLetter.name isEqualToString:@"J"]) {
 
 onWhichQuestion = 25;
 LowerCaseLetter *letterToMove = [self currentLetter];
 [self moveLetterFromCenterStage:letterA centerPoint:CGPointMake(640, 485) letterOff:CGPointMake(100, 350) offStageLetter:letterToMove];
 [self addStrokeArrows];
 }*/

-(void) nextQuestion {
    
    pointsForSprite = [[NSMutableArray alloc]init];
    pointsForSprite2 = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    spriteFromPoint2 = [[NSMutableArray alloc]init];
    controlPoints = [[NSMutableArray alloc]init];
    arrowObjects = [[NSMutableDictionary alloc]init];
    pointsHit = [[NSMutableArray alloc]init];
    pointsHit2 = [[NSMutableArray alloc]init];
    
    multiStroke = FALSE;
    separateStroke = FALSE;
    firstStrokeComplete = FALSE;
    arrowAdded = FALSE;
    
    if (onWhichQuestion == 0) {  // Letter A

        //[self createLetterA];
        [letterA playTheSound];
        letterA.position = CGPointMake(500,400);
        [self createActionForCenterStage:letterA centerPoint:CGPointMake(500, 400) letterOff:CGPointMake(100, 170) offStageLetter:nil];
        
        for (SKSpriteNode *letterSeg in letterSegments) {
            [letterSeg setPosition:CGPointMake(500, 400)];
            [self addChild:letterSeg];
        }
        [self traceTutorial];
        
    }
    else if (onWhichQuestion == 1) { // Letter B

        for (SKSpriteNode *letterAseg in letterSegments) {
            [letterAseg removeFromParent];
        }
        
        [self createLetterB];
        [letterB playTheSound];
        [self createActionForCenterStage:letterB centerPoint:CGPointMake(500, 480) letterOff:CGPointMake(100, 170) offStageLetter:letterA];
        
        letterB.alpha = 0.0;
        
        
        for (SKSpriteNode *letterBseg in letterSegments) {
            
            [letterBseg setPosition:CGPointMake(500,480)];
            [self addChild:letterBseg];
        }
        //[self traceTutorial];
        
    }
    
    else if (onWhichQuestion == 2) { // Letter C
        
        for (SKSpriteNode *letterBseg in letterSegments) {
            [letterBseg removeFromParent];
        }
        
        [self createLetterC];
        [letterC playTheSound];
        letterC.alpha = 0.0;
        [self createActionForCenterStage:letterC centerPoint:CGPointMake(500, 400) letterOff:CGPointMake(100, 170) offStageLetter:letterB];
        
        for (SKSpriteNode *letterCseg in letterSegments) {
            
            [letterCseg setPosition:CGPointMake(500,400)];
            [self addChild:letterCseg];
        }
        
        //for (SKShapeNode *theShape in shapeNodeObjects) {
        //    [theShape removeFromParent];
        //}
        
        //[self traceTutorial];
    }
    
    else if (onWhichQuestion == 3) { // Letter M
        
        for (SKSpriteNode *letterCseg in letterSegments) {
            [letterCseg removeFromParent];
        }
        [self createLetterM];
        [letterM playTheSound];
        letterM.alpha = 0.0;
        [self createActionForCenterStage:letterM centerPoint:CGPointMake(500, 380) letterOff:CGPointMake(100, 220) offStageLetter:letterC];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
        
        for (SKSpriteNode *letterMseg in letterSegments) {
            
            [letterMseg setPosition:CGPointMake(500,380)];
            [self addChild:letterMseg];
        }
    }
    
    else if (onWhichQuestion == 4) { // Letter S
        for (SKSpriteNode *letterMseg in letterSegments) {
            [letterMseg removeFromParent];
        }
        [self createLetterS];
        [letterS playTheSound];
        [self createActionForCenterStage:letterS centerPoint:CGPointMake(500, 380) letterOff:CGPointMake(100, 270) offStageLetter:letterM];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
        
    } else if (onWhichQuestion == 5) { // Letter T
        
        
        self.userInteractionEnabled = NO;
        [self createLetterT];
        [letterT playTheSound];
        [self createActionForCenterStage:letterT centerPoint:CGPointMake(500, 440) letterOff:CGPointMake(100, 320) offStageLetter:letterS];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
        self.userInteractionEnabled = YES;
        
    } else if (onWhichQuestion == 6) { // letter O
        
        [self createLetterO];
        [letterO playTheSound];
        [self createActionForCenterStage:letterO centerPoint:CGPointMake(640, 440) letterOff:CGPointMake(100, 350) offStageLetter:letterT];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
        
    } else if (onWhichQuestion == 7) { // letter G
        
        [self createLetterG];
        [letterG playTheSound];
        [self createActionForCenterStage:letterG centerPoint:CGPointMake(600, 460) letterOff:CGPointMake(100, 370) offStageLetter:letterO];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        //[self traceTutorial];
        
    } else if (onWhichQuestion == 8) {  // letter R
        
        [self createLetterR];
        [letterR playTheSound];
        [self createActionForCenterStage:letterR centerPoint:CGPointMake(600, 490) letterOff:CGPointMake(100, 420) offStageLetter:letterG];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 9) { // letter D
        
        [self createLetterD];
        [letterD playTheSound];
        [self createActionForCenterStage:letterD centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterR];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 10) { // letter F
        
        [self createLetterF];
        [letterF playTheSound];
        [self createActionForCenterStage:letterF centerPoint:CGPointMake(550, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterD];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 11) { // letter I
        
        [self createLetterI];
        [letterI playTheSound];
        [self createActionForCenterStage:letterI centerPoint:CGPointMake(510, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterF];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 12) { // letter P
        
        [self createLetterP];
        [letterP playTheSound];
        [self createActionForCenterStage:letterP centerPoint:CGPointMake(650, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterI];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 13) { // letter N
        
        [self createLetterN];
        [letterN playTheSound];
        [self createActionForCenterStage:letterN centerPoint:CGPointMake(650, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterP];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 14) { // letter L
        
        [self createLetterL];
        [letterL playTheSound];
        [self createActionForCenterStage:letterL centerPoint:CGPointMake(650, 525) letterOff:CGPointMake(100, 350) offStageLetter:letterN];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 15) { // letter H
        [self createLetterH];
        [letterH playTheSound];
        [self createActionForCenterStage:letterH centerPoint:CGPointMake(650, 550) letterOff:CGPointMake(100, 350) offStageLetter:letterL];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 16) { // letter E
        
        [self createLetterE];
        [letterE playTheSound];
        [self createActionForCenterStage:letterE centerPoint:CGPointMake(600, 440) letterOff:CGPointMake(100, 350) offStageLetter:letterH];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 17) { // letter Z
        
        [self createLetterZ];
        [letterZ playTheSound];
        [self createActionForCenterStage:letterZ centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterE];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 18) { // letter X
        
        [self createLetterX];
        [letterX playTheSound];
        [self createActionForCenterStage:letterX centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterZ];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 19) { // letter K
        
        [self createLetterK];
        [letterK playTheSound];
        [self createActionForCenterStage:letterK centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterX];
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 20) { // letter Q
        
        [self createLetterQ];
        [letterQ playTheSound];
        [self createActionForCenterStage:letterQ centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterZ];
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 21) { // letter U
        
        [self createLetterU];
        [letterU playTheSound];
        [self createActionForCenterStage:letterU centerPoint:CGPointMake(550, 400) letterOff:CGPointMake(100, 350) offStageLetter:letterQ];
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 22) { // letter V
        
        [self createLetterV];
        [letterV playTheSound];
        [self createActionForCenterStage:letterV centerPoint:CGPointMake(550, 400) letterOff:CGPointMake(100, 350) offStageLetter:letterU];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 23) { // letter W
        
        [self createLetterW];
        [letterW playTheSound];
        [self createActionForCenterStage:letterW centerPoint:CGPointMake(550, 400) letterOff:CGPointMake(100, 350) offStageLetter:letterV];
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    } else if (onWhichQuestion == 24) { // letter J
        
        [self createLetterJ];
        [letterJ playTheSound];
        [self createActionForCenterStage:letterJ centerPoint:CGPointMake(600, 550) letterOff:CGPointMake(100, 350) offStageLetter:letterV];
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
    } else if (onWhichQuestion == 25) { // letter Y
        
        [self createLetterY];
        [letterY playTheSound];
        [self createActionForCenterStage:letterY centerPoint:CGPointMake(600, 450) letterOff:CGPointMake(100, 350) offStageLetter:letterV];
        
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        
    }
    
    
    [self addStrokeArrows];
    
}

@end
