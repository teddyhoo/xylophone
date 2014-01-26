//
//  TeacherParent.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/1/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TeacherParent.h"
#import "MontessoriData.h"
#import "RedrawLetter.h"
#import "LowerCaseLetter.h"
#import "SKTUtils.h"
#import "SKTTimingFunctions.h"
#import "SKAction+SKTExtras.h"
#import "SKTTimingFunctions.h"
#import "SKTEffects.h"
#import "IntroScreen.h"

@implementation TeacherParent

MontessoriData *sharedData;
NSMutableArray *studentHistory;
NSMutableArray *studentSprites;
NSMutableArray *allTheLetters;
NSMutableArray *redrawOfLetterOnScreen;
SKLabelNode *groupOne;
SKLabelNode *groupTwo;
SKLabelNode *groupThree;
SKLabelNode *groupFour;
SKLabelNode *groupFive;
SKSpriteNode *backToMainMenuArrow;

int onWhichGroup;
int onWhichQuestion;

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
LowerCaseLetter *chosenLetter;

RedrawLetter *currentRedrawLetter;

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

NSMutableArray *shapesForLetters;

CGFloat width;
CGFloat height;
    
-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    if (self) {
        
        onWhichGroup = 0;
        
        sharedData = [MontessoriData sharedManager];

        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        self.userInteractionEnabled = YES;
        width = self.size.width;
        height = self.size.height;
        
        groupOneLetters = [[NSMutableArray alloc]init];
        groupTwoLetters = [[NSMutableArray alloc]init];
        groupThreeLetters = [[NSMutableArray alloc]init];
        groupFourLetters = [[NSMutableArray alloc]init];
        groupFiveLetters = [[NSMutableArray alloc]init];
        allTheLetters = [[NSMutableArray alloc]init];
        shapesForLetters = [[NSMutableArray alloc]init];
        redrawOfLetterOnScreen = [[NSMutableArray alloc]init];
        
        NSMutableArray *studentSprites = [[NSMutableArray alloc]init];
        NSArray *studentNames = [[NSArray alloc]initWithObjects:
                                 @"Student: Ted Hooban",
                                 //@"Teacher: Ms. Stage",
                                 //@"Age: 3 years 2 months",
                                 //@"Session: Mornings",
                                 //@"Assistant Teacher: Darla",
                                 nil];
        
        int i = 0;
        
        for (NSString *studentName in studentNames) {
            
            SKLabelNode *nameLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            nameLabel.text = studentName;
            nameLabel.name = studentName;
            nameLabel.fontColor = [UIColor blackColor];
            nameLabel.fontSize = 20;
            nameLabel.position = CGPointMake(550, 700 - (30*i));
            [self addChild:nameLabel];
            [studentSprites addObject:nameLabel];
            i++;
            
        }
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-button-200x206.png"];
        backToMainMenuArrow.position = CGPointMake(50, 40);
        backToMainMenuArrow.scale = 0.5;
        [self addChild:backToMainMenuArrow];
        
    }
    
    SKSpriteNode *moveableAlpha = [SKSpriteNode spriteNodeWithImageNamed:@"basicWindow-1144x920"];
    SKSpriteNode *tileLetterA = [SKSpriteNode spriteNodeWithImageNamed:@"wood-tile-letter-A-100x96"];
    
    moveableAlpha.position = CGPointMake(500, 500);
    tileLetterA.position = CGPointMake(500, 500);
    
    //[self addChild:moveableAlpha];
    //[self addChild:tileLetterA];
    
    letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-A.png"];
    letterA.whichLetter = @"A";
    
    letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-B.png"];
    letterB.whichLetter = @"B";
    
    letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-C.png"];
    letterC.whichLetter = @"C";
    
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-D.png"];
    letterD.whichLetter = @"D";
    
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-E.png"];
    letterE.whichLetter = @"E";
    
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-F.png"];
    letterF.whichLetter = @"F";
    
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-G.png"];
    letterG.whichLetter = @"G";
    
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-H.png"];
    letterH.whichLetter = @"H";
    
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-I.png"];
    letterI.whichLetter = @"I";
    
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-J.png"];
    letterJ.whichLetter = @"J";
    
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-K.png"];
    letterK.whichLetter = @"K";
    
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-L.png"];
    letterL.whichLetter = @"L";
    
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-M.png"];
    letterM.whichLetter = @"M";
    
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-N.png"];
    letterN.whichLetter = @"N";
    
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-O.png"];
    letterO.whichLetter = @"O";
    
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-P.png"];
    letterP.whichLetter = @"P";
    
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-Q.png"];
    letterQ.whichLetter = @"Q";
    
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-R.png"];;
    letterR.whichLetter = @"R";
    
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-S.png"];;
    letterS.whichLetter = @"S";
    
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-T.png"];;
    letterT.whichLetter = @"T";
    
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-U.png"];;
    letterU.whichLetter = @"U";
    
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-V.png"];;
    letterV.whichLetter = @"V";
    
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-W.png"];;
    letterW.whichLetter = @"W";
    
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-X.png"];;
    letterX.whichLetter = @"X";
    
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-Y.png"];;
    letterY.whichLetter = @"Y";
    
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-Z.png"];;
    letterZ.whichLetter = @"Z";
    
    [allTheLetters addObject:letterA];
    [allTheLetters addObject:letterB];
    [allTheLetters addObject:letterC];
    [allTheLetters addObject:letterD];
    [allTheLetters addObject:letterE];
    [allTheLetters addObject:letterF];
    [allTheLetters addObject:letterG];
    [allTheLetters addObject:letterH];
    [allTheLetters addObject:letterI];
    [allTheLetters addObject:letterJ];
    [allTheLetters addObject:letterK];
    [allTheLetters addObject:letterL];
    [allTheLetters addObject:letterM];
    [allTheLetters addObject:letterN];
    [allTheLetters addObject:letterO];
    [allTheLetters addObject:letterP];
    [allTheLetters addObject:letterQ];
    [allTheLetters addObject:letterR];
    [allTheLetters addObject:letterS];
    [allTheLetters addObject:letterT];
    [allTheLetters addObject:letterU];
    [allTheLetters addObject:letterV];
    [allTheLetters addObject:letterW];
    [allTheLetters addObject:letterX];
    [allTheLetters addObject:letterY];
    [allTheLetters addObject:letterZ];
    
    for (LowerCaseLetter *letter in allTheLetters) {
        
        letter.position = CGPointMake(0,-1000);
        letter.alpha = 0.0;
        //letter.scale = 0.1;
        letter.centerStage = FALSE;
        [self addChild:letter];
    }
    
    
    [self getDataHistory];
    
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
    
    return self;
}


