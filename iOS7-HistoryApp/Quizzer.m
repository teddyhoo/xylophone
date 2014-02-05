//
//  Quizzer.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/6/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "Quizzer.h"
#import "HistoryData.h"
#import "TopicPicker.h"
#import "WorldHistoryMainMenu.h"
#import "QuizzerTracker.h"
#import "ReviewQuestion.h"
#import "TCProgressTimerNode.h"
#import "ExplanationViewer.h"

#define kCyclesPerSecond 0.03f

@implementation Quizzer

@synthesize answerButton1, answerButton2, answerButton3, answerButton4;
@synthesize quizQuestions, quizAnswers, quizWrongOne, quizWrongTwo, quizWrongThree, quizWrongFour,
questionClue, questionSection, tagFirst, tagSecond, difficultyLevel, imageList, forward, goForward;
@synthesize currentlySelectedTerm;

HistoryData *sharedData;
TopicPicker *pickTopic;
QuizzerTracker *hudScore;
ExplanationViewer *explainView;

NSMutableArray *questionData;

SKLabelNode *scoreActual;
SKLabelNode *score;
SKLabelNode *totalTime;
SKLabelNode *correctQuestions;
SKLabelNode *totalScore;
SKLabelNode *explanationText; // from xml
SKLabelNode *explanationTextForQuestion;
SKLabelNode *questionExplanation;
SKLabelNode *numberOfCorrect;
SKLabelNode *totalScoreNow; //auto-calculated
SKLabelNode *totalQuestionsComplete; // dynamic
SKLabelNode *classifyQuestionCategory; // from xml
SKLabelNode *totalTimeDisplay; // dynamic


SKSpriteNode *correctQuestionAnswer;
SKSpriteNode *wrongQuestionAnswer;
SKSpriteNode *timerOutline;
SKSpriteNode *imageForQuestion;

SKSpriteNode *background;
SKSpriteNode *scoreBackground;
SKSpriteNode *explanationIcon;
SKSpriteNode *helpButton;
SKSpriteNode *backToMainMenuArrow;

SKSpriteNode *renderLabel;
SKSpriteNode *renderLabel2;
SKSpriteNode *renderLabel3;
SKSpriteNode *renderLabel4;
SKSpriteNode *renderLabel5;

SKSpriteNode *button1;
SKSpriteNode *button2;
SKSpriteNode *button3;
SKSpriteNode *button4;

static int questionCounter = 0;
static int totalCorrect = 0;
static int correctAnswer = 0;
static int totalIncorrect = 0;
static int offsetStar = 0;
int rowStar = 0;
int numberCorrectAnswers;
int scoreScale = 10;
int scoreFactor = 10; // scale x factor = total points
int amountOfTime = 0;
int scoreOnQuestion = 0;
int totalWeightedScore = 0;
int totalTimeTrack = 0;
int degreeOfDifficulty = 1;
int circlesPerRow = 20;
int currentRow = 1;

CGSize winSize;

BOOL sameQuestion = false;
BOOL sameQuestion2 = false;
BOOL sameQuestion3 = false;
BOOL sameQuestion4 = false;
BOOL sameQuestion5 = false;
BOOL alreadyAnswered = false;
BOOL removeImage = false;
BOOL topicLayerDismissed = false;
BOOL reviewLayerDismissed = false;
BOOL explanationDisplay = false;
BOOL timerOn = false;

NSMutableDictionary *topicsAndSubtopics;
NSMutableArray *subTopics;
NSMutableArray *allStar;
NSMutableArray *allXimg;
HistoryData *sharedData;

- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {

        
        winSize = CGSizeMake(680, 1250);

        [self setUserInteractionEnabled:YES];
        
        sharedData = [HistoryData sharedManager];
        quizQuestions = nil;
        quizAnswers = nil;
        quizWrongOne = nil;
        quizWrongTwo = nil;
        quizWrongThree = nil;
        quizWrongFour = nil;
        questionClue = nil;
        questionSection = nil;
        tagFirst = nil;
        tagSecond = nil;
        difficultyLevel = nil;
        imageList = nil;
        
        questionCounter = 0;
        totalCorrect = 0;
        correctAnswer = 0;
        totalIncorrect = 0;
        numberCorrectAnswers = 0;
        totalTimeTrack = 0;
        totalWeightedScore = 0;
        scoreOnQuestion = 0;
        currentRow = 0;
        offsetStar = 0;
        rowStar = 0;
        
        reviewAnswers = [[NSMutableDictionary alloc] init];
        scoreKeeperSprites = [[NSMutableArray alloc]init];
        allStar = [[NSMutableArray alloc]init];
        allXimg = [[NSMutableArray alloc]init];
        
        timerOn = FALSE;
        sameQuestion = FALSE;

        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"old-image-iphone-background.png"];
        background.position = CGPointMake(450,500);
        [self addChild:background];
        
        SKSpriteNode *scoreBackground = [SKSpriteNode spriteNodeWithImageNamed:@"score-holder"];
        scoreBackground.position = CGPointMake(400, 70);
        [self addChild:scoreBackground];
        
        hudScore = [[QuizzerTracker alloc]init];
        [hudScore setSize:size];
        hudScore.position = CGPointMake(0,0);
        [self addChild:hudScore];
        
        forward = [SKSpriteNode spriteNodeWithImageNamed:@"next-button-200x206.png"];
        forward.scale = 0.4;
        forward.position = CGPointMake(720, 50);
        [self addChild:forward];
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-button-200x206.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        backToMainMenuArrow.scale = 0.9;
        [self addChild:backToMainMenuArrow];

        helpButton = [SKSpriteNode spriteNodeWithImageNamed:@"question-button-200x206.png"];
        helpButton.position = CGPointMake(600, 50);
        [self addChild:helpButton];

        totalTimeDisplay = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        totalTimeDisplay.position = CGPointMake(110, 50);
        totalTimeDisplay.text = @"00";
        [self addChild:totalTimeDisplay];

        button1 = [SKSpriteNode spriteNodeWithImageNamed:@"blue-button-2.png"];
        button2 = [SKSpriteNode spriteNodeWithImageNamed:@"blue-button-2.png"];
        button3 = [SKSpriteNode spriteNodeWithImageNamed:@"blue-button-2.png"];
        button4 = [SKSpriteNode spriteNodeWithImageNamed:@"blue-button-2.png"];
        
        button1.position = CGPointMake(1400, 700);
        button2.position = CGPointMake(1400, 545);
        button3.position = CGPointMake(1400, 395);
        button4.position = CGPointMake(1400, 240);
        
        [self addChild:button1];
        [self addChild:button2];
        [self addChild:button3];
        [self addChild:button4];
        [self topicPicker];
        
    }
    return self;
    
}


-(void) topicPicker {
    
    pickTopic= [[TopicPicker alloc]init];
    pickTopic.anchorPoint = CGPointMake(0, 0);
    pickTopic.position = CGPointMake(300, 600);
    [pickTopic setUserInteractionEnabled:YES];
    [pickTopic setDelegate:self];
    [self addChild:pickTopic];
    
    
}

-(void)startTimer {
    _progressTimerNode2 = [[TCProgressTimerNode alloc] initWithForegroundImageNamed:@"yellow-timer-button-200x206"
                                                               backgroundImageNamed:@"blue-timer-button-206x200"
                                                                accessoryImageNamed:nil];
    
    _progressTimerNode2.position = CGPointMake(720,50);
    _progressTimerNode2.scale = 0.5;
    
    [self addChild:_progressTimerNode2];
    [_progressTimerNode2 setProgress:0.0f];
    self.startTime = CACurrentMediaTime();
    
}

-(void)stopTimer {
    
    
}

