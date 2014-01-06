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
        scoreLabel.position = CGPointMake(400,830);
        scoreLabel.text = @"Test Summary";
        scoreLabel.name = @"scoreLabel";
        scoreLabel.fontColor = [UIColor blackColor];
        scoreLabel.fontSize = 60;
        [self addChild:scoreLabel];
        
        SKSpriteNode *difficultyWindow = [SKSpriteNode spriteNodeWithImageNamed:@"label-title-550x180.png"];
        difficultyWindow.position = CGPointMake(350,800);
        //[self addChild:difficultyWindow];
        
        SKLabelNode *difficultyLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        difficultyLabel.position = CGPointMake(300,740);
        difficultyLabel.text = @"Total Score";
        difficultyLabel.name = @"difficultyLabel";
        difficultyLabel.fontColor = [UIColor blackColor];
        difficultyLabel.fontSize = 40;
        [self addChild:difficultyLabel];
        
        SKSpriteNode *categoryWindow = [SKSpriteNode spriteNodeWithImageNamed:@"label-title-550x180.png"];
        categoryWindow.position = CGPointMake(350,600);
        //[self addChild:categoryWindow];
        
        SKLabelNode *categoryLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        categoryLabel.position = CGPointMake(300,610);
        categoryLabel.text = @"Correct / Total";
        categoryLabel.name = @"categoryLabel";
        categoryLabel.fontColor = [UIColor blackColor];
        categoryLabel.fontSize = 40;
        [self addChild:categoryLabel];
        
        SKLabelNode *categoryTime = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        categoryTime.position = CGPointMake(300, 500);
        categoryTime.text = @"Total Time";
        categoryTime.name = @"timeLabel";
        categoryTime.fontColor = [UIColor blackColor];
        categoryTime.fontSize = 40;
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
    totalScoreLabel.position = CGPointMake(300, 670);
    int iTotalScore = [totalScore intValue];
    //NSString *totalScoreStr = [NSString stringWithFormat:@"%i",iTotalScore];
    totalScoreLabel.text = [NSString stringWithFormat:@"%i",iTotalScore];
    totalScoreLabel.fontColor = [UIColor greenColor];
    totalScoreLabel.fontSize = 60;
    [self addChild:totalScoreLabel];
    
    SKLabelNode *correctAndIncorrect = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    correctAndIncorrect.position = CGPointMake(300, 560);
    correctAndIncorrect.text = [NSString stringWithFormat:@"%i out of %i (%i)",[correctAnswers integerValue],[totalQuestions intValue],[percent intValue]];
    correctAndIncorrect.fontSize = 32;
    correctAndIncorrect.fontColor = [UIColor redColor];
    [self addChild:correctAndIncorrect];
    
    int totalTimeSS = [totalTestTime intValue];
    int totalTimeMM = totalTimeSS/60;
    int totalTimeSSmod = totalTimeSS % 60;
    int totalQtemp = [totalQuestions intValue];
    int avgTimePerQ = totalTimeSS / totalQtemp;
    
    SKLabelNode *totalTime = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
    totalTime.position = CGPointMake(300, 470);
    totalTime.text = [NSString stringWithFormat:@"%i mins %i sec ",totalTimeMM, totalTimeSSmod];
    totalTime.fontSize = 32;
    totalTime.fontColor = [UIColor redColor];
    [self addChild:totalTime];
    
    SKLabelNode *averageTimeToAnswer = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
    averageTimeToAnswer.position = CGPointMake(300,420);
    averageTimeToAnswer.text = [NSString stringWithFormat:@"Average: %i",avgTimePerQ];
    averageTimeToAnswer.fontSize = 32;
    averageTimeToAnswer.fontColor = [UIColor redColor];
    [self addChild:averageTimeToAnswer];
    
}



-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    [self removeFromParent];
    
}

@end
