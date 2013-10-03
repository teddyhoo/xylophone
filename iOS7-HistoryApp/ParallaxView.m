//
//  ParallaxView.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/19/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ParallaxView.h"

@implementation ParallaxView

static const float BG_POINTS_PER_SECT = 50;
NSTimeInterval _dt;
NSTimeInterval _lastUpdateTime;



-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size])
    {
        /*background1 = [SKSpriteNode node];
        background1.texture = [SKTexture textureWithImageNamed:@"myBackgroundImage.png"];
        background1.size = size;
        background1.position = CGPointZero;
        background1.anchorPoint = CGPointZero;
        background1.name = @"bg1";
        [self addChild:background1];
        
        background2 = [SKSpriteNode node];
        background2.texture = [SKTexture textureWithImageNamed:@"myBackgroundImage.png"];
        background2.size = size;
        background2.position = CGPointMake(size.width, 0);
        background2.anchorPoint = CGPointZero;
        background2.name = @"bg2";
        [self addChild:background2];*/
        
        for (int i = 0; i < 2; i++) {
            
            SKSpriteNode *background1 = [SKSpriteNode spriteNodeWithImageNamed:@"myBackgroundImage.png"];
            background1.anchorPoint = CGPointZero;
            background1.position = CGPointMake(i * background1.size.width, 0);
            background1.name = @"bg";
            [self addChild:background1];
        }
    }
    return self;
}

-(void) moveBg {
    
    /*CGPoint bgVelocity = CGPointMake(-BG_POINTS_PER_SECT, 0);
    CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity, _dt);
    background1.position = CGPointAdd(background1.position, amtToMove);
    
    [self enumerateChildNodesWithName:@"bg" usingBlock:^(SKNode *node, BOOL *stop) {
        SKSpriteNode *bg1 = (SKSpriteNode *)node;

    
        
    }];
    
    if (background1.position.x <= -background1.size.width) {
        background1.position = CGPointMake(background1.position.x+background1.size.width*2,background1.position.y);
    }*/
}

- (void)update:(NSTimeInterval)currentTime
{

}

@end
