//
//  Quizzer-Tracker.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/20/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "TCProgressTimerNode.h"

@interface QuizzerTracker : SKNode


@property (readonly,nonatomic)CGSize layerSize;

-(void)setSize:(CGSize)size;
-(void)updateScore:(NSNumber*)numericalCalculatedScore;
-(void)updateOtherInfo:(NSString*)difficulty topicSection:(NSString*)section;
-(void)moveOffScreen;
-(void)moveBackOnScreen;


@end
