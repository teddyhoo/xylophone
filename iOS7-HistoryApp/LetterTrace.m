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
#import "SKTUtils.h"
#import "SKTTimingFunctions.h"
#import "SKAction+SKTExtras.h"
#import "SKTTimingFunctions.h"
#import "SKTEffects.h"

#import "SmoothLineView.h"
#import "RedrawLetter.h"
#import "GroupLetterNode.h"

@implementation LetterTrace

#define DEFAULT_COLOR [UIColor redColor]
#define CORRECT_COLOR [UIColor redColor]
#define INCORRECT_COLOR [UIColor redColor]
#define DEFAULT_WIDTH 10.0f
#define DEFAULT_ALPHA 0.8f

#define SHOW_FIRST_ARROWS FALSE
#define SHOW_SECOND_ARROWS FALSE
#define ARROW_EMITTERS TRUE

MontessoriData *sharedData;

NSMutableArray *menuOptions;
NSMutableArray *letterProblems;
NSMutableArray *controlPointSprites;
NSMutableArray *pointsForSprite;
NSMutableArray *pointsForSprite2;
//NSMutableArray *spriteFromPoint;
NSMutableArray *controlPoints;
NSMutableArray *shapeNodeObjects;
NSMutableDictionary *arrowObjects;
NSMutableArray *traceThePath;
NSMutableArray *finishedLevelText;
//NSMutableArray *listOfTrailSprites;
NSMutableArray *timeToDrawLetter;
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

NSMutableArray *listOfTrailSprites;

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

GroupLetterNode *groupOneLettersNode;

SKSpriteNode *picForQuestion;



SKSpriteNode *backToMainMenuArrow;
SKSpriteNode *fingerTrace;
SKSpriteNode *handPointer;
SKLabelNode *timeDisplay;

int numberOfPoints;
int onWhichQuestion;
int onWhichGroup;

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


SmoothLineView *slv;


NSMutableArray *letterAsegments;

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


@synthesize background, selectedNode, timeForQuestion;


-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        sharedData = [MontessoriData sharedManager];
        
        letterAsegments = [[NSMutableArray alloc]init];

        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_17.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_16.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_15.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_13.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_12.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_11.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_10.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_09.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_08.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_07.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_06.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_05.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_04.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_03.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_02.png"]];
        [letterAsegments addObject:[SKSpriteNode spriteNodeWithImageNamed:@"a_dwn_01.png"]];

        //
        //
        // ACTIONS FOR GUIDING ARROWS
        //
        //
        
        lightUp = [SKAction fadeAlphaTo:1.0 duration:0.1];
        lightUp2 = [SKAction fadeAlphaTo:1.0 duration:0.2];
        lightUp3 = [SKAction fadeAlphaTo:1.0 duration:0.3];
        lightUp4 = [SKAction fadeAlphaTo:1.0 duration:0.4];
        
        scaleUp1 = [SKAction scaleTo:0.5 duration:0.1];
        scaleUp2 = [SKAction scaleTo:0.4 duration:0.2];
        scaleUp3 = [SKAction scaleTo:0.3 duration:0.3];
        scaleUp1.timingMode = SKActionTimingEaseOut;
        scaleUp2.timingMode = SKActionTimingEaseOut;
        scaleUp3.timingMode = SKActionTimingEaseOut;
        
        scaleDown = [SKAction scaleTo:0.4 duration:0.1];
        scaleDown2 = [SKAction scaleTo:0.2 duration:0.1];
        scaleDown3 = [SKAction scaleTo:0.2 duration:0.1];
        scaleDown.timingMode = SKActionTimingEaseIn;
        scaleDown.timingMode = SKActionTimingEaseIn;
        scaleDown.timingMode = SKActionTimingEaseIn;
        
        sequenceActions = [SKAction sequence:@[lightUp,scaleUp1,scaleDown]];
        sequenceActions2 = [SKAction sequence:@[lightUp2,scaleUp1]];
        sequenceActions3 = [SKAction sequence:@[lightUp3,scaleUp3]];
        
        removeSprite = [SKAction removeFromParent];
        

        //
        // ************************************

        width = self.size.width;
        height = self.size.height;
        
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
        
        shapeNodeObjects = [[NSMutableArray alloc]init];
        shapeNodeObjectForLetter = [[NSMutableDictionary alloc]init];
        
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        SKSpriteNode *gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_wood.jpg"];
        gridPaper.position = CGPointMake(size.width/2, size.height/2);
        [self addChild:gridPaper];
        
        letterA = sharedData.letterA;
        
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
        
        [groupOneLetters addObject:letterA];
        [groupOneLetters addObject:letterB];
        [groupOneLetters addObject:letterC];
        [groupOneLetters addObject:letterM];
        [groupOneLetters addObject:letterS];
        [groupOneLetters addObject:letterT];
        
        groupOneLettersNode = [GroupLetterNode node];
        [groupOneLettersNode initWithGroupID:@"first"];
        
        
        
        [groupTwoLetters addObject:letterO];
        [groupTwoLetters addObject:letterG];
        [groupTwoLetters addObject:letterR];
        [groupTwoLetters addObject:letterD];
        [groupTwoLetters addObject:letterF];
        
        groupOneLettersNode = [GroupLetterNode node];
        [groupOneLettersNode initWithGroupID:@"second"];
        
        [groupThreeLetters addObject:letterI];
        [groupThreeLetters addObject:letterP];
        [groupThreeLetters addObject:letterN];
        [groupThreeLetters addObject:letterL];
        [groupThreeLetters addObject:letterH];
        
        groupOneLettersNode = [GroupLetterNode node];
        [groupOneLettersNode initWithGroupID:@"third"];
        
        [groupFourLetters addObject:letterE];
        [groupFourLetters addObject:letterZ];
        [groupFourLetters addObject:letterX];
        [groupFourLetters addObject:letterK];
        [groupFourLetters addObject:letterQ];
        
        groupOneLettersNode = [GroupLetterNode node];
        [groupOneLettersNode initWithGroupID:@"fourth"];
        
        [groupFiveLetters addObject:letterU];
        [groupFiveLetters addObject:letterV];
        [groupFiveLetters addObject:letterW];
        [groupFiveLetters addObject:letterJ];
        [groupFiveLetters addObject:letterY];
        
        groupOneLettersNode = [GroupLetterNode node];
        [groupOneLettersNode initWithGroupID:@"fifth"];
    
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
            letterSprite.scale = 0.2;
            letterSprite.position = CGPointMake(950,750 - i);
            [self addChild:letterSprite];
            i += 80;
        }
        
        for (int i = 0; i < 1500; i++) {
            SKSpriteNode *trailSprite =[SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
            trailSprite.scale = 0.3;
            trailSprite.alpha = 0.0;
            trailSprite.position = CGPointMake(500, 500);
            [self addChild:trailSprite];
            [listOfTrailSprites addObject:trailSprite];
        }
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 725);
        backToMainMenuArrow.scale = 0.5;
        [self addChild:backToMainMenuArrow];
        
        groupOne = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupOne.text = @"Group 1";
        groupOne.fontColor = [UIColor redColor];
        groupOne.fontSize = 20;
        groupOne.position = CGPointMake(100, 100);
        [self addChild:groupOne];
        
        
        groupTwo = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupTwo.text = @"Group 2";
        groupTwo.fontColor = [UIColor redColor];
        groupTwo.fontSize = 20;
        groupTwo.position = CGPointMake(100, 130);
        [self addChild:groupTwo];
        
        groupThree = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupThree.text = @"Group 3";
        groupThree.fontColor = [UIColor redColor];
        groupThree.fontSize = 20;
        groupThree.position = CGPointMake(100, 160);
        [self addChild:groupThree];
        
        groupFour = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupFour.text = @"Group 4";
        groupFour.fontColor = [UIColor redColor];
        groupFour.fontSize = 20;
        groupFour.position = CGPointMake(100, 190);
        [self addChild:groupFour];
        
        
        groupFive = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupFive.text = @"Group 5";
        groupFive.fontColor = [UIColor redColor];
        groupFive.fontSize = 20;
        groupFive.position = CGPointMake(100, 220);
        
        [self addChild:groupFive];
        [self nextQuestion];
        
    }
    
    return self;
    
}

-(SKAction *)createActionForCenterStage:(LowerCaseLetter *)letterToCenter
                         offStageLetter:(LowerCaseLetter *)letterToMoveOff
{
    
    CGPoint locationToMove = letterToMoveOff.position;
    CGPoint locationToMoveOn = letterToCenter.position;
    SKAction *moveLetterOff = [SKAction moveTo:locationToMove duration:1.0];
    SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:0.3];
    SKAction *moveLetterOnstage = [SKAction moveTo:locationToMoveOn duration:1.0];
    
    
    return moveLetterOff;
    
}



-(void) letterShapeNode:(CGPoint)point {
    
    //SKSpriteNode *trailSprite = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
    //trailSprite.position = point;
    //trailSprite.scale = 0.3;
    //trailSprite.alpha = 0.0;
    
    numberOfPoints++;
    
    SKSpriteNode *trailNode = [listOfTrailSprites objectAtIndex:numberOfPoints];
    trailNode.position = point;
    trailNode.alpha = 0.7;
    trailNode.zPosition = 100;
    [shapeNodeObjects addObject:trailNode];
    NSLog(@"count of points %i", numberOfPoints);
}

