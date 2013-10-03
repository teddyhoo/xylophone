//
//  TopicPicker.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/12/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "TopicPicker.h"

@implementation TopicPicker

@synthesize topic1, topic2, topic3, topic4, topic5, topic6, topic7, topic8, topic9, topic10, topic11, topic12, topic13, topic14, topic15, topic16, topic17, topic18, topic19, topic20, topic21, topic22;

SKSpriteNode *startArrow;
NSMutableArray *topicSpriteLabels;

-(void) setDelegate:(id)delegate {
    
    _delegate = delegate;
    
}

- (id)init
{
    self = [super init];
    if (self) {
                
        SKLabelNode *titleLabel = [SKLabelNode labelNodeWithFontNamed:@"Muncie"];
        titleLabel.text = @"Pick a Topic";
        titleLabel.fontColor = [UIColor blackColor];
        titleLabel.fontSize = 40;
        titleLabel.position = CGPointMake(10, 350);
        titleLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        titleLabel.name = @"title";

        
        topic2 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic2.text = @"Colonial";
        topic2.fontColor = [UIColor redColor];
        topic2.fontSize = 30;
        topic2.position = CGPointMake(0, 300);
        topic2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic2.name = @"Colonial";

        
        topic3 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic3.text = @"Revolution";
        topic3.fontColor = [UIColor redColor];
        topic3.fontSize = 30;
        topic3.position = CGPointMake(0, 225);
        topic3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic3.name = @"Revolution";
        
        topic4 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic4.text = @"Early Republic";
        topic4.fontColor = [UIColor redColor];
        topic4.fontSize = 30;
        topic4.position = CGPointMake(0, 150);
        topic4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic4.name = @"Early Republic";
        
        topic5 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic5.text = @"Era of Good Feelings";
        topic5.fontColor = [UIColor redColor];
        topic5.fontSize = 30;
        topic5.position = CGPointMake(0, 75);
        topic5.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic5.name = @"Era of Good Feelings";
        
        topic6 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic6.text = @"Jacksonian Era";
        topic6.fontColor = [UIColor redColor];
        topic6.fontSize = 30;
        topic6.position = CGPointMake(0, 0);
        topic6.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic6.name = @"Jacksonian";
        
        topic7 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic7.text = @"Westward Expansion";
        topic7.fontColor = [UIColor redColor];
        topic7.fontSize = 30;
        topic7.position = CGPointMake(0, -75);
        topic7.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic7.name = @"Westward Expansion";
        
        topic8 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic8.text = @"Antebellum";
        topic8.fontColor = [UIColor redColor];
        topic8.fontSize = 30;
        topic8.position = CGPointMake(0, -150);
        topic8.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic8.name = @"Antebellum";
        
        topic9 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic9.text = @"Civil War";
        topic9.fontColor = [UIColor redColor];
        topic9.fontSize = 30;
        topic9.position = CGPointMake(0, -225);
        topic9.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic9.name = @"Civil War";
        
        topic10 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic10.text = @"Reconstruction";
        topic10.fontColor = [UIColor redColor];
        topic10.fontSize = 30;
        topic10.position = CGPointMake(0, -300);
        topic10.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic10.name = @"Reconstruction";
        
        topic11 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic11.text = @"Gilded Age";
        topic11.fontColor = [UIColor redColor];
        topic11.fontSize = 30;
        topic11.position = CGPointMake(0, -375);
        topic11.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeRight;
        topic11.name = @"Gilded Age";
        
        topic12 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic12.text = @"Progressive";
        topic12.fontColor = [UIColor redColor];
        topic12.fontSize = 30;
        topic12.position = CGPointMake(300, 300);
        topic12.name = @"Progressive";
        
        topic13 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic13.text = @"Imperialism";
        topic13.fontColor = [UIColor redColor];
        topic13.fontSize = 30;
        topic13.position = CGPointMake(300, 225);
        topic13.name = @"Imperialism";
        
        topic14 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic14.text = @"World War I";
        topic14.fontColor = [UIColor redColor];
        topic14.fontSize = 30;
        topic14.position = CGPointMake(300, 150);
        topic14.name = @"World War I";
        
        topic15 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic15.text = @"Roaring 20's";
        topic15.fontColor = [UIColor redColor];
        topic15.fontSize = 30;
        topic15.position = CGPointMake(300, 75);
        topic15.name = @"Roaring 20's";
        
        topic16 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic16.text = @"Depression";
        topic16.fontColor = [UIColor redColor];
        topic16.fontSize = 30;
        topic16.position = CGPointMake(300, 0);
        topic16.name = @"Depression";
        
        
        topic17 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic17.text = @"World War II";
        topic17.fontColor = [UIColor redColor];
        topic17.fontSize = 30;
        topic17.position = CGPointMake(300, -75);
        topic17.name = @"World War II";
        
        topic18 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic18.text = @"Cold War";
        topic18.fontColor = [UIColor redColor];
        topic18.fontSize = 30;
        topic18.position = CGPointMake(300, -150);
        topic18.name = @"Cold War";
        
        topic19 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic19.text = @"Civil Rights";
        topic19.fontColor = [UIColor redColor];
        topic19.fontSize = 30;
        topic19.position = CGPointMake(300, -225);
        topic19.name = @"Civil Rights";
        
        topic20 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic20.text = @"60's and 70's";
        topic20.fontColor = [UIColor redColor];
        topic20.fontSize = 30;
        topic20.position = CGPointMake(300, -300);
        topic20.name = @"60's and 70's";
        
        topic21 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic21.text = @"Reagan Era";
        topic21.fontColor = [UIColor redColor];
        topic21.fontSize = 30;
        topic21.position = CGPointMake(300, -375);
        topic21.name = @"Reagan Era";
        
        topic22 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        topic22.text = @"Modern Era";
        topic22.fontColor = [UIColor redColor];
        topic22.fontSize = 30;
        topic22.position = CGPointMake(300, -450);
        topic22.name = @"Modern Era";
        

        
        [self addChild:titleLabel];
        [self addChild:topic2];
        [self addChild:topic3];
        [self addChild:topic4];
        [self addChild:topic5];
        [self addChild:topic6];
        [self addChild:topic7];
        [self addChild:topic8];
        [self addChild:topic9];
        [self addChild:topic10];
        [self addChild:topic11];
        [self addChild:topic12];
        [self addChild:topic13];
        [self addChild:topic14];
        [self addChild:topic15];
        [self addChild:topic16];
        [self addChild:topic17];
        [self addChild:topic18];
        [self addChild:topic19];
        [self addChild:topic20];
        [self addChild:topic21];
        [self addChild:topic22];
        
        
        topicSpriteLabels = [[NSMutableArray alloc]init];
        [topicSpriteLabels addObject:topic2];
        [topicSpriteLabels addObject:topic3];
        [topicSpriteLabels addObject:topic4];
        [topicSpriteLabels addObject:topic5];
        [topicSpriteLabels addObject:topic6];
        [topicSpriteLabels addObject:topic7];
        [topicSpriteLabels addObject:topic8];
        [topicSpriteLabels addObject:topic9];
        [topicSpriteLabels addObject:topic10];
        [topicSpriteLabels addObject:topic11];
        [topicSpriteLabels addObject:topic12];
        [topicSpriteLabels addObject:topic13];
        [topicSpriteLabels addObject:topic14];
        [topicSpriteLabels addObject:topic15];
        [topicSpriteLabels addObject:topic16];
        [topicSpriteLabels addObject:topic17];
        [topicSpriteLabels addObject:topic18];
        [topicSpriteLabels addObject:topic19];
        [topicSpriteLabels addObject:topic20];
        [topicSpriteLabels addObject:topic21];
        [topicSpriteLabels addObject:topic22];
       
    }
    return self;
    
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    CGPoint buttonLocation = topic2.position;
    

    SKAction *selectAnimate = [SKAction colorizeWithColor:[UIColor orangeColor] colorBlendFactor:0.9 duration:0.1];
    SKAction *zoomSelected = [SKAction scaleTo:2.0 duration:0.3];
    SKAction *sequenceActions = [SKAction sequence:@[selectAnimate,zoomSelected]];
    
    if (CGRectContainsPoint(startArrow.frame, location)) {
        NSString *topicSelected = startArrow.name;
        [_delegate selectedTopic:topicSelected];
        [self removeFromParent];
        
        [self.parent removeFromParent];
        
    }
    
    
    if (CGRectContainsPoint(topic2.frame, location)) {
        
        [topic2 runAction:zoomSelected];
        [self minimizeTopics:topic2.name];
        
            
    } else if (CGRectContainsPoint(topic3.frame, location)) {
            
        [topic3 runAction:zoomSelected];
        [self minimizeTopics:topic3.name];
            
    } else if (CGRectContainsPoint(topic4.frame, location)) {
            
        [topic4 runAction:zoomSelected];
        [self minimizeTopics:topic4.name];
            
            
    } else if (CGRectContainsPoint(topic5.frame, location)) {
        
        SKAction *selectAnimate = [SKAction colorizeWithColor:[UIColor blueColor] colorBlendFactor:0.9 duration:0.5];
        [topic5 runAction:zoomSelected];
        [self minimizeTopics:topic5.name];

        
    } else if (CGRectContainsPoint(topic6.frame, location)) {
        
        [topic6 runAction:zoomSelected];
        [self minimizeTopics:topic6.name];
        
        
    } else if (CGRectContainsPoint(topic7.frame, location)) {
        
        [topic7 runAction:zoomSelected];
        [self minimizeTopics:topic7.name];
        
        
    } else if (CGRectContainsPoint(topic8.frame, location)) {
        
        [topic8 runAction:zoomSelected];
        [self minimizeTopics:topic8.name];
        
        
    } else if (CGRectContainsPoint(topic9.frame, location)) {
        
        [topic9 runAction:zoomSelected];
        [self minimizeTopics:topic9.name];
        
        
    } else if (CGRectContainsPoint(topic10.frame, location)) {
        
        [topic10 runAction:zoomSelected];
        [self minimizeTopics:topic10.name];
        
        
    } else if (CGRectContainsPoint(topic11.frame, location)) {
        
        [topic11 runAction:zoomSelected];
        [self minimizeTopics:topic11.name];
        
    } else if (CGRectContainsPoint(topic12.frame, location)) {
        
        [topic12 runAction:zoomSelected];
        [self minimizeTopics:topic12.name];
        
    }else if (CGRectContainsPoint(topic13.frame, location)) {
        
        [topic13 runAction:zoomSelected];
        [self minimizeTopics:topic13.name];
        
    }else if (CGRectContainsPoint(topic14.frame, location)) {
        
        [topic14 runAction:zoomSelected];
        [self minimizeTopics:topic14.name];
        
    }else if (CGRectContainsPoint(topic15.frame, location)) {
        
        [topic15 runAction:zoomSelected];
        [self minimizeTopics:topic15.name];
        
    }else if (CGRectContainsPoint(topic16.frame, location)) {
        
        [topic16 runAction:zoomSelected];
        [self minimizeTopics:topic16.name];
        
    }else if (CGRectContainsPoint(topic17.frame, location)) {
        
        [topic17 runAction:zoomSelected];
        [self minimizeTopics:topic17.name];
        
    }else if (CGRectContainsPoint(topic18.frame, location)) {
        
        [topic18 runAction:zoomSelected];
        [self minimizeTopics:topic18.name];
        
    }else if (CGRectContainsPoint(topic19.frame, location)) {
        
        [topic19 runAction:zoomSelected];
        [self minimizeTopics:topic19.name];
        
    }else if (CGRectContainsPoint(topic20.frame, location)) {
        
        [topic20 runAction:zoomSelected];
        [self minimizeTopics:topic20.name];
    }else if (CGRectContainsPoint(topic21.frame, location)) {
        
        [topic21 runAction:zoomSelected];
        [self minimizeTopics:topic21.name];
    }else if (CGRectContainsPoint(topic22.frame, location)) {
        
        [topic21 runAction:zoomSelected];
        [self minimizeTopics:topic22.name];
    }
}

-(void) minimizeTopics:(NSString *)spriteName {
    
    SKAction *scaleSmaller = [SKAction scaleTo:0.7 duration:0.2];
    SKAction *selectAnimate = [SKAction colorizeWithColor:[UIColor orangeColor] colorBlendFactor:0.9 duration:0.1];
    
    for(SKSpriteNode *otherTopics in topicSpriteLabels) {
        
        if([spriteName isEqualToString:otherTopics.name]) {
            
            [startArrow removeFromParent];
            
            startArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-right.png"];
            if(otherTopics.position.x > 200) {
                startArrow.position = CGPointMake(otherTopics.position.x-200, otherTopics.position.y);
            } else {
                startArrow.position = CGPointMake(otherTopics.position.x+200, otherTopics.position.y);
            }
            
            startArrow.name = otherTopics.name;
            
            [self addChild:startArrow];
            
        } else {
            [otherTopics runAction:scaleSmaller];
            //[otherTopics runAction:selectAnimate];
            
            
        }
    }
}

@end
