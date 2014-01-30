//
//  Spelling.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 1/23/14.
//  Copyright (c) 2014 Melanie Taylor. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

#import "Spelling.h"
#import "IntroScreen.h"
#import "LowerCaseLetter.h"

@implementation Spelling

NSMutableArray *texturesForAnim;
NSMutableArray *allTheLetterBlocks;
NSMutableArray *placedLetters;
NSMutableArray *dictionaryOfWords;
NSMutableArray *letterDropBox;

LowerCaseLetter *currentSprite;
UIPanGestureRecognizer *gestureRecognizer;

SKSpriteNode *firstLetter;
SKSpriteNode *secondLetter;
SKSpriteNode *thirdLetter;
SKSpriteNode *fourthLetter;
SKSpriteNode *fifthLetter;
SKSpriteNode *sixthLetter;
SKSpriteNode *seventhLetter;
SKSpriteNode *backToMainMenuArrow;
SKSpriteNode *imageForSpelling;


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

AVAudioPlayer *correctMessage; // girl voice correct
AVAudioPlayer *awesomeMessage;
AVAudioPlayer *whoopsMessage;
AVAudioPlayer *magicalSweep;
AVAudioPlayer *gameShowLose;

int questionCount;
int numberOfLettersToPlace;
int xForImage=100;
int yForImage=100;

