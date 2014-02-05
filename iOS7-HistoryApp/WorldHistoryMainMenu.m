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
#import "ContentInAppPurchase.h"

@implementation WorldHistoryMainMenu

NSMutableArray *optionsForMenu;
CGSize *introScreenSize;

- (id)initWithSize:(CGSize)size
{
    
    introScreenSize = &size;
    
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:1.0 green:0.9 blue:0.8 alpha:1.0];

        SKSpriteNode *cloud1 = [SKSpriteNode spriteNodeWithImageNamed:@"american-history-bg.png"];
        cloud1.position = CGPointMake(400,500);
        //cloud1.yScale = 1.3;
        cloud1.alpha = 0.1;
        [self addChild:cloud1];
        
        SKSpriteNode *image1 = [SKSpriteNode spriteNodeWithImageNamed:@"drummer-colored-infantry.png"];
        SKSpriteNode *image2 = [SKSpriteNode spriteNodeWithImageNamed:@"frederick-douglas.png"];
        SKSpriteNode *image3 = [SKSpriteNode spriteNodeWithImageNamed:@"great-depression-iconic.png"];
        SKSpriteNode *image4 = [SKSpriteNode spriteNodeWithImageNamed:@"kennedy-portrait.png"];
         SKSpriteNode *image5 = [SKSpriteNode spriteNodeWithImageNamed:@"uncle-sam-i-want-you.png"];
        
        image1.position = CGPointMake(1000, 200);
        image2.position = CGPointMake(1000, 380);
        image3.position = CGPointMake(1000, 560);
        [image3 runAction:[SKAction rotateByAngle:24.8 duration:0.1]];
        image4.position = CGPointMake(1000, 740);
        [image4 runAction:[SKAction rotateByAngle:19.4 duration:0.1]];
        image5.position = CGPointMake(1000, 930);
        SKAction *moveToBG = [SKAction moveByX:-900 y:0 duration:1.0];
        
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        titleLabel.text = @"AP U.S. History";
        titleLabel.fontColor = [UIColor blackColor];
        titleLabel.fontSize = 80;
        titleLabel.position = CGPointMake(size.width/1.6, 900);
        titleLabel.name = @"title";
        [titleLabel setUserInteractionEnabled:YES];
        
        [self addChild:titleLabel];
        
        SKLabelNode *quizExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        quizExercisesLabel.text = @"QUIZ";
        quizExercisesLabel.fontColor = [UIColor blackColor];
        quizExercisesLabel.fontSize = 72;
        quizExercisesLabel.position = CGPointMake(size.width/1.2, 750);
        quizExercisesLabel.name = @"quiz";
        quizExercisesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        [self addChild:quizExercisesLabel];

        SKLabelNode *matchingExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        matchingExercisesLabel.text = @"MATCH";
        matchingExercisesLabel.fontColor = [UIColor blackColor];
        matchingExercisesLabel.fontSize = 72;
        matchingExercisesLabel.position = CGPointMake(size.width/1.2, 625);
        matchingExercisesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        matchingExercisesLabel.name = @"match";
        
        [self addChild:matchingExercisesLabel];

        SKLabelNode *essayExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        essayExercisesLabel.text = @"ESSAY";
        essayExercisesLabel.fontColor = [UIColor blackColor];
        essayExercisesLabel.fontSize = 72;
        essayExercisesLabel.position = CGPointMake(size.width/1.2, 500);
        essayExercisesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        essayExercisesLabel.name = @"essay";
        
        [self addChild:essayExercisesLabel];
        
        SKLabelNode *tableExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        tableExercisesLabel.text = @"DOCUMENTS";
        tableExercisesLabel.fontColor = [UIColor blackColor];
        tableExercisesLabel.fontSize = 72;
        tableExercisesLabel.position = CGPointMake(size.width/1.2, 375);
        tableExercisesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        tableExercisesLabel.name = @"table";
        
        [self addChild:tableExercisesLabel];
        
        SKLabelNode *timelineExercisesLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        timelineExercisesLabel.text = @"TIMELINE";
        timelineExercisesLabel.fontColor = [UIColor blackColor];
        timelineExercisesLabel.fontSize = 72;
        timelineExercisesLabel.position = CGPointMake(size.width/1.2, 250);
        timelineExercisesLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        timelineExercisesLabel.name = @"timeline";
        
        [self addChild:timelineExercisesLabel];
        
        SKLabelNode *moreQuestionsLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
        moreQuestionsLabel.text = @"PURCHASE";
        moreQuestionsLabel.fontColor = [UIColor blackColor];
        moreQuestionsLabel.fontSize = 72;
        moreQuestionsLabel.position = CGPointMake(size.width/1.2, 125);
        moreQuestionsLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
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

        [self addChild:image1];
        [self addChild:image2];
        [self addChild:image3];
        [self addChild:image4];
        [self addChild:image5];
        
        image1.alpha = 0.1;
        image2.alpha = 0.5;
        image3.alpha = 0.5;
        image4.alpha = 0.3;
        image5.alpha = 0.9;
        
        [image1 runAction:moveToBG];
        [image2 runAction:moveToBG];
        [image3 runAction:moveToBG];
        [image4 runAction:moveToBG];
        [image5 runAction:moveToBG];
        
        
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
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.1];
    Matching *matchScene = [Matching sceneWithSize:self.view.bounds.size];
    matchScene.scaleMode = SKSceneScaleModeResizeFill;
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}

-(void)gotoSectionQuiz {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.1];
    Quizzer *matchScene = [[Quizzer alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}

-(void)gotoSectionEssay {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.1];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    matchScene.scaleMode = SKSceneScaleModeResizeFill;
    
    
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}


-(void)gotoSectionTable {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.1];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}


-(void)gotoSectionTimeline {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.1];
    Matching *matchScene = [[Matching alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:matchScene transition:transitionToMatch];
    
}


-(void)gotoSectionMoreQuestions {
    
    SKTransition *transitionToMatch = [SKTransition doorsOpenVerticalWithDuration:0.1];
    ContentInAppPurchase *inAppPurchase = [[ContentInAppPurchase alloc]initWithSize:CGSizeMake(768, 1024)];
    [self.view presentScene:inAppPurchase transition:transitionToMatch];
    
}

@end
