//
//  ReviewQuestion.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ReviewQuestion : SKScene


@property (nonatomic,retain) NSString* question;
@property (nonatomic,retain) NSString* answer1;
@property (nonatomic,retain) NSString* answer2;
@property (nonatomic,retain) NSString* answer3;
@property (nonatomic,retain) NSString* answer4;
@property (nonatomic,retain) NSNumber* correctAnswer;
@property (nonatomic,retain) NSNumber* totalQuestions;
@property (nonatomic,retain) NSNumber* totalScore;
@property (nonatomic,retain) NSMutableArray *explanation;

@property (readonly,nonatomic)CGSize layerSize;

-(void)updateScoreWindow:(NSNumber*)totalScore
                  totalQ:(NSNumber*)totalQuestions
              percentage:(NSNumber*)percent
                 totTime:(NSNumber*)totalTestTime
              correctAns:(NSNumber*)correctAnswers;

@end
