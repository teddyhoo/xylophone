//
//  Options.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 1/14/14.
//  Copyright (c) 2014 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>

@class Options;
@protocol OptionsDelegate <NSObject>

@optional
-(void)selectedBrush:(NSString*)theBrush;
-(void)soundOnOff:(NSString*)soundOption;
-(void)arrowOnOff:(NSString*)arrowOption;
-(void)handTraceOnOff:(NSString*)traceOption;


@end
@interface Options : SKNode {
    
    id <OptionsDelegate> _delegate;
    
}

@property (nonatomic,strong)id delegate;
@property BOOL showOptions;

-(instancetype)initWithPosition:(CGPoint)position;
-(void)dismissMe;

@end
