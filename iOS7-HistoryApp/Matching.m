//
//  Matching.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/11/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//


#import "Matching.h"
#import "MySpriteNode.h"

@implementation Matching

SKSpriteNode *letterA;
SKSpriteNode *letterB;
SKSpriteNode *backToMainMenuArrow;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        self.backgroundColor = [SKColor colorWithRed:0.15 green:0.15 blue:0.3 alpha:1.0];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Matching Exercises";
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame)+100,
                                       CGRectGetMidY(self.frame)+200);
        
        
        MySpriteNode *testSprite = [MySpriteNode spriteNodeWithImageNamed:@"Arrow-blue-longest.png"];
        testSprite.position = CGPointMake(400, 400);
        [self addChild:testSprite];
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        [self addChild:myLabel];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