-(void) selectedTopic:(NSString *)theSelection {
    
    quizQuestions = nil;
    quizAnswers = nil;
    quizWrongOne = nil;
    quizWrongTwo = nil;
    quizWrongThree = nil;
    quizWrongFour = nil;
    questionClue = nil;
    questionSection = nil;
    tagFirst = nil;
    tagSecond = nil;
    difficultyLevel = nil;
    imageList = nil;
    
    quizQuestions = [[NSMutableArray alloc]init];
    quizAnswers = [[NSMutableArray alloc]init];
    quizWrongOne = [[NSMutableArray alloc]init];
    quizWrongTwo = [[NSMutableArray alloc]init];
    quizWrongThree = [[NSMutableArray alloc]init];
    quizWrongFour = [[NSMutableArray alloc]init];
    questionClue = [[NSMutableArray alloc]init];
    tagFirst = [[NSMutableArray alloc]init];
    tagSecond = [[NSMutableArray alloc]init];
    questionSection = [[NSMutableArray alloc]init];
    imageList = [[NSMutableArray alloc]init];
    difficultyLevel = [[NSMutableArray alloc]init];
    currentlySelectedTerm = theSelection;
    
    int i = 0;
    
    for (NSString *questionsForSection in sharedData.sectionForQuestion) {
        
        if ([questionsForSection isEqualToString:currentlySelectedTerm]) {
            
            NSString *temp = [sharedData.quizQuestions objectAtIndex:i];
            NSString *temp2 = [sharedData.quizAnswers objectAtIndex:i];
            NSString *temp3 = [sharedData.wrongAnswerOne objectAtIndex:i];
            NSString *temp4 = [sharedData.wrongAnswerTwo objectAtIndex:i];
            NSString *temp5 = [sharedData.wrongAnswerThree objectAtIndex:i];
            NSString *temp7 = [sharedData.helperTips objectAtIndex:i];
            NSString *temp8 = [sharedData.difficultyForQuestion objectAtIndex:i];
            NSString *temp11 = [sharedData.sectionForQuestion objectAtIndex:i];
            NSString *temp12 = [sharedData.imageForQuestion objectAtIndex:i];
            
            [quizQuestions addObject:temp];
            [quizAnswers addObject:temp2];
            [quizWrongOne addObject:temp3];
            [quizWrongTwo addObject:temp4];
            [quizWrongThree addObject:temp5];
            [questionClue addObject:temp7];
            [questionSection addObject:temp11];
            [imageList addObject:temp12];
            [difficultyLevel addObject:temp8];
        }
        
        i++;
        
    }

    NSString *pListData = [[NSBundle mainBundle]
                           pathForResource:@"APUSQuiz"
                           ofType:@"plist"];
    
    questionData = [[NSMutableArray alloc] initWithContentsOfFile:pListData];
    
    for (NSDictionary *dic in questionData) {
        
        
            
        if ([[dic valueForKey:@"Time"]isEqualToString:currentlySelectedTerm]) {
            
            for (NSString *information in dic) {

                if ([information isEqualToString:@"Question"]) {
                
                    NSString *temp11 = [dic valueForKey:information];
                    [quizQuestions addObject:temp11];
                
                } else if ([information isEqualToString:@"Correct"]) {
                
                    NSString *temp12 = [dic valueForKey:information];
                    [quizAnswers addObject:temp12];
                
                } else if ([information isEqualToString:@"Answer1"]) {
                
                    [quizWrongOne addObject:[dic valueForKey:information]];
                
                } else if ([information isEqualToString:@"Answer2"]) {
                
                    [quizWrongTwo addObject:[dic valueForKey:information]];
                
                } else if ([information isEqualToString:@"Answer3"]) {
                
                    [quizWrongThree addObject:[dic valueForKey:information]];
                
                } else if ([information isEqualToString:@"helperTips"]) {
                
                    [questionClue addObject:[dic valueForKey:information]];
                
                } else if ([information isEqualToString:@"difficulty"]) {
                
                [difficultyLevel addObject:[dic valueForKey:information]];
                
                } else if ([information isEqualToString:@"Time"]) {
                
                    [questionSection addObject:[dic valueForKey:information]];
                
                } else if ([information isEqualToString:@"Image"]) {
                
                    [imageList addObject:[dic valueForKey:information]];

                }
            }
            i++;
        }
        
        
        
    }

    [self setupCorrectAndIncorrect];
    [self setupQuestionView];
    [self printNextQuestion];
}

-(void) nextQuestion {
    if(!alreadyAnswered) return;
    
    timerOn = TRUE;
    
    questionCounter++;
    alreadyAnswered = FALSE;
    _progressTimerNode2.alpha = 1.0;
    [renderLabel removeFromParent];
    
    [question removeFromParent];
    [answer1 removeFromParent];
    [answer2 removeFromParent];
    [answer3 removeFromParent];
    [answer4 removeFromParent];
    [renderLabel removeFromParent];
    [renderLabel2 removeFromParent];
    [renderLabel3 removeFromParent];
    [renderLabel4 removeFromParent];
    [renderLabel5 removeFromParent];

    [correctQuestionAnswer removeFromParent];
    [wrongQuestionAnswer removeFromParent];

    if (questionCounter+1 > [quizQuestions count]) {
        [self finishedWithSection];
        
    } else {
        [self printNextQuestion];
    }
    
}

