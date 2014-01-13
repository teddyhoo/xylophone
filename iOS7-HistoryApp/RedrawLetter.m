//
//  RedrawLetter.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 11/5/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "RedrawLetter.h"
#import "MontessoriData.h"
#import "LowerCaseLetter.h"

@implementation RedrawLetter

@synthesize timeToComplete, representLetter, spritePointObjects,letterData,dateDrawn;
MontessoriData *sharedData;
SKShapeNode *highlightLetter;

-(instancetype) initWithPosition:(CGPoint)position withKey:(NSNumber *)keyForLetter {
    
    //self.userInteractionEnabled = YES;
    
    spritePointObjects = [[NSMutableArray alloc]init];
    
    
    if (self = [super init]) {
        
        sharedData = [MontessoriData sharedManager];
        self.userInteractionEnabled = YES;
        self.position = position;
        
        _layerSize = CGSizeMake(400, 400);
        
        int convertKey = [keyForLetter intValue];
        
        if(convertKey == 1) {
            letterData = sharedData.letterA;
            representLetter = @"A";
        } else if (convertKey == 2) {
            letterData = sharedData.letterB;
            representLetter = @"B";
        } else if (convertKey == 3) {
            letterData = sharedData.letterC;
            representLetter = @"C";
        } else if (convertKey == 4) {
            letterData = sharedData.letterM;
            representLetter = @"M";
        } else if (convertKey == 5) {
            letterData = sharedData.letterS;
            representLetter = @"S";
        } else if (convertKey == 6) {
            letterData = sharedData.letterT;
            representLetter = @"T";
        } else if (convertKey == 7) {
            letterData = sharedData.letterO;
            representLetter = @"O";
        } else if (convertKey == 8) {
            letterData = sharedData.letterG;
            representLetter = @"G";
        } else if (convertKey == 9) {
            letterData = sharedData.letterR;
            representLetter = @"R";
        } else if (convertKey == 10) {
            letterData = sharedData.letterD;
            representLetter = @"D";
        } else if (convertKey == 11) {
            letterData = sharedData.letterF;
            representLetter = @"F";
        } else if (convertKey == 12) {
            letterData = sharedData.letterI;
            representLetter = @"I";
        } else if (convertKey == 13) {
            letterData = sharedData.letterP;
            representLetter = @"P";
        } else if (convertKey == 14) {
            letterData = sharedData.letterN;
            representLetter = @"N";
        } else if (convertKey == 15) {
            letterData = sharedData.letterL;
            representLetter = @"L";
            
        } else if (convertKey == 16) {
            letterData = sharedData.letterH;
            representLetter = @"H";
            
        } else if (convertKey == 17) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 18) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 19) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 20) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 21) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 22) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 23) {
            letterData = sharedData.letterA;

            representLetter = @"A";
            
        } else if (convertKey == 24) {
            letterData = sharedData.letterA;

            representLetter = @"A";
        } else if (convertKey == 25) {
            letterData = sharedData.letterA;

            representLetter = @"A";
        } else if (convertKey == 26) {
            letterData = sharedData.letterA;

            representLetter = @"A";
        } else if (convertKey == 26) {
            letterData = sharedData.letterA;

            representLetter = @"A";
        }

    }
    return self;
    
    
}

