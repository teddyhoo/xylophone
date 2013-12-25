//
//  MatchImage.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/16/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "MatchImage.h"

@implementation MatchImage

@synthesize letter;

-(instancetype)init:(NSString*)imageFile{
    
    if (self = [super initWithImageNamed:imageFile]) {
        
        //openEmitterEffectMore = [[NSBundle mainBundle]pathForResource:@"sparkPart2" ofType:@"sks"];
        //openEffectMore = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        //openEffectMore.position = CGPointMake(-80, 0);
        
        //[self fireEmitter];
    }
    return self;
    
}

@end
