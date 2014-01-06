//
//  ContentInAppPurchase.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/28/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ContentInAppPurchase.h"
#import <SpriteKit/SpriteKit.h>

@implementation ContentInAppPurchase

@synthesize productOne, productTwo, productThree, productFour, productFive, productOneLabel, productTwoLabel, productThreeLabel, productFourLabel, productFiveLabel;


- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        SKSpriteNode *scoreWindow = [SKSpriteNode spriteNodeWithImageNamed:@"review-bg.png"];
        scoreWindow.position = CGPointMake(400, 510);
        [self addChild:scoreWindow];
        
        SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        scoreLabel.position = CGPointMake(400, 930);
        scoreLabel.text = @"Get More Content";
        scoreLabel.name = @"scoreLabel";
        scoreLabel.fontColor = [UIColor blackColor];
        scoreLabel.fontSize = 60;
        [self addChild:scoreLabel];
        
        productOne = [SKSpriteNode spriteNodeWithImageNamed:@"textfield-with-dollar.png"];
        productOne.position = CGPointMake(180,800);
        productOne.scale = 0.4;
        [self addChild:productOne];
        
        productOneLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        productOneLabel.position = CGPointMake(150,780);
        productOneLabel.text = @"2.99";
        productOneLabel.name = @"difficultyLabel";
        productOneLabel.fontColor = [UIColor redColor];
        productOneLabel.fontSize = 32;
        [self addChild:productOneLabel];
        
        productTwo = [SKSpriteNode spriteNodeWithImageNamed:@"textfield-with-dollar.png"];
        productTwo.position = CGPointMake(180,600);
        productTwo.scale = 0.4;
        [self addChild:productTwo];
        
        productTwoLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        productTwoLabel.position = CGPointMake(150,580);
        productTwoLabel.text = @"2.99";
        productTwoLabel.name = @"categoryLabel";
        productTwoLabel.fontColor = [UIColor redColor];
        productTwoLabel.fontSize = 32;
        [self addChild:productTwoLabel];


        productThree = [SKSpriteNode spriteNodeWithImageNamed:@"textfield-with-dollar.png"];
        productThree .position = CGPointMake(180,400);
        productThree .scale = 0.4;
        [self addChild:productThree];
        
        productThreeLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        productThreeLabel.position = CGPointMake(150,380);
        productThreeLabel.text = @"2.99";
        productThreeLabel.name = @"categoryLabel";
        productThreeLabel.fontColor = [UIColor redColor];
        productThreeLabel.fontSize = 32;
        [self addChild:productThreeLabel];
        
    }
    return self;
    
}

@end