-(void) resetShapeNodePool {
    
    for (SKSpriteNode *trailSpriteRemove in listOfTrailSprites) {
        [trailSpriteRemove removeFromParent];
        
    }
    
    
    listOfTrailSprites = [[NSMutableArray alloc]init];
    
    for (int i = 0; i < 1500; i++) {
        SKSpriteNode *trailSprite =[SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
        trailSprite.scale = 0.3;
        trailSprite.alpha = 0.0;
        trailSprite.position = CGPointMake(500, 500);
        [self addChild:trailSprite];
        [listOfTrailSprites addObject:trailSprite];
    }
    
}

-(void) redrawShapeNode {
    
    
    for (SKSpriteNode *myShape in shapeNodeObjects) {
        SKAction *moveShape = [SKAction moveByX:-300 y:0 duration:1.0];
        SKAction *scaleDown = [SKAction scaleTo:0.2 duration:1.0];
        SKAction *moveInward = [SKAction moveByX:+200 y:+200 duration:1.0];
        SKAction *sequenceLetterSize = [SKAction sequence:@[moveShape, scaleDown, moveInward]];
        [myShape runAction:sequenceLetterSize];
        
    }
    
}

-(void) cleanUpAndRemoveShapeNode {
    
    NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
    [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:letterOn];
    [self removeChildrenInArray:shapeNodeObjects];
    [self removeChildrenInArray:listOfTrailSprites];
    
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
    
    [self addChild:fingerTrace];
    SKLabelNode *directions = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    directions.text = @"WATCH HAND";
    directions.fontColor = [UIColor blueColor];
    directions.position = CGPointMake(620,670);
    directions.fontSize = 24;
    
    SKLabelNode *directions2 = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    directions2.text = @"DO THE SAME";
    directions2.fontColor = [UIColor blueColor];
    directions2.position = CGPointMake(620,640);
    directions.fontSize = 24;
    
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
    
}

-(void) nextQuestion {
    
    pointsForSprite = [[NSMutableArray alloc]init];
    pointsForSprite2 = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    spriteFromPoint2 = [[NSMutableArray alloc]init];
    controlPoints = [[NSMutableArray alloc]init];
    arrowObjects = [[NSMutableDictionary alloc]init];
    traceThePath = [[NSMutableArray alloc]init];
    
    
    multiStroke = FALSE;
    separateStroke = FALSE;
    firstStrokeComplete = FALSE;
    arrowAdded = FALSE;
    
    if (onWhichQuestion == 0) {  // Letter A

        
        [self createLetterA];

        [letterA playTheSound];
        
        letterA.centerStage = TRUE;
        letterA.position = CGPointMake(500, 400);
        letterA.scale = 1.0;
        letterA.alpha = 0;
        
        for (SKSpriteNode *letterAseg in letterAsegments) {
            [letterAseg setPosition:letterA.position];
            [self addChild:letterAseg];
        }


        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left-green.png"];
        handPointer.position = CGPointMake(640, 485);
        handPointer.scale = 0.5;
        handPointer.zPosition = 10;
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:+10 y:0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        SKAction *scaleUp = [SKAction scaleTo:1.2 duration:0.6];
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        
        [self traceTutorial];
       
    }
    else if (onWhichQuestion == 1) { // Letter B
        
        for (SKSpriteNode *letterAseg in letterAsegments) {
            [letterAseg removeFromParent];
        }
        
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [self createLetterB];
        [letterB playTheSound];
        [handPointer removeFromParent];
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
        
        SKAction *scaleUp = [SKAction scaleTo:1.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        
        
        SKAction *moveLetterB = [SKAction moveTo:CGPointMake(500, 480) duration:1.0];
        letterB.scale = 1.0;
        [letterB runAction:moveLetterB];
        [self traceTutorial];
        
    }
    
    else if (onWhichQuestion == 2) { // Letter C
    
        [self createLetterC];
        [letterC playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        letterC.centerStage = TRUE;
        [handPointer removeFromParent];
        
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

        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:+10 y:0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleXTo:1.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        SKAction *moveLetterC = [SKAction moveTo:CGPointMake(500, 400) duration:1.0];
        [letterC runAction:moveLetterC];
        [self traceTutorial];
    }
    
    else if (onWhichQuestion == 3) { // Letter M

        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [self createLetterM];
        [letterM playTheSound];
        
        [handPointer removeFromParent];
        letterM.centerStage = TRUE;
        
        SKAction *moveLetterC = [SKAction moveTo:CGPointMake(100, 220) duration:1.0];
        SKAction *scaleLetterC = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterC runAction:moveLetterC];
        [letterC runAction:scaleLetterC];
        
        letterM.scale = 1.0;
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

        SKAction *moveLetterM = [SKAction moveTo:CGPointMake(500, 380) duration:1.0];
        [letterM runAction:moveLetterM];
        [self traceTutorial];
        
        
    }
    
    else if (onWhichQuestion == 4) { // Letter S
        
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [self createLetterS];
        [letterS playTheSound];

        [handPointer removeFromParent];
        letterS.centerStage = TRUE;
        
        SKAction *moveLetterM = [SKAction moveTo:CGPointMake(100, 270) duration:1.0];
        SKAction *scaleLetterM = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterM runAction:moveLetterM];
        [letterM runAction:scaleLetterM];
        
        letterS.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        //[self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        
        SKAction *moveLetterS = [SKAction moveTo:CGPointMake(500, 380) duration:1.0];
        [letterS runAction:moveLetterS];
        [self traceTutorial];
        
    } else if (onWhichQuestion == 5) { // Letter T
        
        [self createLetterT];
        [letterT playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterT.centerStage = TRUE;
    
        SKAction *moveLetterS = [SKAction moveTo:CGPointMake(100, 320) duration:1.0];
        SKAction *scaleLetterS = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterS runAction:moveLetterS];
        [letterS runAction:scaleLetterS];
        letterT.scale = 1.0;
        
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        
        [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
        
        SKAction *moveLetterT = [SKAction moveTo:CGPointMake(500, 440) duration:1.0];
        [letterT runAction:moveLetterT];
        [self traceTutorial];
        

       
    } else if (onWhichQuestion == 6) { // letter O
        
        // MOVE OFF SHAPE NODES
        
        [self createLetterO];
        [letterO playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterO.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterT runAction:moveLetterOff];
        [letterT runAction:scaleLetterDown];
        
        letterO.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(640, 440) duration:1.0];
        [letterO runAction:moveLetterOn];
        [self traceTutorial];

        
    } else if (onWhichQuestion == 7) { // letter G
        
        [self createLetterG];
        [letterG playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterG.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 370) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterO runAction:moveLetterOff];
        [letterO runAction:scaleLetterDown];
        
        
        letterG.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 460) duration:1.0];
        [letterG runAction:moveLetterOn];
        [self traceTutorial];
        
    } else if (onWhichQuestion == 8) {  // letter R
        
        [self createLetterR];
        [letterR playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterR.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 420) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterG runAction:moveLetterOff];
        [letterG runAction:scaleLetterDown];
        
        letterR.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600,490) duration:1.0];
        [letterR runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 9) { // letter D
        [self createLetterD];
        [letterD playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterD.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterR runAction:moveLetterOff];
        [letterR runAction:scaleLetterDown];
        
        letterD.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterD runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 10) { // letter F
        
        [self createLetterF];
        [letterF playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterF.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterD runAction:moveLetterOff];
        [letterD runAction:scaleLetterDown];
        
        letterF.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(550, 450) duration:1.0];
        [letterF runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 11) { // letter I
        
        [self createLetterI];
        [letterI playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterI.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterF runAction:moveLetterOff];
        [letterF runAction:scaleLetterDown];
        
        letterI.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(550, 450) duration:1.0];
        [letterI runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 12) { // letter P
        
        [self createLetterP];
        [letterP playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterP.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterI runAction:moveLetterOff];
        [letterI runAction:scaleLetterDown];
        
        letterP.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(650, 450) duration:1.0];
        [letterP runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 13) { // letter N
        
        [self createLetterN];
        [letterN playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterN.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterP runAction:moveLetterOff];
        [letterP runAction:scaleLetterDown];
        
        letterN.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(650, 450) duration:1.0];
        [letterN runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 14) { // letter L
        
        
        [self createLetterL];
        [letterL playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterL.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterN runAction:moveLetterOff];
        [letterN runAction:scaleLetterDown];
        
        NSLog(@"adding letter L");
        letterL.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(650, 525) duration:1.0];
        [letterL runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 15) { // letter H
        [self createLetterH];
        [letterH playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterH.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterL runAction:moveLetterOff];
        [letterL runAction:scaleLetterDown];
        
        letterH.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(650, 550) duration:1.0];
        [letterH runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 16) { // letter E
        
        [self createLetterE];
        [letterE playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterE.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterH runAction:moveLetterOff];
        [letterH runAction:scaleLetterDown];
        
        letterE.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterE runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 17) { // letter Z
        
        [self createLetterZ];
        [letterZ playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterZ.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterE runAction:moveLetterOff];
        [letterE runAction:scaleLetterDown];
        
        letterZ.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterZ runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 18) { // letter X
        
        [self createLetterX];
        [letterX playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterX.centerStage = TRUE;
        
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterE runAction:moveLetterOff];
        [letterE runAction:scaleLetterDown];
        
        letterX.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterX runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 19) { // letter K
        
        [self createLetterK];
        [letterK playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterK.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterX runAction:moveLetterOff];
        [letterX runAction:scaleLetterDown];
        
        letterK.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterK runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 20) { // letter Q
        
        [self createLetterQ];
        [letterQ playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterQ.centerStage = TRUE;
        
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterK runAction:moveLetterOff];
        [letterK runAction:scaleLetterDown];
        
        letterQ.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterQ runAction:moveLetterOn];
        
        
    } else if (onWhichQuestion == 21) { // letter U
        
        [self createLetterU];
        [letterU playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        
        [handPointer removeFromParent];
        letterU.centerStage = TRUE;
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterQ runAction:moveLetterOff];
        [letterQ runAction:scaleLetterDown];
        
        letterU.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(550, 400) duration:1.0];
        [letterU runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 22) { // letter V
        
        [self createLetterV];
        [letterV playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterV.centerStage = TRUE;
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterU runAction:moveLetterOff];
        [letterU runAction:scaleLetterDown];
        
        letterV.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterV runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 23) { // letter W
        
        [self createLetterW];
        [letterW playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterW.centerStage = TRUE;
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterV runAction:moveLetterOff];
        [letterV runAction:scaleLetterDown];
        
        letterW.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterW runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 24) { // letter J
        
        [self createLetterJ];
        [letterJ playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterJ.centerStage = TRUE;
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterW runAction:moveLetterOff];
        [letterW runAction:scaleLetterDown];
        
        letterJ.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterJ runAction:moveLetterOn];
        
    } else if (onWhichQuestion == 25) { // letter Y
        
        [self createLetterY];
        [letterY playTheSound];
        [self cleanUpAndRemoveShapeNode];
        [self resetShapeNodePool];
        [handPointer removeFromParent];
        letterY.centerStage = TRUE;
        SKAction *moveLetterOff = [SKAction moveTo:CGPointMake(100, 350) duration:1.0];
        SKAction *scaleLetterDown = [SKAction scaleTo:0.1 duration:1.0];
        [letterJ runAction:moveLetterOff];
        [letterJ runAction:scaleLetterDown];
        
        letterY.scale = 1.0;
        NSValue *theArrowPoint = [pointsForSprite objectAtIndex:0];
        [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
        SKAction *moveLetterOn = [SKAction moveTo:CGPointMake(600, 450) duration:1.0];
        [letterY runAction:moveLetterOn];
        
    }
    
    
    [self addStrokeArrows];
    
}

