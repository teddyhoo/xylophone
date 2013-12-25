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
        SKSpriteNode *scoreWindow = [SKSpriteNode spriteNodeWithImageNamed:@"review-table.png"];
        scoreWindow.position = CGPointMake(350, 500);
        [self addChild:scoreWindow];
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        scoreLabel.position = CGPointMake(280, 650);
        scoreLabel.text = @"Test Summary";
        scoreLabel.name = @"scoreLabel";
        scoreLabel.fontColor = [UIColor blackColor];
        scoreLabel.fontSize = 40;
        [self addChild:scoreLabel];
        
        SKSpriteNode *difficultyWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
        difficultyWindow.position = CGPointMake(250,600);
        [self addChild:difficultyWindow];
        
        SKLabelNode *difficultyLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        difficultyLabel.position = CGPointMake(250,610);
        difficultyLabel.text = @"Total Score";
        difficultyLabel.name = @"difficultyLabel";
        difficultyLabel.fontColor = [UIColor blackColor];
        difficultyLabel.fontSize = 20;
        [self addChild:difficultyLabel];
        
        SKSpriteNode *categoryWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
        categoryWindow.position = CGPointMake(250,450);
        [self addChild:categoryWindow];
        
        SKLabelNode *categoryLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        categoryLabel.position = CGPointMake(250,460);
        categoryLabel.text = @"Total Correct";
        categoryLabel.name = @"categoryLabel";
        categoryLabel.fontColor = [UIColor blackColor];
        categoryLabel.fontSize = 20;
        [self addChild:categoryLabel];
    }
    return self;
    
}
-(void)setSize:(CGSize)size {
    
    _layerSize = size;
    
    SKSpriteNode *scoreWindow = [SKSpriteNode spriteNodeWithImageNamed:@"review-table.png"];
    scoreWindow.position = CGPointMake(350, 500);
    [self addChild:scoreWindow];
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    scoreLabel.position = CGPointMake(80, 790);
    scoreLabel.text = @"Test Summary";
    scoreLabel.name = @"scoreLabel";
    scoreLabel.fontColor = [UIColor blackColor];
    scoreLabel.fontSize = 20;
    [self addChild:scoreLabel];
    
    SKSpriteNode *difficultyWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
    difficultyWindow.position = CGPointMake(100, 920);
    [self addChild:difficultyWindow];
    
    SKLabelNode *difficultyLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    difficultyLabel.position = CGPointMake(80, 930);
    difficultyLabel.text = @"Difficulty";
    difficultyLabel.name = @"difficultyLabel";
    difficultyLabel.fontColor = [UIColor blackColor];
    difficultyLabel.fontSize = 20;
    [self addChild:difficultyLabel];
    
    SKSpriteNode *categoryWindow = [SKSpriteNode spriteNodeWithImageNamed:@"score-window.png"];
    categoryWindow.position = CGPointMake(100, 860);
    [self addChild:categoryWindow];
    
    SKLabelNode *categoryLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    categoryLabel.position = CGPointMake(80, 870);
    categoryLabel.text = @"Category";
    categoryLabel.name = @"categoryLabel";
    categoryLabel.fontColor = [UIColor blackColor];
    categoryLabel.fontSize = 20;
    [self addChild:categoryLabel];
    
    
}

@end
