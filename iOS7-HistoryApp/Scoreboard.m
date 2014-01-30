//
//  Scoreboard.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/9/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "Scoreboard.h"

@implementation Scoreboard

@synthesize numberCorrect, numberWrong, totalQuestions, totalScoreDisplay,topicCategory,topicTimePeriod;

-(instancetype)init {

    if (self = [super init]) {
        
    _layerSize = CGSizeMake(1024, 650);
        
    SKLabelNode *totalQuestionLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    SKLabelNode *totalCorrectLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    SKLabelNode *totalIncorrectLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    SKLabelNode *totalScoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    SKLabelNode *topicCategoryLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    SKLabelNode *degreeOfDifficulty = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        
    totalQuestionLabel.position = CGPointMake(50, 50);
    totalQuestionLabel.text = @"Questions";
    totalQuestionLabel.fontColor = [UIColor blueColor];
    totalQuestionLabel.fontSize = 16;
    [self addChild:totalQuestionLabel];
        
        
    totalCorrectLabel.position = CGPointMake(150, 50);
    totalCorrectLabel.text = @"Correct";
    totalCorrectLabel.fontColor = [UIColor blueColor];
    totalCorrectLabel.fontSize = 16;
    //[self addChild:totalCorrectLabel];
    
    totalIncorrectLabel.position = CGPointMake(250, 50);
    totalIncorrectLabel.text = @"Incorrect";
    totalIncorrectLabel.fontColor = [UIColor blueColor];
    totalIncorrectLabel.fontSize = 16;
    //[self addChild:totalIncorrectLabel];
    
    totalScoreLabel.position = CGPointMake(50,35);
    totalScoreLabel.text = @"Total Score";
    totalScoreLabel.fontColor = [UIColor blueColor];
    totalScoreLabel.fontSize = 16;
    [self addChild:totalScoreLabel];
    
    topicCategoryLabel.position = CGPointMake(50,20);
    topicCategoryLabel.text = @"Category";
    topicCategoryLabel.fontColor = [UIColor blueColor];
    topicCategoryLabel.fontSize = 16;
    [self addChild:topicCategoryLabel];
    
    degreeOfDifficulty.position = CGPointMake(550,50);
    degreeOfDifficulty.text = @"Difficulty";
    degreeOfDifficulty.fontColor = [UIColor blueColor];
    degreeOfDifficulty.fontSize = 16;
    //[self addChild:degreeOfDifficulty];
    
    }
    return self;
    
    
}


-(void)createNewScoreboard {
    
    
}

-(void)updateScoreboard {

    
}

-(void)updateScoreElement:(NSString *)elementValue type:(NSNumber *)elementType {
    
    
}

-(void)removeScoreboard {
    
    [self removeAllChildren];
}


@end
