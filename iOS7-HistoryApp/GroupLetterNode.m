//
//  GroupLetterNode.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 11/13/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "GroupLetterNode.h"
#import "MontessoriData.h"

@implementation GroupLetterNode

@synthesize groupID, drawnShapeData;
MontessoriData *sharedData;
NSMutableArray *groupOfLetters;
NSMutableDictionary *groupOfLettersShapes;
SKLabelNode *groupOne;
SKLabelNode *groupTwo;
SKLabelNode *groupThree;
SKLabelNode *groupFour;
SKLabelNode *groupFive;

-(void)initWithGroupID:(NSString *)IDforGroup {

    
    sharedData = [MontessoriData sharedManager];
    groupOfLetters = [[NSMutableArray alloc]init];
    groupOfLettersShapes = [[NSMutableDictionary alloc]init];
    
    self.userInteractionEnabled = YES;
        
    if ([IDforGroup isEqualToString:@"first"]) {

        [groupOfLetters addObject:sharedData.letterA];
        [groupOfLetters addObject:sharedData.letterB];
        [groupOfLetters addObject:sharedData.letterC];
        [groupOfLetters addObject:sharedData.letterM];
        [groupOfLetters addObject:sharedData.letterT];
        [groupOfLetters addObject:sharedData.letterS];
        
        groupOne = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupOne.text = @"Group 1";
        groupOne.fontColor = [UIColor redColor];
        groupOne.fontSize = 20;
        groupOne.position = CGPointMake(100, 100);
        [self addChild:groupOne];
            
    } else if ([IDforGroup isEqualToString:@"second"]) {
            
        [groupOfLetters addObject:sharedData.letterO];
        [groupOfLetters addObject:sharedData.letterG];
        [groupOfLetters addObject:sharedData.letterR];
        [groupOfLetters addObject:sharedData.letterD];
        [groupOfLetters addObject:sharedData.letterD];
        [groupOfLetters addObject:sharedData.letterF];
        
        groupTwo = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupTwo.text = @"Group 2";
        groupTwo.fontColor = [UIColor redColor];
        groupTwo.fontSize = 20;
        groupTwo.position = CGPointMake(100, 130);
        [self addChild:groupTwo];
            
            
    } else if ([IDforGroup isEqualToString:@"third"]) {
            
        [groupOfLetters addObject:sharedData.letterA];
        [groupOfLetters addObject:sharedData.letterB];
        [groupOfLetters addObject:sharedData.letterC];
        [groupOfLetters addObject:sharedData.letterM];
        [groupOfLetters addObject:sharedData.letterT];
        [groupOfLetters addObject:sharedData.letterS];
            
        groupThree = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupThree.text = @"Group 3";
        groupThree.fontColor = [UIColor redColor];
        groupThree.fontSize = 20;
        groupThree.position = CGPointMake(100, 160);
        [self addChild:groupThree];
        
        
    } else if ([IDforGroup isEqualToString:@"fourth"]) {
            
        [groupOfLetters addObject:sharedData.letterA];
        [groupOfLetters addObject:sharedData.letterB];
        [groupOfLetters addObject:sharedData.letterC];
        [groupOfLetters addObject:sharedData.letterM];
        [groupOfLetters addObject:sharedData.letterT];
        [groupOfLetters addObject:sharedData.letterS];
        
        groupFour = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupFour.text = @"Group 4";
        groupFour.fontColor = [UIColor redColor];
        groupFour.fontSize = 20;
        groupFour.position = CGPointMake(100, 190);
        [self addChild:groupFour];
            
    } else if ([IDforGroup isEqualToString:@"fifth"]) {
        [groupOfLetters addObject:sharedData.letterA];
        [groupOfLetters addObject:sharedData.letterB];
        [groupOfLetters addObject:sharedData.letterC];
        [groupOfLetters addObject:sharedData.letterM];
        [groupOfLetters addObject:sharedData.letterT];
        [groupOfLetters addObject:sharedData.letterS];
            
        groupFive = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
        groupFive.text = @"Group 5";
        groupFive.fontColor = [UIColor redColor];
        groupFive.fontSize = 20;
        groupFive.position = CGPointMake(100, 220);
    }
    

}

-(void)addNodeForLetter:(NSArray *)shapeSpritesForNode{
    
    
}



-(void)moveToShow {
    
    
}


-(void)moveOffScreen {
    
    
}


-(void)playTheSound {
   
    
    
}

-(void)displayLetterHistory {
    
    
    
}




@end