-(void)getDataHistory {
    
    float firstPoint;
    float secondPoint;
    
    for (NSDictionary *results in sharedData.letterDrawResults) {
        for (NSString *key in results) {
            
            if ([key isEqualToString:@"shape"]) {
                NSString *letterVal = [results objectForKey:@"letter"];
                
                NSLog(@"found results for letter: %@",letterVal);
                
                NSDate *dateOf = [results objectForKey:@"dateDone"];
                NSDateFormatter *dateFormatted = [[NSDateFormatter alloc]init];
                [dateFormatted setTimeStyle:NSDateFormatterShortStyle];
                //[dateFormatted setDateStyle:NSDateFormatterLongStyle];
                NSString *formatDate = [dateFormatted stringFromDate:dateOf];
                
                LowerCaseLetter *paramLetter;
                
                for (LowerCaseLetter *currentLetter in allTheLetters) {
                    if ([currentLetter.whichLetter isEqualToString:letterVal]) {
                        paramLetter = currentLetter;
                    }
                }

                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]initWithPosition:CGPointMake(0, 0) withLetter:paramLetter];
                redrawLetterNode.dateDrawn = formatDate;
                
                NSMutableArray *theCloudObjects = [results objectForKey:key];
                for (SKSpriteNode *drawSprite in theCloudObjects) {
                    SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
                    newCloud.position = drawSprite.position;
                    [redrawLetterNode addPointToNode:newCloud];
                }
                
                SKLabelNode *dateLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
                dateLabel.text = formatDate;
                dateLabel.fontColor = [UIColor purpleColor];
                dateLabel.fontSize = 40;
                dateLabel.position = CGPointMake(500, 600);
                SKLabelNode *totalPoints = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];

                [redrawLetterNode addChild:dateLabel];
                [shapesForLetters addObject:redrawLetterNode];
            }
        }
    }
    
}

-(void)letterTouch:(LowerCaseLetter *)letterOn {
    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(width / 2, height / 2 + 150) duration:1.0];
    SKAction *scaleUp = [SKAction scaleTo:0.5 duration:0.4];
    [letterOn runAction:moveAction];
    [letterOn runAction:scaleUp];
    int xposition = 100;
    int yposition = 100;
    
    int numberOfTraces = 0;
    
    for (RedrawLetter *letterShapes in shapesForLetters) {
        
        if ([chosenLetter.whichLetter isEqualToString:letterShapes.representLetter]) {
            numberOfTraces++;
        }
        
    }
    
    for (RedrawLetter *letterShapes in shapesForLetters) {
        
        if ([chosenLetter.whichLetter isEqualToString:letterShapes.representLetter]) {
            NSMutableArray *spritesToDraw = [letterShapes drawMyself];
            float delayDraw = 0.0;
            
            for (SKSpriteNode *drawSprite in spritesToDraw) {
                SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
                newCloud.position = drawSprite.position;
                newCloud.alpha = 0.0;
                
                SKAction *drawItDelayed = [SKAction fadeAlphaTo:1.0 duration:0.1];
                SKAction *delayIt = [SKAction waitForDuration:delayDraw];
                SKAction *sequenceDraw = [SKAction sequence:@[delayIt,drawItDelayed]];
                delayDraw += 0.2;
                [newCloud runAction:sequenceDraw];
                [letterShapes addChild:newCloud];
            }
            [self addChild:letterShapes];
            [redrawOfLetterOnScreen addObject:letterShapes];
            
            letterShapes.position = CGPointMake(xposition*numberOfTraces, yposition);
            numberOfTraces--;
            letterShapes.scale = 0.4;
            currentRedrawLetter = letterShapes;
        }
        
    }
}

