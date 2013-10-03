//
//  Parallax.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/19/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>
#import "Parallax.h"



// BENParallaxNode.m
//#import "BENParallaxNode.h"

@interface Parallax ()
{
    NSMutableArray *backgrounds;
}
@end

@implementation Parallax
- (instancetype)initWithBackground:(NSString *)file size:(CGSize)size
{
    // we add the file 3 times to avoid image flickering
    return [self initWithBackgrounds:@[@"parallax-bg-1.png", @"parallax-bg-2.png", @"parallax-bg-1.png"] size:size];
}

- (instancetype)initWithBackgrounds:(NSArray *)files size:(CGSize)size
{
    if (self = [super init])
    {
        backgrounds = [NSMutableArray arrayWithCapacity:[files count]];
        [files enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            SKSpriteNode *node = [SKSpriteNode node];
            node.texture = [SKTexture textureWithImageNamed:obj];
            node.size = size;
            node.anchorPoint = CGPointZero;
            node.position = CGPointMake(size.width * idx, 0);
            [self addChild:node];
            
            [backgrounds addObject:node];
        }];
    }
    return self;
}

- (void)update:(NSTimeInterval)currentTime
{
    [backgrounds enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        SKSpriteNode *bg = obj;
        CGPoint position = bg.position;
        position.x -= self.parallaxSpeed;
        if (position.x + bg.size.width < 0)
        {
            [backgrounds removeObjectAtIndex:idx];
            
            SKSpriteNode *lastNode = [backgrounds lastObject];
            position.x = lastNode.position.x + lastNode.size.width - self.parallaxSpeed;
            [backgrounds addObject:obj];
        }
        bg.position = position;
    }];
}

@end
