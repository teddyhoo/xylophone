//
//  Spelling.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 1/23/14.
//  Copyright (c) 2014 Melanie Taylor. All rights reserved.
//

#import "Spelling.h"
#import "IntroScreen.h"


@implementation Spelling

NSMutableArray *texturesForAnim;
NSMutableArray *allTheLetterBlocks;
NSMutableArray *placedLetters;
NSMutableArray *dictionaryOfWords;
NSMutableArray *letterDropBox;

SKSpriteNode *currentSprite;
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
        
        
        SKSpriteNode *woodLetterA = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-A"];
        woodLetterA.name = @"A";
        SKSpriteNode *woodLetterB = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-B"];
        woodLetterB.name = @"B";
        SKSpriteNode *woodLetterC = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-C"];
        woodLetterC.name = @"C";
        SKSpriteNode *woodLetterS = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-S"];
        woodLetterS.name = @"S";
        SKSpriteNode *woodLetterM = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-M"];
        woodLetterM.name = @"M";
        SKSpriteNode *woodLetterT = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-T"];
        woodLetterT.name = @"T";
        SKSpriteNode *woodLetterG = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-G"];
        woodLetterG.name = @"G";
        SKSpriteNode *woodLetterR = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-R"];
        woodLetterR.name = @"R";
        SKSpriteNode *woodLetterO = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-O"];
        woodLetterO.name = @"O";
        SKSpriteNode *woodLetterF = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-F"];
        woodLetterF.name = @"F";
        SKSpriteNode *woodLetterD = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-D"];
        woodLetterD.name = @"D";
        SKSpriteNode *woodLetterH = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-H"];
        woodLetterH.name = @"H";
        SKSpriteNode *woodLetterI = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-I"];
        woodLetterI.name = @"I";
        SKSpriteNode *woodLetterP = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-P"];
        woodLetterP.name = @"P";
        SKSpriteNode *woodLetterN = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-N"];
        woodLetterN.name = @"N";
        SKSpriteNode *woodLetterL = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-L"];
        woodLetterL.name = @"L";
        SKSpriteNode *woodLetterK = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-K"];
        woodLetterK.name = @"K";
        SKSpriteNode *woodLetterE = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-E"];
        woodLetterE.name = @"E";
        SKSpriteNode *woodLetterZ = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-Z"];
        woodLetterZ.name = @"Z";
        SKSpriteNode *woodLetterQ = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-Q"];
        woodLetterQ.name = @"Q";
        SKSpriteNode *woodLetterX = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-X"];
        woodLetterX.name = @"X";
        SKSpriteNode *woodLetterU = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-U"];
        woodLetterU.name = @"U";
        SKSpriteNode *woodLetterV = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-V"];
        woodLetterV.name = @"V";
        SKSpriteNode *woodLetterW = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-W"];
        woodLetterW.name = @"W";
        SKSpriteNode *woodLetterJ = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-J"];
        woodLetterJ.name = @"J";
        SKSpriteNode *woodLetterY = [SKSpriteNode spriteNodeWithImageNamed:@"wood-letter-Y"];
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
    
    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];
    NSLog(@"name of node: %@",touchedNode.name);
    

    NSString *fileName = [NSString stringWithFormat:@"wood-letter-%@",touchedNode.name];
    currentSprite = [SKSpriteNode spriteNodeWithImageNamed:fileName];
    currentSprite.scale = 1.6;
    currentSprite.position = touchLocation;
    currentSprite.zPosition = 100;
    currentSprite.name = touchedNode.name;
    
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
        
        for (SKSpriteNode *boxDrop in letterDropBox) {
            BOOL incorrectLetterBox = FALSE;
            
            NSLog(@"chosen letter: %@, boxDrop: %@", currentSprite.name, boxDrop.name);
            if (CGRectIntersectsRect(boxDrop.frame, currentSprite.frame) &&
                [boxDrop.name isEqualToString:currentSprite.name]) {
                
                NSLog(@"matched");
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
                        [imageForSpelling runAction:[SKAction moveTo:CGPointMake(100, 100) duration:0.5]];
                        [self nextQuestion];
                        
                    }];
                    
                    [self runAction:transitionNext];
                    
                }
                
                                                  
                    
            } else {
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

@end
