//
//  LowerCaseLetter.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/10/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "LowerCaseLetter.h"

@implementation LowerCaseLetter

@synthesize baseSound, wordSample1, wordSample2, wordSample3, wordSample4;

-(void)turnOffGestures {
    
}

-(void)playTheSound {
    
    [baseSound play];
}


-(void)createControlPoints:(NSMutableArray *)controlPointsForLetter {
    
    controlPoints = [[NSMutableArray alloc]initWithArray:controlPointsForLetter copyItems:YES];
    
}


@end