-(void)closePreviousGroup:(NSNumber*)whichGroupClose {
    
    if ([whichGroupClose intValue] == 1) {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupOne.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupOneLetters) {
            if(!openLetterBox.centerStage) {
                [openLetterBox runAction:closeLetters];
            }
        }
    } else if ([whichGroupClose intValue] == 2){
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupTwo.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupTwoLetters) {
            if(!openLetterBox.centerStage) {
                [openLetterBox runAction:closeLetters];
            }
        }
        
    } else if ([whichGroupClose intValue] == 3) {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupThree.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupThreeLetters) {
            if(!openLetterBox.centerStage) {
                [openLetterBox runAction:closeLetters];
            }
        }
        
    } else if ([whichGroupClose intValue] == 4)  {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupFour.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupFourLetters) {
            if(!openLetterBox.centerStage) {
                [openLetterBox runAction:closeLetters];
            }
        }
    } else if ([whichGroupClose intValue] == 5) {
        SKAction *closeLetters = [SKAction moveTo:CGPointMake(groupFive.position.x, -400) duration:0.2];
        for (LowerCaseLetter *openLetterBox in groupFiveLetters) {
            if(!openLetterBox.centerStage) {
                [openLetterBox runAction:closeLetters];
            }
        }
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    for (RedrawLetter *letterShapes in shapesForLetters) {
        
        if (CGRectContainsPoint(letterShapes.frame, theTouch)) {
            SKAction *moveIt = [SKAction moveTo:CGPointMake(500, 500) duration:2.0];
            [letterShapes runAction:moveIt];
        }
    }
    
    if(CGRectContainsPoint(currentRedrawLetter.frame, theTouch)) {
        NSLog(@"current redraw frame tapped");
        
        [currentRedrawLetter removeAllChildren];
        NSMutableArray *spritesToDraw = [currentRedrawLetter drawMyself];
        for (SKSpriteNode *drawSprite in spritesToDraw) {
            SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3.png"];
            newCloud.position = drawSprite.position;
            [currentRedrawLetter addChild:newCloud];
        }
        //[self addChild:currentRedrawLetter];
        currentRedrawLetter.position = CGPointMake(400, 300);
        currentRedrawLetter.scale = 0.7;
    }
    
    if (CGRectContainsPoint(backToMainMenuArrow.frame, theTouch)) {

        [self removeAllChildren];
        
        SKView *spriteView = (SKView *)self.view;
        IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.2];
        introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];
        
    }
    
    
    for (LowerCaseLetter *touchLetter in allTheLetters) {
        if (CGRectContainsPoint(touchLetter.frame,theTouch) && !touchLetter.centerStage) {
            chosenLetter = touchLetter;
            chosenLetter.centerStage = TRUE;
            touchLetter.centerStage = TRUE;
            [self letterTouch:touchLetter];
  
        } else if (CGRectContainsPoint(touchLetter.frame,theTouch) && touchLetter.centerStage) {
            touchLetter.scale = 0.1;
            touchLetter.centerStage = FALSE;
            
            if(onWhichGroup != 1) {
                [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            } else if (onWhichGroup != 2) {
                [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            } else if (onWhichGroup != 3) {
                [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            } else if (onWhichGroup != 4) {
                [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            } else if (onWhichGroup != 5) {
                [self closePreviousGroup:[NSNumber numberWithInt:onWhichGroup]];

            }
            [currentRedrawLetter removeFromParent];
            
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
                if (!openLetterBox.centerStage) {
                    [openLetterBox runAction:closeLetters];
                }
                
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
                if (!openLetterBox.centerStage) {
                    [openLetterBox runAction:closeLetters];
                }
                
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
                if (!openLetterBox.centerStage) {
                    [openLetterBox runAction:closeLetters];
                }
                
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
                if (!openLetterBox.centerStage) {
                    [openLetterBox runAction:closeLetters];
                }
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
                if (!openLetterBox.centerStage) {
                    [openLetterBox runAction:closeLetters];
                }
            }
        }
    
        for (SKLabelNode *studentLabel in studentSprites) {
        NSLog(@"text: %@", studentLabel.text);
        
            if (CGRectContainsPoint(studentLabel.frame,theTouch)) {
                SKAction *setToHeadLine = [SKAction moveTo:CGPointMake(400, 600) duration:1.0];
                [studentLabel runAction:setToHeadLine];
            }
        }
    }

}




@end
