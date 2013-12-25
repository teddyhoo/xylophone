//
//  Scoreboard.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/9/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Scoreboard : SKNode

@property (nonatomic,retain) SKLabelNode* numberCorrect;
@property (nonatomic,retain) SKLabelNode* numberWrong;
@property (nonatomic,retain) SKLabelNode* totalQuestions;
@property (nonatomic,retain) SKLabelNode* totalScoreDisplay;
@property (nonatomic,retain) SKLabelNode* topicCategory;
@property (nonatomic,retain) SKLabelNode* topicTimePeriod;
@property (nonatomic,retain) SKLabelNode *timerCount;
@property (readonly,nonatomic)CGSize layerSize;


-(void)initWithPosition:(CGPoint)position;
-(void)updateScoreboard;
-(void)removeScoreboard;
-(void)updateScoreElement:(NSString *)elementValue type:(NSNumber *)elementType;


@end