-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    
    if (self) {
        
        questionCount = 0;
        letterDropBox = [[NSMutableArray alloc]init];
        placedLetters = [[NSMutableArray alloc]init];
        
        SKSpriteNode *backgroundImage = [SKSpriteNode spriteNodeWithImageNamed:@"writing_bckgnd_test_1.jpg"];
        backgroundImage.position = CGPointMake(size.width / 2, size.height / 2);
        [self addChild:backgroundImage];
        
        
        NSString *pListData = [[NSBundle mainBundle]pathForResource:@"WordSpell" ofType:@"plist"];
        dictionaryOfWords = [[NSMutableArray alloc]initWithContentsOfFile:pListData];
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-button-200x206.png"];
        backToMainMenuArrow.position = CGPointMake(70, 50);
        backToMainMenuArrow.scale = 0.5;
        [self addChild:backToMainMenuArrow];
        
        
        allTheLetterBlocks = [[NSMutableArray alloc]init];
        
        
        //SKSpriteNode *woodLetterA = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-A"];
        LowerCaseLetter *woodLetterA = [self createLetterA];
        woodLetterA.name = @"A";
        LowerCaseLetter *woodLetterB = [self createLetterB];
        woodLetterB.name = @"B";
        LowerCaseLetter *woodLetterC = [self createLetterC];
        woodLetterC.name = @"C";
        LowerCaseLetter *woodLetterS = [self createLetterS];
        woodLetterS.name = @"S";
        LowerCaseLetter *woodLetterM = [self createLetterM];
        woodLetterM.name = @"M";
        LowerCaseLetter  *woodLetterT = [self createLetterT];
        woodLetterT.name = @"T";
        LowerCaseLetter  *woodLetterG = [self createLetterG];
        woodLetterG.name = @"G";
        
        LowerCaseLetter  *woodLetterR = [self createLetterR];
        woodLetterR.name = @"R";
        
        LowerCaseLetter  *woodLetterO = [self createLetterO];
        woodLetterO.name = @"O";
        
        LowerCaseLetter *woodLetterF = [self createLetterF];
        woodLetterF.name = @"F";
        
        LowerCaseLetter  *woodLetterD = [self createLetterD];
        woodLetterD.name = @"D";
        
        LowerCaseLetter  *woodLetterH = [self createLetterH];
        woodLetterH.name = @"H";
        
        LowerCaseLetter  *woodLetterI = [self createLetterI];
        woodLetterI.name = @"I";
        
        LowerCaseLetter  *woodLetterP = [self createLetterP];
        woodLetterP.name = @"P";
        
        LowerCaseLetter  *woodLetterN = [self createLetterN];
        woodLetterN.name = @"N";
        
        LowerCaseLetter  *woodLetterL = [self createLetterL];
        woodLetterL.name = @"L";
        
        LowerCaseLetter  *woodLetterK = [self createLetterK];
        woodLetterK.name = @"K";
        
        LowerCaseLetter  *woodLetterE = [self createLetterE];
        woodLetterE.name = @"E";
        
        LowerCaseLetter  *woodLetterZ = [self createLetterZ];
        woodLetterZ.name = @"Z";
        
        LowerCaseLetter  *woodLetterQ = [self createLetterQ];
        woodLetterQ.name = @"Q";
        
        LowerCaseLetter  *woodLetterX = [self createLetterX];
        woodLetterX.name = @"X";
        
        LowerCaseLetter  *woodLetterU = [self createLetterU];
        woodLetterU.name = @"U";
        
        LowerCaseLetter  *woodLetterV = [self createLetterV];
        woodLetterV.name = @"V";
        
        LowerCaseLetter  *woodLetterW = [self createLetterW];
        woodLetterW.name = @"W";
        
        LowerCaseLetter  *woodLetterJ = [self createLetterJ];
        woodLetterJ.name = @"J";
        
        LowerCaseLetter  *woodLetterY = [self createLetterY];
        woodLetterY.name = @"Y";
        
        [allTheLetterBlocks addObject:woodLetterA];
        [allTheLetterBlocks addObject:woodLetterB];
        [allTheLetterBlocks addObject:woodLetterC];
        [allTheLetterBlocks addObject:woodLetterD];
        [allTheLetterBlocks addObject:woodLetterE];
        [allTheLetterBlocks addObject:woodLetterF];
        [allTheLetterBlocks addObject:woodLetterG];
        [allTheLetterBlocks addObject:woodLetterH];
        [allTheLetterBlocks addObject:woodLetterI];
        [allTheLetterBlocks addObject:woodLetterJ];
        [allTheLetterBlocks addObject:woodLetterK];
        [allTheLetterBlocks addObject:woodLetterL];
        [allTheLetterBlocks addObject:woodLetterM];
        [allTheLetterBlocks addObject:woodLetterN];
        [allTheLetterBlocks addObject:woodLetterO];
        [allTheLetterBlocks addObject:woodLetterP];
        [allTheLetterBlocks addObject:woodLetterQ];
        [allTheLetterBlocks addObject:woodLetterR];
        [allTheLetterBlocks addObject:woodLetterS];
        [allTheLetterBlocks addObject:woodLetterT];
        [allTheLetterBlocks addObject:woodLetterU];
        [allTheLetterBlocks addObject:woodLetterV];
        [allTheLetterBlocks addObject:woodLetterW];
        [allTheLetterBlocks addObject:woodLetterX];
        [allTheLetterBlocks addObject:woodLetterY];
        [allTheLetterBlocks addObject:woodLetterZ];
        
        int i = 0;
        float xPos = 120;
        float yPos = 710;
        
        for(SKSpriteNode *letterBlock in allTheLetterBlocks) {
            letterBlock.position = CGPointMake(xPos,yPos);
            xPos += 65;
            
            if (i == 12) {
                xPos = 120;
                yPos -= 60;
                
            }
            
            [self addChild:letterBlock];
            letterBlock.zPosition = 100;

            i++;
        }
        
        
        
    }
    
    /*dictionaryOfWords = [[NSMutableArray alloc]init];
    
    NSMutableDictionary *firstQuestion = [[NSMutableDictionary alloc]init];
    [firstQuestion setObject:@"net" forKey:@"picture"];
    [firstQuestion setObject:@"N" forKey:@"firstLetter"];
    [firstQuestion setObject:@"E" forKey:@"secondLetter"];
    [firstQuestion setObject:@"T" forKey:@"thirdLetter"];
    [firstQuestion setObject:@"3" forKey:@"numberOfLetters"];
    [firstQuestion setObject:@"0.2" forKey:@"scale"];
    
    dictionaryOfWords = [[NSMutableArray alloc]init];
    [dictionaryOfWords addObject:firstQuestion];*/
    [self setupSounds];
    [self nextQuestion];
    return self;
}

