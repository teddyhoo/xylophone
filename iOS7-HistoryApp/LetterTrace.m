//
//  LetterTrace.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "LetterTrace.h"
#import <AVFoundation/AVFoundation.h>
#import "IntroScreen.h"
#import "LowerCaseLetter.h"
#import "MontessoriData.h"

@implementation LetterTrace


MontessoriData *sharedData;

NSMutableArray *menuOptions;
NSMutableArray *letterProblems;
NSMutableArray *controlPointSprites;
NSMutableArray *pointsForSprite;
NSMutableArray *spriteFromPoint;

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

int onWhichQuestion;
int onWhichGroup;

BOOL firstPointTest;



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


@synthesize background, selectedNode;


-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    if (self) {
        
        sharedData = [MontessoriData sharedManager];
        
        onWhichQuestion = 0;
        onWhichGroup = 0;
        
        firstPointTest = FALSE;
        
        
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
        
        SKSpriteNode *gridPaper = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_test_1.jpg"];
        gridPaper.position = CGPointMake(size.width/2, size.height/2);
        gridPaper.scale = 0.5;
        [self addChild:gridPaper];
        
        letterA = [sharedData createLetterA];
        letterA.userInteractionEnabled = NO;
        
        letterB = [sharedData createLetterB];
        
        letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"b_850x600.png"];
        
        NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"letter-B-sound" withExtension:@"mp3"];
        letterB.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterBurl error:nil];
        letterB.name = @"B";
        
        
        letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-c.png"];
        NSURL *letterCurl = [[NSBundle mainBundle]URLForResource:@"letterCsound" withExtension:@"mp3"];
        letterC.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterCurl error:nil];
        letterC.name = @"C";
        
        letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-d.png"];
        NSURL *letterDurl = [[NSBundle mainBundle]URLForResource:@"letterDsound" withExtension:@"mp3"];
        letterD.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterDurl error:nil];
        letterD.name = @"D";
        
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
        
        letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-m.png"];
        NSURL *letterMurl = [[NSBundle mainBundle]URLForResource:@"letterMsound" withExtension:@"mp3"];
        letterM.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterMurl error:nil];
        letterM.name = @"M";
        
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
        
        letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-s.png"];
        NSURL *letterSurl = [[NSBundle mainBundle]URLForResource:@"letterSsound" withExtension:@"mp3"];
        letterS.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterSurl error:nil];
        letterS.name = @"S";
        
        letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-t.png"];
        NSURL *letterTurl = [[NSBundle mainBundle]URLForResource:@"letterTsound" withExtension:@"mp3"];
        letterT.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterTurl error:nil];
        letterT.name = @"T";
        
        letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-u.png"];
        NSURL *letterUurl = [[NSBundle mainBundle]URLForResource:@"letterUsound" withExtension:@"mp3"];
        letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterUurl error:nil];
        letterA.name = @"U";
        
        letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"lower-v.png"];
        NSURL *letterVurl = [[NSBundle mainBundle]URLForResource:@"letterVsound" withExtension:@"mp3"];
        letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterVurl error:nil];
        letterA.name = @"V";
        
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
        letterZ.name = @"Z";
        
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
        
        
        firstPencil = [SKSpriteNode spriteNodeWithImageNamed:@"popsicle-chocolate.png"];
        secondPencil = [SKSpriteNode spriteNodeWithImageNamed:@"popsicle-green.png"];
        thirdPencil = [SKSpriteNode spriteNodeWithImageNamed:@"popsicle-orange.png"];
        fourthPencil = [SKSpriteNode spriteNodeWithImageNamed:@"popsicle-raspberry.png"];
        fifthPencil = [SKSpriteNode spriteNodeWithImageNamed:@"popsicle-raspberry.png"];
        
        firstPencil.name = @"group1";
        secondPencil.name = @"group2";
        thirdPencil.name = @"group3";
        fourthPencil.name = @"group4";
        fifthPencil.name = @"group5";
        
        firstPencil.scale = 0.1;
        secondPencil.scale = 0.1;
        thirdPencil.scale = 0.1;
        fourthPencil.scale = 0.1;
        fifthPencil.scale = 0.1;
        
        
        [self addChild:firstPencil];
        firstPencil.position = CGPointMake(100,650);
        
        [self addChild:secondPencil];
        secondPencil.position = CGPointMake(900, 100);
        
        [self addChild:thirdPencil];
        thirdPencil.position = CGPointMake(930, 100);
        
        [self addChild:fourthPencil];
        fourthPencil.position = CGPointMake(960, 100);
        
        [self addChild:fifthPencil];
        fifthPencil.position = CGPointMake(990, 100);
        
        int i = 1;
        for (SKSpriteNode *letterSprite in groupOneLetters) {
            letterSprite.scale = 0.3;
            letterSprite.position = CGPointMake(100 + i ,200);
            [self addChild:letterSprite];
            i += 150;
        }
        
        for (SKSpriteNode *letterSprite in groupTwoLetters) {
            letterSprite.scale = 0.1;
            
        }
        
        for (SKSpriteNode *letterSprite in groupThreeLetters) {
            letterSprite.scale = 0.1;
            
        }
        
        for (SKSpriteNode *letterSprite in groupFourLetters) {
            letterSprite.scale = 0.1;
            
        }
        
        for (SKSpriteNode *letterSprite in groupFiveLetters) {
            
            letterSprite.scale = 0.1;
        
        }
        
        
        
        [self nextQuestion];
        
    }
    
    return self;
    
}

