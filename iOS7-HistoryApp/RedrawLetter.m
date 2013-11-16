//
//  RedrawLetter.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 11/5/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "RedrawLetter.h"
#import "MontessoriData.h"

@implementation RedrawLetter

@synthesize timeToComplete, representLetter;
MontessoriData *sharedData;

-(instancetype) initWithPosition:(CGPoint)position withKey:(NSNumber *)keyForLetter {
    
    //self.userInteractionEnabled = YES;
    
    if (self = [super init]) {
        sharedData = [MontessoriData sharedManager];

        self.position = position;
        self.userInteractionEnabled = YES;
        
        int convertKey = [keyForLetter intValue];
        
        if(convertKey == 0) {
            
            representLetter = @"A";
            
        } else if (convertKey == 1) {
            
            representLetter = @"B";
            
        } else if (convertKey == 2) {
            
            representLetter = @"C";
            
        } else if (convertKey == 3) {
            
            representLetter = @"M";
            
        } else if (convertKey == 4) {
            
            representLetter = @"S";
            
        } else if (convertKey == 5) {
            
            representLetter = @"O";
            
        } else if (convertKey == 6) {
            
            representLetter = @"A";
            
        } else if (convertKey == 7) {
            
            representLetter = @"A";
            
        } else if (convertKey == 8) {
            
            representLetter = @"A";
            
        } else if (convertKey == 9) {
            
            representLetter = @"A";
            
        } else if (convertKey == 10) {
            
            representLetter = @"A";
            
        } else if (convertKey == 11) {
            
            representLetter = @"A";
            
        } else if (convertKey == 12) {
            
            representLetter = @"A";
            
        } else if (convertKey == 13) {
            
            representLetter = @"A";
            
        } else if (convertKey == 14) {
            
            representLetter = @"A";
            
        } else if (convertKey == 15) {
            
            representLetter = @"A";
            
        } else if (convertKey == 16) {
            
            representLetter = @"A";
            
        } else if (convertKey == 17) {
            
            representLetter = @"A";
            
        } else if (convertKey == 18) {
            
            representLetter = @"A";
            
        } else if (convertKey == 19) {
            
            representLetter = @"A";
            
        } else if (convertKey == 20) {
            
            representLetter = @"A";
            
        } else if (convertKey == 21) {
            
            representLetter = @"A";
            
        } else if (convertKey == 22) {
            
            representLetter = @"A";
            
        } else if (convertKey == 23) {
            representLetter = @"A";
        } else if (convertKey == 24) {
            representLetter = @"A";
        } else if (convertKey == 25) {
            representLetter = @"A";
        } else if (convertKey == 26) {
            representLetter = @"A";
        }

    }
    return self;
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog (@"touched drawn letter");
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}


@end