-(void) setupCorrectAndIncorrect {
    
    int offsetCircle = 0;
    int totalQuestionsForRows = [quizQuestions count];
    int totalRows = (totalQuestionsForRows+1)/circlesPerRow;
    int incompleteRowCount = [quizQuestions count]%circlesPerRow;
    int totalSlots = [quizQuestions count]+incompleteRowCount;
    int yValue = 110;
    
   
    for (int rows = 0; rows < totalRows; rows++) {
        
        for (int i = 0; i < circlesPerRow; i++) {
            
            SKSpriteNode *blankCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle-2.png"];
            [self addChild:blankCircle];
            blankCircle.position = CGPointMake(100+offsetCircle, yValue);
            offsetCircle += 25;
            [scoreKeeperSprites addObject:blankCircle];
            totalSlots--;
            
            
        }
        
        yValue += 35;
        offsetCircle = 0;
        
    }
    
    for (int p = 0; p < totalSlots; totalSlots--) {
        
        SKSpriteNode *blankCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle-2.png"];
        [self addChild:blankCircle];
        blankCircle.position = CGPointMake(100+offsetCircle, yValue);
        offsetCircle += 25;
        [scoreKeeperSprites addObject:blankCircle];
        totalSlots--;
    }
    
    
}

-(void) setupQuestionView {
    
    //SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    //title.position = _pointForTitlePosition;
    //[self addChild:title];
    
    sameQuestion = FALSE;
    sameQuestion2 = FALSE;
    sameQuestion3 = FALSE;
    sameQuestion4 = FALSE;
    
}