-(void)finishedWithAllImages {
    
    
}
-(void) nextQuestion {
    
    if (questionCount < [dictionaryOfWords count]) {
        
        SKAction *scaleImage = [SKAction scaleTo:0.3 duration:1.7];
        SKAction *fadeInImage = [SKAction fadeAlphaTo:1.0 duration:1.7];
        
        NSMutableDictionary *currentQuestion = [dictionaryOfWords objectAtIndex:questionCount];
        imageForSpelling = [SKSpriteNode spriteNodeWithImageNamed:[currentQuestion objectForKey:@"picture"]];
        imageForSpelling.position = CGPointMake(500, 500);
        imageForSpelling.scale = 0.0;
        imageForSpelling.alpha = 0.0;
        [imageForSpelling runAction:scaleImage];
        [imageForSpelling runAction:fadeInImage];
        
        NSString *scaleString = [currentQuestion objectForKey:@"scale"];
        
        NSString *numLetters = [currentQuestion objectForKey:@"numberOfLetters"];
        numberOfLettersToPlace = [numLetters intValue];
        NSLog(@"number of letters: %i",numberOfLettersToPlace);
        
        [self addChild:imageForSpelling];
        for (NSString *letter in currentQuestion) {
            
            if ([letter isEqualToString:@"firstLetter"]) {
                
                firstLetter = [SKSpriteNode spriteNodeWithImageNamed:@"blue-Letter-Placement-430x414"];
                firstLetter.position = CGPointMake(400, 350);
                firstLetter.scale = 0.5;
                firstLetter.alpha = 0.0;
                firstLetter.name = [currentQuestion valueForKey:letter];
                [self addChild:firstLetter];
                [firstLetter runAction:fadeInImage];
                firstLetter.zPosition = 5;
                [letterDropBox addObject:firstLetter];
                
            } else if ([letter isEqualToString:@"secondLetter"]) {
                
                secondLetter = [SKSpriteNode spriteNodeWithImageNamed:@"blue-Letter-Placement-430x414"];
                secondLetter.position = CGPointMake(510, 350);
                secondLetter.scale = 0.5;
                secondLetter.alpha = 0.0;
                secondLetter.name = [currentQuestion valueForKey:letter];
                [self addChild:secondLetter];
                [secondLetter runAction:fadeInImage];
                secondLetter.zPosition = 5;
                [letterDropBox addObject:secondLetter];
                
            } else if ([letter isEqualToString:@"thirdLetter"]) {
                
                thirdLetter = [SKSpriteNode spriteNodeWithImageNamed:@"blue-Letter-Placement-430x414"];
                thirdLetter.position = CGPointMake(620, 350);
                thirdLetter.scale = 0.5;
                thirdLetter.alpha = 0.0;
                thirdLetter.name = [currentQuestion valueForKey:letter];
                [self addChild:thirdLetter];
                [thirdLetter runAction:fadeInImage];
                thirdLetter.zPosition = 5;
                [letterDropBox addObject:thirdLetter];
            } else if ([letter isEqualToString:@"fourthLetter"]) {
                
                fourthLetter = [SKSpriteNode spriteNodeWithImageNamed:@"blue-Letter-Placement-430x414"];
                fourthLetter.position = CGPointMake(730, 350);
                fourthLetter.scale = 0.5;
                fourthLetter.alpha = 0.0;
                fourthLetter.name = [currentQuestion valueForKey:letter];
                [self addChild:fourthLetter];
                [fourthLetter runAction:fadeInImage];
                fourthLetter.zPosition = 5;
                [letterDropBox addObject:fourthLetter];
                
            } else if ([letter isEqualToString:@"fifthLetter"]) {
                fifthLetter = [SKSpriteNode spriteNodeWithImageNamed:@"blue-Letter-Placement-430x414"];
                fifthLetter.position = CGPointMake(840, 350);
                fifthLetter.scale = 0.5;
                fifthLetter.alpha = 0.0;
                fifthLetter.name = [currentQuestion valueForKey:letter];
                [self addChild:fifthLetter];
                [fifthLetter runAction:fadeInImage];
                fifthLetter.zPosition = 5;
                [letterDropBox addObject:fourthLetter];
                
                
            } else if ([letter isEqualToString:@"sixthLetter"]) {
                
            }
        }

        questionCount++;
        xForImage += 50;
        
    } else {
   
        [self finishedWithAllImages];
    
    }
}


- (void)didMoveToView:(SKView *)view {
    
    gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
    
}


- (void)selectNodeForTouch:(CGPoint)touchLocation {
    
    LowerCaseLetter *touchedNode = (LowerCaseLetter *)[self nodeAtPoint:touchLocation];
    NSLog(@"name of node: %@",touchedNode.name);
    

    NSString *fileName = [NSString stringWithFormat:@"wood-letter-%@",touchedNode.name];
    currentSprite = [LowerCaseLetter spriteNodeWithImageNamed:fileName];
    currentSprite.scale = 1.6;
    currentSprite.position = touchLocation;
    currentSprite.zPosition = 100;
    currentSprite.name = touchedNode.name;
    [currentSprite playTheSound];
    
    [self addChild:currentSprite];

    
}


