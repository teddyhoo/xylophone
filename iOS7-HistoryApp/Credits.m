//
//  Credits.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 10/29/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "Credits.h"
#import "FilterFrame.h"

@implementation Credits


- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];
        //self.filter = [[FilterFrame alloc]init];
        //self.shouldEnableEffects = YES;
        
        NSLog(@"called init");
        
    }
    return self;
}


- (void) didMoveToView:(SKView *)view {
    
    NSLog(@"called did Move To View");
    
    NSString *headerTitle = @"The Stage Classroom";
    
    SKLabelNode *headerTitleForCredits = [SKLabelNode labelNodeWithFontNamed:@"StalinistOne-Regular"];
    headerTitleForCredits.text = headerTitle;
    headerTitleForCredits.position = CGPointMake(550, 720);
    [self addChild:headerTitleForCredits];
    
    
    NSMutableArray *header = [[NSMutableArray alloc]initWithObjects:
                              @"[CoolGraphics designedBy:@\"Mark\"]",
                              @"[CoolVocals spokenBy:@\"Lorelei\"];",
                              @"[ThemeSong sungBy:@\"The Lorelei\'s onVocals:Haley onUkelele:Lorelei];",
                              @"[TheCode writtenBy:@\"Ted\"];",
                              @"[TheStageClassroom brainchildOf:@\"Ms. Stage\"];",
                              
                              @"[self haveFunWhileYouLearn];",
                              
                              nil];
    
    int yPos = 0;
    
    for (NSString *creditInfo in header) {
        SKLabelNode *labelForCredit = [SKLabelNode labelNodeWithFontNamed:@"courier"];
        labelForCredit.text = creditInfo;
        labelForCredit.fontSize = 16;
        labelForCredit.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeLeft;
        
        labelForCredit.position = CGPointMake(150, 600 - yPos);
        yPos += 100;
        [self addChild:labelForCredit];
        
    }
    
    
    SKSpriteNode *tedHead = [SKSpriteNode spriteNodeWithImageNamed:@"ted.png"];
    SKSpriteNode *stewieHead = [SKSpriteNode spriteNodeWithImageNamed:@"stewie-cartoon.png"];
    
    tedHead.position = CGPointMake(70, 300);
    [self addChild:tedHead];
    
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
    
}

-(void) createSceneContents {
    
    self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];
    self.scaleMode = SKSceneScaleModeAspectFit;

    
    
}


@end