-(void) addStrokeArrows {
    shapeNodeObjects = [[NSMutableArray alloc]init];
    
    int spritePointCount = 0;
    
    for (NSValue *pointValue in pointsForSprite) {
        
        SKSpriteNode *spritePoint;
        spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"left-yellow-mini-arrow.png"];
        
        CGPoint finalLocation = [pointValue CGPointValue];
        
        [arrowObjects enumerateKeysAndObjectsUsingBlock:^(NSNumber* key, NSNumber *value, BOOL *stop) {
            
            if (spritePointCount == [key integerValue]) {
                spritePoint.zRotation = [value floatValue];
            }
        }];
        
        spritePoint.position = CGPointMake(finalLocation.x, finalLocation.y);
        spritePoint.name = @"firstLine";
        
        if (spritePointCount == 0) {
            spritePoint.alpha = 1.0;
            spritePoint.scale = 0.4;
        } else {
            spritePoint.alpha = 0.0;
            spritePoint.scale = 0.3;
            
        }
        
        [self addChild:spritePoint];
        
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
            spritePoint2.name = @"secondLine";
            spritePoint2.alpha = 0.0;
            [self addChild:spritePoint2];
            float moveTime = 0.07 * (float)spritePointCount;
            SKAction *movePointsX = [SKAction moveToX:finalLocation.x duration:moveTime];
            SKAction *movePointsY = [SKAction moveToY:finalLocation.y duration:moveTime];
            
            
            [arrowObjects enumerateKeysAndObjectsUsingBlock:^(NSNumber* key, NSNumber *value, BOOL *stop) {
                int newSpriteCount = spritePointCount;
                
                if (newSpriteCount == [key integerValue]) {
                    spritePoint2.zRotation = [value floatValue];
                    spritePoint2.zPosition = 22;
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



-(void) moveLetterFromCenterStage:(LowerCaseLetter *)letterOff display:(LowerCaseLetter *)letterOn {
    
    
}

////////////////////////////////
//
// SHAPE NODE
//
////////////////////////////////


-(void)showActivity {
    
    timerForLetter++;
    
    NSString *currentTime = [NSString stringWithFormat:@"%d seconds", timerForLetter];

    NSLog(@"timer: %@", currentTime);
    
    if ([self childNodeWithName:@"timer"]) {
        
        [timeDisplay removeFromParent];
        
    }
    
    timeDisplay = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    timeDisplay.name = @"timer";
    timeDisplay.text = currentTime;
    timeDisplay.fontSize = 20;
    timeDisplay.fontColor = [UIColor redColor];
    timeDisplay.position = CGPointMake(500, 200);
    [self addChild:timeDisplay];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    timeForQuestion = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                       target:self
                                                     selector:@selector(showActivity)
                                                     userInfo:Nil
                                                      repeats:YES];
    
    if (onWhichQuestion > 0) {
        [timeDisplay removeFromParent];
    }
    
    for (LowerCaseLetter *tapLetter in allLettersSprites) {
        
        if (CGRectContainsPoint(tapLetter.frame,theTouch) && tapLetter.centerStage == NO) {
            //if (tapLetter.centerStage) {
            [tapLetter playTheSound];
            
            [self nextQuestion];
            
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
    
    if(pointsForSprite != NULL) {
        
        SKSpriteNode *firstPointSprite = [spriteFromPoint objectAtIndex:0];
        
        if (CGRectContainsPoint (firstPointSprite.frame, theTouch)) {
            firstPointTest = TRUE;
            NSLog(@"first point test");
            strokeLetterBegin = TRUE;
        }
        
        //[firstPointSprite runAction:[SKAction removeFromParent]];
        
        
    }
 
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    currentPoint = theTouch;
    previousPoint2 = previousPoint;
    
    previousPoint = [touch previousLocationInNode:self];
    deltaPoint = CGPointSubtract(theTouch, previousPoint);
    
    NSLog(@"delta point %f, %f", deltaPoint.x, deltaPoint.y);
    
    [self letterShapeNode:theTouch];

    if(pointsForSprite != NULL) {
        
        SKSpriteNode *firstPointSprite = [spriteFromPoint objectAtIndex:0];
        
        if (CGRectContainsPoint (firstPointSprite.frame, theTouch)) {
            firstPointTest = TRUE;
            NSLog(@"first point test");
            strokeLetterBegin = TRUE;
            [firstPointSprite runAction:[SKAction removeFromParent]];
        }
        
    }

    
    int onWhichPoint = 0;
    
    for (SKSpriteNode *pointHit in spriteFromPoint) {

        onWhichPoint++;
        
        if (CGRectContainsPoint(pointHit.frame, theTouch) && !firstStrokeComplete) {
            if ([spriteFromPoint count] == onWhichPoint) {
                
                firstStrokeComplete = TRUE;
                
            }

            [pointHit runAction:removeSprite];
            
            SKSpriteNode *letterAsegToFade = [[SKSpriteNode alloc]init];
            
            if (onWhichPoint-1 < [letterAsegments count]) {
                letterAsegToFade = [letterAsegments objectAtIndex:[letterAsegments count]-onWhichPoint];
                [letterAsegToFade runAction:removeSprite];
            }
            
            if (onWhichPoint < [spriteFromPoint count]) {
                
                SKAction *remove = [SKAction removeFromParent];
                [pointHit runAction:remove];
                
                SKSpriteNode *nextOne = [spriteFromPoint objectAtIndex:onWhichPoint];
                [nextOne runAction:sequenceActions];

                [self createEffectForArrow:nextOne valueForColor:4.8];
                
                if (onWhichPoint+1 < [spriteFromPoint count]){
                    SKSpriteNode *nextSprite = [spriteFromPoint objectAtIndex:onWhichPoint+1];
                    CGPoint nextPos = nextSprite.position;
                    SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.2];
                    SKAction *removeTheArrow = [SKAction removeFromParent];
                    SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                    //[nextOne runAction:moveToNextArrow];
                    [nextOne runAction:sequenceArrow];
                }

            }
            
            if (onWhichPoint+1 < [spriteFromPoint count]) {

                SKSpriteNode *nextTwo = [spriteFromPoint objectAtIndex:onWhichPoint + 1];
                [nextTwo runAction:sequenceActions2];
                
                [self createEffectForArrow:nextTwo valueForColor:2.8];
                
                
                if(ARROW_EMITTERS) {
                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                    [self addChild:openEffect];
                    openEffect.position = nextTwo.position;
                    
                }
                
                if (onWhichPoint+2 < [spriteFromPoint count]){
                    SKSpriteNode *nextSprite = [spriteFromPoint objectAtIndex:onWhichPoint+2];
                    CGPoint nextPos = nextSprite.position;
                    SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.3];
                    SKAction *removeTheArrow = [SKAction removeFromParent];
                    SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                    //[nextTwo runAction:moveToNextArrow];
                    [nextTwo runAction:sequenceArrow];
                }
            }
            
            if (onWhichPoint + 2 < [spriteFromPoint count]) {
                SKSpriteNode *nextThree = [spriteFromPoint objectAtIndex:onWhichPoint + 2];
                [nextThree runAction:sequenceActions3];
                
                [self createEffectForArrow:nextThree valueForColor:1.8];
                
                if (ARROW_EMITTERS) {
                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                    [self addChild:openEffect];
                    openEffect.position = nextThree.position;
                    
                }
                
                if (onWhichPoint+3 < [spriteFromPoint count]){
                    SKSpriteNode *nextSprite = [spriteFromPoint objectAtIndex:onWhichPoint+3];
                    CGPoint nextPos = nextSprite.position;
                    SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.4];
                    SKAction *removeTheArrow = [SKAction removeFromParent];
                    SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                    //[nextThree runAction:moveToNextArrow];
                    [nextThree runAction:sequenceArrow];
                }
                
            }
            
            if (onWhichPoint + 3 < [spriteFromPoint count]) {
                SKSpriteNode *nextFour = [spriteFromPoint objectAtIndex:onWhichPoint + 3];
                [nextFour runAction:sequenceActions3];
                [self createEffectForArrow:nextFour valueForColor:5.8];
                
                if (ARROW_EMITTERS) {
                    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                    [self addChild:openEffect];
                    openEffect.position = nextFour.position;
                }
            }
 
        }
        
    }
 
    
    if (multiStroke && firstStrokeComplete) {
        
        int secondSpritePointCount = 0;
        int totalCountOfSprites = onWhichPoint + secondSpritePointCount;
        
        
        SKSpriteNode *firstOne = [spriteFromPoint2 objectAtIndex:0];
        firstOne.alpha = 1.0;
        [firstOne runAction:[SKAction scaleBy:1.2 duration:0.2]];
        
        for (SKSpriteNode *pointHit in spriteFromPoint2) {
        
            secondSpritePointCount++;
            totalCountOfSprites++;
        
            if (CGRectContainsPoint(pointHit.frame, theTouch)) {
                
                [arrowObjects enumerateKeysAndObjectsUsingBlock:^(NSNumber* key, NSNumber *value, BOOL *stop) {
                    
                    if (secondSpritePointCount == [key integerValue]) {
                        pointHit.zRotation = [value floatValue];
                        pointHit.zPosition = 99;
                        
                    }
                }];

                SKAction *remove = [SKAction removeFromParent];
                [pointHit runAction:remove];
                
                if (secondSpritePointCount < [spriteFromPoint2 count]) {
                    SKSpriteNode *nextOne = [spriteFromPoint2 objectAtIndex:secondSpritePointCount];
                    [nextOne runAction:sequenceActions];
                    
                    [self createEffectForArrow:nextOne valueForColor:4.8];
                    
                    if (ARROW_EMITTERS ) {
                        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                        [self addChild:openEffect];
                        openEffect.position = nextOne.position;
                    }
                    
                    if (secondSpritePointCount+1 < [spriteFromPoint2 count]){
                        SKSpriteNode *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+1];
                        CGPoint nextPos = nextSprite.position;
                        SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.2];
                        SKAction *removeTheArrow = [SKAction removeFromParent];
                        SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                        
                        //[nextOne runAction:moveToNextArrow];
                        [nextOne runAction:sequenceArrow];
                        
                    }
                    
                    
                }
                if (secondSpritePointCount+1 < [spriteFromPoint2 count]) {
                    
                    SKSpriteNode *nextTwo = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 1];
                    [nextTwo runAction:sequenceActions2];
                    
                    [self createEffectForArrow:nextTwo valueForColor:2.8];
                    
                    if (secondSpritePointCount+2 < [spriteFromPoint2 count]){
                        SKSpriteNode *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+2];
                        CGPoint nextPos = nextSprite.position;
                        SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.4];
                        SKAction *removeTheArrow = [SKAction removeFromParent];
                        SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                        //[nextTwo runAction:moveToNextArrow];
                        [nextTwo runAction:sequenceArrow];
                    }
                }
                
                if (secondSpritePointCount + 2 < [spriteFromPoint2 count]) {
                    SKSpriteNode *nextThree = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 2];
                    [nextThree runAction:sequenceActions3];
                    [self createEffectForArrow:nextThree valueForColor:1.8];

                    if (ARROW_EMITTERS) {
                        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                        [self addChild:openEffect];
                        openEffect.position = nextThree.position;
                    }
                    
                    if (secondSpritePointCount+3 < [spriteFromPoint2 count]){
                        SKSpriteNode *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+3];
                        CGPoint nextPos = nextSprite.position;
                        SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.5];
                        SKAction *removeTheArrow = [SKAction removeFromParent];
                        SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                        //[nextThree runAction:moveToNextArrow];
                        [nextThree runAction:sequenceArrow];
                    }
                }
                
                if (secondSpritePointCount + 3 < [spriteFromPoint2 count]) {
                    SKSpriteNode *nextFour = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 3];
                    [nextFour runAction:sequenceActions3];

                    [self createEffectForArrow:nextFour valueForColor:5.8];
                    
                    if (ARROW_EMITTERS) {
                        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
                        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                        [self addChild:openEffect];
                        openEffect.position = nextFour.position;
                        
                    }
                    
                    if (secondSpritePointCount+4 < [spriteFromPoint2 count]){
                        SKSpriteNode *nextSprite = [spriteFromPoint2 objectAtIndex:secondSpritePointCount+4];
                        CGPoint nextPos = nextSprite.position;
                        SKAction *moveToNextArrow = [SKAction moveTo:nextPos duration:0.5];
                        SKAction *removeTheArrow = [SKAction removeFromParent];
                        SKAction *sequenceArrow = [SKAction sequence:@[moveToNextArrow,removeTheArrow]];
                        //[nextFour runAction:moveToNextArrow];
                        [nextFour runAction:sequenceArrow];
                    }
                }
                
                /*if (secondSpritePointCount + 4 < [spriteFromPoint2 count]) {
                    SKSpriteNode *nextFive = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 4];
                    [nextFive runAction:lightUp4];
                }
                
                if (secondSpritePointCount + 5 < [spriteFromPoint2 count]) {
                    
                    SKSpriteNode *nextSix = [spriteFromPoint2 objectAtIndex:secondSpritePointCount + 5];
                    [nextSix runAction:lightUp4];
                }*/
     
            }
        }
    }
    
}


