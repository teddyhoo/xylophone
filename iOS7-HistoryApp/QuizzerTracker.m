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
    categoryWindow.position = CGPointMake(420, 120);
    [self addChild:categoryWindow];

    
    actualSection = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualSection.text = @"   ";
    actualSection.fontSize = 20;
    actualSection.fontColor = [UIColor redColor];
    actualSection.position = CGPointMake(420, 965);
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
    
    int xPos = 0;
    
    for (NSString *scorePart in characters) {
        
        SKSpriteNode *scoreComponent = [SKSpriteNode spriteNodeWithImageNamed:@"score-box-blue"];
        SKLabelNode *scoreCompLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        scoreCompLabel.text = scorePart;
        scoreCompLabel.fontSize = 48;
        scoreCompLabel.fontColor = [UIColor redColor];
        scoreCompLabel.position = CGPointMake(300+xPos,35);
        
        scoreComponent.position = CGPointMake(300+xPos,50);
        [self addChild:scoreComponent];
        [self addChild:scoreCompLabel];
        xPos += 70;
        
        [scorePartsSprite addObject:scoreComponent];
        [scorePartsLabel addObject:scorePartsLabel];
        
    }
}

-(void)updateOtherInfo:(NSString*)difficulty topicSection:(NSString *)section {
    
    [actualDifficulty removeFromParent];
    [actualSection removeFromParent];
    
    for (SKSpriteNode *difficultyButtonRemove in difficultyButtons) {
        [difficultyButtonRemove removeFromParent];
    }
    
    int difficultyNumber = [difficulty intValue];
    int xPosDiff = 50;
    for (int i = 0; i < difficultyNumber; i++) {
        SKSpriteNode *difficultyButton = [SKSpriteNode spriteNodeWithImageNamed:@"difficulty-level-circle"];
        difficultyButton.scale = 0.6;
        difficultyButton.position = CGPointMake(xPosDiff, 120);
        [self addChild:difficultyButton];
        xPosDiff += 30;
        [difficultyButtons addObject:difficultyButton];
    }
    
    actualSection = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualSection.text = section;
    actualSection.fontSize = 32;
    actualSection.fontColor = [UIColor blueColor];
    actualSection.position = CGPointMake(420, 100);
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
