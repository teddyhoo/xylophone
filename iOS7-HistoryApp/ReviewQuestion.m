//
//  ReviewQuestion.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ReviewQuestion.h"

@implementation ReviewQuestion


-(id)init {
    
    self = [super init];
    
    if(self) {
        SKSpriteNode *scoreWindow = [SKSpriteNode spriteNodeWithImageNamed:@"review-bg.png"];
        scoreWindow.position = CGPointMake(400, 510);
        //[self addChild:scoreWindow];
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        scoreLabel.position = CGPointMake(200,830);
        scoreLabel.text = @"Test Summary";
        scoreLabel.name = @"scoreLabel";
        scoreLabel.fontColor = [UIColor blackColor];
        scoreLabel.fontSize = 60;
        [self addChild:scoreLabel];
        
        SKSpriteNode *difficultyWindow = [SKSpriteNode spriteNodeWithImageNamed:@"explanation.png"];
        difficultyWindow.position = CGPointMake(350,800);
        //[self addChild:difficultyWindow];
        
        SKLabelNode *difficultyLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        difficultyLabel.position = CGPointMake(100,740);
        difficultyLabel.text = @"Total Score";
        difficultyLabel.name = @"difficultyLabel";
        difficultyLabel.fontColor = [UIColor blackColor];
        difficultyLabel.fontSize = 40;
        difficultyLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        [self addChild:difficultyLabel];
        
        SKSpriteNode *categoryWindow = [SKSpriteNode spriteNodeWithImageNamed:@"label-title-550x180.png"];
        categoryWindow.position = CGPointMake(350,600);
        //[self addChild:categoryWindow];
        
        SKLabelNode *categoryLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        categoryLabel.position = CGPointMake(100,610);
        categoryLabel.text = @"Correct / Total";
        categoryLabel.name = @"categoryLabel";
        categoryLabel.fontColor = [UIColor blackColor];
        categoryLabel.fontSize = 40;
        categoryLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        [self addChild:categoryLabel];
        
        SKLabelNode *categoryTime = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        categoryTime.position = CGPointMake(100, 500);
        categoryTime.text = @"Total Time";
        categoryTime.name = @"timeLabel";
        categoryTime.fontColor = [UIColor blackColor];
        categoryTime.fontSize = 40;
        categoryTime.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        [self addChild:categoryTime];

    }
    return self;
    
}

-(void)updateScoreWindow:(NSNumber*)totalScore
                  totalQ:(NSNumber*)totalQuestions
              percentage:(NSNumber*)percent
                 totTime:(NSNumber*)totalTestTime
              correctAns:(NSNumber*)correctAnswers

{
    
    
    SKLabelNode *totalScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    totalScoreLabel.position = CGPointMake(650, 740);
    int iTotalScore = [totalScore intValue];
    //NSString *totalScoreStr = [NSString stringWithFormat:@"%i",iTotalScore];
    totalScoreLabel.text = [NSString stringWithFormat:@"%i",iTotalScore];
    totalScoreLabel.fontColor = [UIColor greenColor];
    totalScoreLabel.fontSize = 32;
    totalScoreLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:totalScoreLabel];
    
    SKLabelNode *correctAndIncorrect = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    correctAndIncorrect.position = CGPointMake(650, 610);
    correctAndIncorrect.text = [NSString stringWithFormat:@"%i / %i (%i)",[correctAnswers integerValue],[totalQuestions intValue],[percent intValue]];
    correctAndIncorrect.fontSize = 32;
    correctAndIncorrect.fontColor = [UIColor redColor];
    correctAndIncorrect.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:correctAndIncorrect];
    
    int totalTimeSS = [totalTestTime intValue];
    int totalTimeMM = totalTimeSS/60;
    int totalTimeSSmod = totalTimeSS % 60;
    int totalQtemp = [totalQuestions intValue];
    int avgTimePerQ = totalTimeSS / totalQtemp;
    
    SKLabelNode *totalTime = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
    totalTime.position = CGPointMake(650, 500);
    totalTime.text = [NSString stringWithFormat:@"%i m %i s ",totalTimeMM, totalTimeSSmod];
    totalTime.fontSize = 32;
    totalTime.fontColor = [UIColor redColor];
    totalTime.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:totalTime];
    
    SKLabelNode *averageTimeToAnswer = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
    averageTimeToAnswer.position = CGPointMake(650,460);
    averageTimeToAnswer.text = [NSString stringWithFormat:@"Avg: %i",avgTimePerQ];
    averageTimeToAnswer.fontSize = 32;
    averageTimeToAnswer.fontColor = [UIColor redColor];
    averageTimeToAnswer.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
    [self addChild:averageTimeToAnswer];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    [self removeFromParent];
    
}

@end