-(void) createEffectForArrow:(SKSpriteNode *)spriteToDisplayEffect valueForColor:(float)colorVal {
    effectNode = [SKEffectNode node];
    [spriteToDisplayEffect removeFromParent];
    [effectNode addChild:spriteToDisplayEffect];
    [self addChild:effectNode];
    effectNode.shouldRasterize = YES;
    
    filter = [CIFilter filterWithName:@"CIHueAdjust"];
    [filter setValue:@0 forKey:@"inputAngle"];
    effectNode.filter = filter;
    effectNode.shouldEnableEffects = YES;
    float randVal = colorVal;
    [filter setValue:[NSNumber numberWithFloat:randVal] forKey:@"inputAngle"];
    
}

-(void) fireEmitterForArrow {
    
    
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    [timeForQuestion invalidate];

    //[self resetShapeNodePool];
    
    numberOfPoints = 0;

    for(LowerCaseLetter *onLetter in allLettersSprites) {
        
        if (onLetter.centerStage && firstPointTest) {
            
            SKAction *fadeOut = [SKAction fadeAlphaTo:0.0 duration:1.5];
            [onLetter runAction:fadeOut];
            
            onLetter.timeForTrace = [NSNumber numberWithInt:timerForLetter];
            
            
        }
    }
    
    if (firstPointTest && strokeLetterBegin) {
        
        NSLog(@"on Which Question, %i", onWhichQuestion);
        
        for (SKSpriteNode *spritePoint in spriteFromPoint) {
            [spritePoint removeFromParent];
        }

        if (multiStroke) {
            for (SKSpriteNode *pinWheel in spriteFromPoint2) {
                NSLog(@"removed second arrow");
                [pinWheel removeFromParent];
            }
        }

        firstPointTest = FALSE;
        onWhichQuestion++;

        
        if (onWhichQuestion == 6) { // GROUP ONE COMPLETED
            
            SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:groupOne duration:4.0
                                                        startPosition:groupOne.position
                                                          endPosition:CGPointMake(groupOne.position.x+100, groupOne.position.y + 600) ];
            
            actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
            
            SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
            
            [groupOne runAction:actionWithEffect];
            
            
            SKAction *scaleIt = [SKAction scaleTo:2.0 duration:4.0];
            SKAction *scaleItBack = [SKAction scaleTo:0.5 duration:2.0];
            SKAction *moveToClose = [SKAction moveByX:0 y:+50 duration:1.0];
            SKAction *sequenceScaleGroup = [SKAction sequence:@[scaleIt,scaleItBack,moveToClose]];
            
            [groupOne runAction:sequenceScaleGroup];
            
            groupOne.fontColor = [SKColor greenColor];
            groupOne.fontColor = [SKColor colorWithHue:0.8 saturation:0.2 brightness:0.4 alpha:1.0];
            
            
            
            int xposition = 100;
            int yposition = 500;
            
            NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
            [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:letterOn];
            
            for (NSNumber *key in shapeNodeObjectForLetter) {
                NSLog(@"key is %@",key);
                
                NSMutableArray *pointsInShape = [shapeNodeObjectForLetter objectForKey:key];
                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]initWithPosition:CGPointMake(0, 0) withKey:key];
                

                for (SKSpriteNode *shapeSprite in pointsInShape) {
                    [shapeSprite removeFromParent];
                    [redrawLetterNode addChild:shapeSprite];
                    SKAction *fadeOut = [SKAction fadeAlphaTo:1.0 duration:5.0];
                    
                    SKAction *sequence = [SKAction sequence:@[fadeOut,removeSprite]];
                    [redrawLetterNode runAction:sequence];
                }
                
                [self addChild:redrawLetterNode];
                [finishedLevelText addObject:redrawLetterNode];
                redrawLetterNode.scale = 0.3;
                redrawLetterNode.position = CGPointMake(xposition, yposition);
                yposition -= 100;
                
                
            }
            
            [letterT runAction:[SKAction moveTo:CGPointMake(100, 500) duration:0.3]];
            [letterT runAction:[SKAction scaleTo:0.2 duration:0.3]];
            
            
            int i = 0;
            
            for (SKSpriteNode *letterSprite in groupTwoLetters) {
                letterSprite.scale = 0.2;
                letterSprite.position = groupTwo.position;
                
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
            
            for (SKSpriteNode *letterMoveOff in groupOneLetters) {
                SKAction *moveOff = [SKAction moveTo:CGPointMake(-100, -300) duration:5.0];
                SKAction *removeFromScene = [SKAction removeFromParent];
                SKAction *sequenceMoveOff = [SKAction sequence:@[moveOff,removeFromScene]];
                [letterMoveOff runAction:sequenceMoveOff];
                
            }
        } else if (onWhichQuestion == 11) {
            
            SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:groupTwo duration:4.0
                                                        startPosition:groupTwo.position
                                                          endPosition:CGPointMake(groupTwo.position.x+200, groupTwo.position.y + 570) ];
            
            actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
            
            SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
            
            [groupTwo runAction:actionWithEffect];
            
            SKAction *scaleIt = [SKAction scaleTo:2.0 duration:4.0];
            SKAction *scaleItBack = [SKAction scaleTo:0.5 duration:2.0];
            SKAction *moveToClose = [SKAction moveByX:0 y:+50 duration:1.0];
            SKAction *sequenceScaleGroup = [SKAction sequence:@[scaleIt,scaleItBack,moveToClose]];
            
            [groupTwo runAction:sequenceScaleGroup];
            
            groupTwo.fontColor = [SKColor greenColor];
            groupTwo.fontColor = [SKColor colorWithHue:0.8 saturation:0.2 brightness:0.4 alpha:1.0];
            
            int xposition = 100;
            int yposition = 500;
            
            NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
            [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:letterOn];
            
            int countOfNodes = 0;
            
            for (NSNumber *key in shapeNodeObjectForLetter) {
                
                NSMutableArray *pointsInShape = [shapeNodeObjectForLetter objectForKey:key];
                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]init];
                
                for (SKSpriteNode *shapeSprite in pointsInShape) {
                    [shapeSprite removeFromParent];
                    [redrawLetterNode addChild:shapeSprite];
                    SKAction *fadeOut = [SKAction fadeAlphaTo:1.0 duration:5.0];
                    SKAction *sequence = [SKAction sequence:@[fadeOut,removeSprite]];
                    [redrawLetterNode runAction:sequence];
                }
                
                [self addChild:redrawLetterNode];
                [finishedLevelText addObject:redrawLetterNode];
                redrawLetterNode.scale = 0.3;
                redrawLetterNode.position = CGPointMake(xposition, yposition);
                
                yposition -= 100;
                countOfNodes++;
                
                if (countOfNodes == 6) {
                    yposition = 500;
                    xposition = 300;
                }


            }
            [letterF runAction:[SKAction moveTo:CGPointMake(100, 500) duration:0.3]];
            [letterF runAction:[SKAction scaleTo:0.2 duration:0.3]];
            
            
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
            
            for (SKSpriteNode *letterMoveOff in groupTwoLetters) {
                SKAction *moveOff = [SKAction moveTo:CGPointMake(-100, -300) duration:5.0];
                SKAction *removeFromScene = [SKAction removeFromParent];
                SKAction *sequenceMoveOff = [SKAction sequence:@[moveOff,removeFromScene]];
                [letterMoveOff runAction:sequenceMoveOff];
                
            }
            
        } else if (onWhichQuestion == 16) {
            
            SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:groupThree duration:4.0
                                                        startPosition:groupThree.position
                                                          endPosition:CGPointMake(groupThree.position.x+300, groupThree.position.y + 540) ];
            
            actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
            
            SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
            
            [groupThree runAction:actionWithEffect];
            
            
            SKAction *scaleIt = [SKAction scaleTo:2.0 duration:4.0];
            SKAction *scaleItBack = [SKAction scaleTo:0.5 duration:2.0];
            SKAction *moveToClose = [SKAction moveByX:0 y:+50 duration:1.0];
            SKAction *sequenceScaleGroup = [SKAction sequence:@[scaleIt,scaleItBack,moveToClose]];
            
            [groupThree runAction:sequenceScaleGroup];
            
            groupThree.fontColor = [SKColor greenColor];
            groupThree.fontColor = [SKColor colorWithHue:0.8 saturation:0.2 brightness:0.4 alpha:1.0];
            
            

            int i = 0;
            for (SKSpriteNode *letterSprite in groupFourLetters) {
                letterSprite.scale = 0.2;
                letterSprite.position = CGPointMake(950, 650 - i);
                [self addChild:letterSprite];
                i += 100;
            }
        
            
            int xposition = 100;
            int yposition = 500;
            
            NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
            [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:letterOn];
            
            int countOfNodes = 0;
            
            for (NSNumber *key in shapeNodeObjectForLetter) {
                
                NSMutableArray *pointsInShape = [shapeNodeObjectForLetter objectForKey:key];
                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]init];
                
                for (SKSpriteNode *shapeSprite in pointsInShape) {
                    [shapeSprite removeFromParent];
                    [redrawLetterNode addChild:shapeSprite];
                    SKAction *fadeOut = [SKAction fadeAlphaTo:1.0 duration:10.0];
                    SKAction *sequence = [SKAction sequence:@[fadeOut,removeSprite]];
                    [redrawLetterNode runAction:sequence];
    
                }
                
                [self addChild:redrawLetterNode];
                [finishedLevelText addObject:redrawLetterNode];
                redrawLetterNode.scale = 0.3;
                redrawLetterNode.position = CGPointMake(xposition, yposition);
                
                yposition -= 100;
                countOfNodes++;
                
                if (countOfNodes == 6) {
                    yposition = 500;
                    xposition = 300;
                } else if (countOfNodes == 12) {
                    yposition = 500;
                    xposition = 500;
                }
                
                
            }
         
            
        } else if (onWhichQuestion == 21) {
            
            SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:groupFour duration:4.0
                                                        startPosition:groupFour.position
                                                          endPosition:CGPointMake(groupFour.position.x+400, groupFour.position.y + 510) ];
            
            actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
            
            SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
            
            [groupFour runAction:actionWithEffect];
            
            
            SKAction *scaleIt = [SKAction scaleTo:2.0 duration:4.0];
            SKAction *scaleItBack = [SKAction scaleTo:0.5 duration:2.0];
            SKAction *moveToClose = [SKAction moveByX:0 y:+50 duration:1.0];
            SKAction *sequenceScaleGroup = [SKAction sequence:@[scaleIt,scaleItBack,moveToClose]];
            
            [groupFour runAction:sequenceScaleGroup];
            
            groupFour.fontColor = [SKColor greenColor];
            groupFour.fontColor = [SKColor colorWithHue:0.8 saturation:0.2 brightness:0.4 alpha:1.0];
            
            
            
            int i = 0;
            for (SKSpriteNode *letterSprite in groupFiveLetters) {
                letterSprite.scale = 0.2;
                letterSprite.position = CGPointMake(950, 650 - i);
                [self addChild:letterSprite];
                i += 100;
            }
            
            
            int xposition = 100;
            int yposition = 500;
            
            NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
            [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:letterOn];
            
            int countOfNodes = 0;
            
            for (NSNumber *key in shapeNodeObjectForLetter) {
                
                NSMutableArray *pointsInShape = [shapeNodeObjectForLetter objectForKey:key];
                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]init];
                
                for (SKSpriteNode *shapeSprite in pointsInShape) {
                    [shapeSprite removeFromParent];
                    [redrawLetterNode addChild:shapeSprite];
                    SKAction *fadeOut = [SKAction fadeAlphaTo:1.0 duration:10.0];
                    SKAction *sequence = [SKAction sequence:@[fadeOut,removeSprite]];
                    [redrawLetterNode runAction:sequence];
                    
                    
                    
                    
                }
                
                [self addChild:redrawLetterNode];
                [finishedLevelText addObject:redrawLetterNode];
                redrawLetterNode.scale = 0.3;
                redrawLetterNode.position = CGPointMake(xposition, yposition);
                
                yposition -= 100;
                countOfNodes++;
                
                if (countOfNodes == 6) {
                    yposition = 500;
                    xposition = 300;
                } else if (countOfNodes == 12) {
                    yposition = 500;
                    xposition = 500;
                } else if (countOfNodes == 18) {
                    yposition = 500;
                    xposition = 700;
                }
                
                
            }
            
            
        } else if (onWhichQuestion == 26) {
            
            SKTMoveEffect *actionMove = [SKTMoveEffect effectWithNode:groupFive duration:4.0
                                                        startPosition:groupFive.position
                                                          endPosition:CGPointMake(groupFive.position.x+500, groupFive.position.y + 480 ) ];
            
            actionMove.timingFunction = SKTTimingFunctionBounceEaseOut;
            
            SKAction *actionWithEffect = [SKAction actionWithEffect:actionMove];
            
            [groupFive runAction:actionWithEffect];
            
            
            SKAction *scaleIt = [SKAction scaleTo:2.0 duration:4.0];
            SKAction *scaleItBack = [SKAction scaleTo:0.5 duration:2.0];
            
            
            SKAction *sequenceScaleGroup = [SKAction sequence:@[scaleIt,scaleItBack]];
            
            [groupFive runAction:sequenceScaleGroup];
            
            
            
                                   
            
            
            
            int i = 0;
            /*for (SKSpriteNode *letterSprite in groupFourLetters) {
                letterSprite.scale = 0.2;
                letterSprite.position = CGPointMake(950, 650 - i);
                [self addChild:letterSprite];
                i += 100;
            }*/
            
            
            int xposition = 100;
            int yposition = 500;
            
            NSNumber *letterOn = [NSNumber numberWithInt:onWhichQuestion];
            [shapeNodeObjectForLetter setObject:shapeNodeObjects forKey:letterOn];
            
            int countOfNodes = 0;
            
            for (NSNumber *key in shapeNodeObjectForLetter) {
                
                NSMutableArray *pointsInShape = [shapeNodeObjectForLetter objectForKey:key];
                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]init];
                
                for (SKSpriteNode *shapeSprite in pointsInShape) {
                    [shapeSprite removeFromParent];
                    [redrawLetterNode addChild:shapeSprite];
                    SKAction *fadeOut = [SKAction fadeAlphaTo:1.0 duration:10.0];
                    SKAction *sequence = [SKAction sequence:@[fadeOut,removeSprite]];
                    [redrawLetterNode runAction:sequence];
                    
                    
                    
                    
                }
                
                [self addChild:redrawLetterNode];
                [finishedLevelText addObject:redrawLetterNode];
                redrawLetterNode.scale = 0.3;
                redrawLetterNode.position = CGPointMake(xposition, yposition);
                
                yposition -= 100;
                countOfNodes++;
                
                if (countOfNodes == 6) {
                    yposition = 600;
                    xposition = 400;
                } else if (countOfNodes == 11) {
                    yposition = 600;
                    xposition = 600;
                } else if (countOfNodes == 16) {
                    yposition = 600;
                    xposition = 800;
                } else if (countOfNodes == 21) {
                    yposition = 600;
                    xposition = 1000;
                }
                
                
            }
            
            
        }

    }
    
    timerForLetter = 0;
    
}

