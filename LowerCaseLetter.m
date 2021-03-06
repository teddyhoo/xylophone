//
//  LowerCaseLetter.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/10/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "LowerCaseLetter.h"
#import <AVFoundation/AVFoundation.h>

@implementation LowerCaseLetter

@synthesize baseSound,wordSample1, wordSample2, wordSample3, wordSample4, centerStage, wordsForLetter, timeForTrace, numberAttempts,whichLetter;



-(void) atCenterStage {
    
    if (centerStage) {
        centerStage = FALSE;
    }  else {
        centerStage = TRUE;
    }
}

-(void) wordsForImages:(NSDictionary *)theWords {
    
    
}

-(void)playTheSound {
    
    [baseSound play];
}

-(void) playWordSample:(NSNumber *)wordNumber {
    
    
}

-(void)createControlPoints:(NSMutableArray *)controlPointsForLetter {
    
    controlPoints = [[NSMutableArray alloc]initWithArray:controlPointsForLetter copyItems:YES];
    
}

-(void)createWordSamples {

    
}

-(void)fireEmitter {
    NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"displayLetter"
                                                                 ofType:@"sks"];
    
    SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
    openEffect.position = CGPointMake(300, 300);
    [self addChild:openEffect];
    
}



@end