-(instancetype)initWithPosition:(CGPoint)position withLetter:(LowerCaseLetter*)letter {
    
    spritePointObjects = [[NSMutableArray alloc]init];
    
    if (self = [super init]) {
        
        sharedData = [MontessoriData sharedManager];
        //self.userInteractionEnabled = YES;
        self.position = position;
        _layerSize = CGSizeMake(400, 400);
        
        if([letter.whichLetter isEqual: @"A"]) {
            letterData = sharedData.letterA;
            representLetter = @"A";
        } else if ([letter.whichLetter isEqual: @"B"]) {
            letterData = sharedData.letterB;
            representLetter = @"B";
        } else if ([letter.whichLetter isEqual: @"C"]) {
            letterData = sharedData.letterC;
            representLetter = @"C";
        } else if ([letter.whichLetter isEqual: @"D"]) {
            letterData = sharedData.letterD;
            representLetter = @"D";
        } else if ([letter.whichLetter isEqual: @"E"]) {
            letterData = sharedData.letterE;
            representLetter = @"E";
        } else if ([letter.whichLetter isEqual: @"F"]) {
            letterData = sharedData.letterF;
            representLetter = @"F";
        } else if ([letter.whichLetter isEqual: @"G"]) {
            letterData = sharedData.letterG;
            representLetter = @"G";
        } else if ([letter.whichLetter isEqual: @"H"]) {
            letterData = sharedData.letterH;
            representLetter = @"H";
        } else if ([letter.whichLetter isEqual: @"I"]) {
            letterData = sharedData.letterI;
            representLetter = @"I";
        } else if ([letter.whichLetter isEqual: @"J"]) {
            letterData = sharedData.letterJ;
            representLetter = @"J";
        } else if ([letter.whichLetter isEqual: @"K"]) {
            letterData = sharedData.letterK;
            representLetter = @"K";
        } else if ([letter.whichLetter isEqual: @"L"]) {
            letterData = sharedData.letterL;
            representLetter = @"L";
        } else if ([letter.whichLetter isEqual: @"M"]) {
            letterData = sharedData.letterM;
            representLetter = @"M";
        } else if ([letter.whichLetter isEqual: @"N"]) {
            letterData = sharedData.letterN;
            representLetter = @"N";
        } else if ([letter.whichLetter isEqual: @"O"]) {
            letterData = sharedData.letterO;
            representLetter = @"O";
        } else if ([letter.whichLetter isEqual: @"P"]) {
            letterData = sharedData.letterP;
            representLetter = @"P";
        } else if ([letter.whichLetter isEqual: @"Q"]) {
            letterData = sharedData.letterQ;
            representLetter = @"Q";
        } else if ([letter.whichLetter isEqual: @"R"]) {
            letterData = sharedData.letterR;
            representLetter = @"R";
        } else if ([letter.whichLetter isEqual: @"S"]) {
            letterData = sharedData.letterS;
            representLetter = @"S";
        } else if ([letter.whichLetter isEqual: @"T"]) {
            letterData = sharedData.letterT;
            representLetter = @"T";
        } else if ([letter.whichLetter isEqual: @"U"]) {
            letterData = sharedData.letterU;
            representLetter = @"U";
        } else if ([letter.whichLetter isEqual: @"V"]) {
            letterData = sharedData.letterV;
            representLetter = @"V";
        } else if ([letter.whichLetter isEqual: @"W"]) {
            letterData = sharedData.letterW;
            representLetter = @"W";
        } else if ([letter.whichLetter isEqual: @"X"]) {
            letterData = sharedData.letterX;
            representLetter = @"X";
        } else if ([letter.whichLetter isEqual: @"Y"]) {
            letterData = sharedData.letterY;
            representLetter = @"Y";
        } else if ([letter.whichLetter isEqual: @"Z"]) {
            letterData = sharedData.letterZ;
            representLetter = @"Z";
        }
        
    }
    
    return self;
    

}


-(void)encodeWithCoder:(NSCoder *)aCoder {
    
    [super encodeWithCoder:aCoder];
    [aCoder encodeObject:spritePointObjects forKey:@"letterShape"];
    // [aCoder encodeObject:DATE-DRAWN forKey:@"date"];
    
    
}
-(void)addPointToNode:(SKSpriteNode*)drawnPoint {
    
    [spritePointObjects addObject:drawnPoint];
 
}

-(NSMutableArray *)drawMyself {
    
    return spritePointObjects;
}


-(void) saveWork {
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog (@"touched node element");
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation  = [touch locationInNode:self];
    
    for (SKSpriteNode *spriteRemove in spritePointObjects) {
        spriteRemove.alpha = 0.0;
        [spriteRemove removeFromParent];
    }
    
    for (SKSpriteNode *replaySprite in spritePointObjects) {
        
        //[self addChild:replaySprite];
    }
    
    [letterData playTheSound];
    
    
    
    
    

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}


@end