-(void)update:(NSTimeInterval)currentTime {
  
    [self enumerateChildNodesWithName:@"firstLine" usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *arrowOnFirstLine = (SKSpriteNode *)node;
        if (CGRectIntersectsRect(arrowOnFirstLine.frame, fingerTrace.frame)) {
            [arrowOnFirstLine removeFromParent];
        }
    }];
    
    if (multiStroke && firstStrokeComplete && arrowAdded == FALSE) {
        
        
        if ([secondStroke isEqualToString:@"up"]) {
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.y -= 100;
            
            [self arrowPointerToDraw:@"up" location:arrowPointCG];

            
        } else if ([secondStroke isEqualToString:@"down"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            CGPoint dropPoint = [theArrowPoint CGPointValue];
            
            [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];
            
            NSLog(@"arrow pointer location: %f, %f", dropPoint.x, dropPoint.y);
            
            
        } else if ([secondStroke isEqualToString:@"left"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.x -= 100;
            
            [self arrowPointerToDraw:@"left" location:arrowPointCG];
            
            
        } else if ([secondStroke isEqualToString:@"right"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            CGPoint arrowPointCG = [theArrowPoint CGPointValue];
            arrowPointCG.x += 100;
            
            [self arrowPointerToDraw:@"left" location:arrowPointCG];
            
            
        }

        arrowAdded = TRUE;

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
    SKAction *moveToFinish = [SKAction moveToX:-300 duration:0.1];
    SKAction *scaleDown = [SKAction scaleTo:0.3 duration:0.1];
    [currentLetterFinish runAction:moveToFinish];
    [currentLetterFinish runAction:scaleDown];
    
}


-(void) createLetterA {
    
    float beginx = 660;
    float beginy = 450;
    multiStroke = TRUE;
    secondStroke = @"down";
    
   
    CGPoint letterAvalue1 = CGPointMake(beginx-100, beginy+60);
    CGPoint letterAvalue5 = CGPointMake(beginx - 150, beginy + 60);
    CGPoint letterAvalue6 = CGPointMake(beginx - 200, beginy + 45);
    CGPoint letterAvalue7 = CGPointMake(beginx - 230, beginy +15);
    CGPoint letterAvalue8 = CGPointMake(beginx - 237, beginy - 20);
    CGPoint letterAvalue9 = CGPointMake(beginx - 245, beginy - 65);
    //CGPoint letterAvalue10 = CGPointMake(beginx - 245, beginy - 65);
    CGPoint letterAvalue11 = CGPointMake(beginx - 245, beginy - 125);
    //CGPoint letterAvalue12 = CGPointMake(beginx - 245, beginy - 125);
    //CGPoint letterAvalue13 = CGPointMake(beginx - 237, beginy - 140);
    CGPoint letterAvalue14 = CGPointMake(beginx - 200, beginy - 150);
    CGPoint letterAvalue15 = CGPointMake(beginx - 150, beginy - 160);
    CGPoint letterAvalue16 = CGPointMake(beginx - 100, beginy - 160);
    CGPoint letterAvalue17 = CGPointMake(beginx - 50, beginy - 110);
    CGPoint letterAvalue18 = CGPointMake(beginx-50, beginy - 70);
    //CGPoint letterAvalue19 = CGPointMake(beginx-60, beginy - 90);
    CGPoint letterAvalue20 = CGPointMake(beginx-60, beginy - 10);
    CGPoint letterAvalue23 = CGPointMake(beginx-60, beginy +80);
    CGPoint letterAvalue24 = CGPointMake(beginx-60, beginy - 60);
    CGPoint letterAvalue25 = CGPointMake(beginx-60, beginy - 120);
    
    
    
    NSString *pListData = [[NSBundle mainBundle]pathForResource:@"LetterControlPoints" ofType:@"plist"];
    
    NSMutableArray *controlPointsForLetter = [[NSMutableArray alloc]initWithContentsOfFile:pListData];
    
    
    for (NSMutableDictionary *dictionaryPoints in controlPointsForLetter) {
        
        for (NSString *key in dictionaryPoints) {
            
            NSLog(@"key value: %@, value: %@", key, [dictionaryPoints valueForKey:key]);
            
            
            if ([key isEqualToString:@"letter"]) {
                
                
            } else {
                
                CGPoint myPoint = CGPointFromString(key);
                //letterAvalue1 = myPoint;
                
            }
            
        }
    }

    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x,letterAvalue6.y,
                          letterAvalue8.x,letterAvalue8.y,
                          letterAvalue11.x, letterAvalue11.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue11.x, letterAvalue11.y-80,
                          letterAvalue14.x, letterAvalue14.y-80,
                          letterAvalue16.x, letterAvalue16.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue16.x, letterAvalue16.y-80,
                          letterAvalue17.x, letterAvalue17.y-80,
                          letterAvalue20.x, letterAvalue20.y+80);
    
    CGPathAddLineToPoint(cgpath, NULL, letterAvalue25.x, letterAvalue25.y-80);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"1"];
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.1] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.7] forKey:@"7"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:20.9] forKey:@"8"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"9"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"11"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.7] forKey:@"12"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23] forKey:@"13"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"14"];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"15"];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"16"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"17"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"18"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"19"];

}



