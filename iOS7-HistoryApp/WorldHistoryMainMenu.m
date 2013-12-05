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

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];

        SKSpriteNode *cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud.png"];
        cloud1.position = CGPointMake(600, 800);
        //[self addChild:cloud1];
        
        SKSpriteNode *cloud2 = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
        cloud2.position = CGPointMake(200, 800);
        [self addChild:cloud2];

        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"MyParticle" ofType:@"sks"];
        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(700, 600);
        openEffect.targetNode = self.scene;
        
        [self addChild:openEffect];
       
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        titleLabel.text = @"A P World History Study Prep";
        titleLabel.fontColor = [UIColor redColor];
        titleLabel.fontSize = 20;
        titleLabel.position = CGPointMake(50, 900);
        titleLabel.name = @"title";
        [titleLabel setUserInteractionEnabled:YES];
        
        [self addChild:titleLabel];
        
        SKLabelNode *quizExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        quizExercisesLabel.text = @"Quiz Exercises";
        quizExercisesLabel.fontColor = [UIColor orangeColor];
        quizExercisesLabel.fontSize = 20;
        quizExercisesLabel.position = CGPointMake(150, 650);
        quizExercisesLabel.name = @"quiz";
        [self addChild:quizExercisesLabel];

        SKLabelNode *matchingExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        matchingExercisesLabel.text = @"Matching Exercises";
        matchingExercisesLabel.fontColor = [UIColor orangeColor];
        matchingExercisesLabel.fontSize = 20;
        matchingExercisesLabel.position = CGPointMake(150, 600);
        matchingExercisesLabel.name = @"match";
        
        [self addChild:matchingExercisesLabel];
        
        
        SKLabelNode *essayExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        essayExercisesLabel.text = @"Essay Exercises";
        essayExercisesLabel.fontColor = [UIColor orangeColor];
        essayExercisesLabel.fontSize = 20;
        essayExercisesLabel.position = CGPointMake(150, 550);
        essayExercisesLabel.name = @"essay";
        
        [self addChild:essayExercisesLabel];
        
        SKLabelNode *tableExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        tableExercisesLabel.text = @"Data Tables";
        tableExercisesLabel.fontColor = [UIColor orangeColor];
        tableExercisesLabel.fontSize = 20;
        tableExercisesLabel.position = CGPointMake(150, 500);
        tableExercisesLabel.name = @"table";
        
        [self addChild:tableExercisesLabel];
        
        SKLabelNode *timelineExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        timelineExercisesLabel.text = @"Timelines";
        timelineExercisesLabel.fontColor = [UIColor orangeColor];
        timelineExercisesLabel.fontSize = 20;
        timelineExercisesLabel.position = CGPointMake(150, 450);
        timelineExercisesLabel.name = @"timeline";
        
        [self addChild:timelineExercisesLabel];
        
        SKLabelNode *moreQuestionsLabel = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        moreQuestionsLabel.text = @"Get More Questions";
        moreQuestionsLabel.fontColor = [UIColor orangeColor];
        moreQuestionsLabel.fontSize = 20;
        moreQuestionsLabel.position = CGPointMake(150, 400);
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
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
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
