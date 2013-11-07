//
//  QuizButtons.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 10/31/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "QuizButtons.h"
#import "UIColor+FlatUI.h"



@implementation QuizButtons

@synthesize button1, button2, button3, button4;


-(id) initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        self.button1.buttonColor = [UIColor turquoiseColor];
        self.button1.shadowColor = [UIColor greenSeaColor];
        self.button1.shadowHeight = 3.0f;
        self.button1.cornerRadius = 6.0f;
        
        self.button1.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        [self addSubview:button1];
        
        
    }
    return self;
    
}

@end
