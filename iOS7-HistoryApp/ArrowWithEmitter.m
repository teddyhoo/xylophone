//
//  ArrowWithEmitter.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/10/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ArrowWithEmitter.h"

@implementation ArrowWithEmitter
@synthesize directionArrow;

NSString *openEmitterEffect;
NSString *openEmitterEffectMore;
SKEmitterNode *openEffect;

NSMutableArray *texturesForAnim;
SKSpriteNode *firstImageAnimate;
BOOL fireEmitterFired = FALSE;

//-(instancetype)init {
    
    //if (self = [super initWithImageNamed:@"arrow-left-yellow.png"]) {
    
    //if(self = [super init]) {
    
    //self = [SKSpriteNode initWithImageNamed:@"arrow-left-yellow.png"];
    
    //[self setupAnimationEffects];
    //}
    //if (self) {
        
       // self = [super initWithImageNamed:@"arrow-left-yellow.png"];
        
    //}
    
    
    //return self;
    
//}


-(instancetype)initWithDirection:(NSString *)direction {
    

        
        if ([direction isEqualToString:@"down"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-down.png"]) {
                
                directionArrow = @"down";
            }
            [self setupAnimationEffectsForArrowDown];
            
        } else if ([direction isEqualToString:@"up"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-up.png"]) {
                
                directionArrow = @"up";
                
            }
            [self setupAnimationEffectsForArrowUp];
            
        } else if ([direction isEqualToString:@"left"]) {
            
            if(self = [super initWithImageNamed:@"arrow2.png"]) {
                
                directionArrow = @"left";
            }
            [self setupAnimationEffectsForArrowLeft];
            
        } else if ([direction isEqualToString:@"right"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-right.png"]) {
                
                directionArrow = @"right";
            }
            [self setupAnimationEffectsForArrowRight];
            
        } else if ([direction isEqualToString:@"down-left"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-down-left.png"]) {
                
                directionArrow = @"down-left";
            }
            [self setupAnimationEffectsForArrowDownLeft];
            
        } else if ([direction isEqualToString:@"down-right"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-down-right.png"]) {
                
                directionArrow = @"down-right";
            }
            [self setupAnimationEffectsForArrowDownRight];
            
        } else if ([direction isEqualToString:@"up-right"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-up-right.png"]) {
                directionArrow = @"up-right";
            }
            [self setupAnimationEffectsForArrowUpRight];
            
        } else if ([direction isEqualToString:@"up-left"]) {
            
            if(self = [super initWithImageNamed:@"arrow2-up-left.png"]) {
                directionArrow = @"up-left";
            }
            [self setupAnimationEffectsForArrowUpLeft];
            
        }
    
    return self;
    
}

-(void)fireEmitter {
    
 if (!fireEmitterFired) {
    
    fireEmitterFired = TRUE;
     
    if([directionArrow isEqualToString:@"down"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartUpDown" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(46,90);
        openEffect.name = @"emitter";
        
    } else if ([directionArrow isEqualToString:@"up"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartUpDown" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(46,0);
        openEffect.name = @"emitter";
    } else if ([directionArrow isEqualToString:@"left"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartRightLeft" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(90,42);
        openEffect.name = @"emitter";
    } else if ([directionArrow isEqualToString:@"right"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartRightLeft" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(0,42);
    } else if ([directionArrow isEqualToString:@"down-left"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartArrow" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(90,82);
    } else if ([directionArrow isEqualToString:@"down-right"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartArrow" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(0,82);
    } else if ([directionArrow isEqualToString:@"up-right"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartArrow" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(0,0);
    } else if ([directionArrow isEqualToString:@"up-left"]) {
        openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SparkPartArrow" ofType:@"sks"];
        openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(90,0);
    }
     
    [self addChild:openEffect];
     
  }
    
    
}

-(void)setupAnimationEffectsForArrowLeft {  // LEFT
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowDown { // DOWN
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-down"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-down"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-down"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-down"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-down"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowUp{ // UP
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-up"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-up"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-up"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-up"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-up"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowRight { // RIGHT
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-right"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-right"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-right"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-right"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-right"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowDownLeft { // DOWN
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-down-left"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-down-left"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-down-left"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-down-left"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-down-left"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowDownRight { // Down Right
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-down-right"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-down-right"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-down-right"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-down-right"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-down-right"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowUpLeft { // Up Left
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-up-left"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-up-left"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-up-left"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-up-left"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-up-left"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
    texturesForAnim = animFrames;
    
    SKTexture *beginFrame= texturesForAnim[0];
    firstImageAnimate = [SKSpriteNode spriteNodeWithTexture:beginFrame];
    //firstImageAnimate.position = CGPointMake(500, 400);
    [self addChild:firstImageAnimate];
    [self runAnimation];
    
}

-(void)setupAnimationEffectsForArrowUpRight { // DOWN
    NSMutableArray *animFrames = [NSMutableArray array];
    SKTextureAtlas *imageAnimationAtlas = [SKTextureAtlas atlasNamed:@"MoveArrow"];
    SKTexture *temp = [imageAnimationAtlas textureNamed:@"arrow1-up-right"];
    SKTexture *temp2 = [imageAnimationAtlas textureNamed:@"arrow2-up-right"];
    SKTexture *temp3 = [imageAnimationAtlas textureNamed:@"arrow3-up-right"];
    SKTexture *temp4 = [imageAnimationAtlas textureNamed:@"arrow4-up-right"];
    SKTexture *temp5 = [imageAnimationAtlas textureNamed:@"arrow5-up-right"];
    [animFrames addObject:temp];
    [animFrames addObject:temp2];
    [animFrames addObject:temp3];
    [animFrames addObject:temp4];
    [animFrames addObject:temp5];
    
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
                                                   timePerFrame:0.1
                                                         resize:NO
                                                        restore:YES]]withKey:@"walkInPlace"];
    
    return;
    
}




-(void)setDirection:(NSString *)direction {
    
    
}


@end
