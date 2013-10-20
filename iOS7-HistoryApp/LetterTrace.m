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
NSMutableArray *starsForPoints;
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


@synthesize background, selectedNode;


-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        sharedData = [MontessoriData sharedManager];
        slv = [[SmoothLineView alloc]initWithFrame:CGRectMake(0, 0, 1024, 768)];
        
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        
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
        
        self.userInteractionEnabled = YES;
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        SKSpriteNode *gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_wood.jpg"];
        gridPaper.position = CGPointMake(size.width/2, size.height/2-100);
        [self addChild:gridPaper];
        
        letterA = sharedData.letterA;
        
        
        letterA.position = CGPointMake(400, 200);
        
        letterB = sharedData.letterB;
        letterC = sharedData.letterC;
        letterD = sharedData.letterD;
        letterE = sharedData.letterE;
        letterF = sharedData.letterF;
        letterG = sharedData.letterG;
        letterH = sharedData.letterH;
        letterI = sharedData.letterI;
        letterJ = sharedData.letterJ;
        letterK = sharedData.letterK;
        letterL = sharedData.letterL;
        letterM = sharedData.letterM;
        letterN = sharedData.letterN;
        letterO = sharedData.letterO;
        letterP = sharedData.letterP;
        letterQ = sharedData.letterQ;
        letterR = sharedData.letterR;
        letterS = sharedData.letterS;
        letterT = sharedData.letterT;
        letterU = sharedData.letterU;
        letterV = sharedData.letterV;
        letterW = sharedData.letterW;
        letterX = sharedData.letterX;
        letterY = sharedData.letterY;
        letterZ = sharedData.letterZ;
        
        [self createLetters];
        
        [groupOneLetters addObject:letterA];
        [groupOneLetters addObject:letterB];
        [groupOneLetters addObject:letterC];
        [groupOneLetters addObject:letterM];
        [groupOneLetters addObject:letterS];
        [groupOneLetters addObject:letterT];
        
        [groupTwoLetters addObject:letterG];
        [groupTwoLetters addObject:letterR];
        [groupTwoLetters addObject:letterD];
        [groupTwoLetters addObject:letterF];
        [groupTwoLetters addObject:letterO];
        
        [groupThreeLetters addObject:letterP];
        [groupThreeLetters addObject:letterN];
        [groupThreeLetters addObject:letterL];
        [groupThreeLetters addObject:letterH];
        [groupThreeLetters addObject:letterI];
        
        [groupFourLetters addObject:letterZ];
        [groupFourLetters addObject:letterE];
        [groupFourLetters addObject:letterX];
        [groupFourLetters addObject:letterK];
        [groupFourLetters addObject:letterQ];
        
        [groupFiveLetters addObject:letterV];
        [groupFiveLetters addObject:letterW];
        [groupFiveLetters addObject:letterJ];
        [groupFiveLetters addObject:letterU];
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
        
        
        firstPencil = [SKSpriteNode spriteNodeWithImageNamed:@"orange-pencil.png"];
        secondPencil = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-pencil.png"];
        thirdPencil = [SKSpriteNode spriteNodeWithImageNamed:@"green-pencil.png"];
        fourthPencil = [SKSpriteNode spriteNodeWithImageNamed:@"green-pencil.png"];
        fifthPencil = [SKSpriteNode spriteNodeWithImageNamed:@"green-pencil.png"];
        
        firstPencil.name = @"group1";
        secondPencil.name = @"group2";
        thirdPencil.name = @"group3";
        fourthPencil.name = @"group4";
        fifthPencil.name = @"group5";
        
        firstPencil.scale = 0.6;
        secondPencil.scale = 0.6;
        thirdPencil.scale = 0.6;
        fourthPencil.scale = 0.6;
        fifthPencil.scale = 0.6;
        
        
        [self addChild:firstPencil];
        firstPencil.position = CGPointMake(50,650);
        
        /*[self addChild:secondPencil];
        secondPencil.position = CGPointMake(900, 100);
        
        [self addChild:thirdPencil];
        thirdPencil.position = CGPointMake(930, 100);
        
        [self addChild:fourthPencil];
        fourthPencil.position = CGPointMake(960, 100);
        
        [self addChild:fifthPencil];
        fifthPencil.position = CGPointMake(990, 100);*/
        
        int i = 1;
        
        for (SKSpriteNode *letterSprite in groupOneLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(900,550 - i);
            [self addChild:letterSprite];
            i += 50;
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupTwoLetters) {
            letterSprite.scale = 0.1;
            letterSprite.anchorPoint = CGPointMake(0.5,1.0);
            
            letterSprite.position = CGPointMake(100 + i,720);
            [self addChild:letterSprite];
            i += 50;
            
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupThreeLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(600 + i,720);
  
            [self addChild:letterSprite];
            i += 50;
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupFourLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(100 + i,650);

            [self addChild:letterSprite];
            i += 50;
        }
        
        i = 1;
        
        for (SKSpriteNode *letterSprite in groupFiveLetters) {
            
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(600+i,650);
 
            [self addChild:letterSprite];
            i += 50;
        
        }
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow_left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        [self nextQuestion];
        
    }
    
    return self;
    
}

