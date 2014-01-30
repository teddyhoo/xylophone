//
//  MainMenu.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/18/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "MainMenu.h"
#import "ViewController.h"
#import "SmoothLineView.h"
#import "HistoryData.h"
#import "HistoryTerm.h"
#import "MainMenu.h"
#import "MontessoriData.h"

@implementation MainMenu

@synthesize controlPointsLetterA;
@synthesize letterA, letterB, letterC, letterM, letterS, letterT;
@synthesize handLeft, handTracer, handStraight, handTracerBottom, handTracerLeft, handTracerRight;

CGPoint mainMenuLabelPos;
CGPoint accountLabelPos;
CGPoint dataTablesPos;
CGPoint quizzesPos;
CGPoint matchingPos;
CGPoint essayPos;
CGPoint timelinePos;
NSMutableArray *menuOptions;
NSMutableArray *letterProblems;
NSMutableArray *controlPointSprites;
NSMutableArray *pointsForSprite;
NSMutableArray *spriteFromPoint;

bool removeAllBoxes;
bool traceLetters;
int onWhichLetter;


- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];

        NSLog(@"called init");
        
        

    }
    return self;
}


- (void) didMoveToView:(SKView *)view {
    
    NSLog(@"called did Move To View");
    
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
    
}

-(void) createSceneContents {
    
    self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;
    
    removeAllBoxes = false;
    traceLetters = false;
    onWhichLetter = 0;
    controlPointSprites = [[NSMutableArray alloc]init];
    
    //self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:0.0];
    
    letterA = [SKSpriteNode spriteNodeWithImageNamed:@"letter-A-1.png"];
    letterA.position = CGPointMake(550, 520);
    [self addChild:letterA];
    
    handTracer = [SKSpriteNode spriteNodeWithImageNamed:@"hand-point-straight-up.png"];
    handTracer.position = letterA.position;
    handTracer.position = CGPointMake(letterA.position.x + 15, letterA.position.y + 35);
    handTracer.scale = 0.5;
    
    SKAction *rotateHand = [SKAction rotateToAngle:-20 duration:0.1];
    [handTracer runAction:rotateHand];
    [self addChild:handTracer];
    
    SKAction *aDelay = [SKAction waitForDuration:3.0];
    SKAction *bigger1 = [SKAction scaleXTo:0.8 duration:0.1];
    SKAction *lowerYval = [SKAction scaleYTo:0.8 duration:0.1];
    SKAction *moveDown = [SKAction moveToY:handTracer.position.y-20 duration:0.4];
    SKAction *moveLeft = [SKAction moveToX:handTracer.position.x-10 duration:0.2];
    SKAction *sequenceIt = [SKAction sequence:@[aDelay,bigger1,lowerYval]];
    SKAction *sequence2 = [SKAction sequence:@[aDelay,moveDown]];
    SKAction *sequence3 = [SKAction sequence:@[aDelay,moveLeft]];
    
    SKAction *smaller1 = [SKAction scaleXTo:0.5 duration:0.2];
    SKAction *higherYval = [SKAction scaleYTo:0.5 duration:0.2];
    
    CGPoint letterAval[] = {
        {400,400}, {360,380}, {320,380}, {280,380} };
    
    
    
    CGPoint letterAvalue1 = CGPointMake(400, 400);
    CGPoint letterAvalue2 = CGPointMake(360, 380);
    CGPoint letterAvalue3 = CGPointMake(320, 340);
    CGPoint letterAvalue4 = CGPointMake(280, 300);
    CGPoint letterAvalue5 = CGPointMake(240, 300);
    CGPoint letterAvalue6 = CGPointMake(200, 300);
    CGPoint letterAvalue7 = CGPointMake(160, 260);

    
    
    pointsForSprite = [[NSMutableArray alloc]init];
    spriteFromPoint = [[NSMutableArray alloc]init];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    //[pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    
    
    for (NSValue *pointValue in pointsForSprite) {
        SKSpriteNode *spritePoint = [SKSpriteNode spriteNodeWithImageNamed:@"color-spectrum.jpg"];
        spritePoint.position = [pointValue CGPointValue];
        [self addChild:spritePoint];
        NSLog(@"adding point");
        
        SKAction *rotateCircle = [SKAction rotateToAngle:360 duration:0.4];
        SKAction *keepSpinning = [SKAction repeatActionForever:rotateCircle];
        [spritePoint runAction:keepSpinning];
        [spriteFromPoint addObject:spritePoint];
        
        
        
    }
    //[handTracer runAction:bigger1];
    //[handTracer runAction:lowerYval];
    //[handTracer runAction:moveDown];
    //[handTracer runAction:moveLeft];
    
    
    [handTracer runAction:sequenceIt];
    [handTracer runAction:sequence2];
    [handTracer runAction:sequence3];
    
    letterB = [SKSpriteNode spriteNodeWithImageNamed:@"letter-B.png"];
    letterC = [SKSpriteNode spriteNodeWithImageNamed:@"letter-c.png"];
    letterM = [SKSpriteNode spriteNodeWithImageNamed:@"letter-D.png"];
    letterS = [SKSpriteNode spriteNodeWithImageNamed:@"letter-S.png"];
    letterT = [SKSpriteNode spriteNodeWithImageNamed:@"letter-t.png"];
    
    letterB.position = CGPointMake(100, 220);
    letterC.position = CGPointMake(250, 220);
    letterM.position = CGPointMake(400, 220);
    letterS.position = CGPointMake(550, 220);
    letterT.position = CGPointMake(700, 220);
    
    [self addChild:letterB];
    [self addChild:letterC];
    [self addChild:letterM];
    [self addChild:letterS];
    [self addChild:letterT];
    
    
    
    letterProblems = [[NSMutableArray alloc]init];
    [letterProblems addObject:letterA];
    [letterProblems addObject:letterB];
    [letterProblems addObject:letterC];
    [letterProblems addObject:letterM];
    [letterProblems addObject:letterS];
    [letterProblems addObject:letterT];
    
    
    
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    /*slv = [[SmoothLineView alloc]initWithFrame:CGRectMake(0,0,1024,768)];
    slv.delegate = self;
    float red = 0.3;
    float green = 0.5;
    float blue = 0.7;
    float alpha = 1.0;
    slv.onQuestion = [NSNumber numberWithInteger:onWhichLetter];
    [slv addControlPointsForNextProblem];
    [slv setColor:red  g:green b:blue a:alpha];
    
    [self.view addSubview:slv];
    */
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    
   
    
}

