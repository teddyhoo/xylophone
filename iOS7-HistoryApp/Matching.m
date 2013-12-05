//
//  Matching.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/11/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//


#import "Matching.h"

@implementation Matching

SKSpriteNode *letterA;
SKSpriteNode *letterB;
SKSpriteNode *backToMainMenuArrow;

NSMutableArray *myLines;
NSMutableArray *myEndLines;
NSMutableArray *matchingData;
NSMutableArray *myArrows;
NSMutableArray *correctAndIncorrectMarks;
NSMutableArray *myCurrentTerms;
NSMutableArray *labelTermsForRemove;

int termNumber = 0;
int termsInSection = 0;
int correct;
int incorrect;
int midPoint;
int midPointHoriz;
int cause_y_offset;
int cause_long_y_offset;
int effect_y_offset;
int effect_long_y_offset;

BOOL sectionCompleted;
BOOL mapFlag = FALSE;
BOOL docFlag = FALSE;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        
        
        NSMutableArray *instructionsText = [[NSMutableArray alloc]initWithObjects:
                                        @"A term is presented to you",
                                        @"The causes and effects for the term are also displayed",
                                        @"If a cause Drag the term to the left ",
                                        @"If effect Drag the term to the right",
                                        nil];
        
        
        
       
        
        int i=0;
        
        for (NSString *instruct in instructionsText) {
            NSLog(@"instructions");
            
            SKLabelNode *myInstruct = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
            myInstruct.text = instruct;
            myInstruct.fontSize = 20;
            myInstruct.fontColor = [UIColor redColor];
            myInstruct.position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - i);
            [self addChild:myInstruct];
            i += 50;
            
        }
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
        SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        
        myLabel.text = @"Matching Exercises";
        myLabel.fontColor = [UIColor blueColor];
        myLabel.fontSize = 30;
        myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
                                       CGRectGetMidY(self.frame)+200);
        [self addChild:myLabel];
    }
    return self;
}



@end
