//
//  Matching.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/11/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//


#import "Matching.h"
#import "HistoryData.h"
#import "Scoreboard.h"
#import "MatchTerm.h"

@implementation Matching

SKSpriteNode *backToMainMenuArrow;
SKSpriteNode *forward;

NSMutableArray *myLines;
NSMutableArray *myEndLines;
NSMutableArray *matchingData;
NSMutableArray *myArrows;
NSMutableArray *correctAndIncorrectMarks;
NSMutableArray *myCurrentTerms;
NSMutableArray *labelTermsForRemove;
NSMutableArray *termsToMatch;
NSMutableArray *movableSprites;

int termNumber = 0;
int termsInSection = 0;
int correct;
int incorrect;
int midPoint;
int midPointHoriz;
int cause_y_offset;
int cause_long_y_offset;
int effect_y_offset;
int effect_long_y_offset;

BOOL sectionCompleted;
BOOL mapFlag = FALSE;
BOOL docFlag = FALSE;

BOOL levelOne = FALSE;
BOOL levelTwo = FALSE;
BOOL levelThree = FALSE;

BOOL levelOneSubOne = FALSE;
BOOL levelOneSubTwo = FALSE;
BOOL levelOneSubThree = FALSE;

BOOL levelTwoSub = FALSE;


SKNode *topicMenu;
SKNode *menuWithItems;

SKLabelNode *correctMatch;
SKLabelNode *incorrectMatch;
SKLabelNode *navigator;
SKLabelNode *backgroundInfo;
SKLabelNode *categoryInfo;

SKLabelNode *numberCorrect;
SKLabelNode *numberWrong;
SKLabelNode *numberCorrectCounter;
SKLabelNode *numberIncorrectCounter;
SKLabelNode *scoreDisplay;
SKLabelNode *scoreCounter;
SKLabelNode *topicSection;

SKLabelNode *explanationText;
SKLabelNode *explanationText2;
SKLabelNode *explanationText3;
SKLabelNode *explanationText4;
SKLabelNode *explanationText5;
Scoreboard *scoreHUD;

NSMutableArray *instructionsText;

HistoryData *sharedData;

CGPoint _scoreActual_pos;

CGPoint _birdie_pos;
CGPoint _questionCategory_pos;

CGPoint _setOfAnswers;
CGPoint _totalScoreCounter;
CGPoint answerRelativeToButton;
CGPoint _pointForTitlePosition;
CGPoint _timerCounterPos;
CGPoint _explanation_pos;
CGPoint answerPosition;
CGSize winSize;


int xValTerm = 100;
int yValTerm = 100;

@synthesize selectedNode, background;

- (id)initWithSize:(CGSize)size
{
    if(self = [super initWithSize:size])
    {
        
        background = [SKSpriteNode spriteNodeWithImageNamed:@"old-notebook-10.png"];
        background.name = @"background";
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
       
        winSize = CGSizeMake(size.width, size.height);
    
        
        
        sharedData = [HistoryData sharedManager];
        
        termNumber = 0;
        correct = 0;
        
        NSString *pListData = [[NSBundle mainBundle]
                               pathForResource:@"Matching"
                               ofType:@"plist"];
        
        matchingData = [[NSMutableArray alloc] initWithContentsOfFile:pListData];
        
        myCurrentTerms = [[NSMutableArray alloc]init];
        myArrows = [[NSMutableArray alloc]init];
        myLines = [[NSMutableArray alloc]init];
        myEndLines = [[NSMutableArray alloc]init];
        correctAndIncorrectMarks = [[NSMutableArray alloc]init];
        labelTermsForRemove = [[NSMutableArray alloc]init];
        
        instructionsText = [[NSMutableArray alloc]initWithObjects:
                                        @"A term is presented to you",
                                        @"The causes and effects for the term are also displayed",
                                        @"If a cause Drag the term to the left ",
                                        @"If effect Drag the term to the right",
                                        nil];
        
        int i=0;
        
        for (NSString *instruct in instructionsText) {
            NSLog(@"instructions");
            
            SKLabelNode *myInstruct = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            myInstruct.text = instruct;
            myInstruct.fontSize = 12;
            myInstruct.fontColor = [UIColor redColor];
            myInstruct.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - i);
            myInstruct.name = @"instruct";
            [self addChild:myInstruct];
            i += 50;
            
        }
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        
        myLabel.text = @"Matching Exercises";
        myLabel.fontColor = [UIColor blueColor];
        myLabel.fontSize = 24;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)+200);
        [self addChild:myLabel];
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-3.png"];
        backToMainMenuArrow.scale = 0.2;
        backToMainMenuArrow.position = CGPointMake(400, 20);
        [self addChild:backToMainMenuArrow];
        
        forward = [SKSpriteNode spriteNodeWithImageNamed:@"next-button.png"];
        forward.name = @"next";
        forward.scale = 0.2;

        forward.position = CGPointMake(450, 20);
        [self addChild:forward];
    }
    return self;
}