-(void) setupHUD {
    
    
}


-(void) nextQuestion {
    
    pointsForSprite = [[NSMutableArray alloc]init];
    pointsForSprite2 = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    spriteFromPoint2 = [[NSMutableArray alloc]init];
    starsForPoints = [[NSMutableArray alloc]init];
    controlPoints = [[NSMutableArray alloc]init];
    
    
    float startPointX;
    float startPointY;
    
    multiStroke = FALSE;
    separateStroke = FALSE;
    firstStrokeComplete = FALSE;
    arrowAdded = FALSE;
    
    if (onWhichQuestion == 0) {

        [self createLetterA];
        letterA.position = CGPointMake(500, 300);
        letterA.scale = 1.0;
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"left-green-arrow.png"];
        handPointer.position = CGPointMake(580, 425);
        handPointer.zPosition = 10;
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:+10 y:0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleXTo:2.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];

        letterB.scale = 0.1;
        startPointX = 150;
        startPointY = 80;
    
    }
    else if (onWhichQuestion == 1) {
    
        [self createLetterB];

        SKAction *moveLetterA = [SKAction moveTo:CGPointMake(100, 120) duration:1.0];
        SKAction *scaleLetterA = [SKAction scaleTo:0.1 duration:1.0];
        [letterA runAction:moveLetterA];
        [letterA runAction:scaleLetterA];
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"down-arrow.png"];
        handPointer.position = CGPointMake(400,670);
        handPointer.zPosition = 10;
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleYTo:2.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        
        
        SKAction *moveLetterB = [SKAction moveTo:CGPointMake(500, 400) duration:1.0];
        letterB.scale = 1.0;
        [letterB runAction:moveLetterB];
        
    
    }
    
    else if (onWhichQuestion == 2) {
    
        [self createLetterC];
        
        SKAction *moveLetterB = [SKAction moveTo:CGPointMake(100, 170) duration:1.0];
        SKAction *scaleLetterB = [SKAction scaleTo:0.1 duration:1.0];
        
        [letterB runAction:moveLetterB];
        [letterB runAction:scaleLetterB];
        
        letterC.scale = 1.0;
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"left-green-arrow.png"];
        handPointer.position = CGPointMake(640, 360);
        handPointer.zPosition = 10;
        
        [self addChild:handPointer];
        
        SKAction *moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        SKAction *moveDown = [SKAction moveByX:+10 y:0 duration:0.3];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
        SKAction *scaleUp = [SKAction scaleXTo:2.2 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[moveUp,moveDown,scaleUp,moveUp,moveDown,repeatmoveUpDown, repeatmoveUpDown2,[SKAction removeFromParent]]];
        [handPointer runAction:sequenceArrow];
        SKAction *moveLetterC = [SKAction moveTo:CGPointMake(500, 300) duration:1.0];
        [letterC runAction:moveLetterC];
    }
    
    else if (onWhichQuestion == 3) {


        [self createLetterM];
        
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
        
        [self finishedWithGroup];
        
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
    NSLog(@"points for sprite %i", [pointsForSprite count]);
    
    
    SKAction *rotateCircle = [SKAction rotateToAngle:360 duration:60];
    SKAction *keepSpinning = [SKAction repeatActionForever:rotateCircle];
    
    for (NSValue *pointValue in pointsForSprite) {
        
        SKSpriteNode *spritePoint;
        
        if (onWhichQuestion == 0) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        } else if (onWhichQuestion == 1) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        } else if (onWhichQuestion == 2) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        } else if (onWhichQuestion == 3) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        } else if (onWhichQuestion == 4) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        } else if (onWhichQuestion == 5) {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        } else {
            spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        }
        CGPoint finalLocation = [pointValue CGPointValue];

        spritePoint.position = CGPointMake(finalLocation.x+300, finalLocation.y+400);
        spritePoint.scale = 0.1;
        spritePoint.name = @"wheel";
        [self addChild:spritePoint];
        
        float moveTime = 0.1 * (float)spritePointCount;
        SKAction *movePointsX = [SKAction moveToX:finalLocation.x+startPointX duration:moveTime];
        SKAction *movePointsY = [SKAction moveToY:finalLocation.y+startPointY duration:moveTime];
        
        
        [spritePoint runAction:movePointsX];
        [spritePoint runAction:movePointsY];
        //[spritePoint runAction:keepSpinning];
        [spriteFromPoint addObject:spritePoint];
        if (spritePointCount == 0) {
            
            [spritePoint runAction:keepSpinning];
            [spritePoint runAction:[SKAction scaleTo:0.7 duration:0.5]];
            [spritePoint runAction:[SKAction scaleTo:0.3 duration:0.5]];
            
            
        }
        spritePointCount++;
    }
    
    if (multiStroke == TRUE) {
        NSLog(@"multi-stroke");
        for (NSValue *pointValue in pointsForSprite2) {
            //SKSpriteNode *spritePoint2 = [SKSpriteNode spriteNodeWithImageNamed:@"sprite639.png"];
            SKSpriteNode *spritePoint2 = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
            CGPoint finalLocation = [pointValue CGPointValue];
            spritePoint2.position = CGPointMake(finalLocation.x+300, finalLocation.y+400);
            spritePoint2.scale = 0.3;
            spritePoint2.name = @"pixie";
            spritePoint2.alpha = 0.0;
            [self addChild:spritePoint2];
            float moveTime = 0.07 * (float)spritePointCount;
            SKAction *movePointsX = [SKAction moveToX:finalLocation.x+startPointX duration:moveTime];
            SKAction *movePointsY = [SKAction moveToY:finalLocation.y+startPointY duration:moveTime];
            
            
            [spritePoint2 runAction:movePointsX];
            [spritePoint2 runAction:movePointsY];
            [spritePoint2 runAction:keepSpinning];
            [spriteFromPoint2 addObject:spritePoint2];
            spritePointCount++;
        }
    }
    
}