-(void) printNextQuestion {
    
    if (questionCounter+1 > [quizQuestions count]) {

        [self finishedWithSection];
        
    } else {
        [self startTimer];
        [hudScore updateOtherInfo:[difficultyLevel objectAtIndex:questionCounter]
                     topicSection:[questionSection objectAtIndex:questionCounter]];
        
        NSString *degDiff = [difficultyLevel objectAtIndex:questionCounter];
        degreeOfDifficulty = [degDiff integerValue];
        amountOfTime = 0;
        timerOn = TRUE;

        
        correctAnswer = arc4random() % 4;
        
        NSString *firstAnswerPrint;
        NSString *secondAnswerPrint;
        NSString *thirdAnswerPrint;
        NSString *fourthAnswerPrint;
        
        if (correctAnswer == 0) {
            firstAnswerPrint = [quizAnswers objectAtIndex:questionCounter];
            secondAnswerPrint = [quizWrongOne objectAtIndex:questionCounter];
            thirdAnswerPrint = [quizWrongTwo objectAtIndex:questionCounter];
            fourthAnswerPrint = [quizWrongThree objectAtIndex:questionCounter];
            
        } else if (correctAnswer == 1) {
            firstAnswerPrint = [quizWrongOne objectAtIndex:questionCounter];
            secondAnswerPrint = [quizAnswers objectAtIndex:questionCounter];
            thirdAnswerPrint = [quizWrongTwo objectAtIndex:questionCounter];
            fourthAnswerPrint = [quizWrongThree objectAtIndex:questionCounter];
            
        } else if (correctAnswer == 2) {
            firstAnswerPrint = [quizWrongOne objectAtIndex:questionCounter];
            secondAnswerPrint = [quizWrongTwo objectAtIndex:questionCounter];
            thirdAnswerPrint = [quizAnswers objectAtIndex:questionCounter];
            fourthAnswerPrint = [quizWrongThree objectAtIndex:questionCounter];
            
        } else if (correctAnswer == 3) {
            firstAnswerPrint = [quizWrongOne objectAtIndex:questionCounter];
            secondAnswerPrint = [quizWrongTwo objectAtIndex:questionCounter];
            thirdAnswerPrint = [quizWrongThree objectAtIndex:questionCounter];
            fourthAnswerPrint = [quizAnswers objectAtIndex:questionCounter];
            
        }
        
        NSString *currentQuestion = [quizQuestions objectAtIndex:questionCounter];

        UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(150, 0, 350, 400)];
        firstLabel.text = currentQuestion;
        firstLabel.textColor = [UIColor blackColor];
        firstLabel.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel.numberOfLines = 4;
        firstLabel.preferredMaxLayoutWidth = 350;
        UIImage *imageToRender = [self makeImageFromLabel:firstLabel];
        SKTexture *labelTexture = [SKTexture textureWithImage:imageToRender];
        renderLabel = [SKSpriteNode spriteNodeWithTexture:labelTexture];
        renderLabel.position = CGPointMake(400,960);
        renderLabel.scale = 1.8;
        [self addChild:renderLabel];
        
        
        NSString *currentQuestionA1 = firstAnswerPrint;
        UILabel *firstLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350, 200)];
        firstLabel2.text = currentQuestionA1;
        firstLabel2.textColor = [UIColor blackColor];
        firstLabel2.font = [UIFont fontWithName:@"Carton-Slab" size:12.0];
        firstLabel2.numberOfLines = 4;
        firstLabel2.preferredMaxLayoutWidth = 300;
        UIImage *imageToRender2 = [self makeImageFromLabel:firstLabel2];
        SKTexture *labelTexture2 = [SKTexture textureWithImage:imageToRender2];
        renderLabel2 = [SKSpriteNode spriteNodeWithTexture:labelTexture2];
        renderLabel2.position = CGPointMake(0,0);
        renderLabel2.scale = 1.7;

        NSString *currentQuestionA2 = secondAnswerPrint;
        UILabel *firstLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350, 200)];
        firstLabel3.text = currentQuestionA2;
        firstLabel3.textColor = [UIColor blackColor];
        firstLabel3.font = [UIFont fontWithName:@"Carton-Slab" size:48.0];
        firstLabel3.numberOfLines = 4;
        firstLabel3.preferredMaxLayoutWidth = 300;
        UIImage *imageToRender3 = [self makeImageFromLabel:firstLabel3];
        SKTexture *labelTexture3 = [SKTexture textureWithImage:imageToRender3];
        renderLabel3 = [SKSpriteNode spriteNodeWithTexture:labelTexture3];
        renderLabel3.position = CGPointMake(0,0);
        renderLabel3.scale = 1.7;
        
        NSString *currentQuestionA3 = thirdAnswerPrint;
        UILabel *firstLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350, 200)];
        firstLabel4.text = currentQuestionA3;
        firstLabel4.textColor = [UIColor blackColor];
        firstLabel4.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel4.numberOfLines = 4;
        firstLabel4.preferredMaxLayoutWidth = 300;
        UIImage *imageToRender4 = [self makeImageFromLabel:firstLabel4];
        SKTexture *labelTexture4 = [SKTexture textureWithImage:imageToRender4];
        renderLabel4 = [SKSpriteNode spriteNodeWithTexture:labelTexture4];
        renderLabel4.position = CGPointMake(0,0);
        renderLabel4.scale = 1.7;
        
        NSString *currentQuestionA4 = fourthAnswerPrint;
        UILabel *firstLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 350, 200)];
        firstLabel5.text = currentQuestionA4;
        firstLabel5.textColor = [UIColor blackColor];
        firstLabel5.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel5.numberOfLines = 4;
        firstLabel5.preferredMaxLayoutWidth = 300;
        UIImage *imageToRender5 = [self makeImageFromLabel:firstLabel5];
        SKTexture *labelTexture5 = [SKTexture textureWithImage:imageToRender5];
        renderLabel5 = [SKSpriteNode spriteNodeWithTexture:labelTexture5];
        renderLabel5.position = CGPointMake(0,0);
        renderLabel5.scale = 1.7;
        
        
        
        SKAction *moveButtonOn = [SKAction moveByX:-1000 y:0 duration:0.5];
        [button1 runAction:moveButtonOn];
        [button2 runAction:moveButtonOn];
        [button3 runAction:moveButtonOn];
        [button4 runAction:moveButtonOn];
        
        renderLabel2.position = CGPointMake(430, 700);
        renderLabel3.position = CGPointMake(430, 545);
        renderLabel4.position = CGPointMake(430, 390);
        renderLabel5.position = CGPointMake(430, 235);
        
        [self addChild:renderLabel2];
        [self addChild:renderLabel3];
        [self addChild:renderLabel4];
        [self addChild:renderLabel5];
        

        NSString *imageName = [NSString stringWithFormat:[imageList objectAtIndex:questionCounter]];
        
        if([imageName isEqualToString:@"0"]) {
            
            return;
            
        } else {
            
            imageForQuestion = [SKSpriteNode spriteNodeWithImageNamed:@"background-with-title-2"];
            SKSpriteNode *sourceImage = [SKSpriteNode spriteNodeWithImageNamed:imageName];

            imageForQuestion.position = CGPointMake(300,-600);
            sourceImage.position = CGPointMake(0, 0);
            [imageForQuestion addChild:sourceImage];
            
            [self addChild:imageForQuestion];
            
            SKAction *moveImage = [SKAction moveToY:600 duration:0.2];
            [imageForQuestion runAction:moveImage];
            imageForQuestion.userInteractionEnabled = YES;
            removeImage = TRUE;
            
        }
    }
    
}