-(void) handTraceTheLetter {
    
    
}

-(void) animateActionsForNextQuestion {
    
    onWhichLetter ++;
    
    
}

// Setting everything up to put letter into specific place

-(void) setUndoButtonEnable:(NSNumber*)isEnable
{
    //if (onWhichLetter == 0) {
        
        SKSpriteNode *correctSprite = [letterProblems objectAtIndex:0];
        
        [letterProblems removeObject:correctSprite];
        for (SKSpriteNode *moveNextSprite in letterProblems) {
            if ([letterProblems indexOfObject:moveNextSprite] == 0) {
                SKAction *moveToCenter = [SKAction moveToX:400 duration:0.5];
                SKAction *moveToCenter2 = [SKAction moveToY:720 duration:0.5];
                
                [moveNextSprite runAction:moveToCenter];
                [moveNextSprite runAction:moveToCenter2];
                
            } else {
                
                
            }
        }
        
        SKAction *rotate = [SKAction rotateByAngle:360 duration:0.5];
        SKAction *repeatRotate = [SKAction repeatAction:rotate count:100];
        
        SKAction *disappear = [SKAction fadeOutWithDuration:0.5];
        
        [correctSprite runAction:repeatRotate];
        [correctSprite runAction:disappear];
        
        [correctSprite runAction:[SKAction sequence:@[rotate,disappear]]];
        
        SKLabelNode *congratulation = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        congratulation.text = @"Way to go!";
        congratulation.fontSize = 60;
        congratulation.fontColor = [UIColor purpleColor];
        congratulation.position = (CGPointMake(-100, 600));
        SKAction *moveCongrat = [SKAction moveToX:950 duration:1.25];
        [self addChild:congratulation];
        [congratulation runAction:moveCongrat];
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SmokeEffect" ofType:@"sks"];
        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(400, 600);
        openEffect.targetNode = self.scene;
        [self addChild:openEffect];
        
    //}
    
    
    onWhichLetter++;
    /*[slv removeFromSuperview];
    slv = [[SmoothLineView alloc]initWithFrame:CGRectMake(0,0,768,1024)];
    slv.delegate = self;
    float red = 0.3;
    float green = 0.5;
    float blue = 0.7;
    float alpha = 1.0;
    [slv setColor:red  g:green b:blue a:alpha];
    slv.onQuestion = [NSNumber numberWithInteger:onWhichLetter];
    [slv addControlPointsForNextProblem];
    [self.view addSubview:slv];
    */
    
}

-(void) setRedoButtonEnable:(NSMutableArray *)controlPointsForLetter
{
    //NSLog(@"---called control point sprite display");
    //NSLog(@"---number of control points: %i", [controlPointsForLetter count]);
    
    int myHitPointIndex =0;
    float startPointX;
    float startPointY;
    float coordinateBase = 1024/2;
    
    for (NSValue *myHitPoint in controlPointsForLetter){
        CGPoint theControlPoint = [myHitPoint CGPointValue];

        
        //SKSpriteNode *hitPointSprite = [SKSpriteNode spriteNodeWithImageNamed:@"gold-star.png"];
        
        //hitPointSprite.position = positionInNode;
        //hitPointSprite.position = theControlPoint;
        //[self addChild:hitPointSprite];
        
        myHitPointIndex++;
        
    }
    
    
}


-(void) setClearButtonEnable:(NSNumber*)isEnable
{
}
-(void) setEraserButtonEnable:(NSNumber*)isEnable
{
}
-(void) setSave2FileButtonEnable:(NSNumber*)isEnable
{
}
-(void) setSave2AlbumButtonEnable:(NSNumber*)isEnable
{
}

-(void)moveLetter {
                 
                 
}

-(void)update:(NSTimeInterval)currentTime {
    
    
}



@end