-(void)arrowPointerToDraw:(NSString *)direction location:(CGPoint)pointForArrow {
    
    SKAction *moveUp;
    SKAction *moveDown;
    SKAction *repeatmoveUpDown;
    SKAction *repeatmoveUpDown2;
    
    if ([direction isEqualToString:@"down"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"down-arrow.png"];
        
        moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"up"]) {
        
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"up-arrow.png"];
        moveUp = [SKAction moveByX:0 y:10.0 duration:0.3];
        moveDown = [SKAction moveByX:0 y:-10.0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"left"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"left-green-arrow.png"];
        moveUp = [SKAction moveByX:-10 y:0 duration:0.3];
        moveDown = [SKAction moveByX:10 y:0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    } else if ([direction isEqualToString:@"right"]) {
        handPointer = [SKSpriteNode spriteNodeWithImageNamed:@"right-arrow"];
        moveUp = [SKAction moveByX:10 y:0 duration:0.3];
        moveDown = [SKAction moveByX:-10 y:0 duration:0.3];
        repeatmoveUpDown = [SKAction repeatAction:moveUp count:3];
        repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:3];
        
    }
    
    
    handPointer.position = pointForArrow;
    handPointer.zPosition = 10;
    [self addChild:handPointer];
    
    SKAction *scaleUp = [SKAction scaleYTo:2.2 duration:0.6];
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
    
   
    
    if (CGRectContainsPoint(backToMainMenuArrow.frame, theTouch)) {
        SKView *spriteView = (SKView *)self.view;
        IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];
    }
    
    
    if(pointsForSprite != NULL) {
        NSValue *pointForFirstSpriteNSV = [pointsForSprite objectAtIndex:0];
        CGPoint spritePoint = [pointForFirstSpriteNSV CGPointValue];
        CGRect spritePointRect = CGRectMake(spritePoint.x-10, spritePoint.y-10, 20, 20);
    
    
        if (CGRectContainsPoint (spritePointRect, theTouch)) {
        
            NSLog(@"hit first point");
            firstPointTest = TRUE;
        }
        
    }
    
    
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    previousPoint2 = previousPoint;
    previousPoint = [touch previousLocationInNode:self];
    deltaPoint = CGPointSubtract(theTouch, previousPoint);
    
    
    if(pointsForSprite != NULL) {
        NSValue *pointForFirstSpriteNSV = [pointsForSprite objectAtIndex:0];
        CGPoint spritePoint = [pointForFirstSpriteNSV CGPointValue];
        CGRect spritePointRect = CGRectMake(spritePoint.x-10, spritePoint.y-10, 20, 20);
        
        
        if (CGRectContainsPoint (spritePointRect, theTouch)) {
            
            NSLog(@"hit first point");
            firstPointTest = TRUE;
        }
        
    }
    
    for (SKSpriteNode *pointHit in spriteFromPoint) {

        CGRect myControlPoint = CGRectMake(pointHit.position.x-20, pointHit.position.y-20, 35, 35);
        
        if (CGRectContainsPoint(myControlPoint, theTouch)) {
            
            SKSpriteNode *goldStar = [SKSpriteNode spriteNodeWithImageNamed:@"star_100x100.png"];
            goldStar.position = pointHit.position;
            [goldStar setScale:0.3];
            [self addChild:goldStar];

            SKAction *growGoldStar = [SKAction scaleTo:0.3 duration:0.05];
            SKAction *growGoldStarY = [SKAction scaleYTo:1.0 duration:0.05];
            SKAction *growGoldStar2 = [SKAction scaleTo:0.2 duration:0.05];
            SKAction *growAndShrink = [SKAction sequence:@[growGoldStar,growGoldStarY,growGoldStar2]];
            
            
            SKAction *upAction = [SKAction moveByX:-10.90f y:20.0f duration:0.2];
            upAction.timingMode = SKActionTimingEaseOut;
            SKAction *downAction = [SKAction moveByX:-400.0f y:0.0f duration:0.2];
            downAction.timingMode = SKActionTimingEaseIn;
            
            [goldStar runAction:growAndShrink];
            [starsForPoints addObject:goldStar];
            
            if ([spriteFromPoint count] <= [starsForPoints count]) {
                firstStrokeComplete = TRUE;
                for (SKSpriteNode *secondPointHit in spriteFromPoint2) {
                    secondPointHit.alpha = 1.0;
                }
            }

            SKAction *remove = [SKAction removeFromParent];
            [pointHit runAction:[SKAction sequence:@[upAction,downAction,remove]]];
            
            /*NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
            SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
            openEffect.position = goldStar.position;
            openEffect.targetNode = self.scene;
            
            [self addChild:openEffect];*/
            
        }
        
    }
 
    
    if (multiStroke && firstStrokeComplete) {
        
        for (SKSpriteNode *pointHit in spriteFromPoint2) {
        
            CGRect myControlPoint = CGRectMake(pointHit.position.x-20, pointHit.position.y-20, 35, 35);
        
            if (CGRectContainsPoint(myControlPoint, theTouch)) {
            
                SKSpriteNode *goldStar = [SKSpriteNode spriteNodeWithImageNamed:@"star_100x100.png"];
                goldStar.position = pointHit.position;
                [goldStar setScale:0.3];
                [self addChild:goldStar];
            
            
                SKAction *growGoldStar = [SKAction scaleTo:0.3 duration:0.5];
                SKAction *growGoldStarY = [SKAction scaleYTo:1.0 duration:0.5];
                SKAction *growGoldStar2 = [SKAction scaleTo:0.2 duration:0.5];
                growGoldStar.timingMode = SKActionTimingEaseOut;
                growGoldStarY.timingMode = SKActionTimingEaseIn;
                
                SKAction *growAndShrink = [SKAction sequence:@[growGoldStar,growGoldStarY,growGoldStar2]];
            
            
                SKAction *upAction = [SKAction moveByX:0.0f y:10.0f duration:1.0];
                upAction.timingMode = SKActionTimingEaseOut;
                SKAction *downAction = [SKAction moveByX:-10.0f y:-10.0 duration:1.0];
                downAction.timingMode = SKActionTimingEaseOut;
            
                [goldStar runAction:growAndShrink];
                [starsForPoints addObject:goldStar];
            
                SKAction *remove = [SKAction removeFromParent];
                [pointHit runAction:[SKAction sequence:@[upAction,downAction,remove]]];
            
                /*NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
                SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
                openEffect.position = goldStar.position;
                openEffect.targetNode = self.scene;
            
                [self addChild:openEffect];*/
            
            
            }
        }
    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self removeSpriteFromScene];

    if (firstPointTest) {
        for (SKSpriteNode *spritePoint in spriteFromPoint) {
        
            SKAction *moveTest = [SKAction moveTo:CGPointMake(0, 0) duration:0.1];
            [spritePoint removeFromParent];
            //[spritePoint runAction:moveTest];
        }
    
        for (SKSpriteNode *starWin in starsForPoints) {
            [starWin removeFromParent];
        }
    
        if (multiStroke) {
            for (SKSpriteNode *pinWheel in spriteFromPoint2) {
                [pinWheel removeFromParent];
            }
        }

        firstPointTest = FALSE;
        onWhichQuestion++;
        if (onWhichQuestion < 7) {
            [self nextQuestion];
        }
    }
    
}

