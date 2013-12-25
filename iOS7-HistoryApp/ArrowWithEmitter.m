//
//  ArrowWithEmitter.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/10/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ArrowWithEmitter.h"

@implementation ArrowWithEmitter
NSString *openEmitterEffect;
NSString *openEmitterEffectMore;
SKEmitterNode *openEffect;

NSMutableArray *texturesForAnim;
SKSpriteNode *firstImageAnimate;


-(instancetype)init{
    
    if (self = [super initWithImageNamed:@"arrow-left-yellow.png"]) {

        [self setupAnimationEffects];
    }
    return self;
    
}


-(void)setupAnimationEffects {
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"Direction"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)runAnimation {
    [firstImageAnimate runAction:[SKAction repeatActionForever:
                                  [SKAction animateWithTextures:texturesForAnim
                                                   timePerFrame:0.2
                                                         resize:NO
                                                        restore:YES]]withKey:@"walkInPlace"];
    
    return;
    
}


-(void)fireEmitter {
    openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPart" ofType:@"sks"];
    openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
    openEffect.position = CGPointMake(80,-100);
    [self addChild:openEffect];
    //[self addChild:openEffectMore];
    
}



@end
