//
//  Options.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 1/14/14.
//  Copyright (c) 2014 Melanie Taylor. All rights reserved.
//

#import "Options.h"
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>

@implementation Options

SKSpriteNode *optionsBackground;

NSMutableArray *brushOptions;

SKLabelNode *audioOnOff;
SKSpriteNode *toggleOnAudio;
SKSpriteNode *toggleOffAudio;

SKLabelNode *showArrows;
SKSpriteNode *toggleOnArrows;
SKSpriteNode *toggleOffArrows;

SKLabelNode *handHelper;
SKSpriteNode *toggleOnHand;
SKSpriteNode *toggleOffHand;

SKLabelNode *letterSize;
SKSpriteNode *toggleLetterSizeOn;
SKSpriteNode *toggleLetterSizeOff;

SKLabelNode *traceWidth;
SKSpriteNode *toggleTraceWidthOn;
SKSpriteNode *toggelTraceWidthOff;




SKLabelNode *difficultyLevel;

SKLabelNode *fontType;


SKSpriteNode *brushSelect;
SKLabelNode *pickBrush;
SKSpriteNode *brushOne;
SKSpriteNode *brushTwo;
SKSpriteNode *brushThree;
SKSpriteNode *brushFour;

SKSpriteNode *checkMark;
SKSpriteNode *xMark;

SKAction *moveSelect1;
SKAction *moveSelect2;
SKAction *moveSelect3;
SKAction *moveSelect4;
SKAction *sequenceBrushUpdate;

@synthesize showOptions;