- (UIImage *)makeImageFromLabel: (UILabel *)labelToConvert {
    
    CGRect labelBound = [labelToConvert bounds];
    UIGraphicsBeginImageContext(labelBound.size);
    [[labelToConvert layer]renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *convertedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return convertedImage;
    
}


- (void)didMoveToView:(SKView *)view {
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}


- (void)handlePanFrom:(UIPanGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateBegan) {
        
        CGPoint touchLocation = [recognizer locationInView:recognizer.view];
        touchLocation = [self convertPointFromView:touchLocation];
        [self selectNodeForTouch:touchLocation];
        
    } else if (recognizer.state == UIGestureRecognizerStateChanged) {
        
        CGPoint translation = [recognizer translationInView:recognizer.view];
        translation = CGPointMake(translation.x, -translation.y);
        [self panForTranslation:translation];
        [recognizer setTranslation:CGPointZero inView:recognizer.view];
        
    } else if (recognizer.state == UIGestureRecognizerStateEnded) {
        
        for(MatchTerm *destination in movableSprites) {
            if(CGRectIntersectsRect(destination.frame,selectedNode.frame) &&
               [destination.name isEqualToString:selectedNode.name]) {
                
                NSLog(@"destination: %@, selected: %@", destination.name, selectedNode.name);
                
                [selectedNode removeAllActions];
                destination.matched = TRUE;
                SKAction *moveToTop = [SKAction moveTo:CGPointMake(destination.position.x,destination.position.y + 100) duration:1.0];
                [destination runAction:moveToTop];
                [selectedNode runAction:moveToTop];
                selectedNode.scale = 0.2;
                //destination.scale = 0.5;
                selectedNode = nil;
                
            }
        }
        
        BOOL allMatched = FALSE;
        int checkMatches = [movableSprites count];
        
        for(MatchTerm *destination in movableSprites) {
            if (destination.matched) {
                checkMatches--;
            }
            if (checkMatches == 0) {
                allMatched = TRUE;
            }
        }
        
        if (allMatched) {
            NSLog(@"all terms matched");
        }
        
    }
}

-(void)moveIt:(UIPanGestureRecognizer *)recognizer {
    float scrollDuration = 0.2;
    CGPoint velocity = [recognizer velocityInView:recognizer.view];
    CGPoint pos = [selectedNode position];
    CGPoint p = mult(velocity, scrollDuration);
    
    CGPoint newPos = CGPointMake(pos.x + p.x, pos.y + p.y);
    newPos = [self boundLayerPos:newPos];
    [selectedNode removeAllActions];
    
    SKAction *moveTo = [SKAction moveTo:newPos duration:scrollDuration];
    [moveTo setTimingMode:SKActionTimingEaseOut];
    [selectedNode runAction:moveTo];
}

CGPoint mult(const CGPoint v, const CGFloat s) {
	return CGPointMake(v.x*s, v.y*s);
}

-(void)addChainEffectTermDestination:(NSString*)type theTerm:(NSString*)term {
    
    /*SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-arrow-right.png"];
    termDestination.position = CGPointMake(winSize.width/2, winSize.height/2);
    termDestination.zPosition = 10;
    termDestination.name = type;*/
    UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 240)];
    firstLabel.text = term;
    firstLabel.textColor = [UIColor blackColor];
    firstLabel.font = [UIFont fontWithName:@"Carton-Slab" size:12.0];
    firstLabel.numberOfLines = 4;
    firstLabel.preferredMaxLayoutWidth = 350;
    
    UIImage *imageToRender4 = [self makeImageFromLabel:firstLabel];
    SKTexture *labelTexture4 = [SKTexture textureWithImage:imageToRender4];
    SKSpriteNode *renderLabel4 = [SKSpriteNode spriteNodeWithTexture:labelTexture4];
    renderLabel4.position = CGPointMake(xValTerm,yValTerm);
    renderLabel4.scale = 1.0;
    [self addChild:renderLabel4];
    
    /*SKLabelNode *theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    theLabel.text = term;
    theLabel.name = type;
    theLabel.fontSize = 16;
    theLabel.fontColor = [UIColor orangeColor];
    theLabel.position = CGPointMake(xValTerm, yValTerm);
    theLabel.zPosition = 100;
    
    [self addChild:theLabel];*/
    
    
    
    xValTerm += 200;
    if(xValTerm > 500) {
        xValTerm = 100;
        yValTerm -= 50;
    }
    
    //[termsToMatch addObject:theLabel];
    [termsToMatch addObject:renderLabel4];
}