-(void) checkCollisions {
    
    [self enumerateChildNodesWithName:@"wheel" usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *wheel = (SKSpriteNode *)node;
        
    }];
    
}



-(void)update:(NSTimeInterval)currentTime {
    
    if (multiStroke && firstStrokeComplete && arrowAdded == FALSE) {
        
        
        if ([secondStroke isEqualToString:@"up"]) {
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            [self arrowPointerToDraw:@"up" location:[theArrowPoint CGPointValue]];

            
        } else if ([secondStroke isEqualToString:@"down"]) {
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            [self arrowPointerToDraw:@"down" location:[theArrowPoint CGPointValue]];

            
        } else if ([secondStroke isEqualToString:@"left"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            [self arrowPointerToDraw:@"left" location:[theArrowPoint CGPointValue]];
            
            
        } else if ([secondStroke isEqualToString:@"right"]) {
            
            NSValue *theArrowPoint = [pointsForSprite2 objectAtIndex:0];
            
            [self arrowPointerToDraw:@"right" location:[theArrowPoint CGPointValue]];
            
            
        }
        
        
        
        
        /*SKSpriteNode *arrowPoint = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-cloud.png"];
        arrowPoint.scale = 0.1;
        NSValue *pointValue = [pointsForSprite2 objectAtIndex:0];
        CGPoint finalLocation = [pointValue CGPointValue];
        finalLocation.y -= 100;
        
        arrowPoint.position = finalLocation;
        
        
        SKAction *rotateArrow = [SKAction rotateByAngle:M_PI+30 duration:0.1];
        SKAction *moveUp = [SKAction moveByX:0.0 y:+10 duration:0.85];
        SKAction *moveDown = [SKAction moveByX:0.0 y:-15 duration:0.85];
        SKAction *repeatmoveUpDown = [SKAction repeatAction:moveUp count:10];
        SKAction *repeatmoveUpDown2  = [SKAction repeatAction:moveDown count:10];
        
        SKAction *scaleUp = [SKAction scaleYTo:0.3 duration:0.6];
        
        SKAction *sequenceArrow = [SKAction sequence:@[rotateArrow, moveUp,moveDown,moveUp,moveDown,[SKAction removeFromParent]]];
        [arrowPoint runAction:sequenceArrow];
        
        
        [self addChild:arrowPoint];*/
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
    //[self addChild:letterA];
    //letterA.position = CGPointMake (400,420);
    //letterA.scale = 0.5;
    
    float beginx = 400;
    float beginy = 340;
    multiStroke = TRUE;
    secondStroke = @"down";
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx - 20, beginy + 5);
    CGPoint letterAvalue3 = CGPointMake(beginx - 40, beginy + 5);
    CGPoint letterAvalue4 = CGPointMake(beginx - 60, beginy + 5);
    CGPoint letterAvalue5 = CGPointMake(beginx - 80, beginy + 0);
    CGPoint letterAvalue6 = CGPointMake(beginx - 110, beginy - 15);
    CGPoint letterAvalue7 = CGPointMake(beginx - 130, beginy - 40);
    CGPoint letterAvalue8 = CGPointMake(beginx - 137, beginy - 60);
    CGPoint letterAvalue9 = CGPointMake(beginx - 145, beginy - 85);
    CGPoint letterAvalue10 = CGPointMake(beginx - 145, beginy - 105);
    CGPoint letterAvalue11 = CGPointMake(beginx - 145, beginy - 125);
    CGPoint letterAvalue12 = CGPointMake(beginx - 145, beginy - 155);
    CGPoint letterAvalue13 = CGPointMake(beginx - 137, beginy - 180);
    CGPoint letterAvalue14 = CGPointMake(beginx - 115, beginy - 210);
    CGPoint letterAvalue15 = CGPointMake(beginx - 75, beginy - 230);
    CGPoint letterAvalue16 = CGPointMake(beginx - 35, beginy - 230);
    CGPoint letterAvalue17 = CGPointMake(beginx - 10, beginy - 220);
    CGPoint letterAvalue18 = CGPointMake(beginx + 20, beginy - 170);
    CGPoint letterAvalue19 = CGPointMake(beginx + 30, beginy - 130);
    CGPoint letterAvalue20 = CGPointMake(beginx + 30, beginy - 100);
    CGPoint letterAvalue21 = CGPointMake(beginx + 30, beginy - 30);
    CGPoint letterAvalue22 = CGPointMake(beginx +45, beginy - 30);
    CGPoint letterAvalue23 = CGPointMake(beginx + 45, beginy - 100);
    CGPoint letterAvalue24 = CGPointMake(beginx + 45, beginy - 180);
    CGPoint letterAvalue25 = CGPointMake(beginx + 45, beginy - 220);
    /*CGPoint letterAvalue26 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue27 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue28 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue29 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue30 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue31 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue32 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue33 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue34 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue35 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue36 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue37 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue38 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue39 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue40 = CGPointMake(beginx - 145, beginy + 5);
    CGPoint letterAvalue41 = CGPointMake(beginx - 145, beginy + 5);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    ///[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
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
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    /*[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue26]];
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
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue41]];*/
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue42]];
    
    for (NSValue *pointValue in pointsForSprite) {
        
        SKSpriteNode *spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        CGPoint finalLocation = [pointValue CGPointValue];
        
        spritePoint.position = CGPointMake(finalLocation.x+300, finalLocation.y+400);
        spritePoint.scale = 0.1;
        //[self addChild:spritePoint];
        
        /*float moveTime = 0.1 * (float)spritePointCount;
        SKAction *movePointsX = [SKAction moveToX:finalLocation.x+startPointX duration:moveTime];
        SKAction *movePointsY = [SKAction moveToY:finalLocation.y+startPointY duration:moveTime];
        
        
        [spritePoint runAction:movePointsX];
        [spritePoint runAction:movePointsY];
        [spritePoint runAction:keepSpinning];*/
        [spriteFromPoint addObject:spritePoint];

    }
    
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
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
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
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    //[pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue28]];
    

}

