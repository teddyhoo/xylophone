//
//  WorldHistoryMainMenu.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/8/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "WorldHistoryMainMenu.h"
#import "Matching.h"
#import "Quizzer.h"

@implementation WorldHistoryMainMenu

NSMutableArray *optionsForMenu;
CGSize *introScreenSize;

- (id)initWithSize:(CGSize)size
{
    
    introScreenSize = &size;
    
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];

        SKSpriteNode *cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"constitution-bg-2.jpg"];
        cloud1.position = CGPointMake(500,500);
        [self addChild:cloud1];
        
        SKSpriteNode *cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
        cloud2.position = CGPointMake(200, 800);
        //[self addChild:cloud2];

       
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        titleLabel.text = @"AP U.S. History";
        titleLabel.fontColor = [UIColor redColor];
        titleLabel.fontSize = 60;
        titleLabel.position = CGPointMake(size.width/2, 750);
        titleLabel.name = @"title";
        [titleLabel setUserInteractionEnabled:YES];
        
        [self addChild:titleLabel];
        
        SKLabelNode *quizExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        quizExercisesLabel.text = @"Quiz Exercises";
        quizExercisesLabel.fontColor = [UIColor orangeColor];
        quizExercisesLabel.fontSize = 50;
        quizExercisesLabel.position = CGPointMake(size.width/2, 650);
        quizExercisesLabel.name = @"quiz";
        [self addChild:quizExercisesLabel];

        SKLabelNode *matchingExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        matchingExercisesLabel.text = @"Matching Exercises";
        matchingExercisesLabel.fontColor = [UIColor orangeColor];
        matchingExercisesLabel.fontSize = 50;
        matchingExercisesLabel.position = CGPointMake(size.width/2, 550);
        matchingExercisesLabel.name = @"match";
        
        [self addChild:matchingExercisesLabel];
        
        
        SKLabelNode *essayExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        essayExercisesLabel.text = @"Essay Exercises";
        essayExercisesLabel.fontColor = [UIColor orangeColor];
        essayExercisesLabel.fontSize = 50;
        essayExercisesLabel.position = CGPointMake(size.width/2, 450);
        essayExercisesLabel.name = @"essay";
        
        [self addChild:essayExercisesLabel];
        
        SKLabelNode *tableExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        tableExercisesLabel.text = @"Data Tables";
        tableExercisesLabel.fontColor = [UIColor orangeColor];
        tableExercisesLabel.fontSize = 50;
        tableExercisesLabel.position = CGPointMake(size.width/2, 350);
        tableExercisesLabel.name = @"table";
        
        [self addChild:tableExercisesLabel];
        
        SKLabelNode *timelineExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        timelineExercisesLabel.text = @"Timelines";
        timelineExercisesLabel.fontColor = [UIColor orangeColor];
        timelineExercisesLabel.fontSize = 50;
        timelineExercisesLabel.position = CGPointMake(size.width/2, 250);
        timelineExercisesLabel.name = @"timeline";
        
        [self addChild:timelineExercisesLabel];
        
        SKLabelNode *moreQuestionsLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        moreQuestionsLabel.text = @"Get More Questions";
        moreQuestionsLabel.fontColor = [UIColor orangeColor];
        moreQuestionsLabel.fontSize = 50;
        moreQuestionsLabel.position = CGPointMake(size.width/2, 150);
        moreQuestionsLabel.name = @"moreQ";
        
        [self addChild:moreQuestionsLabel];
        
        
        optionsForMenu = [[NSMutableArray alloc]init];
        [optionsForMenu addObject:titleLabel];
        [optionsForMenu addObject:quizExercisesLabel];
        [optionsForMenu addObject:matchingExercisesLabel];
        [optionsForMenu addObject:essayExercisesLabel];
        [optionsForMenu addObject:tableExercisesLabel];
        [optionsForMenu addObject:timelineExercisesLabel];
        [optionsForMenu addObject:moreQuestionsLabel];
        
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    for (SKLabelNode* myMenuPick in optionsForMenu) {
        
        if (CGRectContainsPoint(myMenuPick.frame, location)) {
        
            if ([myMenuPick.name isEqualToString:@"match"]) {
                
                [self gotoSectionMatching];
                
                
            } else if ([myMenuPick.name isEqualToString:@"quiz"]) {
                
                [self gotoSectionQuiz];
                
            } else if ([myMenuPick.name isEqualToString:@"table"]) {
                
                [self gotoSectionTable];
                
                
            } else if ([myMenuPick.name isEqualToString:@"essay"]) {
                
                [self gotoSectionEssay];
                
            } else if ([myMenuPick.name isEqualToString:@"timeline"]) {
                
                [self gotoSectionTimeline];
                
            } else if ([myMenuPick.name isEqualToString:@"moreQ"]) {
                
                [self gotoSectionMoreQuestions];
                
                
            }
        
            
        }
        
    }
}

-(void)gotoSectionMatching {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.9];
    Matching *matchScene = [Matching sceneWithSize:self.view.bounds.size];
    //matchScene.scaleMode = SKSceneScaleModeAspectFill;
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}

-(void)gotoSectionQuiz {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.9];
    Quizzer *matchScene = [[Quizzer alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}

-(void)gotoSectionEssay {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.9];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}


-(void)gotoSectionTable {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.9];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}


-(void)gotoSectionTimeline {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.9];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}


-(void)gotoSectionMoreQuestions {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.9];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}

@end