- (UIImage *)makeImageFromLabel: (UILabel *)labelToConvert {

    CGRect labelBound = [labelToConvert bounds];
    UIGraphicsBeginImageContext(labelBound.size);
    [[labelToConvert layer]renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *convertedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return convertedImage;
    
}

-(void) finishedWithSection {
    
    timerOn = NO;
    [totalTimeDisplay removeFromParent];
    [_progressTimerNode2 removeFromParent];
    
    CGFloat percentage = (float)numberCorrectAnswers / (float)questionCounter * 100.0f;
    int percentageConv = round(percentage);
    
    ReviewQuestion *reviewPage = [[ReviewQuestion alloc]init];
    reviewPage.position = CGPointMake(0, 0);
    [reviewPage updateScoreWindow:[NSNumber numberWithInt:totalWeightedScore]
                           totalQ:[NSNumber numberWithInt:questionCounter]
                       percentage:[NSNumber numberWithInt:percentageConv]
                          totTime:[NSNumber numberWithInt:totalTimeTrack]
                       correctAns:[NSNumber numberWithInt:numberCorrectAnswers]];
    
    [self addChild:reviewPage];
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    
    if (timerOn) {
        CGFloat secondsElapsed = currentTime - self.startTime;
        int timerTotal = round(secondsElapsed);
        amountOfTime = timerTotal;
        [totalTimeDisplay removeFromParent];
        totalTimeDisplay = [SKLabelNode labelNodeWithFontNamed:@"JED"];
        totalTimeDisplay.fontColor = [UIColor blackColor];
        totalTimeDisplay.fontSize = 32;
        totalTimeDisplay.text = [NSString stringWithFormat:@"%i",timerTotal];
        totalTimeDisplay.position = CGPointMake(720, 50);
        [self addChild:totalTimeDisplay];
        
        CGFloat cycle = secondsElapsed * kCyclesPerSecond;
        CGFloat progress = cycle - (NSInteger)cycle;
        [self.progressTimerNode2 setProgress:progress];
    }
}

-(void)checkAnswer:(NSNumber*) index {

    timerOn = FALSE;
    totalTimeTrack += amountOfTime;
    _progressTimerNode2.alpha = 0.0;
    [totalTimeDisplay removeFromParent];
    
    [hudScore moveBackOnScreen];
    SKAction *moveButtonOff = [SKAction moveByX:1000 y:0 duration:0.5];

    [button1 runAction:moveButtonOff];
    [button2 runAction:moveButtonOff];
    [button3 runAction:moveButtonOff];
    [button4 runAction:moveButtonOff];
    if(alreadyAnswered == TRUE) return;
    //[timerBar stopAllActions];
    timerOn = false;
    int theIndex = [index intValue];
    int determineRow = questionCounter/circlesPerRow;
    
    if (questionCounter%circlesPerRow == 0) {
        offsetStar = 0;
    }
    
    if (determineRow == 0 && questionCounter > 0) {
        currentRow = 0;
    } else if (determineRow == 1 && currentRow == 0) {
        currentRow = 1;
        rowStar += 50;
    } else if (determineRow == 2 && currentRow == 1) {
        currentRow = 2;
        rowStar += 50;
    } else if (determineRow == 3 && currentRow == 2) {
        currentRow = 3;
        rowStar += 50;
    }
    
    
    if (correctAnswer == theIndex) {
        
        alreadyAnswered = TRUE;
        
        correctQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"correct-button-overlay.png"];
        correctQuestionAnswer.alpha = 0.3;
        
        wrongQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"wrong-box.png"];
        
        
        /****************************SCORING UPDATE***************************************/
        
        // Update the scoring
        amountOfTime = (100-amountOfTime)/2;
        scoreOnQuestion = scoreFactor * amountOfTime;
        scoreOnQuestion = scoreOnQuestion * degreeOfDifficulty;
        
        totalWeightedScore += scoreOnQuestion;
        [hudScore updateScore:[NSNumber numberWithInt:totalWeightedScore]];
        numberCorrectAnswers++;
        /*****************************************************************************/
       
        
        SKSpriteNode *circleToPop = [scoreKeeperSprites objectAtIndex:questionCounter];

        SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"gold-star.png"];
        star.position = CGPointMake(circleToPop.position.x,circleToPop.position.y-100);
        SKAction *bigStar = [SKAction scaleTo:3.0 duration:0.4];
        SKAction *smallStar = [SKAction scaleTo:1.0 duration:0.3];
        SKAction *moveToPosition = [SKAction moveTo:circleToPop.position duration:0.2];
        SKAction *correctSteps = [SKAction runBlock:^{
            SKAction *scaleUp = [SKAction scaleTo:2.0 duration:2.0];
            SKAction *scaleDown = [SKAction scaleTo:1.0 duration:2.0];
            SKAction *sequenceUpDown = [SKAction sequence:@[scaleUp, scaleDown]];
            NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
            SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
            [circleToPop addChild:openEffect];
            [circleToPop runAction:sequenceUpDown];
        }];
        [circleToPop runAction:correctSteps];
        
        SKAction *bigSmall = [SKAction sequence:@[bigStar,smallStar]];
        
        [star runAction:bigSmall];
        [star runAction:moveToPosition];
        [self addChild:star];
        [allStar addObject:star];
        
        offsetStar += 75;
        
        NSMutableArray *answerArchive = [[NSMutableArray alloc]init];

        if (theIndex == 0) {
            
            correctQuestionAnswer.position = button1.position;
            wrongQuestionAnswer.position = button1.position;
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
            
        } else if (theIndex == 1) {

            correctQuestionAnswer.position = button2.position;
            wrongQuestionAnswer.position = button2.position;
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 2) {

            correctQuestionAnswer.position = button3.position;
            wrongQuestionAnswer.position = button3.position;
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 3) {

            correctQuestionAnswer.position = button4.position;
            wrongQuestionAnswer.position = button4.position;
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        }
        
        [self addChild:correctQuestionAnswer];

    } else {  // Incorrect Answer
        
        alreadyAnswered = TRUE;
        SKSpriteNode *circleToPop = [scoreKeeperSprites objectAtIndex:questionCounter];
        SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"Incorrect-iphone.png"];
        star.position = CGPointMake(circleToPop.position.x,circleToPop.position.y-100);
        SKAction *bigStar = [SKAction scaleTo:3.0 duration:0.4];
        SKAction *smallStar = [SKAction scaleTo:0.7 duration:0.3];
        SKAction *moveToPosition = [SKAction moveTo:circleToPop.position duration:0.2];
        SKAction *correctSteps = [SKAction runBlock:^{
            SKAction *scaleUp = [SKAction scaleTo:2.0 duration:2.0];
            SKAction *scaleDown = [SKAction scaleTo:0.7 duration:2.0];
            SKAction *sequenceUpDown = [SKAction sequence:@[scaleUp, scaleDown]];
            NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"CirclePop" ofType:@"sks"];
            SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
            [circleToPop addChild:openEffect];
            [circleToPop runAction:sequenceUpDown];
        }];
        [circleToPop runAction:correctSteps];
        
        SKAction *bigSmall = [SKAction sequence:@[bigStar,smallStar]];
        
        [star runAction:bigSmall];
        [star runAction:moveToPosition];
        [self addChild:star];
        [allXimg addObject:star];
        
        wrongQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"wrong-box.png"];
        wrongQuestionAnswer.alpha = 0.6;
        correctQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"correct-button-overlay.png"];
        correctQuestionAnswer.alpha = 0.6;
        
        NSMutableArray *answerArchive = [[NSMutableArray alloc]init];
        
        if (theIndex == 0) {
            wrongQuestionAnswer.position = button1.position;
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 1) {
            wrongQuestionAnswer.position = button2.position;
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 2) {
            wrongQuestionAnswer.position = button3.position;
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            //[reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 3) {
            wrongQuestionAnswer.position = button4.position;
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            //[reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
        }

        if (correctAnswer == 0) {
            SKAction *moveOverlay = [SKAction moveTo:button1.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button1.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 1) {
            SKAction *moveOverlay = [SKAction moveTo:button2.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button2.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 2) {
            SKAction *moveOverlay = [SKAction moveTo:button3.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button3.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 3) {
            SKAction *moveOverlay = [SKAction moveTo:button4.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button4.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 4) {
        }
        
        [self addChild:wrongQuestionAnswer];
        [self addChild:correctQuestionAnswer];
        
        offsetStar += 12;

    }
    
}

-(void) chooseAnswer1: (id)sender {
    [self checkAnswer:[NSNumber numberWithInt:0]];
}

-(void) chooseAnswer2: (id)sender{
    [self checkAnswer:[NSNumber numberWithInt:1]];
}

-(void) chooseAnswer3: (id)sender {
    [self checkAnswer:[NSNumber numberWithInt:2]];
}

-(void) chooseAnswer4: (id)sender {
    [self checkAnswer:[NSNumber numberWithInt:3]];
}

-(void) addBackButton {
    
    
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    /* Called when a touch begins */
    UITouch *touch = [touches anyObject];
    CGPoint location = [touch locationInNode:self];
    
    if (CGRectContainsPoint(button1.frame, location)) {
        [self checkAnswer:[NSNumber numberWithInt:0]];
    } else if (CGRectContainsPoint(button2.frame, location)) {
        [self checkAnswer:[NSNumber numberWithInt:1]];
    } else if (CGRectContainsPoint(button3.frame, location)) {
        [self checkAnswer:[NSNumber numberWithInt:2]];
    } else if (CGRectContainsPoint(button4.frame, location)) {
        [self checkAnswer:[NSNumber numberWithInt:3]];
    }
    
    
    if (CGRectContainsPoint(forward.frame, location)) {
        
        [self nextQuestion];
        
    } else if (CGRectContainsPoint(backToMainMenuArrow.frame,location)) {
        
        WorldHistoryMainMenu *worldHistory = [[WorldHistoryMainMenu alloc]initWithSize:CGSizeMake(768, 1024)];
        SKView *spriteView = (SKView *)self.view;
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:2.0];
        [spriteView presentScene:worldHistory transition:reveal];
        return;
        
    } else if (CGRectContainsPoint(helpButton.frame, location)) {
        
        explainView = [[ExplanationViewer alloc]init];
        [explainView setSize:self.size];
        explainView.position = CGPointMake(0,0);
        SKAction *moveToCenter = [SKAction moveTo:CGPointMake(20, 20) duration:0.3];
        [explainView runAction:moveToCenter];
        [self addChild:explainView];
        
        UILabel *helperLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 300)];
        helperLabel.text = [questionClue objectAtIndex:questionCounter];
        helperLabel.textColor = [UIColor blackColor];
        helperLabel.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        helperLabel.numberOfLines = 4;
        helperLabel.preferredMaxLayoutWidth = 270;
        UIImage *imageToRender = [self makeImageFromLabel:helperLabel];
        SKTexture *labelTexture = [SKTexture textureWithImage:imageToRender];
        SKSpriteNode *renderLabelExplain = [SKSpriteNode spriteNodeWithTexture:labelTexture];
        renderLabelExplain.position = CGPointMake(350,550);
        renderLabelExplain.scale = 1.4;
        [explainView addChild:renderLabelExplain];
        
    } else if (CGRectContainsPoint(explanationIcon.frame, location)) {
        
        explainView = [[ExplanationViewer alloc]init];
        [explainView setSize:self.size];
        explainView.position = CGPointMake(0,0);
        SKAction *moveToCenter = [SKAction moveTo:CGPointMake(20, 20) duration:0.3];
        [explainView runAction:moveToCenter];
        [self addChild:explainView];
        
    } else if (CGRectContainsPoint(imageForQuestion.frame, location)) {
        
        [imageForQuestion removeFromParent];
        self.userInteractionEnabled = YES;
    }
    
    //}
}


@end
