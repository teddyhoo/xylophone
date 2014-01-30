//
//  ExplanationViewer.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/24/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ExplanationViewer.h"

@implementation ExplanationViewer

-(void)setSize:(CGSize)size {

    self.userInteractionEnabled = YES;
    
    _layerSize = size;
    
    SKSpriteNode *backgroundLight = [SKSpriteNode spriteNodeWithImageNamed:@"light_1"];
    backgroundLight.position = CGPointMake(400, 500);
    [self addChild:backgroundLight];
    
    SKSpriteNode *scoreWindow = [SKSpriteNode spriteNodeWithImageNamed:@"explanation.png"];
    scoreWindow.position = CGPointMake(350, 500);
    [self addChild:scoreWindow];
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Oranienbaum"];
    scoreLabel.position = CGPointMake(400, 700);
    scoreLabel.text = @"Explanation";
    scoreLabel.name = @"scoreLabel";
    scoreLabel.fontColor = [UIColor redColor];
    scoreLabel.fontSize = 60;
    [self addChild:scoreLabel];
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    [self removeFromParent];
    
}

@end
