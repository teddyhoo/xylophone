//
//  MySpriteNode.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/8/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "MySpriteNode.h"

@implementation MySpriteNode : SKSpriteNode

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    for (UITouch *touch in touches) {
        
        CGPoint location = [touch locationInNode:self];
        
        // Instantiate the new subclass MySpriteNode, not SKSpriteNode as before
        MySpriteNode *sprite = [MySpriteNode spriteNodeWithImageNamed:@"Spaceship"];
        
        sprite.position = location;
        
        // Remember this, else it won't work.
        
        sprite.userInteractionEnabled = YES;
        
        
        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
        
        [sprite runAction:[SKAction repeatActionForever:action]];
        
        [self addChild:sprite];
    }
}


@end