-(void) nextTopic {
    
    if (termNumber == 0) {
        [self removeAllChildren];
        scoreHUD = [[Scoreboard alloc]init];
        scoreHUD.position = CGPointMake(0,0);
        [self addChild:backToMainMenuArrow];
        [self addChild:forward];
        [self addChild:scoreHUD];
    }
    
    for (SKLabelNode *oldTerm in termsToMatch) {
        [oldTerm removeFromParent];
    }
    
    for (SKLabelNode *arrows in movableSprites) {
        [arrows removeFromParent];
    }
    
    [backgroundInfo removeFromParent];
    [myLines removeAllObjects];
    [myEndLines removeAllObjects];
    [myCurrentTerms removeAllObjects];
    
    mapFlag = FALSE;
    docFlag = FALSE;
    termsToMatch = [[NSMutableArray alloc]init];
    movableSprites = [[NSMutableArray alloc]init];
    labelTermsForRemove = [[NSMutableArray alloc]init];
    
    NSDictionary *currentProblem = [[NSDictionary alloc]initWithDictionary:(NSDictionary *)[matchingData objectAtIndex:termNumber]];
    
    int index = 0;
    
    if ([[currentProblem valueForKey:@"Type"]isEqualToString:@"chainEffect"]) {
        
        xValTerm = 100;
        yValTerm = 100;
        
        for (NSString *key in currentProblem) {
            if ([key isEqualToString:@"Term1"]) {
                
                MatchTerm *termDestination = [MatchTerm spriteNodeWithImageNamed:@"yellow-arrow-right.png"];
                termDestination.position = CGPointMake(winSize.width/4, winSize.height/1.8);
                termDestination.zPosition = 10;
                termDestination.name = key;
                termDestination.zPosition = 5;
                [self addChild:termDestination];
                [movableSprites addObject:termDestination];
                [self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
                
                index++;
                termsInSection++;
                
            } else if ([key isEqualToString:@"Term2"]) {
                
                MatchTerm *termDestination = [MatchTerm spriteNodeWithImageNamed:@"blue-arrow-right.png"];
                termDestination.position = CGPointMake(winSize.width/2, winSize.height/1.8);
                termDestination.zPosition = 10;
                termDestination.name = key;
                [self addChild:termDestination];
                [movableSprites addObject:termDestination];
                
                
                [self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
                
                index++;
                termsInSection++;
                
            } else if ([key isEqualToString:@"Term3"]) {
                
                MatchTerm *termDestination = [MatchTerm spriteNodeWithImageNamed:@"purple-arrow-right.png"];
                termDestination.position = CGPointMake(winSize.width/1.2, winSize.height/1.8);
                termDestination.zPosition = 10;
                termDestination.name = key;
                [self addChild:termDestination];
                [movableSprites addObject:termDestination];
                
                
                [self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
 
                
                index++;
                termsInSection++;
                
            } else if ([key isEqualToString:@"Term2A"]) {
                //[self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
  
                //index++;
                //termsInSection++;
            } else if ([key isEqualToString:@"Term2B"]) {
                //[self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];

                
                //index++;
                //termsInSection++;
            } else if ([key isEqualToString:@"Term3A"]) {
                //[self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
                
                //index++;
                //termsInSection++;
            }else if ([key isEqualToString:@"Term3B"]) {
                //[self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
                
                //index++;
                //termsInSection++;
            }else if ([key isEqualToString:@"Term4"]) {
                //[self addChainEffectTermDestination:key theTerm:[currentProblem valueForKey:key]];
                
                //index++;
                //termsInSection++;
            }
        }
        
    } else if ([[currentProblem valueForKey:@"Type"]isEqualToString:@"multiCausev"]) {
        
        
    } else if ([[currentProblem valueForKey:@"Type"]isEqualToString:@"docTopic"]) {
        
        
    }
    
    
    int offsetX = 0;
    int offsetY = 0;
    float startX = 300;
    float startY = 420;
    float startXMatch = 100;
    float startYMatch = 500;
    
    int LTC_Beg_X = 150;
    int LTC_Beg_Y = 450;
    
    int LTE_Beg_X = 850;
    int LTE_Beg_Y = 450;
    
    int STC_Beg_X = 150;
    int STC_Beg_Y = 360;
    
    int STE_Beg_X = 850;
    int STE_Beg_Y = 260;
    
    int CON_Beg_X = 380;
    int CON_Beg_Y = 560;

    
    termsInSection = 0;
    
    
    
    for (NSString *key in currentProblem) {
        // ****** Layout BUTTONS based on type *****

        
        int typeOfMatchTag = 100;
        
        id typeOfMatchTemp = [currentProblem objectForKey:key];
        
        NSString *typeOfMatch = [[NSString alloc]initWithString:typeOfMatchTemp];
        
        if ([typeOfMatch isEqualToString:@"LTE"]) {
            typeOfMatchTag = 1;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-arrow-left.png"];
            termDestination.position = CGPointMake(500,500+LTE_Beg_Y);
            // no tagging
            LTE_Beg_Y -= 50;
            
            [self addChild:termDestination];

            SKLabelNode *theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.text = key;
            theLabel.fontSize = 14;
            theLabel.fontColor = [UIColor orangeColor];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);
            offsetX += 100;
            
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 140;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
            
        } else if([typeOfMatch isEqualToString:@"STE"]) {
            
            typeOfMatchTag = 2;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-arrow-left.png"];
            termDestination.scale = 0.4;
            
            termDestination.position = CGPointMake(100, 400);
            STE_Beg_Y -= 50;
            
            [self addChild:termDestination];
            
            
            SKLabelNode *theLabel;
            theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.text = key;
            theLabel.fontSize = 14;
            theLabel.fontColor = [UIColor orangeColor];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);
            offsetX += 100;
            
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 140;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
            
        } else if([typeOfMatch isEqualToString:@"LTC"]) {
            typeOfMatchTag = 3;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-arrow-right.png"];
            termDestination.position = CGPointMake(LTC_Beg_X, LTC_Beg_Y);
            termDestination.scale = 0.4;
            LTC_Beg_Y -= 50;
            
            [self addChild:termDestination];
            
            
            
            SKLabelNode *theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);
            theLabel.text = key;
            theLabel.fontSize = 14;
            theLabel.fontColor = [UIColor orangeColor];
            offsetX += 120;
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 140;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
            
        } else if([typeOfMatch isEqualToString:@"STC"]) {
            typeOfMatchTag = 4;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"yellow-arrow-right.png"];
            termDestination.position = CGPointMake(STC_Beg_X, STC_Beg_Y);
            termDestination.scale = 0.4;
            STC_Beg_Y -= 50;
            [self addChild:termDestination];

            SKLabelNode *theLabel;
            theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);
            theLabel.text = key;
            theLabel.fontSize = 14;
            theLabel.fontColor = [UIColor orangeColor];
            offsetX += 120;
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 140;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
        } else if([typeOfMatch isEqualToString:@"CON"]) {
            typeOfMatchTag = 5;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"Conflict-arrow.png"];
            termDestination.position = CGPointMake(CON_Beg_X, CON_Beg_Y);
            termDestination.scale = 0.4;
            CON_Beg_Y -=50;
            [self addChild:termDestination];
            
            SKLabelNode *theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);theLabel.fontSize = 14;
            theLabel.fontColor = [UIColor orangeColor];
            theLabel.text = key;
            offsetX += 120;
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 40;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
            
        } else if([typeOfMatch isEqualToString:@"CON1"]) {
            
            typeOfMatchTag = 6;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"conflict-winner-arrow.png"];
            termDestination.position = CGPointMake(CON_Beg_X, CON_Beg_Y);
            [self addChild:termDestination];
            
            SKLabelNode *theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);
            
            theLabel.fontSize = 14;
            theLabel.fontColor = [UIColor orangeColor];
            theLabel.text = key;
            offsetX += 120;
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 140;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
        } else if([typeOfMatch isEqualToString:@"CON2"]) {
            
            typeOfMatchTag = 7;
            SKSpriteNode *termDestination = [SKSpriteNode spriteNodeWithImageNamed:@"conflict-resist-arrow.png"];
            
            termDestination.position = CGPointMake(CON_Beg_X-200, CON_Beg_Y);
            [self addChild:termDestination];
            
            SKLabelNode *theLabel;
            theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            theLabel.position = CGPointMake(startX+offsetX, startY+offsetY);
            offsetX += 120;
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 140;
                
            }
            
            [self addChild:theLabel];
            
            [termsToMatch addObject:theLabel];
            [movableSprites addObject:termDestination];
            
            index++;
            termsInSection++;
            
            
        }
        else if([typeOfMatch isEqualToString:@"Topic"]) {
            
            backgroundInfo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            backgroundInfo.fontColor = [UIColor blueColor];
            backgroundInfo.fontSize = 20;
            backgroundInfo.text = key;
            backgroundInfo.position = CGPointMake(winSize.width/2,winSize.height/2);
            [self addChild:backgroundInfo];
            
            
            
        } else if([typeOfMatch isEqualToString:@"Category"]) {
            
            categoryInfo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            categoryInfo.position = CGPointMake(500,520);
            [self addChild:categoryInfo];
            [labelTermsForRemove addObject:categoryInfo];
            
        } else if([typeOfMatch isEqualToString:@"Subcat1"]) {
            
            continue;
            
        } else if([typeOfMatch isEqualToString:@"Subcat2"]) {
            
            continue;
            
        } else if([typeOfMatch isEqualToString:@"DocTopic"]) {
            
            docFlag = TRUE;
            
            backgroundInfo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            backgroundInfo.position = CGPointMake(500,670);
            backgroundInfo.text = key;
            
            [self addChild:backgroundInfo];

            [labelTermsForRemove addObject:backgroundInfo];
            
            
        } else if([typeOfMatch isEqualToString:@"1Doc"]) {
            
            
            typeOfMatchTag = 11;
            
            backgroundInfo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            backgroundInfo.position = CGPointMake(180,500);
            
            SKSpriteNode *mainTerm = [SKSpriteNode spriteNodeWithImageNamed:@"association.png"];
            mainTerm.position = CGPointMake(200,420);
            
            [self addChild:backgroundInfo];
            [self addChild:mainTerm];
            
            
            [movableSprites addObject:mainTerm];
            [labelTermsForRemove addObject:backgroundInfo];
            
            
        } else if([typeOfMatch isEqualToString:@"1-1Doc"]) {
            
            typeOfMatchTag = 11;
            SKLabelNode *theLabel;
            theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            offsetX += 400;
            
            
            if (offsetX > 388) {
                offsetX = 400;
                offsetY -= 50;
                
            }
            theLabel.position = CGPointMake(startXMatch+offsetX, startYMatch+offsetY);
            [self addChild:theLabel];
            
            
            [termsToMatch addObject:theLabel];
            termsInSection++;
            
            
        }
        else if([typeOfMatch isEqualToString:@"2Doc"]) {
            
            typeOfMatchTag = 12;
            
            backgroundInfo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            SKSpriteNode *mainTerm = [SKSpriteNode spriteNodeWithImageNamed:@"association.png"];
            mainTerm.position = CGPointMake(820,420);
            [self addChild:backgroundInfo];
            [self addChild:mainTerm];
            
            [movableSprites addObject:mainTerm];
            [labelTermsForRemove addObject:backgroundInfo];
            
            
        } else if ([typeOfMatch isEqualToString:@"2-1Doc"]) {
            
            typeOfMatchTag = 12;
            
            SKLabelNode *theLabel;
            offsetX += 400;
            
            if (offsetX > 488) {
                offsetX = 400;
                offsetY -= 50;
                
            }
            
            theLabel.position = CGPointMake(startXMatch+offsetX, startYMatch+offsetY);
            [termsToMatch addObject:theLabel];
            termsInSection++;
            
            
        } else if ([typeOfMatch isEqualToString:@"3Doc"]) {
            typeOfMatchTag = 13;
            
            backgroundInfo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            SKSpriteNode *mainTerm = [SKSpriteNode spriteNodeWithImageNamed:@"document.png"];
            mainTerm.position = CGPointMake(500,500);
            backgroundInfo.position = CGPointMake(500,500);
            [self addChild:backgroundInfo];
            [self addChild:mainTerm];
            
            [movableSprites addObject:mainTerm];
            //[termsToMatch addObject:backgroundInfo];
            [labelTermsForRemove addObject:backgroundInfo];
            
        } else if ([typeOfMatch isEqualToString:@"3-1Doc"]) {
            
            typeOfMatchTag = 13;
            
            SKLabelNode *theLabel;
            theLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            offsetX += 200;
            
            if (offsetX > 488) {
                offsetX = 200;
                offsetY -= 20;
                
            }
            
            theLabel.position = CGPointMake(startX+offsetX+300, startY+offsetY);
            [self addChild:theLabel];
            [termsToMatch addObject:theLabel];
            termsInSection++;
            
        } else if([typeOfMatch isEqualToString:@"DocWrong"]) {
            
            
        } else if([typeOfMatch isEqualToString:@"Map"]) {
            
 
        
            mapFlag = TRUE;
            
  
            
            
        } else if([typeOfMatch isEqualToString:@"map-element-1"]) {
            
            typeOfMatchTag = 20;
   
            
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 20;
                
            }
            
 
            index++;
            termsInSection++;
            
        } else if([typeOfMatch isEqualToString:@"map-element-2"]) {
            
            typeOfMatchTag = 21;
 
            
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 20;
                
            }
            

            index++;
            termsInSection++;
            
        } else if([typeOfMatch isEqualToString:@"map-element-3"]) {
            typeOfMatchTag = 22;
            
            if (offsetX > 488) {
                offsetX = 100;
                offsetY -= 20;
                
            }
            

            index++;
            termsInSection++;
        } else if([typeOfMatch isEqualToString:@"map-end"]) {
            
            mapFlag = TRUE;
            
        }
        
    }
    termNumber++;   // Index into array of NSDictionary of terms to match
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch *touch = [touches anyObject];
    CGPoint positionInScene = [touch locationInNode:self];
    [self selectNodeForTouch:positionInScene];
    
    
}