- (void)panForTranslation:(CGPoint)translation {
    CGPoint position = [currentSprite position];
    [currentSprite setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
    

}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
    
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        [self selectNodeForTouch:touchLocation];

        if (CGRectContainsPoint(backToMainMenuArrow.frame, touchLocation)) {
            
            [self removeAllChildren];
            [[self view] removeGestureRecognizer:gestureRecognizer];

            SKView *spriteView = (SKView *)self.view;
            IntroScreen *introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
            SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:0.2];
            introScreen.scaleMode = SKSceneScaleModeAspectFill;
            [spriteView presentScene:introScreen transition:reveal];
            
        } else {
            
            
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
        for (SKSpriteNode *boxDrop in letterDropBox) {
            if (CGRectIntersectsRect(currentSprite.frame, boxDrop.frame)) {
                SKSpriteNode *highlightBox = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-Letter-Placement-430x414"];
                highlightBox.scale = 0.5;
                highlightBox.position = boxDrop.position;
                highlightBox.zPosition = 10;
                [self addChild:highlightBox];
                SKAction *removeTheBox = [SKAction removeFromParent];
                SKAction *delayRemove = [SKAction waitForDuration:0.5];
                [highlightBox runAction:[SKAction sequence:@[delayRemove,removeTheBox]]];
                 
            }
        }
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        for (LowerCaseLetter *boxDrop in letterDropBox) {
            BOOL incorrectLetterBox = FALSE;
            if (CGRectIntersectsRect(boxDrop.frame, currentSprite.frame) &&
                [boxDrop.name isEqualToString:currentSprite.name]) {
                
                [correctMessage play];
                numberOfLettersToPlace--;
                incorrectLetterBox = FALSE;
                
                NSString *fileName = [NSString stringWithFormat:@"wood-letter-%@",currentSprite.name];
                [currentSprite removeFromParent];
                SKSpriteNode *placedLetter = [SKSpriteNode spriteNodeWithImageNamed:fileName];
                [self addChild:placedLetter];
                placedLetter.position = boxDrop.position;
                placedLetter.name = currentSprite.name;
                placedLetter.scale = 1.4;
                placedLetter.zPosition = 100;
                [placedLetters addObject:placedLetter];
                
                
                if (numberOfLettersToPlace == 0) {

                    SKAction *transitionNext = [SKAction runBlock:^{
                        for (SKSpriteNode *letterPlaced in placedLetters) {
                            SKAction *scaleUp = [SKAction scaleTo:0.5 duration:0.5];
                            SKAction *moveOffScreen = [SKAction moveTo:CGPointMake(-500,letterPlaced.position.y) duration:1.0];
                            SKAction *sequenceNext = [SKAction sequence:@[scaleUp,moveOffScreen,[SKAction removeFromParent]]];
                            [letterPlaced runAction:sequenceNext];
                            
                        }
                        
                        for (SKSpriteNode *dropBox in letterDropBox) {
                            SKAction *scaleUp = [SKAction scaleTo:0.5 duration:0.5];
                            SKAction *moveOffScreen = [SKAction moveTo:CGPointMake(-500, dropBox.position.y) duration:1.0];
                            SKAction *sequenceNext = [SKAction sequence:@[scaleUp,moveOffScreen,[SKAction removeFromParent]]];
                            [dropBox runAction:sequenceNext];
                        }
                        
                        [imageForSpelling runAction:[SKAction scaleTo:0.1 duration:0.5]];
                        [imageForSpelling runAction:[SKAction moveTo:CGPointMake(xForImage, yForImage) duration:0.5]];
                        [self nextQuestion];
                        
                    }];
                    
                    [self runAction:transitionNext];
                    
                }
                break;
                                                  
                    
            } else if (CGRectIntersectsRect(boxDrop.frame, currentSprite.frame)) {
                [whoopsMessage play];
                
                incorrectLetterBox = TRUE;
                if (incorrectLetterBox) {
                    incorrectLetterBox = FALSE;
                    SKSpriteNode *highlightBox = [SKSpriteNode spriteNodeWithImageNamed:@"red-Letter-Placement-430x414"];
                    highlightBox.scale = 0.5;
                    highlightBox.position = boxDrop.position;
                    highlightBox.zPosition = 10;
                    [self addChild:highlightBox];
                    SKAction *removeTheBox = [SKAction removeFromParent];
                    SKAction *delayRemove = [SKAction waitForDuration:0.5];
                    [highlightBox runAction:[SKAction sequence:@[delayRemove,removeTheBox]]];
                }
                SKAction *shrink = [SKAction scaleTo:0.3 duration:0.01];
                SKAction *moveTo = [SKAction moveTo:CGPointMake(currentSprite.position.x, currentSprite.position.y-100) duration:0.1];
                SKAction *removeFromView = [SKAction removeFromParent];
                SKAction *sequenceAction = [SKAction sequence:@[moveTo,shrink,removeFromView]];

                [currentSprite runAction:sequenceAction];
            }
        }
    }
}