-(instancetype)initWithPosition:(CGPoint)position {

    if (self = [super init]) {
        
        showOptions = TRUE;

        self.userInteractionEnabled = YES;
        optionsBackground = [SKSpriteNode spriteNodeWithImageNamed:@"optionsBg"];
        optionsBackground.position = CGPointMake(500, 400);
        [self addChild:optionsBackground];
        //
        //
        //
        //
        //
        //
        
        
        SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        title.text = @"O P T I O N S";
        title.position = CGPointMake(500,600);
        title.fontColor = [UIColor whiteColor];
        title.fontSize = 44;
        [self addChild:title];
        
        audioOnOff = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        audioOnOff.text = @"SOUND";
        audioOnOff.fontColor = [UIColor redColor];
        audioOnOff.position = CGPointMake(280, 520);
        audioOnOff.fontSize = 24;
        [self addChild:audioOnOff];
        
        handHelper = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        handHelper.text = @"HAND";
        handHelper.fontColor = [UIColor redColor];
        handHelper.fontSize = 24;
        handHelper.position = CGPointMake(280, 460);
        [self addChild:handHelper];
        
        showArrows = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        showArrows.text = @"ARROWS";
        showArrows.fontColor = [UIColor redColor];
        showArrows.fontSize = 24;
        showArrows.position = CGPointMake(280, 390);
        [self addChild:showArrows];
        
        
        pickBrush = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        pickBrush.text = @"BRUSH";
        pickBrush.fontColor = [UIColor redColor];
        pickBrush.fontSize = 24;
        pickBrush.position = CGPointMake(280, 320);
        [self addChild:pickBrush];

        letterSize = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        letterSize.text = @"LETTER SIZE";
        letterSize.fontSize = 24;
        letterSize.fontColor = [UIColor redColor];
        letterSize.position = CGPointMake(560, 390);
        [self addChild:letterSize];
        
        
        traceWidth = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        traceWidth.text = @"TRACE WIDTH";
        traceWidth.fontSize = 24;
        traceWidth.fontColor = [UIColor redColor];
        traceWidth.position = CGPointMake(560, 460);
        [self addChild:traceWidth];
        
        
        fontType = [SKLabelNode labelNodeWithFontNamed:@"Trickster"];
        fontType.text = @"FONT TYPE";
        fontType.fontSize = 24;
        fontType.fontColor = [UIColor redColor];
        fontType.position = CGPointMake(560, 520);
        [self addChild:fontType];

        
        brushOne = [SKSpriteNode spriteNodeWithImageNamed:@"flare-red"];
        brushTwo = [SKSpriteNode spriteNodeWithImageNamed:@"light-blue"];
        brushThree = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud3"];
        brushFour = [SKSpriteNode spriteNodeWithImageNamed:@"sunburst"];
        
        
        brushOne.position = CGPointMake(280, 280);
        brushTwo.position = CGPointMake(340, 280);
        brushThree.position = CGPointMake(400, 280);
        brushFour.position = CGPointMake(460, 280);
        brushFour.scale = 0.5;
        
        brushSelect = [SKSpriteNode spriteNodeWithImageNamed:@"button-frame"];
        brushSelect.position = brushThree.position;
        brushSelect.scale = 0.5;
        [self addChild:brushSelect];

        [self addChild:brushOne];
        [self addChild:brushTwo];
        [self addChild:brushThree];
        [self addChild:brushFour];
        
 
        toggleOffAudio = [SKSpriteNode spriteNodeWithImageNamed:@"toggleOff"];
        toggleOffAudio.position = CGPointMake(400, 530);
        [self addChild:toggleOffAudio];
        
        toggleOnAudio = [SKSpriteNode spriteNodeWithImageNamed:@"toggleOn"];
        toggleOnAudio.position = CGPointMake(400, 530);
        [self addChild:toggleOnAudio];
        
        toggleOffHand = [SKSpriteNode spriteNodeWithImageNamed:@"toggleOff"];
        toggleOffHand.position = CGPointMake(400, 470);
        [self addChild:toggleOffHand];
        
        toggleOnHand = [SKSpriteNode spriteNodeWithImageNamed:@"toggleOn"];
        toggleOnHand.position = CGPointMake(400, 470);
        [self addChild:toggleOnHand];
        
        toggleOffArrows = [SKSpriteNode spriteNodeWithImageNamed:@"toggleOff"];
        toggleOffArrows.position = CGPointMake(400, 410);
        [self addChild:toggleOffArrows];
        
        toggleOnArrows = [SKSpriteNode spriteNodeWithImageNamed:@"toggleOn"];
        toggleOnArrows.position = CGPointMake(400, 410);
        [self addChild:toggleOnArrows];
        
        checkMark = [SKSpriteNode spriteNodeWithImageNamed:@"checkmark"];
        checkMark.position = CGPointMake(700, 240);
        [self addChild:checkMark];
        
        xMark = [SKSpriteNode spriteNodeWithImageNamed:@"x-mark"];
        xMark.position = CGPointMake(780, 200);
        //[self addChild:xMark];
        
        moveSelect1 = [SKAction moveTo:brushOne.position duration:0.0];
        moveSelect2 = [SKAction moveTo:brushTwo.position duration:0.0];
        moveSelect3 = [SKAction moveTo:brushThree.position duration:0.0];
        moveSelect4 = [SKAction moveTo:brushFour.position duration:0.0];

    
    }
    
    return self;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation  = [touch locationInNode:self];
    
    if(CGRectContainsPoint(checkMark.frame, touchLocation)) {
        
        [self removeFromParent];

        
    } else if (CGRectContainsPoint(brushOne.frame, touchLocation)) {
        
        SKAction *delayDelegate = [SKAction waitForDuration:0.5];
        SKAction *callDelegate = [SKAction runBlock:^{
            [self.delegate selectedBrush:@"flare-red"];
        }];
        
        [brushSelect runAction:[SKAction sequence:@[moveSelect1,delayDelegate,callDelegate]]];
        
    } else if (CGRectContainsPoint(brushTwo.frame, touchLocation)) {
        
        
        SKAction *delayDelegate = [SKAction waitForDuration:0.5];
        SKAction *callDelegate = [SKAction runBlock:^{
            [self.delegate selectedBrush:@"light-blue"];
        }];
        
        [brushSelect runAction:[SKAction sequence:@[moveSelect2,delayDelegate,callDelegate]]];


    } else if (CGRectContainsPoint(brushThree.frame, touchLocation)) {
        
        SKAction *delayDelegate = [SKAction waitForDuration:0.5];
        SKAction *callDelegate = [SKAction runBlock:^{
            [self.delegate selectedBrush:@"cartoon-cloud3"];
        }];
        [brushSelect runAction:[SKAction sequence:@[moveSelect3,delayDelegate,callDelegate]]];
        
    } else if (CGRectContainsPoint(brushFour.frame, touchLocation)) {
        
        SKAction *delayDelegate = [SKAction waitForDuration:0.5];
        SKAction *callDelegate = [SKAction runBlock:^{
            [self.delegate selectedBrush:@"sunburst"];
        }];
        [brushSelect runAction:[SKAction sequence:@[moveSelect4,delayDelegate,callDelegate]]];
        
    } else if (CGRectContainsPoint(toggleOnAudio.frame, touchLocation)) {
        
        toggleOnAudio.alpha = 0.0;
        toggleOffAudio.alpha = 1.0;
        
        [self.delegate selectedBrush:@"off audio"];
        
        
    } else if (CGRectContainsPoint(toggleOnHand.frame, touchLocation)) {
        
        if (toggleOnHand.alpha == 1.0) {
            
            toggleOnHand.alpha = 0.0;
            toggleOffHand.alpha = 1.0;
            [self.delegate handTraceOnOff:@"off"];
            
        } else {
            toggleOnHand.alpha = 1.0;
            toggleOffHand.alpha = 0.0;
            [self.delegate handTraceOnOff:@"on"];
            
        }
        
    } else if (CGRectContainsPoint(toggleOnArrows.frame, touchLocation)) {
        
        if(toggleOnArrows.alpha == 1.0) {
            toggleOnArrows.alpha = 0.0;
            toggleOffArrows.alpha = 1.0;
            [self.delegate arrowOnOff:@"off"];
        } else {
            toggleOnArrows.alpha = 1.0;
            toggleOffArrows.alpha = 0.0;
            [self.delegate arrowOnOff:@"on"];
        }
        
        
    }
}

@end