-(void) createLetterC {
    
    //letterC.position = CGPointMake(400,420);
    //[self addChild:letterC];
    float beginx = 600;
    float beginy = 360;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy+25);
    CGPoint letterAvalue2 = CGPointMake(beginx-30, beginy+35);
    CGPoint letterAvalue3 = CGPointMake(beginx-70, beginy+50);
    CGPoint letterAvalue4 = CGPointMake(beginx-110, beginy+60);
    CGPoint letterAvalue5 = CGPointMake(beginx-150, beginy+40);
    CGPoint letterAvalue6 = CGPointMake(beginx-180, beginy+0);
    CGPoint letterAvalue7 = CGPointMake(beginx-180, beginy-60);
    CGPoint letterAvalue8 = CGPointMake(beginx-180, beginy-100);
    CGPoint letterAvalue9 = CGPointMake(beginx-150, beginy-140);
    CGPoint letterAvalue10 = CGPointMake(beginx-110, beginy-170);
    CGPoint letterAvalue11 = CGPointMake(beginx-70, beginy-170);
    CGPoint letterAvalue12 = CGPointMake(beginx, beginy - 150);
    /*CGPoint letterAvalue13 = CGPointMake(beginx-120, beginy+45);
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
    CGPoint letterAvalue41 = CGPointMake(430, 360);*/
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    /*[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
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
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue25]];
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
    
    CGPoint letterAvalue1 = CGPointMake(beginx-10, beginy);
    CGPoint letterAvalue2 = CGPointMake(beginx-10, beginy-50);
    CGPoint letterAvalue3 = CGPointMake(beginx-10, beginy-75);
    CGPoint letterAvalue4 = CGPointMake(beginx-10, beginy-100);
    CGPoint letterAvalue5 = CGPointMake(beginx-10, beginy-150);
    CGPoint letterAvalue6 = CGPointMake(beginx-10, beginy-200);
    CGPoint letterAvalue7 = CGPointMake(beginx-10, beginy-225);
    CGPoint letterAvalue8 = CGPointMake(beginx-10, beginy-260);
    CGPoint letterAvalue9 = CGPointMake(beginx+10, beginy-255);
    CGPoint letterAvalue10 = CGPointMake(beginx+10, beginy-225);
    CGPoint letterAvalue11 = CGPointMake(beginx+10, beginy-200);
    CGPoint letterAvalue12 = CGPointMake(beginx+10, beginy-150);
    CGPoint letterAvalue13 = CGPointMake(beginx+10, beginy-100);
    CGPoint letterAvalue14 = CGPointMake(beginx+25, beginy-70);
    CGPoint letterAvalue15 = CGPointMake(beginx+50, beginy-20);
    CGPoint letterAvalue16 = CGPointMake(beginx+75, beginy-70);
    CGPoint letterAvalue17 = CGPointMake(beginx+75, beginy-100);
    CGPoint letterAvalue18 = CGPointMake(beginx+75, beginy-150);
    CGPoint letterAvalue19 = CGPointMake(beginx+75, beginy-225);
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
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [pointsForSprite2 addObject:[NSValue valueWithCGPoint:letterAvalue13]];
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
    CGPoint letterAvalue6 = CGPointMake(beginx-150, beginy+10);
    CGPoint letterAvalue7 = CGPointMake(beginx-160, beginy);
    CGPoint letterAvalue8 = CGPointMake(beginx-160, beginy-30);
    CGPoint letterAvalue9 = CGPointMake(beginx-150, beginy-30);
    CGPoint letterAvalue10 = CGPointMake(beginx-120, beginy-70);
    CGPoint letterAvalue11 = CGPointMake(beginx-90, beginy-110);
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

-(void) createLetterT {
    
    float beginx = 400;
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