-(void) createLetterB {

    float beginx = 400;
    float beginy = 720;
    
    letterBeginX  = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy-25);

    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-85);

    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-135);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-185);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-235);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy-285);
    CGPoint letterAvalue13 = CGPointMake(beginx, beginy-335);
    CGPoint letterAvalue14 = CGPointMake(beginx, beginy-385);
    
    // Second stroke
    CGPoint letterAvalue15 = CGPointMake(beginx + 40, beginy - 475);
    CGPoint letterAvalue16 = CGPointMake(beginx+ 40, beginy - 400);
    CGPoint letterAvalue17 = CGPointMake(beginx+ 40, beginy - 325);
    CGPoint letterAvalue18 = CGPointMake(beginx+ 40, beginy - 275);
    CGPoint letterAvalue19 = CGPointMake(beginx+ 80, beginy - 250);
    //CGPoint letterAvalue20 = CGPointMake(beginx+ 80, beginy - 220);
    CGPoint letterAvalue21 = CGPointMake(beginx+ 120, beginy - 220);
    CGPoint letterAvalue22 = CGPointMake(beginx+ 160, beginy - 250);
    CGPoint letterAvalue23 = CGPointMake(beginx+ 180, beginy - 280);
    CGPoint letterAvalue24 = CGPointMake(beginx+ 180, beginy - 360);
    CGPoint letterAvalue25 = CGPointMake(beginx+ 160, beginy - 430);
    //CGPoint letterAvalue26 = CGPointMake(beginx+ 120, beginy - 450);
    //CGPoint letterAvalue27 = CGPointMake(beginx+ 80, beginy - 460);
    
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue11.x,letterAvalue11.y-40,
                          letterAvalue14.x, letterAvalue14.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue14.x, letterAvalue14.y,
                          letterAvalue18.x, letterAvalue18.y-30,
                          letterAvalue21.x, letterAvalue21.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue22.x+80, letterAvalue22.y-10,
                          letterAvalue24.x+80, letterAvalue24.y-60,
                          letterAvalue25.x+70, letterAvalue25.y-60);
    
   // CGPathAddLineToPoint(cgpath, NULL, letterAvalue25.x+160, letterAvalue25.y);
    
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:22.9] forKey:@"12"];
    
    //[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"14"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"15"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"16"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"17"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"18"];
    
    //[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"19"];
    
    //[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"20"];
}

-(void) createLetterC {

    float beginx = 580;
    float beginy = 460;
    
    letterBeginX = beginx;
    letterBeginY = beginy;
    
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

    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue18.x+80, letterAvalue18.y-10,
                          letterAvalue19.x+80, letterAvalue19.y-10,
                          letterAvalue20.x+70, letterAvalue20.y);*/
    
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
    float beginx = 540;
    float beginy = 700;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-40);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-90);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-140);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-190);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-240);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-290);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-340);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-390);
    
    
    CGPoint letterAvalue11 = CGPointMake(beginx-20, beginy-410);
    CGPoint letterAvalue12 = CGPointMake(beginx-20, beginy-360);
    CGPoint letterAvalue13 = CGPointMake(beginx-20, beginy-310);
    CGPoint letterAvalue14 = CGPointMake(beginx-20, beginy-260);
    CGPoint letterAvalue15 = CGPointMake(beginx-50, beginy-190);
    CGPoint letterAvalue16 = CGPointMake(beginx-100, beginy-170);
    CGPoint letterAvalue17 = CGPointMake(beginx-150, beginy-210);
    CGPoint letterAvalue18 = CGPointMake(beginx-180, beginy-230);
    CGPoint letterAvalue19 = CGPointMake(beginx-190, beginy-290);
    CGPoint letterAvalue20 = CGPointMake(beginx-180, beginy-360);
    CGPoint letterAvalue21 = CGPointMake(beginx-120, beginy-420);
    CGPoint letterAvalue22 = CGPointMake(beginx-60, beginy-440);
    CGPoint letterAvalue23 = CGPointMake(beginx-10, beginy-430);
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"2"];
    
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
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"12"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"13"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"14"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"15"];
    
    
    
}

-(void) createLetterE {
    float beginx = 370;
    float beginy = 420;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = FALSE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx+40, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx+90, beginy);
    CGPoint letterAvalue5 = CGPointMake(beginx+140, beginy);
    CGPoint letterAvalue6 = CGPointMake(beginx+190, beginy);
    CGPoint letterAvalue7 = CGPointMake(beginx+160, beginy+30);
    CGPoint letterAvalue8 = CGPointMake(beginx+130, beginy+70);
    CGPoint letterAvalue9 = CGPointMake(beginx+100, beginy+110);
    CGPoint letterAvalue10 = CGPointMake(beginx+50, beginy+140);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-30);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy-80);
    CGPoint letterAvalue13 = CGPointMake(beginx, beginy-110);
    CGPoint letterAvalue14 = CGPointMake(beginx, beginy-130);
    CGPoint letterAvalue15 = CGPointMake(beginx+50, beginy-150);
    CGPoint letterAvalue16 = CGPointMake(beginx+150, beginy-160);
    CGPoint letterAvalue17 = CGPointMake(beginx+200, beginy-150);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"2"];
    
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
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    
}

-(void) createLetterF {
    float beginx = 440;
    float beginy = 630;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    //multiStroke = TRUE;
    secondStroke = @"down";

    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx-20, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx-20, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx-20, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx-20, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx-20, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx-20, beginy-270);
    CGPoint letterAvalue9 = CGPointMake(beginx-80, beginy-100);
    CGPoint letterAvalue10 = CGPointMake(beginx-20, beginy-100);
    CGPoint letterAvalue11 = CGPointMake(beginx+30, beginy-100);
    CGPoint letterAvalue12 = CGPointMake(beginx+80, beginy-100);
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"2"];
    
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


-(void) createLetterG {
    
    float beginx = 500;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx-50, beginy);
    CGPoint letterAvalue5 = CGPointMake(beginx-100, beginy);
    CGPoint letterAvalue7 = CGPointMake(beginx-130, beginy-50);
    CGPoint letterAvalue9 = CGPointMake(beginx-130, beginy-100);
    CGPoint letterAvalue10 = CGPointMake(beginx-130, beginy-120);
    CGPoint letterAvalue12 = CGPointMake(beginx-130, beginy-180);
    CGPoint letterAvalue14 = CGPointMake(beginx-100, beginy-220);
    CGPoint letterAvalue16 = CGPointMake(beginx-50, beginy-230);
    CGPoint letterAvalue17 = CGPointMake(beginx+40, beginy-200);
    CGPoint letterAvalue18 = CGPointMake(beginx+40, beginy-150);
    CGPoint letterAvalue19 = CGPointMake(beginx+40, beginy-100);
    CGPoint letterAvalue20 = CGPointMake(beginx+40, beginy-50);
    
    
    // Second Line
    CGPoint letterAvalue21 = CGPointMake(beginx+60, beginy-10);
    CGPoint letterAvalue22 = CGPointMake(beginx+60, beginy-40);
    CGPoint letterAvalue23 = CGPointMake(beginx+60, beginy-90);
    CGPoint letterAvalue24 = CGPointMake(beginx+60, beginy-140);
    CGPoint letterAvalue25 = CGPointMake(beginx+60, beginy-190);
    CGPoint letterAvalue26 = CGPointMake(beginx+60, beginy-240);
    CGPoint letterAvalue27 = CGPointMake(beginx+60, beginy-290);
    
    CGPoint letterAvalue28 = CGPointMake(beginx+40, beginy-360);
    CGPoint letterAvalue29 = CGPointMake(beginx-10, beginy-410);
    CGPoint letterAvalue30 = CGPointMake(beginx-50, beginy-440);
    CGPoint letterAvalue31 = CGPointMake(beginx-120, beginy-400);
    
    
    
    
    cgpath = CGPathCreateMutable();
    
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
    
    
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"17"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.1] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.2] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.3] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"9"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"11"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"12"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"13"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"14"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"15"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"16"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"17"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue28]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"18"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue29]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"19"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue30]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"19"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue31]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"19"];
}

