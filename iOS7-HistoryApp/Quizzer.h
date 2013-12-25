//
//  Quizzer.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/6/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TopicPicker.h"
#import "TCProgressTimerNode.h"

@interface Quizzer : SKScene {

    SKSpriteNode *clue;

    SKLabelNode *question;
    SKLabelNode *answer1;
    SKLabelNode *answer2;
    SKLabelNode *answer3;
    SKLabelNode *answer4;
    SKSpriteNode *forward;
    SKSpriteNode *goForward;

    NSMutableArray *scoreKeeperSprites;

    NSMutableArray *quizQuestions;
    NSMutableArray *quizAnswers;
    NSMutableArray *quizWrongOne;
    NSMutableArray *quizWrongTwo;
    NSMutableArray *quizWrongThree;
    NSMutableArray *quizWrongFour;
    NSMutableArray *questionClue;
    NSMutableArray *questionSection;
    NSMutableArray *tagFirst;
    NSMutableArray *tagSecond;
    NSMutableArray *difficultyLevel;
    NSMutableArray *imageList;


    NSArray *essayQuestions;

    NSInteger section;
    NSString *mySection;
    NSMutableDictionary *reviewAnswers;

    //QuizzerFinish *finishWithTest;


}

@property (nonatomic,retain) NSMutableArray *quizQuestions;
@property (nonatomic,retain) NSMutableArray *quizAnswers;
@property (nonatomic,retain) NSMutableArray *quizWrongOne;
@property (nonatomic,retain) NSMutableArray *quizWrongTwo;
@property (nonatomic,retain) NSMutableArray *quizWrongThree;
@property (nonatomic,retain) NSMutableArray *quizWrongFour;
@property (nonatomic,retain) NSMutableArray *questionClue;
@property (nonatomic,retain) NSMutableArray *questionSection;
@property (nonatomic,retain) NSMutableArray *tagFirst;
@property (nonatomic,retain) NSMutableArray *tagSecond;
@property (nonatomic,retain) NSMutableArray *difficultyLevel;
@property (nonatomic,retain) NSMutableArray *imageList;
@property (nonatomic,retain) SKSpriteNode *forward;
@property (nonatomic,retain) SKSpriteNode *goForward;
@property (nonatomic,retain) NSString *currentlySelectedTerm;


@property (nonatomic,strong) SKSpriteNode * answerButton1;
@property (nonatomic,strong) SKSpriteNode * answerButton2;
@property (nonatomic,strong) SKSpriteNode * answerButton3;
@property (nonatomic,strong) SKSpriteNode * answerButton4;

@property (nonatomic,strong) TCProgressTimerNode *progressTimerNode2;
@property (nonatomic) NSTimeInterval startTime;

-(void) addBackButton;
-(void) printNextQuestion;
-(void) checkAnswer:(NSNumber*)index;
-(void) finishedWithSection;
-(void) setupCorrectAndIncorrect;
-(void) selectedTopic:(NSString *)theSelection;


@end