-(void) setupHUD {
    
    
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


-(void) nextQuestion {
    
    NSLog(@"next question: %i", onWhichQuestion);
    
    pointsForSprite = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    starsForPoints = [[NSMutableArray alloc]init];
    float startPointX;
    float startPointY;
    
    if (onWhichQuestion == 0) {

        [self createLetterA];
        letterA.position = CGPointMake(500, 500);
        startPointX = 150;
        startPointY = 80;
    
    }
    else if (onWhichQuestion == 1) {
    
        [self createLetterB];

        SKAction *moveLetterA = [SKAction moveTo:CGPointMake(100, 700) duration:1.0];
        SKAction *scaleLetterA = [SKAction scaleTo:0.2 duration:1.0];
        [letterA runAction:moveLetterA];
        [letterA runAction:scaleLetterA];
        
        SKAction *moveLetterB = [SKAction moveTo:CGPointMake(500, 500) duration:1.0];
        [letterB runAction:moveLetterB];
        
    
    }
    else if (onWhichQuestion == 2) {
    
        [self createLetterC];
    
    }
    else if (onWhichQuestion == 3) {
        
        [self createLetterD];
        
    }
    
    
    int spritePointCount = 0;
    
    for (NSValue *pointValue in pointsForSprite) {
         
        SKSpriteNode *spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"pinwheel_100x100.png"];
        CGPoint finalLocation = [pointValue CGPointValue];

        spritePoint.position = CGPointMake(finalLocation.x+300, finalLocation.y+400);
        spritePoint.scale = 0.1;
        [self addChild:spritePoint];
        
        float moveTime = 0.1 * (float)spritePointCount;
        
        SKAction *movePointsX = [SKAction moveToX:finalLocation.x+startPointX duration:moveTime];
        SKAction *movePointsY = [SKAction moveToY:finalLocation.y+startPointY duration:moveTime];
        
        [spritePoint runAction:movePointsX];
        [spritePoint runAction:movePointsY];
        
        SKAction *rotateCircle = [SKAction rotateToAngle:360 duration:60];
        SKAction *keepSpinning = [SKAction repeatActionForever:rotateCircle];
        [spritePoint runAction:keepSpinning];
        [spriteFromPoint addObject:spritePoint];
        spritePointCount++;
    }

    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    [self selectedNodeForTouch:theTouch];
    
    NSValue *pointForFirstSpriteNSV = [pointsForSprite objectAtIndex:0];
    CGPoint spritePoint = [pointForFirstSpriteNSV CGPointValue];
    CGRect spritePointRect = CGRectMake(spritePoint.x-10, spritePoint.y-10, 20, 20);
    
    if (CGRectContainsPoint (spritePointRect, theTouch)) {
        
        NSLog(@"hit first point");
        firstPointTest = TRUE;
        
        
    }
    
    if (CGRectContainsPoint(backToMainMenuArrow.frame, theTouch)) {
        SKView *spriteView = (SKView *)self.view;
        IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];
    }
}



-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];

    //CGPoint previousPosition = [touch previousLocationInNode:self];
    //CGPoint translation = CGPointMake(theTouch.x - previousPosition.x, theTouch.y - previousPosition.y);
    
    //[self panForTranslation:translation];
    
    for (SKSpriteNode *pointHit in spriteFromPoint) {

        CGRect myControlPoint = CGRectMake(pointHit.position.x, pointHit.position.y, 30, 30);
        CGPoint myPoint = myControlPoint.origin;
        
        if (CGRectContainsPoint(myControlPoint, theTouch)) {
            
            SKSpriteNode *goldStar = [SKSpriteNode spriteNodeWithImageNamed:@"star_100x100.png"];
            goldStar.position = pointHit.position;
            [goldStar setScale:0.3];
            [self addChild:goldStar];
            

            SKAction *growGoldStar = [SKAction scaleTo:0.3 duration:0.05];
            SKAction *growGoldStarY = [SKAction scaleYTo:1.0 duration:0.05];
            SKAction *growGoldStar2 = [SKAction scaleTo:0.2 duration:0.05];
            SKAction *growAndShrink = [SKAction sequence:@[growGoldStar,growGoldStarY,growGoldStar2]];
            
            [goldStar runAction:growAndShrink];
            [starsForPoints addObject:goldStar];
            
            SKAction *popup = [SKAction moveByX:20 y:40 duration:0.1];
            SKAction *drop = [SKAction moveToY:-200 duration:0.5];
            [pointHit runAction:popup];
            [pointHit runAction:drop];
            
            NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
            SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
            openEffect.position = goldStar.position;
            openEffect.targetNode = self.scene;
            
            [self addChild:openEffect];
            
            
        }
        
    }
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    //[self removeSpriteFromScene];

    for (SKSpriteNode *spritePoint in spriteFromPoint) {
        
        SKAction *moveTest = [SKAction moveTo:CGPointMake(0, 0) duration:0.1];
        //[spritePoint removeFromParent];
        [spritePoint runAction:moveTest];
    }
    
    for (SKSpriteNode *starWin in starsForPoints) {
        [starWin removeFromParent];
    }

    firstPointTest = FALSE;
    onWhichQuestion++;
    [self nextQuestion];
    
}

