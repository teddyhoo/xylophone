//
//  HistoryData.h
//  HistoryApp
//
//  Created by Edward Hooban on 9/30/12.
//
//

#import <Foundation/Foundation.h>

@interface HistoryData : NSObject {
    NSMutableArray *quizQuestions;
    NSMutableArray *quizAnswers;
    NSMutableArray *wrongAnswerOne;
    NSMutableArray *wrongAnswerTwo;
    NSMutableArray *wrongAnswerThree;
    NSMutableArray *wrongAnswerFour;
    NSMutableArray *clueToAnswer;
    NSMutableArray *terms;
    NSMutableArray *helperTips;
    NSMutableArray *sectionForQuestion;
    NSMutableArray *tag1ForQuestion;
    NSMutableArray *tag2ForQuestion;
    NSMutableArray *tag3ForQuestion;
    NSMutableArray *difficultyForQuestion;
    NSMutableArray *imageForQuestion;

    NSMutableArray *matchingData;
    
    NSMutableArray *essayData;
    
    NSMutableArray *historyData;
    
    NSMutableArray *causesTerm;
    NSMutableArray *effectsTerm;
    NSMutableArray *explanationTerm;
    NSMutableArray *termTitle;
    NSMutableArray *overlayTerms;
    
    NSMutableDictionary *scoringTracking;
    
    NSMutableDictionary *americanHistoryTopics;
    NSMutableDictionary *worldHistoryTopics;
    
    NSMutableDictionary *questionsByTopic;
    NSMutableDictionary *quizAnswersByTopic;
}
@property (nonatomic,retain) NSMutableArray *helperTips;
@property (nonatomic,retain) NSMutableArray *quizQuestions;
@property (nonatomic,retain) NSMutableArray *quizAnswers;
@property (nonatomic,retain) NSMutableArray *wrongAnswerOne;
@property (nonatomic,retain) NSMutableArray *wrongAnswerTwo;
@property (nonatomic,retain) NSMutableArray *wrongAnswerThree;
@property (nonatomic,retain) NSMutableArray *wrongAnswerFour;
@property (nonatomic,retain) NSMutableArray *clueToAnswer;
@property (nonatomic,retain) NSMutableArray *sectionForQuestion;
@property (nonatomic,retain) NSMutableArray *tag1ForQuestion;
@property (nonatomic,retain) NSMutableArray *tag2ForQuestion;
@property (nonatomic,retain) NSMutableArray *tag3ForQuestion;
@property (nonatomic,retain) NSMutableArray *difficultyForQuestion;
@property (nonatomic,retain) NSMutableArray *imageForQuestion;


@property (nonatomic,retain) NSMutableDictionary *scoringTracking;

@property (nonatomic,retain) NSMutableArray *causesTerm;
@property (nonatomic,retain) NSMutableArray *effectsTerm;
@property (nonatomic,retain) NSMutableArray *explanationTerm;

@property (nonatomic,retain) NSMutableArray *termTitle;
@property (nonatomic,retain) NSMutableArray *overlayTerms;

@property (nonatomic,retain) NSMutableDictionary *americanHistoryTopics;
@property (nonatomic,retain) NSMutableDictionary *worldHistoryTopics;

@property (nonatomic,retain) NSMutableArray *matchingData;
@property (nonatomic,retain) NSMutableArray *essayData;
@property (nonatomic,retain) NSMutableArray *historyData;

+(id)sharedManager;

@end