-(void) setupSounds {
    
    
    NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_correct" withExtension:@"wav"];
    correctMessage = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];
    
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
    
    letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-A"];
    NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"a" withExtension:@"aiff"];
    letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
    letterA.name = @"A";
    letterA.whichLetter = @"A";
    return letterA;
}

-(LowerCaseLetter *) createLetterB {
    
    letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-B"];
    NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"b" withExtension:@"aiff"];
    letterB.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterBurl error:nil];
    letterB.name = @"B";
    letterB.whichLetter = @"B";
    letterB.centerStage = FALSE;
    return letterB;
}

-(LowerCaseLetter *) createLetterC {
    
    letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-C"];
    NSURL *letterCurl = [[NSBundle mainBundle]URLForResource:@"c" withExtension:@"aiff"];
    letterC.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterCurl error:nil];
    letterC.name = @"C";
    letterC.whichLetter = @"C";
    return letterC;
}

-(LowerCaseLetter *) createLetterD {
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-D"];
    NSURL *letterDurl = [[NSBundle mainBundle]URLForResource:@"d" withExtension:@"aiff"];
    letterD.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterDurl error:nil];
    letterD.name = @"D";
    letterD.whichLetter = @"D";
    return letterD;
}

-(LowerCaseLetter *) createLetterE {
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-E"];
    NSURL *letterEurl = [[NSBundle mainBundle]URLForResource:@"e" withExtension:@"aiff"];
    letterE.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterEurl error:nil];
    letterE.name = @"E";
    letterE.whichLetter = @"E";
    return letterE;
}

-(LowerCaseLetter *) createLetterF {
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-F"];
    NSURL *letterFurl = [[NSBundle mainBundle]URLForResource:@"f2" withExtension:@"aiff"];
    letterF.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterFurl error:nil];
    letterF.name = @"F";
    letterF.whichLetter = @"F";
    return letterF;
    
}

-(LowerCaseLetter *) createLetterG {
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-G"];
    NSURL *letterGurl = [[NSBundle mainBundle]URLForResource:@"g" withExtension:@"aiff"];
    letterG.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterGurl error:nil];
    letterG.name = @"G";
    letterG.whichLetter = @"G";
    return letterG;
    
}

-(LowerCaseLetter *) createLetterH {
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-H"];
    NSURL *letterHurl = [[NSBundle mainBundle]URLForResource:@"h2" withExtension:@"aiff"];
    letterH.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterHurl error:nil];
    letterH.name = @"H";
    letterH.whichLetter = @"H";
    return letterH;
}

-(LowerCaseLetter *) createLetterI {
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-I"];
    NSURL *letterIurl = [[NSBundle mainBundle]URLForResource:@"i2" withExtension:@"aiff"];
    letterI.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterIurl error:nil];
    letterI.name = @"I";
    letterI.whichLetter = @"I";
    return letterI;
}

-(LowerCaseLetter *) createLetterJ {
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-J"];
    NSURL *letterJurl = [[NSBundle mainBundle]URLForResource:@"j2" withExtension:@"aiff"];
    letterJ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterJurl error:nil];
    letterJ.name = @"J";
    letterJ.whichLetter = @"J";
    return letterJ;
}

-(LowerCaseLetter *) createLetterK {
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-K"];
    NSURL *letterKurl = [[NSBundle mainBundle]URLForResource:@"k" withExtension:@"aiff"];
    letterK.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterKurl error:nil];
    letterK.name = @"K";
    letterK.whichLetter = @"K";
    return letterK;
}

-(LowerCaseLetter *)createLetterL {
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-L"];
    NSURL *letterLurl = [[NSBundle mainBundle]URLForResource:@"l" withExtension:@"aiff"];
    letterL.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterLurl error:nil];
    letterL.name = @"L";
    letterL.whichLetter = @"L";
    return letterL;
}