-(void) createLetterH {
    
    float beginx = 400;
    float beginy = 670;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-350);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-400);
    
    // second point
    CGPoint letterAvalue11 = CGPointMake(beginx+40, beginy-400);
    CGPoint letterAvalue12 = CGPointMake(beginx+40, beginy-350);
    CGPoint letterAvalue13 = CGPointMake(beginx+40, beginy-220);
    CGPoint letterAvalue14 = CGPointMake(beginx+40, beginy-250);
    CGPoint letterAvalue15 = CGPointMake(beginx+40, beginy-220);

    CGPoint letterAvalue16 = CGPointMake(beginx+40, beginy-170);
    CGPoint letterAvalue17 = CGPointMake(beginx+40, beginy-120);
    CGPoint letterAvalue18 = CGPointMake(beginx+40, beginy-70);
    CGPoint letterAvalue19 = CGPointMake(beginx+200, beginy-300);
    CGPoint letterAvalue20 = CGPointMake(beginx+225, beginy-350);
    
    CGPoint letterAvalue21 = CGPointMake(beginx+225, beginy-350);
    CGPoint letterAvalue22 = CGPointMake(beginx+225, beginy-400);
    CGPoint letterAvalue23 = CGPointMake(beginx+225, beginy-300);
    CGPoint letterAvalue24 = CGPointMake(beginx+225, beginy-300);
    
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
    
    
}

-(void) createLetterI {
    
    float beginx = 440;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    //multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-220);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy+70);
    //CGPoint letterAvalue9 = CGPointMake(beginx-150, beginy-80);
    //CGPoint letterAvalue10 = CGPointMake(beginx-100, beginy-80);
    //CGPoint letterAvalue11 = CGPointMake(beginx+100, beginy-80);
    //CGPoint letterAvalue12 = CGPointMake(beginx+150, beginy-80);
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:21.0] forKey:@"7"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"8"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"9"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
}

-(void) createLetterJ {
    float beginx = 400;
    float beginy = 650;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    //multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-220);
    CGPoint letterAvalue8 = CGPointMake(beginx-20, beginy-225);
    CGPoint letterAvalue9 = CGPointMake(beginx-50, beginy-230);
    //CGPoint letterAvalue10 = CGPointMake(beginx-100, beginy-80);
    //CGPoint letterAvalue11 = CGPointMake(beginx+100, beginy-80);
    //CGPoint letterAvalue12 = CGPointMake(beginx+150, beginy-80);
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
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
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"8"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"9"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
}

-(void) createLetterK {
    float beginx = 390;
    float beginy = 670;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    //multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-350);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-400);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-450);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy-500);
    
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

-(void) createLetterL {
    float beginx = 470;
    float beginy = 680;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    //multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-300);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-350);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-400);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-450);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy-500);
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"8"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"9"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"10"];
}

-(void) createLetterM {
    
    float beginx = 320;
    float beginy = 550;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke  = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx-10, beginy-30);
    CGPoint letterAvalue2 = CGPointMake(beginx-10, beginy-90);
    CGPoint letterAvalue3 = CGPointMake(beginx-10, beginy-150);
    CGPoint letterAvalue4 = CGPointMake(beginx-10, beginy-210);
    CGPoint letterAvalue5 = CGPointMake(beginx-10, beginy-270);
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-310);
    
    // Line 2
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-275);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-225);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-175);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy-125);
    CGPoint letterAvalue13 = CGPointMake(beginx+45, beginy-70);
    CGPoint letterAvalue14 = CGPointMake(beginx+90, beginy-50);
    CGPoint letterAvalue15 = CGPointMake(beginx+140, beginy-70);
    CGPoint letterAvalue16 = CGPointMake(beginx+155, beginy-120);
    CGPoint letterAvalue17 = CGPointMake(beginx+155, beginy-170);
    CGPoint letterAvalue18 = CGPointMake(beginx+155, beginy-220);
    CGPoint letterAvalue19 = CGPointMake(beginx+155, beginy-275);
    CGPoint letterAvalue20 = CGPointMake(beginx+190, beginy-275);
    CGPoint letterAvalue21 = CGPointMake(beginx+190, beginy-220);
    CGPoint letterAvalue22 = CGPointMake(beginx+190, beginy-170);
    CGPoint letterAvalue23 = CGPointMake(beginx+190, beginy-120);
    CGPoint letterAvalue24 = CGPointMake(beginx+190, beginy-200);
    CGPoint letterAvalue25 = CGPointMake(beginx+190, beginy-150);
    CGPoint letterAvalue26 = CGPointMake(beginx+260, beginy-50);
    CGPoint letterAvalue27 = CGPointMake(beginx+350, beginy-150);
    CGPoint letterAvalue28 = CGPointMake(beginx+350, beginy-210);
    CGPoint letterAvalue29 = CGPointMake(beginx+350, beginy-270);

    cgpath = CGPathCreateMutable();
    
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
                          letterAvalue19.x+20, letterAvalue19.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue19.x+20, letterAvalue19.y-80,
                          letterAvalue20.x+20, letterAvalue20.y-80,
                          letterAvalue24.x+20, letterAvalue24.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue24.x+80, letterAvalue24.y-80,
                          letterAvalue25.x+80, letterAvalue25.y-80,
                          letterAvalue26.x+80, letterAvalue26.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue26.x+20, letterAvalue26.y-80,
                          letterAvalue27.x+20, letterAvalue27.y-80,
                          letterAvalue29.x+20, letterAvalue29.y-80);
    
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
    
    
    // Line 2
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.9] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23] forKey:@"11"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"12"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"13"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"14"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"15"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"16"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"17"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"18"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"19"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"20"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.9] forKey:@"21"];

    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23] forKey:@"22"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23] forKey:@"23"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"24"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue28]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"25"];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue29]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"26"];

 
}

-(void) createLetterN {
    float beginx = 400;
    float beginy = 560;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy- 50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy - 100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy - 150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy - 200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy - 250);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy - 300);
    CGPoint letterAvalue9 = CGPointMake(beginx+40, beginy-280);
    CGPoint letterAvalue10 = CGPointMake(beginx+40, beginy-230);
    CGPoint letterAvalue11 = CGPointMake(beginx+40, beginy-180);
    CGPoint letterAvalue12 = CGPointMake(beginx+40, beginy-130);
    
    CGPoint letterAvalue13 = CGPointMake(beginx+40, beginy-70);
    
    CGPoint letterAvalue14 = CGPointMake(beginx+40, beginy-30);
    
    CGPoint letterAvalue15 = CGPointMake(beginx+80, beginy-30);
    CGPoint letterAvalue16 = CGPointMake(beginx+120, beginy-20);
    CGPoint letterAvalue17 = CGPointMake(beginx+160, beginy-30);
    CGPoint letterAvalue18 = CGPointMake(beginx+200, beginy-30);
    CGPoint letterAvalue19 = CGPointMake(beginx+200, beginy-80);
    CGPoint letterAvalue20 = CGPointMake(beginx+200, beginy-130);
    CGPoint letterAvalue21 = CGPointMake(beginx+200, beginy-180);
    CGPoint letterAvalue22 = CGPointMake(beginx+200, beginy-230);
    CGPoint letterAvalue23 = CGPointMake(beginx+200, beginy-300);
    
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.0] forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];

}

-(void) createLetterO {
 
    secondStroke = @"up";
    
    float beginx = 570;
    float beginy = 440;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = FALSE;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx-40, beginy+60);
    CGPoint letterAvalue7 = CGPointMake(beginx-90, beginy+60);
    CGPoint letterAvalue9 = CGPointMake(beginx-160, beginy+20);
    CGPoint letterAvalue12 = CGPointMake(beginx-160, beginy-50);
    CGPoint letterAvalue13 = CGPointMake(beginx-150, beginy-140);
    CGPoint letterAvalue14 = CGPointMake(beginx-70, beginy-170);
    CGPoint letterAvalue16 = CGPointMake(beginx, beginy-120);
    CGPoint letterAvalue19 = CGPointMake(beginx, beginy-40);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue7.x+40, letterAvalue7.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue7.x+40, letterAvalue7.y,
                          letterAvalue9.x, letterAvalue9.y-30,
                          letterAvalue12.x, letterAvalue12.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue12.x+40, letterAvalue12.y,
                          letterAvalue13.x, letterAvalue13.y-30,
                          letterAvalue14.x, letterAvalue14.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue14.x+40, letterAvalue14.y,
                          letterAvalue16.x, letterAvalue16.y-30,
                          letterAvalue19.x, letterAvalue19.y-80);
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.0] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.1] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.2] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.3] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.9] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"8"];
    
    
    
}

-(void) createLetterP {
    float beginx = 400;
    float beginy = 550;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-300);
    
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-350);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-400);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-450);
    
    // second point
    CGPoint letterAvalue12 = CGPointMake(beginx+40, beginy-500);
    CGPoint letterAvalue13 = CGPointMake(beginx+40, beginy-550);
    //CGPoint letterAvalue14 = CGPointMake(beginx+40, beginy-600);
    
    
    CGPoint letterAvalue15 = CGPointMake(beginx+40, beginy-570);
    CGPoint letterAvalue16 = CGPointMake(beginx+40, beginy-520);
    
    
    CGPoint letterAvalue17 = CGPointMake(beginx+40, beginy-470);
    CGPoint letterAvalue18 = CGPointMake(beginx+40, beginy-420);
    CGPoint letterAvalue19 = CGPointMake(beginx+40, beginy-370);
    CGPoint letterAvalue20 = CGPointMake(beginx+40, beginy-320);
    CGPoint letterAvalue21 = CGPointMake(beginx+40, beginy-270);
    CGPoint letterAvalue22 = CGPointMake(beginx+40, beginy-220);
    CGPoint letterAvalue23 = CGPointMake(beginx+40, beginy-170);
    CGPoint letterAvalue24 = CGPointMake(beginx+40, beginy-120);
    CGPoint letterAvalue25 = CGPointMake(beginx+40, beginy-70);
    CGPoint letterAvalue26 = CGPointMake(beginx+40, beginy-10);
    CGPoint letterAvalue27 = CGPointMake(beginx+50, beginy-10);
    CGPoint letterAvalue28 = CGPointMake(beginx+100, beginy-10);
    CGPoint letterAvalue29 = CGPointMake(beginx+150, beginy-30);
    CGPoint letterAvalue30 = CGPointMake(beginx+200, beginy-50);
    
    CGPoint letterAvalue31 = CGPointMake(beginx+200, beginy-100);
    CGPoint letterAvalue32 = CGPointMake(beginx+200, beginy-150);
    CGPoint letterAvalue33 = CGPointMake(beginx+200, beginy-200);
    CGPoint letterAvalue34 = CGPointMake(beginx+150, beginy-250);
    CGPoint letterAvalue35 = CGPointMake(beginx+100, beginy-300);
    CGPoint letterAvalue36 = CGPointMake(beginx+50, beginy-310);
    

    

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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"10"];
    
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"10"];
    
    
    //[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    //[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    //[arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue28]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue29]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue30]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue31]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue32]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue33]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue34]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue35]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue36]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
}

