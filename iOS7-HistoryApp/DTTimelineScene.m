//
//  DTTimelineScene.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/2/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "DTTimelineScene.h"
#import "ViewController.h"
#import "SmoothLineView.h"
#import "HistoryData.h"
#import "HistoryTerm.h"
#import "MainMenu.h"

@implementation DTTimelineScene

NSMutableArray *historyTerms;
HistoryData *sharedData;

-(id)initWithSize:(CGSize)size {
    
    if(self = [super initWithSize:size]) {
        
        self.backgroundColor = [SKColor colorWithRed:0.4 green:0.6 blue:0.3 alpha:1.0];

        SKLabelNode *testLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        testLabel.text = @"Next Question";
        testLabel.fontSize = 40;
        testLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                         CGRectGetMidY(self.frame)+400);
        
        [self addChild:testLabel];
        
        historyTerms = [[NSMutableArray alloc]init];
        [historyTerms addObject:testLabel];
        
        sharedData = [HistoryData sharedManager];
       
        
        for(NSMutableDictionary *termDef in sharedData.historyData) {
            for (NSString *key in termDef) {
                
                if ([key isEqualToString:@"theTerm"]) {
                    
                    NSLog(@"matched %@",[termDef objectForKey:key]);
                    
                    SKLabelNode *termSprite = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
                    termSprite.text = [termDef objectForKey:key];
                    termSprite.fontSize = 40;
                    termSprite.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)+200);
                    termSprite.position = CGPointMake(CGRectGetMidX(self.frame),
                                                      CGRectGetMidY(self.frame));
                    
                    
                    [self addChild:termSprite];
                    
                                                      
                }
            }
        }
                        
        [self setupHUD];
        [self nextQuestion];
        
    }
    
    return self;
    
}

-(BOOL)checkCollision:(CGPoint)begX :(CGPoint)begY {
    
    
    return FALSE;
    
}

-(BOOL)checkCollisionEnd:(CGPoint)begX :(CGPoint)begY {
    
    return FALSE;
    
}


-(void)setupHUD {
    
    
}

-(void)nextQuestion {
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touched");
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    for (SKNode *labels in historyTerms) {
       
        if([labels containsPoint:theTouch]) {
            
            NSLog(@"touching");
            SKScene *newSceneComing = [[MainMenu alloc]initWithSize:self.size];
            SKTransition *doors = [SKTransition doorsOpenVerticalWithDuration:0.5];
            [self.view presentScene:newSceneComing transition:doors];
            
        }
        
    }
    
    
    

    
    
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}


-(void)update:(NSTimeInterval)currentTime {
    
    
}




@end
