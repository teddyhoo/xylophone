//
//  Quizzer-Tracker.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/20/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "QuizzerTracker.h"

SKLabelNode *scoreActual;
SKSpriteNode *difficultyWindow;
SKLabelNode *difficultyLabel;
SKSpriteNode *categoryWindow;
SKLabelNode *categoryLabel;
SKSpriteNode *scoreWindow;
SKLabelNode *scoreLabel;
SKLabelNode *actualDifficulty;
SKLabelNode *actualSection;
SKLabelNode *theLetterQForQuestion;

NSMutableArray *scorePartsLabel;
NSMutableArray *scorePartsSprite;
NSMutableArray *difficultyButtons;

@implementation QuizzerTracker

-(void)setSize:(CGSize)size {
    
    _layerSize = size;

    scorePartsLabel = [[NSMutableArray alloc]init];
    scorePartsSprite = [[NSMutableArray alloc]init];
    difficultyButtons = [[NSMutableArray alloc]init];

    categoryWindow = [SKSpriteNode spriteNodeWithImageNamed:@"category-banner.png"];
    categoryWindow.position = CGPointMake(size.width/2-20, 930);
    [self addChild:categoryWindow];
    
    theLetterQForQuestion = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
    theLetterQForQuestion.position = CGPointMake(50,955);
    theLetterQForQuestion.text = @"Q:";
    theLetterQForQuestion.fontColor = [UIColor blueColor];
    theLetterQForQuestion.fontSize = 56;
    [self addChild:theLetterQForQuestion];
    

    
    actualSection = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualSection.text = @"   ";
    actualSection.fontSize = 20;
    actualSection.fontColor = [UIColor redColor];
    actualSection.position = CGPointMake(400, 790);
    [self addChild:actualSection];
    
    
}


-(void)updateScore:(NSNumber *)numericalCalculatedScore {
    
    int score = [numericalCalculatedScore intValue];
    NSString *scoreWithFactor = [NSString stringWithFormat:@"%i", score];
    
    NSMutableArray *characters = [[NSMutableArray alloc]initWithCapacity:[scoreWithFactor length]];
    for(int i = 0; i < [scoreWithFactor length]; i++) {
        NSString *ichar = [NSString stringWithFormat:@"%c", [scoreWithFactor characterAtIndex:i]];
        [characters addObject:ichar];
        
    }
    
    if (score > 99 && score < 999) {
        NSString *appendDigit = [NSString stringWithFormat:@"0"];
        NSString *appendDigit2 = [NSString stringWithFormat:@"0"];
        [characters insertObject:appendDigit atIndex:0];
        [characters insertObject:appendDigit2 atIndex:0];
        
    } else if (score > 999 && score < 10000) {
        NSString *appendDigit = [NSString stringWithFormat:@"0"];
        [characters insertObject:appendDigit atIndex:0];
    }
    
    int xPos = 0;

    for (NSString *scorePart in characters) {
        
        SKSpriteNode *scoreComponent;
        
        if ([scorePart isEqualToString:@"0"]) {
            
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-0-icon"];

        } else if ([scorePart isEqualToString:@"1"]) {
            
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-1-icon"];

        } else if ([scorePart isEqualToString:@"2"]) {
            
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-2-icon"];

        } else if ([scorePart isEqualToString:@"3"]) {
            
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-3-icon"];

        } else if ([scorePart isEqualToString:@"4"]) {
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-4-icon"];

        } else if ([scorePart isEqualToString:@"5"]) {
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-5-icon"];

        } else if ([scorePart isEqualToString:@"6"]) {
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-6-icon"];

        } else if ([scorePart isEqualToString:@"7"]) {
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-7-icon"];

        } else if ([scorePart isEqualToString:@"8"]) {
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-8-icon"];

        } else if ([scorePart isEqualToString:@"9"]) {
            scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"Number-9-icon"];

        }
        
        scoreComponent.position = CGPointMake(180+xPos,50);
        scoreComponent.scale = 0.5;
        [self addChild:scoreComponent];

        xPos += 70;
        
        [scorePartsSprite addObject:scoreComponent];
        
    }
}

-(void)updateOtherInfo:(NSString*)difficulty topicSection:(NSString *)section {
    
    [actualDifficulty removeFromParent];
    [actualSection removeFromParent];
    
    for (SKSpriteNode *difficultyButtonRemove in difficultyButtons) {
        [difficultyButtonRemove removeFromParent];
    }
    
    int difficultyNumber = [difficulty intValue];
    int xPosDiff = 600;
    
    SKLabelNode *difficultyBack = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    difficultyBack.position = CGPointMake(530, 970);
    difficultyBack.fontColor = [UIColor blueColor];
    difficultyBack.fontSize = 24;
    difficultyBack.text = @"Difficulty: ";
    [self addChild:difficultyBack];
    
    for (int i = 0; i < difficultyNumber; i++) {
        SKSpriteNode *difficultyButton = [SKSpriteNode spriteNodeWithImageNamed:@"difficulty-level-circle"];
        difficultyButton.scale = 0.3;
        difficultyButton.position = CGPointMake(xPosDiff, 980);
        [self addChild:difficultyButton];
        xPosDiff += 15;
        [difficultyButtons addObject:difficultyButton];
    }
    
    actualSection = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualSection.text = section;
    actualSection.fontSize = 24;
    actualSection.fontColor = [UIColor blueColor];
    actualSection.position = CGPointMake(200, 970);
    //actualSection.position = CGPointMake(_layerSize.width/2, 140);
    [self addChild:actualSection];
    
}
-(void)moveOffScreen {
    
    /*SKAction *moveOff = [SKAction moveToY:1200 duration:1.0];
    [difficultyLabel runAction:moveOff];
    [difficultyWindow runAction:moveOff];
    [categoryLabel runAction:moveOff];
    [categoryWindow runAction:moveOff];*/
}

-(void)moveBackOnScreen {
    /*SKAction *moveOn = [SKAction moveToY:900 duration:1.0];
    [difficultyLabel runAction:moveOn];
    [difficultyWindow runAction:moveOn];
    [categoryLabel runAction:moveOn];
    [categoryWindow runAction:moveOn];*/
    
}


@end
