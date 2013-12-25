//
//  HistoryData.m
//  HistoryApp
//
//  Created by Edward Hooban on 9/30/12.
//
//

#import "HistoryData.h"
#import "SMXMLDocument.h"

static HistoryData *sharedMyManager = nil;
static NSString *subjectType = @"americanhistory";


// AP World History: worldhistory
// AP US History: ushistory
// AP European History: eurohistory
// AP Government: govt
// AP Human Geography: geography
// 
@implementation HistoryData

@synthesize quizQuestions, quizAnswers, wrongAnswerOne, wrongAnswerTwo, wrongAnswerThree, wrongAnswerFour, sectionForQuestion;
@synthesize overlayTerms, causesTerm, helperTips, termTitle, explanationTerm, scoringTracking, clueToAnswer, effectsTerm;
@synthesize worldHistoryTopics, americanHistoryTopics;
@synthesize tag1ForQuestion, tag2ForQuestion, tag3ForQuestion, difficultyForQuestion, imageForQuestion;
@synthesize matchingData;
@synthesize essayData;
@synthesize historyData;


// Read data files for all the history questions / exercises
// Singleton
+(id)sharedManager {
    
    @synchronized(self) {
        if (sharedMyManager == nil) {
            sharedMyManager = [[self alloc] init];
        }
        
        return sharedMyManager;
    }
	
}

-(id)init {
    
	if (self = [super init]) {
        
        scoringTracking = [[NSMutableDictionary alloc]init];
        quizQuestions = [[NSMutableArray alloc] init];
        quizAnswers = [[NSMutableArray alloc] init];
        wrongAnswerOne = [[NSMutableArray alloc] init];
        wrongAnswerTwo = [[NSMutableArray alloc] init];
        wrongAnswerThree = [[NSMutableArray alloc] init];
        wrongAnswerFour = [[NSMutableArray alloc] init];
        helperTips = [[NSMutableArray alloc] init];
        sectionForQuestion = [[NSMutableArray alloc] init];
        imageForQuestion = [[NSMutableArray alloc]init];
        difficultyForQuestion = [[NSMutableArray alloc]init];
        causesTerm = [[NSMutableArray alloc] init];
        effectsTerm = [[NSMutableArray alloc] init];
        explanationTerm = [[NSMutableArray alloc] init];
        
        questionsByTopic = [[NSMutableDictionary alloc]init];
        
        NSString *sampleXML;
        
        if ([subjectType isEqualToString:@"worldhistory"] ) {
            
            sampleXML = [[NSBundle mainBundle] pathForResource:@"WorldHistory" ofType:@"xml"];
            
            NSString *pListData = [[NSBundle mainBundle] pathForResource:@"Matching-World-History" ofType:@"plist"];
            matchingData = [[NSMutableArray alloc] initWithContentsOfFile:pListData];
            
            NSString *pListEssay = [[NSBundle mainBundle] pathForResource:@"WorldEssays" ofType:@"plist"];
            essayData = [[NSMutableArray alloc] initWithContentsOfFile:pListEssay];
            
            NSString *historyTerms = [[NSBundle mainBundle] pathForResource:@"HistoryTerms" ofType:@"plist"];
            historyData = [[NSMutableArray alloc] initWithContentsOfFile:historyTerms];
            NSLog(@"History term 1: %@",[historyData objectAtIndex:0]);
            
            
            
        } else if ([subjectType isEqualToString:@"americanhistory"]) {
            
            sampleXML = [[NSBundle mainBundle] pathForResource:@"AmericanHistory" ofType:@"xml"];
            
            NSString *pListData = [[NSBundle mainBundle] pathForResource:@"Matching-World-History" ofType:@"plist"];
            matchingData = [[NSMutableArray alloc] initWithContentsOfFile:pListData];
            
            
        } else if ([subjectType isEqualToString:@"eurohistory"]) {
            
            sampleXML = [[NSBundle mainBundle] pathForResource:@"WorldHistory" ofType:@"xml"];
            
        } else if ([subjectType isEqualToString:@"govt"]) {
            
            sampleXML = [[NSBundle mainBundle] pathForResource:@"WorldHistory" ofType:@"xml"];
            
        } else if ([subjectType isEqualToString:@"geography"]) {
            
            sampleXML = [[NSBundle mainBundle] pathForResource:@"WorldHistory" ofType:@"xml"];
            
        } else {
            
            
            sampleXML = [[NSBundle mainBundle] pathForResource:@"WorldHistory" ofType:@"xml"];

            
        }
                    
                    
        //NSString *sampleXML = [[NSBundle mainBundle] pathForResource:@"AmericanHistory" ofType:@"xml"];
        
        NSData *data = [NSData dataWithContentsOfFile:sampleXML];
        
        
        SMXMLDocument *document = [SMXMLDocument documentWithData:data error:NULL];
        SMXMLElement *element = [document.root childNamed:@"questions"];
        
        for (SMXMLElement *question in [element childrenNamed:@"question"]) {
            
            NSString *questionResult = [question valueWithPath:@"title"];
            NSString *answerResult = [question valueWithPath:@"answer"];
            NSString *wrongOne = [question valueWithPath:@"firstWrong"];
            NSString *wrongTwo = [question valueWithPath:@"secondWrong"];
            NSString *wrongThree = [question valueWithPath:@"thirdWrong"];
            NSString *wrongFour = [question valueWithPath:@"fourthWrong"];
            NSString *clue = [question valueWithPath:@"clue"];
            NSString *section = [question valueWithPath:@"time"];

            //NSString *tagFirst = [question valueWithPath:@"tag1"];
            //NSString *tagSecond = [question valueWithPath:@"tag2"];
            //NSString *tagThird = [question valueWithPath:@"tag3"];
            NSString *difficulty = [question valueWithPath:@"difficulty"];
            NSString *image = [question valueWithPath:@"image"];
            
            [quizQuestions addObject:questionResult];
            [quizAnswers addObject:answerResult];
            [wrongAnswerOne addObject:wrongOne];
            [wrongAnswerTwo addObject:wrongTwo];
            [wrongAnswerThree addObject:wrongThree];
            [wrongAnswerFour addObject:wrongFour];
            [helperTips addObject:clue];
            [sectionForQuestion addObject:section];
            [imageForQuestion addObject:image];
            [difficultyForQuestion addObject:difficulty];
            
            [questionsByTopic setValue:section forKey:questionResult];
            
            
        }
        
        
        NSLog(@"Number of questions: %i",[quizQuestions count]);
        
       
        
    }
    return self;
}

@end