-(void) createLetterQ {
    float beginx = 490;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    //multiStroke = TRUE;
    secondStroke = @"up";
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.9] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.0] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.1] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.2] forKey:@"4"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.3] forKey:@"5"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.5] forKey:@"6"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.9] forKey:@"7"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"8"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"8"];
    
    
}

-(void) createLetterR {
    float beginx = 540;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    multiStroke = TRUE;
    secondStroke = @"up";
    
    
    CGPoint letterAvalue1 = CGPointMake(beginx-190, beginy+25);
    CGPoint letterAvalue2 = CGPointMake(beginx-190, beginy-20);
    CGPoint letterAvalue3 = CGPointMake(beginx-190, beginy-70);
    CGPoint letterAvalue4 = CGPointMake(beginx-190, beginy-120);
    CGPoint letterAvalue5 = CGPointMake(beginx-190, beginy-170);
    CGPoint letterAvalue6 = CGPointMake(beginx-190, beginy-220);
    
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
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.0] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"4"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"5"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"6"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"7"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"8"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.9] forKey:@"9"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"10"];
    
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.5] forKey:@"10"];
    
}

-(void) createLetterS {
    
    float beginx = 580;
    float beginy = 480;
    letterBeginX = beginx;
    letterBeginY = beginy;
    multiStroke = FALSE;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx-90, beginy+20);
    CGPoint letterAvalue7 = CGPointMake(beginx-150, beginy-30);
    CGPoint letterAvalue9 = CGPointMake(beginx-110, beginy-80);
    CGPoint letterAvalue12 = CGPointMake(beginx-60, beginy-110);
    CGPoint letterAvalue14 = CGPointMake(beginx-10, beginy-150);
    CGPoint letterAvalue16 = CGPointMake(beginx-65, beginy-200);
    CGPoint letterAvalue19 = CGPointMake(beginx-155, beginy-180);

    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue7.x+40, letterAvalue7.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue7.x+40, letterAvalue7.y-40,
                          letterAvalue9.x+40, letterAvalue9.y-40,
                          letterAvalue12.x+40, letterAvalue12.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue12.x+40, letterAvalue12.y-80,
                          letterAvalue14.x+40, letterAvalue14.y-80,
                          letterAvalue16.x+40, letterAvalue16.y-80);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue16.x+40, letterAvalue16.y-80,
                          letterAvalue19.x+40, letterAvalue19.y-80,
                          letterAvalue19.x+40, letterAvalue19.y-80);
    
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.0] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:19.5] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [arrowObjects setObject:[NSNumber numberWithFloat:20] forKey:@"2"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"3"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21.8] forKey:@"4"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.3] forKey:@"5"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.0] forKey:@"6"];

    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [arrowObjects setObject:[NSNumber numberWithFloat:18.0] forKey:@"7"];

}

-(void) createLetterT {
    
    float beginx = 490;
    float beginy = 560;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx-20, beginy+40);
    CGPoint letterAvalue2 = CGPointMake(beginx-20, beginy-35);
    CGPoint letterAvalue3 = CGPointMake(beginx-20, beginy-80);
    CGPoint letterAvalue4 = CGPointMake(beginx-20, beginy-125);
    CGPoint letterAvalue5 = CGPointMake(beginx-20, beginy-180);
    CGPoint letterAvalue6 = CGPointMake(beginx-20, beginy-225);
    CGPoint letterAvalue7 = CGPointMake(beginx-20, beginy-270);
    CGPoint letterAvalue8 = CGPointMake(beginx-20, beginy-310);
    CGPoint letterAvalue9 = CGPointMake(beginx-150, beginy);
    CGPoint letterAvalue10 = CGPointMake(beginx-110, beginy);
    CGPoint letterAvalue11 = CGPointMake(beginx-60, beginy);
    CGPoint letterAvalue12 = CGPointMake(beginx-10, beginy);
    CGPoint letterAvalue13 = CGPointMake(beginx+30, beginy);
    CGPoint letterAvalue14 = CGPointMake(beginx+90, beginy);
    
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
    
    cgpath = CGPathCreateMutable();
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x+40,letterAvalue1.y-40,
                          letterAvalue4.x+40,letterAvalue4.y-40,
                          letterAvalue8.x+40, letterAvalue8.y-40);
    
    //CGPathMoveToPoint(cgpath, NULL, letterAvalue10.x, letterAvalue10.y);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue10.x+40, letterAvalue10.y-40,
                          letterAvalue12.x+40, letterAvalue12.y-40,
                          letterAvalue14.x+40, letterAvalue14.y-80);
    
    
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"0"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"1"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"2"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:20.5] forKey:@"3"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"4"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"5"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"6"];
    
    [arrowObjects setObject:[NSNumber numberWithFloat:23.5] forKey:@"7"];


}

-(void) createLetterU {
    float beginx = 450;
    float beginy = 500;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx+30, beginy-210);
    CGPoint letterAvalue8 = CGPointMake(beginx+80, beginy-220);
    CGPoint letterAvalue9 = CGPointMake(beginx+130, beginy-230);
    CGPoint letterAvalue10 = CGPointMake(beginx+180, beginy-180);
    CGPoint letterAvalue11 = CGPointMake(beginx+180, beginy-120);
    CGPoint letterAvalue12 = CGPointMake(beginx+180, beginy - 70);
    CGPoint letterAvalue13 = CGPointMake(beginx+180, beginy - 10);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
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
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
}

-(void) createLetterV {
    float beginx = 500;
    float beginy = 470;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx+50, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx+80, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx+110, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx+140, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx+170, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx+200, beginy-200);
    CGPoint letterAvalue9 = CGPointMake(beginx+230, beginy-150);
    CGPoint letterAvalue10 = CGPointMake(beginx+260, beginy-100);
    CGPoint letterAvalue11 = CGPointMake(beginx+290, beginy-50);
    CGPoint letterAvalue12 = CGPointMake(beginx+320, beginy);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
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

-(void) createLetterW {
    float beginx = 500;
    float beginy = 470;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx+50, beginy-50);
    CGPoint letterAvalue4 = CGPointMake(beginx+100, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx+150, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx+200, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx+250, beginy-250);
    CGPoint letterAvalue8 = CGPointMake(beginx+300, beginy-200);
    CGPoint letterAvalue9 = CGPointMake(beginx+350, beginy-150);
    CGPoint letterAvalue10 = CGPointMake(beginx+400, beginy-100);
    CGPoint letterAvalue11 = CGPointMake(beginx+450, beginy-50);
    CGPoint letterAvalue12 = CGPointMake(beginx+500, beginy);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
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

-(void) createLetterX {
    float beginx = 360;
    float beginy = 540;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx+40, beginy-60);
    CGPoint letterAvalue4 = CGPointMake(beginx+90, beginy-130);
    CGPoint letterAvalue5 = CGPointMake(beginx+140, beginy-160);
    CGPoint letterAvalue6 = CGPointMake(beginx+190, beginy-220);
    CGPoint letterAvalue7 = CGPointMake(beginx+240, beginy-280);
    CGPoint letterAvalue8 = CGPointMake(beginx+220, beginy-270);
    CGPoint letterAvalue9 = CGPointMake(beginx+170, beginy-230);
    CGPoint letterAvalue10 = CGPointMake(beginx+120, beginy-180);
    CGPoint letterAvalue11 = CGPointMake(beginx+90, beginy-220);
    CGPoint letterAvalue12 = CGPointMake(beginx+40, beginy-270);
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:21] forKey:@"2"];
    
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

-(void) createLetterY {
    float beginx = 500;
    float beginy = 470;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
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
    
    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
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

-(void) createLetterZ {
    float beginx = 370;
    float beginy = 530;
    letterBeginX = beginx;
    letterBeginY = beginy;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue3 = CGPointMake(beginx+40, beginy);
    CGPoint letterAvalue4 = CGPointMake(beginx+80, beginy);
    CGPoint letterAvalue5 = CGPointMake(beginx+120, beginy);
    CGPoint letterAvalue6 = CGPointMake(beginx+160, beginy);
    CGPoint letterAvalue7 = CGPointMake(beginx+110, beginy-20);
    CGPoint letterAvalue8 = CGPointMake(beginx+60, beginy-90);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-140);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-190);
    CGPoint letterAvalue11 = CGPointMake(beginx-20, beginy-220);
    CGPoint letterAvalue12 = CGPointMake(beginx-40, beginy-240);
    
    CGPoint letterAvalue13 = CGPointMake(beginx+40, beginy - 240);
    CGPoint letterAvalue14 = CGPointMake(beginx+80, beginy - 240);
    CGPoint letterAvalue15 = CGPointMake(beginx+120, beginy - 240);
    CGPoint letterAvalue16 = CGPointMake(beginx+160, beginy - 240);

    cgpath = CGPathCreateMutable();
    
    CGPathMoveToPoint(cgpath, NULL, beginx, beginy);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue1.x,letterAvalue1.y-40,
                          letterAvalue4.x,letterAvalue4.y-40,
                          letterAvalue6.x, letterAvalue6.y-40);
    
    CGPathAddCurveToPoint(cgpath, NULL,
                          letterAvalue6.x, letterAvalue6.y,
                          letterAvalue9.x, letterAvalue9.y-60,
                          letterAvalue12.x+40, letterAvalue12.y-100);
    
    /*CGPathAddCurveToPoint(cgpath, NULL,
     letterAvalue18.x+80, letterAvalue18.y-10,
     letterAvalue19.x+80, letterAvalue19.y-10,
     letterAvalue20.x+70, letterAvalue20.y);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"0"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"1"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"2"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22] forKey:@"3"];
    
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
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [arrowObjects setObject:[NSNumber numberWithFloat:22.0] forKey:@"10"];

    
}


@end
