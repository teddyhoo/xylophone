//
//  TopicPicker.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/12/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "TopicPicker.h"
#import "HistoryData.h"

@implementation TopicPicker

@synthesize topic1, topic2, topic3, topic4, topic5, topic6, topic7, topic8, topic9, topic10, topic11, topic12, topic13, topic14, topic15, topic16, topic17, topic18, topic19, topic20, topic21, topic22;

SKSpriteNode *startArrow;
NSMutableArray *topicSpriteLabels;
int numColonial, numRevolution, numEarlyRep, numEraGood, numJacksonian, numWestward, numAntebellum, numCivilWar, numReconstruct, numGilded, numProgressive, numImperialism, numWorldWarI, numTwenties, numDepression, numWorldWarII, numColdWar, numCivilRights, num60sAnd70s, numReagan, numModern;

-(void) setDelegate:(id)delegate {
    
    _delegate = delegate;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        
        //HistoryData *sharedData = [HistoryData sharedManager];

        SKSpriteNode *pickerBackground = [SKSpriteNode spriteNodeWithImageNamed:@"topicPicker.png"];
        pickerBackground.position = CGPointMake(80, -10);
        [self addChild:pickerBackground];
        
        /*
        NSMutableArray *quizQuestions = [[NSMutableArray alloc]init];
        NSMutableArray *quizAnswers = [[NSMutableArray alloc]init];
        NSMutableArray *quizWrongOne = [[NSMutableArray alloc]init];
        NSMutableArray *quizWrongTwo = [[NSMutableArray alloc]init];
        NSMutableArray *quizWrongThree = [[NSMutableArray alloc]init];
        NSMutableArray *quizWrongFour = [[NSMutableArray alloc]init];
        NSMutableArray *questionClue = [[NSMutableArray alloc]init];
        NSMutableArray *tagFirst = [[NSMutableArray alloc]init];
        NSMutableArray *tagSecond = [[NSMutableArray alloc]init];
        NSMutableArray *questionSection = [[NSMutableArray alloc]init];
        NSMutableArray *imageList = [[NSMutableArray alloc]init];
        
        NSMutableDictionary *sortedQuestions = [[NSMutableDictionary alloc]init];
        
        int i = 0;
        
        for (NSString *questionsForSection in sharedData.sectionForQuestion) {
            
            //if ([questionsForSection isEqualToString:currentlySelectedTerm]) {
                
                NSString *temp = [sharedData.quizQuestions objectAtIndex:i];
                NSString *temp2 = [sharedData.quizAnswers objectAtIndex:i];
                NSString *temp3 = [sharedData.wrongAnswerOne objectAtIndex:i];
                NSString *temp4 = [sharedData.wrongAnswerTwo objectAtIndex:i];
                NSString *temp5 = [sharedData.wrongAnswerThree objectAtIndex:i];
                
                NSString *temp7 = [sharedData.helperTips objectAtIndex:i];
                
                NSString *temp11 = [sharedData.sectionForQuestion objectAtIndex:i];
                NSString *temp12 = [sharedData.imageForQuestion objectAtIndex:i];
                
                [quizQuestions addObject:temp];
                [quizAnswers addObject:temp2];
                [quizWrongOne addObject:temp3];
                [quizWrongTwo addObject:temp4];
                [quizWrongThree addObject:temp5];
                [questionClue addObject:temp7];
                [questionSection addObject:temp11];
                [imageList addObject:temp12];
            
            //if ([temp11 isEqualToString:@"Jacksonian"]) {
                //NSLog(@"%@: %@",temp11,temp);
            //}
            
                [sortedQuestions setValue:temp11 forKey:temp];

                i++;
        }
        
        numColonial = 0;
        numRevolution =  0;
        numEarlyRep =  0;
        numEraGood = 0;
        numJacksonian =  0;
        numWestward = 0;
        numAntebellum =  0;
        numCivilWar = 0;
        numReconstruct = 0;
        numGilded = 0;
        numProgressive = 0;
        numImperialism = 0;
        numWorldWarI = 0;
        numTwenties = 0;
        numDepression = 0;
        numWorldWarII = 0;
        numCivilRights = 0;
        numColdWar = 0;
        num60sAnd70s = 0;
        numReagan = 0;
        numModern = 0;
        */
        
        /*for (NSString *key in sortedQuestions) {
            
            if ([[sortedQuestions valueForKey:key] isEqualToString:@"Colonial"]) {
                numColonial++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Revolution"]) {
                numRevolution++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Early Republic"]) {
                numEarlyRep++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Era of Good Feelings"]) {
                numEraGood++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Jacksonian"]) {
                numJacksonian++;
             } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Westward Expansion"]) {
                numWestward++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Antebellum"]) {
                numAntebellum++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Civil War"]) {
                numCivilWar++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Reconstruction"]) {
                numReconstruct++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Gilded Age"]) {
                numGilded++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Progressive"]) {
                numProgressive++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Imperialism"]) {
                numImperialism++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"World War I"]) {
                numWorldWarI++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Twenties"]) {
                numTwenties++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Depression"]) {
                numDepression++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"World War II"]) {
                numWorldWarII++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Civil Rights"]) {
                numCivilRights++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Cold War"]) {
                numColdWar++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Reagan Era"]) {
                numReagan++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Modern"]) {
                numModern++;
            } else if ([[sortedQuestions valueForKey:key] isEqualToString:@"Sixties"]) {
                num60sAnd70s++;
            }
        }*/

       /* NSLog(@"number of colonial: %i", numColonial);
        NSLog(@"number of revolution: %i", numRevolution);
        NSLog(@"number of early republic: %i", numEarlyRep);
        NSLog(@"number of era of good feelings: %i", numEraGood);
        NSLog(@"number of Jacksonian: %i", numJacksonian);
        NSLog(@"number of westward: %i", numWestward);
        NSLog(@"number of antebellum: %i", numAntebellum);
        NSLog(@"number of civil war: %i", numCivilWar);
        NSLog(@"number of reconstruction: %i", numReconstruct);
        NSLog(@"number of gilded: %i", numGilded);
        NSLog(@"number of Progressive: %i", numProgressive);
        NSLog(@"number of Imperialism: %i", numImperialism);
        NSLog(@"number of World War I: %i", numWorldWarI);
        NSLog(@"number of Twenties: %i", numTwenties);
        NSLog(@"number of Depression: %i", numDepression);
        NSLog(@"number of World War II: %i", numWorldWarII);
        NSLog(@"number of Cold War: %i", numColdWar);
        NSLog(@"number of Reagan: %i",numReagan);
        NSLog(@"number of Modern: %i", numModern);
        NSLog(@"number of Civil Rights %i", numCivilRights);
        NSLog(@"number of 60's %i", num60sAnd70s);
 */
// ----------------------------------------------------------------------------------------------
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Muncie"];
        titleLabel.text = @"Choose Topic";
        titleLabel.fontColor = [UIColor yellowColor];
        titleLabel.fontSize = 40;
        titleLabel.position = CGPointMake(180, 380);
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        titleLabel.name = @"title";
        
        topic2 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic2.text = @"Colonial";
        topic2.fontColor = [UIColor blackColor];
        topic2.fontSize = 40;
        topic2.position = CGPointMake(50, 300);
        topic2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic2.name = @"Colonial";
// ----------------------------------------------------------------------------------------------
        topic3 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic3.text = @"Revolution";
        topic3.fontColor = [UIColor blackColor];
        topic3.fontSize = 40;
        topic3.position = CGPointMake(50, 225);
        topic3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic3.name = @"Revolution";
// ----------------------------------------------------------------------------------------------

        topic4 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic4.text = @"Early Republic";
        topic4.fontColor = [UIColor blackColor];
        topic4.fontSize =40;
        topic4.position = CGPointMake(50, 150);
        topic4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic4.name = @"Early Republic";
// ----------------------------------------------------------------------------------------------
        topic5 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic5.text = @"Good Feelings";
        topic5.fontColor = [UIColor blackColor];
        topic5.fontSize = 40;
        topic5.position = CGPointMake(50, 75);
        topic5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic5.name = @"Good Feelings";
// ----------------------------------------------------------------------------------------------
        topic6 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic6.text = @"Jacksonian";
        topic6.fontColor = [UIColor blackColor];
        topic6.fontSize = 40;
        topic6.position = CGPointMake(50, 0);
        topic6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic6.name = @"Jacksonian";
// ----------------------------------------------------------------------------------------------
        topic7 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic7.text = @"Manifest Destiny";
        topic7.fontColor = [UIColor blackColor];
        topic7.fontSize = 40;
        topic7.position = CGPointMake(50, -75);
        topic7.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic7.name = @"Manifest Destiny";
        
// ----------------------------------------------------------------------------------------------
        topic8 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic8.text = @"Antebellum";
        topic8.fontColor = [UIColor blackColor];
        topic8.fontSize = 40;
        topic8.position = CGPointMake(50, -150);
        topic8.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic8.name = @"Antebellum";
// ----------------------------------------------------------------------------------------------
        topic9 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic9.text = @"Civil War";
        topic9.fontColor = [UIColor blackColor];
        topic9.fontSize = 40;
        topic9.position = CGPointMake(50, -225);
        topic9.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic9.name = @"Civil War";
// ----------------------------------------------------------------------------------------------
        topic10 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic10.text = @"Reconstruction";
        topic10.fontColor = [UIColor blackColor];
        topic10.fontSize = 40;
        topic10.position = CGPointMake(50, -300);
        topic10.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic10.name = @"Reconstruction";

// ----------------------------------------------------------------------------------------------
        topic11 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic11.text = @"Gilded Age";
        topic11.fontColor = [UIColor blackColor];
        topic11.fontSize = 40;
        topic11.position = CGPointMake(50, -375);
        topic11.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic11.name = @"Gilded Age";

// ----------------------------------------------------------------------------------------------
        topic12 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic12.text = @"Progressive";
        topic12.fontColor = [UIColor blackColor];
        topic12.fontSize = 40;
        topic12.position = CGPointMake(50, -450);
        topic12.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic12.name = @"Progressive";
// ----------------------------------------------------------------------------------------------
        topic13 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic13.text = @"Imperialism";
        topic13.fontColor = [UIColor blackColor];
        topic13.fontSize = 40;
        topic13.position = CGPointMake(360, 250);
        topic13.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic13.name = @"Imperialism";
        
// ----------------------------------------------------------------------------------------------
        topic14 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic14.text = @"World War I";
        topic14.fontColor = [UIColor blackColor];
        topic14.fontSize = 40;
        topic14.position = CGPointMake(360, 175);
        topic14.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic14.name = @"World War I";
        
// ----------------------------------------------------------------------------------------------
        
        topic15 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic15.text = @"Roaring 20's";
        topic15.fontColor = [UIColor blackColor];
        topic15.fontSize = 40;
        topic15.position = CGPointMake(360, 100);
        topic15.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic15.name = @"Roaring 20's";
        
// ----------------------------------------------------------------------------------------------
        
        topic16 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic16.text = @"Depression";
        topic16.fontColor = [UIColor blackColor];
        topic16.fontSize = 40;
        topic16.position = CGPointMake(360, 25);
        topic16.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic16.name = @"Depression";
        
        
// ----------------------------------------------------------------------------------------------
        
        
        topic17 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic17.text = @"World War II";
        topic17.fontColor = [UIColor blackColor];
        topic17.fontSize = 40;
        topic17.position = CGPointMake(360, -50);
        topic17.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic17.name = @"World War II";
        

        
// ----------------------------------------------------------------------------------------------
       
        topic18 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic18.text = @"Cold War";
        topic18.fontColor = [UIColor blackColor];
        topic18.fontSize = 40;
        topic18.position = CGPointMake(360, -125);
        topic18.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic18.name = @"Cold War";
        
        
// ----------------------------------------------------------------------------------------------
       
        topic19 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic19.text = @"Civil Rights";
        topic19.fontColor = [UIColor blackColor];
        topic19.fontSize = 40;
        topic19.position = CGPointMake(360, -200);
        topic19.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic19.name = @"Civil Rights";
        
        
// ----------------------------------------------------------------------------------------------
       
        topic20 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic20.text = @"60's and 70's";
        topic20.fontColor = [UIColor blackColor];
        topic20.fontSize = 40;
        topic20.position = CGPointMake(360, -275);
        topic20.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic20.name = @"60's and 70's";
        
        
// ----------------------------------------------------------------------------------------------
       
        topic21 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic21.text = @"Reagan Era";
        topic21.fontColor = [UIColor blackColor];
        topic21.fontSize = 40;
        topic21.position = CGPointMake(360, -350);
        topic21.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic21.name = @"Reagan Era";
        
// ----------------------------------------------------------------------------------------------
       
        topic22 = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        topic22.text = @"Modern Era";
        topic22.fontColor = [UIColor blackColor];
        topic22.fontSize = 40;
        topic22.position = CGPointMake(360, -425);
        topic22.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic22.name = @"Modern Era";
        

        
        [self addChild:titleLabel];
        [self addChild:topic2];
        [self addChild:topic3];
        [self addChild:topic4];
        [self addChild:topic5];
        [self addChild:topic6];
        [self addChild:topic7];
        [self addChild:topic8];
        [self addChild:topic9];
        [self addChild:topic10];
        [self addChild:topic11];
        [self addChild:topic12];
        [self addChild:topic13];
        [self addChild:topic14];
        [self addChild:topic15];
        [self addChild:topic16];
        [self addChild:topic17];
        [self addChild:topic18];
        [self addChild:topic19];
        [self addChild:topic20];
        [self addChild:topic21];
        [self addChild:topic22];
        
        
        topicSpriteLabels = [[NSMutableArray alloc]init];
        [topicSpriteLabels addObject:topic2];
        [topicSpriteLabels addObject:topic3];
        [topicSpriteLabels addObject:topic4];
        [topicSpriteLabels addObject:topic5];
        [topicSpriteLabels addObject:topic6];
        [topicSpriteLabels addObject:topic7];
        [topicSpriteLabels addObject:topic8];
        [topicSpriteLabels addObject:topic9];
        [topicSpriteLabels addObject:topic10];
        [topicSpriteLabels addObject:topic11];
        [topicSpriteLabels addObject:topic12];
        [topicSpriteLabels addObject:topic13];
        [topicSpriteLabels addObject:topic14];
        [topicSpriteLabels addObject:topic15];
        [topicSpriteLabels addObject:topic16];
        [topicSpriteLabels addObject:topic17];
        [topicSpriteLabels addObject:topic18];
        [topicSpriteLabels addObject:topic19];
        [topicSpriteLabels addObject:topic20];
        [topicSpriteLabels addObject:topic21];
        [topicSpriteLabels addObject:topic22];
       
    }
    return self;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    SKAction *zoomSelected = [SKAction scaleTo:1.5 duration:0.1];
    
    if (CGRectContainsPoint(startArrow.frame, location)) {
        NSString *topicSelected = startArrow.name;
        [_delegate selectedTopic:topicSelected];
        [self removeFromParent];
        [self.parent removeFromParent];
        
    }
    
    if (CGRectContainsPoint(topic2.frame, location)) {
        
        [topic2 runAction:zoomSelected];
        [self minimizeTopics:topic2.name];
        
            
    } else if (CGRectContainsPoint(topic3.frame, location)) {

        [topic3 runAction:zoomSelected];
        [self minimizeTopics:topic3.name];
            
    } else if (CGRectContainsPoint(topic4.frame, location)) {
            
        [topic4 runAction:zoomSelected];
        [self minimizeTopics:topic4.name];
            
            
    } else if (CGRectContainsPoint(topic5.frame, location)) {
        
        [topic5 runAction:zoomSelected];
        [self minimizeTopics:topic5.name];

        
    } else if (CGRectContainsPoint(topic6.frame, location)) {
        
        [topic6 runAction:zoomSelected];
        [self minimizeTopics:topic6.name];
        
        
    } else if (CGRectContainsPoint(topic7.frame, location)) {
        
        [topic7 runAction:zoomSelected];
        [self minimizeTopics:topic7.name];
        
        
    } else if (CGRectContainsPoint(topic8.frame, location)) {
        
        [topic8 runAction:zoomSelected];
        [self minimizeTopics:topic8.name];
        
        
    } else if (CGRectContainsPoint(topic9.frame, location)) {
        
        [topic9 runAction:zoomSelected];
        [self minimizeTopics:topic9.name];
        
        
    } else if (CGRectContainsPoint(topic10.frame, location)) {
        
        [topic10 runAction:zoomSelected];
        [self minimizeTopics:topic10.name];
        
        
    } else if (CGRectContainsPoint(topic11.frame, location)) {
        
        [topic11 runAction:zoomSelected];
        [self minimizeTopics:topic11.name];
        
    } else if (CGRectContainsPoint(topic12.frame, location)) {
        
        [topic12 runAction:zoomSelected];
        [self minimizeTopics:topic12.name];
        
    }else if (CGRectContainsPoint(topic13.frame, location)) {
        
        [topic13 runAction:zoomSelected];
        [self minimizeTopics:topic13.name];
        
    }else if (CGRectContainsPoint(topic14.frame, location)) {
        
        [topic14 runAction:zoomSelected];
        [self minimizeTopics:topic14.name];
        
    }else if (CGRectContainsPoint(topic15.frame, location)) {
        
        [topic15 runAction:zoomSelected];
        [self minimizeTopics:topic15.name];
        
    }else if (CGRectContainsPoint(topic16.frame, location)) {
        
        [topic16 runAction:zoomSelected];
        [self minimizeTopics:topic16.name];
        
    }else if (CGRectContainsPoint(topic17.frame, location)) {
        
        [topic17 runAction:zoomSelected];
        [self minimizeTopics:topic17.name];
        
    }else if (CGRectContainsPoint(topic18.frame, location)) {
        
        [topic18 runAction:zoomSelected];
        [self minimizeTopics:topic18.name];
        
    }else if (CGRectContainsPoint(topic19.frame, location)) {
        
        [topic19 runAction:zoomSelected];
        [self minimizeTopics:topic19.name];
        
    }else if (CGRectContainsPoint(topic20.frame, location)) {
        
        [topic20 runAction:zoomSelected];
        [self minimizeTopics:topic20.name];
    }else if (CGRectContainsPoint(topic21.frame, location)) {
        
        [topic21 runAction:zoomSelected];
        [self minimizeTopics:topic21.name];
    }else if (CGRectContainsPoint(topic22.frame, location)) {
        
        [topic21 runAction:zoomSelected];
        [self minimizeTopics:topic22.name];
    }
}

-(void) minimizeTopics:(NSString *)spriteName {
    
    SKAction *scaleSmaller = [SKAction scaleTo:0.7 duration:0.1];
    
    for(SKSpriteNode *otherTopics in topicSpriteLabels) {
        
        if([spriteName isEqualToString:otherTopics.name]) {
            
            [startArrow removeFromParent];
            startArrow = [SKSpriteNode spriteNodeWithImageNamed:@"next-button-200x206.png"];
            startArrow.scale = 0.7;
            
            if(otherTopics.position.x > 200) {
                startArrow.position = CGPointMake(otherTopics.position.x+10, otherTopics.position.y);
            } else {
                startArrow.position = CGPointMake(otherTopics.position.x+70, otherTopics.position.y);
            }
            
            startArrow.name = otherTopics.name;
            [self addChild:startArrow];
            
        } else {
            [otherTopics runAction:scaleSmaller];
            //[otherTopics runAction:selectAnimate];
            
            
        }
    }
}

@end
