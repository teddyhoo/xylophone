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

@implementation QuizzerTracker

-(void)setSize:(CGSize)size {
    
    _layerSize = size;

    scoreWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
    scoreWindow.position = CGPointMake(100, 980);
    [self addChild:scoreWindow];
    
    scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    scoreLabel.position = CGPointMake(80,995);
    scoreLabel.text = @"Score";
    scoreLabel.name = @"scoreLabel";
    scoreLabel.fontColor = [UIColor blackColor];
    scoreLabel.fontSize = 20;
    [self addChild:scoreLabel];
    
    difficultyWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
    difficultyWindow.position = CGPointMake(260, 980);
    [self addChild:difficultyWindow];
    
    difficultyLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    difficultyLabel.position = CGPointMake(240, 995);
    difficultyLabel.text = @"Difficulty";
    difficultyLabel.name = @"difficultyLabel";
    difficultyLabel.fontColor = [UIColor blackColor];
    difficultyLabel.fontSize = 20;
    [self addChild:difficultyLabel];
    
    categoryWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
    categoryWindow.position = CGPointMake(420, 980);
    [self addChild:categoryWindow];
    
    categoryLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    categoryLabel.position = CGPointMake(400, 995);
    categoryLabel.text = @"Category";
    categoryLabel.name = @"categoryLabel";
    categoryLabel.fontColor = [UIColor blackColor];
    categoryLabel.fontSize = 20;
    [self addChild:categoryLabel];
    
    actualDifficulty = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualDifficulty.text = @"   ";
    actualDifficulty.fontSize = 20;
    actualDifficulty.fontColor = [UIColor redColor];
    actualDifficulty.position = CGPointMake(240, 965);
    [self addChild:actualDifficulty];
    
    actualSection = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualSection.text = @"   ";
    actualSection.fontSize = 20;
    actualSection.fontColor = [UIColor redColor];
    actualSection.position = CGPointMake(420, 965);
    [self addChild:actualSection];
    
    
}


-(void)updateScore:(NSNumber *)numericalCalculatedScore {
    
    [scoreActual removeFromParent];
    int score = [numericalCalculatedScore intValue];
    NSString *scoreWithFactor = [NSString stringWithFormat:@"%i", score];
    scoreActual = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    scoreActual.text = scoreWithFactor;
    scoreActual.fontColor = [UIColor redColor];
    scoreActual.position = CGPointMake(90, 960);
    [self addChild:scoreActual];
}

-(void)updateOtherInfo:(NSString*)difficulty topicSection:(NSString *)section {
    
    [actualDifficulty removeFromParent];
    [actualSection removeFromParent];
    
    actualDifficulty = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualDifficulty.text = difficulty;
    actualDifficulty.fontSize = 20;
    actualDifficulty.fontColor = [UIColor redColor];
    actualDifficulty.position = CGPointMake(240, 965);
    [self addChild:actualDifficulty];
    
    actualSection = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    actualSection.text = section;
    actualSection.fontSize = 20;
    actualSection.fontColor = [UIColor redColor];
    actualSection.position = CGPointMake(420, 965);
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