-(void) removeSpriteFromScene {

    SKSpriteNode *currentLetterFinish = [allLettersSprites objectAtIndex:onWhichQuestion];
    [currentLetterFinish removeFromParent];
    SKAction *moveToFinish = [SKAction moveToX:-300 duration:0.1];
    SKAction *scaleDown = [SKAction scaleTo:0.3 duration:0.1];
    [currentLetterFinish runAction:moveToFinish];
    [currentLetterFinish runAction:scaleDown];
    
}

- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [selectedNode position];
    if([[selectedNode name] isEqualToString:@"M"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    } else {
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [background setPosition:[self boundLayerPos:newPos]];
    }
}

- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[background size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}


-(void) createLetterA {
    //[self addChild:letterA];
    //letterA.position = CGPointMake (400,420);
    //letterA.scale = 0.5;
    
    CGPoint letterAvalue1 = CGPointMake(400, 500);
    CGPoint letterAvalue2 = CGPointMake(385, 505);
    CGPoint letterAvalue3 = CGPointMake(370, 510);
    CGPoint letterAvalue4 = CGPointMake(355, 510);
    CGPoint letterAvalue5 = CGPointMake(340, 510);
    CGPoint letterAvalue6 = CGPointMake(325, 500);
    CGPoint letterAvalue7 = CGPointMake(310, 490);
    CGPoint letterAvalue8 = CGPointMake(300, 480);
    CGPoint letterAvalue9 = CGPointMake(290, 470);
    CGPoint letterAvalue10 = CGPointMake(280, 450);
    CGPoint letterAvalue11 = CGPointMake(277, 440);
    CGPoint letterAvalue12 = CGPointMake(275, 430);
    CGPoint letterAvalue13 = CGPointMake(273, 420);
    CGPoint letterAvalue14 = CGPointMake(270, 410);
    CGPoint letterAvalue15 = CGPointMake(270, 400);
    CGPoint letterAvalue16 = CGPointMake(270, 390);
    CGPoint letterAvalue17 = CGPointMake(270, 380);
    CGPoint letterAvalue18 = CGPointMake(270, 370);
    CGPoint letterAvalue19 = CGPointMake(280, 360);
    CGPoint letterAvalue20 = CGPointMake(290, 355);
    CGPoint letterAvalue21 = CGPointMake(300, 345);
    CGPoint letterAvalue22 = CGPointMake(310, 340);
    CGPoint letterAvalue23 = CGPointMake(320, 340);
    CGPoint letterAvalue24 = CGPointMake(330, 342);
    CGPoint letterAvalue25 = CGPointMake(340, 342);
    CGPoint letterAvalue26 = CGPointMake(350, 345);
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
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue42]];
    
    
}



-(void) createLetterB {
    //letterB.position = CGPointMake(500,500);
    //letterB.scale = 0.5;
    //[self addChild:letterB];
    float beginx = 480;
    float beginy = 600;
    
    CGPoint letterAvalue1 = CGPointMake(beginx, beginy-25);
    CGPoint letterAvalue2 = CGPointMake(beginx, beginy-35);
    CGPoint letterAvalue3 = CGPointMake(beginx, beginy-40);
    CGPoint letterAvalue4 = CGPointMake(beginx, beginy-45);
    CGPoint letterAvalue5 = CGPointMake(beginx, beginy-48);
    CGPoint letterAvalue6 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue7 = CGPointMake(beginx, beginy-52);
    CGPoint letterAvalue8 = CGPointMake(beginx, beginy-54);
    CGPoint letterAvalue9 = CGPointMake(beginx, beginy-54);
    CGPoint letterAvalue10 = CGPointMake(beginx, beginy-52);
    CGPoint letterAvalue11 = CGPointMake(beginx, beginy-50);
    CGPoint letterAvalue12 = CGPointMake(beginx-110, beginy-48);
    CGPoint letterAvalue13 = CGPointMake(beginx-120, beginy-45);
    CGPoint letterAvalue14 = CGPointMake(beginx-125, beginy-40);
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

-(void) createLetterC {
    
    letterC.position = CGPointMake(400,420);
    [self addChild:letterC];
    float beginx = 480;
    float beginy = 465;
    
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
    
}

-(void) createLetterT {
    
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

float degToRad(float degree) {
    return degree/180.0f * M_PI;
}

@end
