//
//  Chooser.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 11/16/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "Chooser.h"
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


SKLabelNode *groupOne;
SKLabelNode *groupTwo;
SKLabelNode *groupThree;
SKLabelNode *groupFour;
SKLabelNode *groupFive;

NSString *secondStroke;
CGFloat width;
CGFloat height;
//float letterBeginX = 0;
//float letterBeginY = 0;
//int timerForLetter = 0;

@implementation Chooser

@end