- (CGPoint)boundLayerPos:(CGPoint)newPos {
    CGSize winSize = self.size;
    CGPoint retval = newPos;
    retval.x = MIN(retval.x, 0);
    retval.x = MAX(retval.x, -[background size].width+ winSize.width);
    retval.y = [self position].y;
    return retval;
}

- (void)panForTranslation:(CGPoint)translation {
    
    CGPoint position = [selectedNode position];
    
    if([[selectedNode name] isEqualToString:@"Term1"]) {
        
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"Term2"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];

    } else if ([[selectedNode name]isEqualToString:@"Term3"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"Term2A"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"Term2B"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"Term3A"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"Term3B"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"Term4"]) {
        [selectedNode setPosition:CGPointMake(position.x + translation.x, position.y + translation.y)];
        
    } else if ([[selectedNode name]isEqualToString:@"next"]) {
        
        [self nextTopic];
        
    } else {
        
        CGPoint newPos = CGPointMake(position.x + translation.x, position.y + translation.y);
        [background setPosition:[self boundLayerPos:newPos]];
    }
}

float degToRad(float degree) {
	return degree / 180.0f * M_PI;
}

- (void)selectNodeForTouch:(CGPoint)touchLocation {

    SKSpriteNode *touchedNode = (SKSpriteNode *)[self nodeAtPoint:touchLocation];

	if(![selectedNode isEqual:touchedNode]) {
		[selectedNode removeAllActions];
		[selectedNode runAction:[SKAction rotateToAngle:0.0f duration:0.1]];
        
		selectedNode = touchedNode;

		if([[touchedNode name] isEqualToString:@"Term1"]) {
			SKAction *scaleUpSelect = [SKAction scaleTo:1.5 duration:0.1];
			[selectedNode runAction:scaleUpSelect];
		} else if ([[touchedNode name]isEqualToString:@"Term2"]) {
            SKAction *scaleUpSelect = [SKAction scaleTo:1.5 duration:0.1];
			[selectedNode runAction:scaleUpSelect];
        } else if ([[touchedNode name]isEqualToString:@"Term3"]) {
            SKAction *scaleUpSelect = [SKAction scaleTo:1.5 duration:0.1];
			[selectedNode runAction:scaleUpSelect];
        } else if ([[touchedNode name]isEqualToString:@"next"]) {
            NSLog(@"next topic");
            [self nextTopic];
        }
	}
    
}


@end