-(LowerCaseLetter *)createLetterM {
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-M"];
    NSURL *letterMurl = [[NSBundle mainBundle]URLForResource:@"m" withExtension:@"aiff"];
    letterM.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterMurl error:nil];
    letterM.name = @"M";
    letterM.whichLetter = @"M";
    return letterM;
}

-(LowerCaseLetter *)createLetterN {
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-N"];
    NSURL *letterNurl = [[NSBundle mainBundle]URLForResource:@"n" withExtension:@"aiff"];
    letterN.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterNurl error:nil];
    letterN.name = @"N";
    letterN.whichLetter = @"N";
    return letterN;
}

-(LowerCaseLetter *)createLetterO {
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-O"];
    NSURL *letterOurl = [[NSBundle mainBundle]URLForResource:@"o" withExtension:@"aiff"];
    letterO.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterOurl error:nil];
    letterO.name = @"O";
    letterO.whichLetter = @"O";
    return letterO;
}

-(LowerCaseLetter *)createLetterP {
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-P"];
    
    NSURL *letterPurl = [[NSBundle mainBundle]URLForResource:@"p" withExtension:@"aiff"];
    letterP.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterPurl error:nil];
    letterP.name = @"P";
    letterP.whichLetter = @"P";
    return letterP;
}

-(LowerCaseLetter *)createLetterQ {
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-Q"];
    NSURL *letterQurl = [[NSBundle mainBundle]URLForResource:@"q" withExtension:@"aiff"];
    letterQ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterQurl error:nil];
    letterQ.name = @"Q";
    letterQ.whichLetter = @"Q";
    return letterQ;
}

-(LowerCaseLetter *)createLetterR {
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-R"];
    
    NSURL *letterRurl = [[NSBundle mainBundle]URLForResource:@"r" withExtension:@"aiff"];
    letterR.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterRurl error:nil];
    letterR.name = @"R";
    letterR.whichLetter = @"R";
    return letterR;
}

-(LowerCaseLetter *)createLetterS {
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-S"];
    NSURL *letterSurl = [[NSBundle mainBundle]URLForResource:@"s" withExtension:@"aiff"];
    letterS.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterSurl error:nil];
    letterS.name = @"S";
    letterS.whichLetter = @"S";
    return letterS;
}

-(LowerCaseLetter *)createLetterT {
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-T"];
    NSURL *letterTurl = [[NSBundle mainBundle]URLForResource:@"t2" withExtension:@"aiff"];
    letterT.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterTurl error:nil];
    letterT.name = @"T";
    letterT.whichLetter = @"T";
    return letterT;
}

-(LowerCaseLetter *)createLetterU {
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-U"];
    NSURL *letterUurl = [[NSBundle mainBundle]URLForResource:@"u" withExtension:@"aiff"];
    letterU.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterUurl error:nil];
    letterU.name = @"U";
    letterU.whichLetter = @"U";
    return letterU;
}

-(LowerCaseLetter *)createLetterV {
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-V"];
    NSURL *letterVurl = [[NSBundle mainBundle]URLForResource:@"v" withExtension:@"aiff"];
    letterV.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterVurl error:nil];
    letterV.name = @"V";
    letterV.whichLetter = @"V";
    return letterV;
}

-(LowerCaseLetter *)createLetterW {
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-W"];
    NSURL *letterWurl = [[NSBundle mainBundle]URLForResource:@"w" withExtension:@"aiff"];
    letterW.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterWurl error:nil];
    letterW.name = @"W";
    letterW.whichLetter = @"W";
    return letterW;
}

-(LowerCaseLetter *)createLetterX {
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-X"];
    NSURL *letterXurl = [[NSBundle mainBundle]URLForResource:@"x" withExtension:@"aiff"];
    letterX.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterXurl error:nil];
    letterX.name = @"X";
    letterX.whichLetter = @"X";
    return letterX;
}

-(LowerCaseLetter *) createLetterY {
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-Y"];
    NSURL *letterYurl = [[NSBundle mainBundle]URLForResource:@"y" withExtension:@"aiff"];
    letterY.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterYurl error:nil];
    letterY.name = @"Y";
    letterY.whichLetter = @"Y";
    return letterY;
}

-(LowerCaseLetter *)createLetterZ {
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"wood-letter-Z"];
    NSURL *letterZurl = [[NSBundle mainBundle]URLForResource:@"z" withExtension:@"aiff"];
    letterZ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterZurl error:nil];
    letterZ.name = @"Z";
    letterZ.whichLetter = @"Z";
    return letterZ;
}

@end
