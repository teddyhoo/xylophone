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

#define kCyclesPerSecond 0.5f

@implementation Quizzer

@synthesize answerButton1, answerButton2, answerButton3, answerButton4;
@synthesize quizQuestions, quizAnswers, quizWrongOne, quizWrongTwo, quizWrongThree, quizWrongFour,
questionClue, questionSection, tagFirst, tagSecond, difficultyLevel, imageList, forward, goForward;
@synthesize currentlySelectedTerm;

HistoryData *sharedData;
TopicPicker *pickTopic;
QuizzerTracker *hudScore;
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
int circlesPerRow = 12;
int currentRow = 1;
int questionTextWidth;
CGPoint _score_pos;
CGPoint _scoreActual_pos;
CGPoint _totalTime_pos;
CGPoint _totalScore_pos; // Label: Tot Quest:
CGPoint _questionCategory_pos;
CGPoint _totalQuestionsComplete_pos;
CGPoint _totalScoreNow_pos;
CGPoint _totalTime_pos;
CGPoint _total_Actual_Time;
CGPoint _setOfAnswers;
CGPoint _totalScoreCounter;
CGPoint _pointForTitlePosition;
CGPoint _timerCounterPos;
CGPoint _explanation_pos;
CGPoint answerPosition;
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

        _progressTimerNode2 = [[TCProgressTimerNode alloc] initWithForegroundImageNamed:@"progress_foreground"
                    backgroundImageNamed:@"progress_background"
                    accessoryImageNamed:nil];
        
        _progressTimerNode2.position = CGPointMake(600,900);
        [self addChild:_progressTimerNode2];
        [_progressTimerNode2 setProgress:0.5f];
        self.startTime = CACurrentMediaTime();
        
        winSize = CGSizeMake(680, 1250);
        answerPosition = CGPointMake(450, 700);
        _totalTime_pos = CGPointMake(300, 200); // Total Time Count Label
        _total_Actual_Time = CGPointMake(400, 200); // Total Time Counter
        _totalScore_pos = CGPointMake(300, 300); // % Label
        _totalScoreNow_pos = CGPointMake(400, 300); // % value
        _timerCounterPos = CGPointMake(300, 400);
        _explanation_pos = CGPointMake(400, 400);

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
        background.position = CGPointMake(500,500);
        [self addChild:background];
        
        hudScore = [[QuizzerTracker alloc]init];
        [hudScore setSize:size];
        hudScore.position = CGPointMake(0,0);
        [self addChild:hudScore];
        
        forward = [SKSpriteNode spriteNodeWithImageNamed:@"next-button.png"];
        forward.scale = 0.5;
        forward.position = CGPointMake(700, 50);
        [self addChild:forward];
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"home-3.png"];
        backToMainMenuArrow.position = CGPointMake(80, 50);
        backToMainMenuArrow.scale = 0.5;
        [self addChild:backToMainMenuArrow];
        
        explanationIcon = [SKSpriteNode spriteNodeWithImageNamed:@"information.png"];
        explanationIcon.position = CGPointMake(270, 50);
        explanationIcon.scale = 0.5;
        [self addChild:explanationIcon];
        
        helpButton = [SKSpriteNode spriteNodeWithImageNamed:@"question-icon.png"];
        helpButton.position = CGPointMake(500, 50);
        helpButton.scale = 0.5;
        [self addChild:helpButton];
        
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
    
    
    [self setupCorrectAndIncorrect];
    [self setupQuestionView];
    [self printNextQuestion];
}

-(void) nextQuestion {
    if(!alreadyAnswered) return;
    
    questionCounter++;
    alreadyAnswered = FALSE;
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
    //if (incompleteRowCount == 0)
    //    totalRows--;
    int totalSlots = [quizQuestions count]+incompleteRowCount;
    int yValue = 120;
    
   
    for (int rows = 0; rows < totalRows; rows++) {
        
        for (int i = 0; i < circlesPerRow; i++) {
            
            SKSpriteNode *blankCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
            [self addChild:blankCircle];
            blankCircle.position = CGPointMake(100+offsetCircle, yValue);
            offsetCircle += 45;
            [scoreKeeperSprites addObject:blankCircle];
            totalSlots--;
            
            
        }
        
        yValue += 35;
        offsetCircle = 0;
        
    }
    
    for (int p = 0; p < totalSlots; totalSlots--) {
        
        SKSpriteNode *blankCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
        [self addChild:blankCircle];
        blankCircle.position = CGPointMake(100+offsetCircle, yValue);
        offsetCircle += 45;
        [scoreKeeperSprites addObject:blankCircle];
        totalSlots--;
    }
    
    
}

-(void) setupQuestionView {
    
    SKLabelNode *title = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    title.position = _pointForTitlePosition;
    [self addChild:title];
    
    sameQuestion = FALSE;
    sameQuestion2 = FALSE;
    sameQuestion3 = FALSE;
    sameQuestion4 = FALSE;
    
}

-(void) printNextQuestion {
    
    if (questionCounter+1 > [quizQuestions count]) {

        [self finishedWithSection];
        
    } else {
        
        [hudScore updateOtherInfo:[difficultyLevel objectAtIndex:questionCounter]
                     topicSection:[questionSection objectAtIndex:questionCounter]];
        
        NSString *degDiff = [difficultyLevel objectAtIndex:questionCounter];
        degreeOfDifficulty = [degDiff integerValue];
        NSLog(@"returned degree of difficulty: %i",degreeOfDifficulty);
        
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
            
        } //else if (correctAnswer == 4) {
        //    firstAnswerPrint = [quizWrongOne objectAtIndex:questionCounter];
        //    secondAnswerPrint = [quizWrongTwo objectAtIndex:questionCounter];
        //    thirdAnswerPrint = [quizWrongThree objectAtIndex:questionCounter];
        //    fourthAnswerPrint = [quizWrongFour objectAtIndex:questionCounter];
        //}
        
        NSString *currentQuestion = [quizQuestions objectAtIndex:questionCounter];
        
        UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 600)];
        firstLabel.text = currentQuestion;
        firstLabel.textColor = [UIColor blackColor];
        firstLabel.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel.numberOfLines = 4;
        firstLabel.preferredMaxLayoutWidth = 400;
        UIImage *imageToRender = [self makeImageFromLabel:firstLabel];
        SKTexture *labelTexture = [SKTexture textureWithImage:imageToRender];
        renderLabel = [SKSpriteNode spriteNodeWithTexture:labelTexture];
        renderLabel.position = CGPointMake(400,900);
        renderLabel.scale = 1.6;
        [self addChild:renderLabel];
        
        
        NSString *currentQuestionA1 = firstAnswerPrint;
        UILabel *firstLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        firstLabel2.text = currentQuestionA1;
        firstLabel2.textColor = [UIColor whiteColor];
        firstLabel2.font = [UIFont fontWithName:@"Carton-Slab" size:12.0];
        firstLabel2.numberOfLines = 4;
        firstLabel2.preferredMaxLayoutWidth = 400;
        UIImage *imageToRender2 = [self makeImageFromLabel:firstLabel2];
        SKTexture *labelTexture2 = [SKTexture textureWithImage:imageToRender2];
        renderLabel2 = [SKSpriteNode spriteNodeWithTexture:labelTexture2];
        renderLabel2.position = CGPointMake(5,0);
        renderLabel2.scale = 1.5;
        

        
        NSString *currentQuestionA2 = secondAnswerPrint;
        UILabel *firstLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        firstLabel3.text = currentQuestionA2;
        firstLabel3.textColor = [UIColor whiteColor];
        firstLabel3.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel3.numberOfLines = 4;
        firstLabel3.preferredMaxLayoutWidth = 400;
        UIImage *imageToRender3 = [self makeImageFromLabel:firstLabel3];
        SKTexture *labelTexture3 = [SKTexture textureWithImage:imageToRender3];
        renderLabel3 = [SKSpriteNode spriteNodeWithTexture:labelTexture3];
        renderLabel3.position = CGPointMake(5,0);
        renderLabel3.scale = 1.5;
        
        NSString *currentQuestionA3 = thirdAnswerPrint;
        UILabel *firstLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        firstLabel4.text = currentQuestionA3;
        firstLabel4.textColor = [UIColor whiteColor];
        firstLabel4.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel4.numberOfLines = 4;
        firstLabel4.preferredMaxLayoutWidth = 400;
        UIImage *imageToRender4 = [self makeImageFromLabel:firstLabel4];
        SKTexture *labelTexture4 = [SKTexture textureWithImage:imageToRender4];
        renderLabel4 = [SKSpriteNode spriteNodeWithTexture:labelTexture4];
        renderLabel4.position = CGPointMake(5,0);
        renderLabel4.scale = 1.5;
        
        NSString *currentQuestionA4 = fourthAnswerPrint;
        UILabel *firstLabel5 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 400, 200)];
        firstLabel5.text = currentQuestionA4;
        firstLabel5.textColor = [UIColor whiteColor];
        firstLabel5.font = [UIFont fontWithName:@"Carton-Slab" size:24.0];
        firstLabel5.numberOfLines = 4;
        firstLabel5.preferredMaxLayoutWidth = 400;
        UIImage *imageToRender5 = [self makeImageFromLabel:firstLabel5];
        SKTexture *labelTexture5 = [SKTexture textureWithImage:imageToRender5];
        renderLabel5 = [SKSpriteNode spriteNodeWithTexture:labelTexture5];
        renderLabel5.position = CGPointMake(5,0);
        renderLabel5.scale = 1.5;
        
        button1 = [SKSpriteNode spriteNodeWithImageNamed:@"button-blue-2.png"];
        button2 = [SKSpriteNode spriteNodeWithImageNamed:@"button-blue-2.png"];
        button3 = [SKSpriteNode spriteNodeWithImageNamed:@"button-blue-2.png"];
        button4 = [SKSpriteNode spriteNodeWithImageNamed:@"button-blue-2.png"];
        
        [button1 addChild:renderLabel2];
        button1.position = CGPointMake(400, 750);
        [self addChild:button1];
        
        [button2 addChild:renderLabel3];
        button2.position = CGPointMake(400, 595);
        [self addChild:button2];
        
        [button3 addChild:renderLabel4];
        button3.position = CGPointMake(400, 440);
        [self addChild:button3];
        
        [button4 addChild:renderLabel5];
        button4.position = CGPointMake(400, 285);
        [self addChild:button4];
        
        
        
        NSString *imageName = [NSString stringWithFormat:[imageList objectAtIndex:questionCounter]];
        
        if([imageName isEqualToString:@"0"]) {
            
            return;
            
        } else {
            
            imageForQuestion = [SKSpriteNode spriteNodeWithImageNamed:imageName];
            imageForQuestion.position = CGPointMake(280,-300);
            [self addChild:imageForQuestion];
            
            SKAction *moveImage = [SKAction moveToY:500 duration:0.2];
            [imageForQuestion runAction:moveImage];
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
    
    int totalIncorrect = questionCounter - numberCorrectAnswers;
    
    ReviewQuestion *reviewPage = [[ReviewQuestion alloc]init];
    reviewPage.position = CGPointMake(0, 0);
    [self addChild:reviewPage];
}

-(void)update:(NSTimeInterval)currentTime {
    [super update:currentTime];
    CGFloat secondsElapsed = currentTime - self.startTime;
    CGFloat cycle = secondsElapsed * kCyclesPerSecond;
    CGFloat progress = cycle - (NSInteger)cycle;
    [self.progressTimerNode2 setProgress:progress];
}

-(void)checkAnswer:(NSNumber*) index {

    [hudScore moveBackOnScreen];
    
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
        
        /*****************************************************************************/
        [hudScore updateScore:[NSNumber numberWithInt:totalWeightedScore]];
        numberCorrectAnswers++;
        
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

        [self addChild:wrongQuestionAnswer];
        [self addChild:correctQuestionAnswer];

    } else {  // Incorrect Answer
        
        alreadyAnswered = TRUE;
        SKSpriteNode *circleToPop = [scoreKeeperSprites objectAtIndex:questionCounter];
        SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"Incorrect-iphone.png"];
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
            //correctQuestionAnswer.position = button2.position;
            SKAction *moveOverlay = [SKAction moveTo:button2.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button2.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 2) {
            //correctQuestionAnswer.position = button3.position;
            SKAction *moveOverlay = [SKAction moveTo:button3.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button3.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 3) {
            //correctQuestionAnswer.position = button4.position;
            SKAction *moveOverlay = [SKAction moveTo:button4.position duration:1.0];
            correctQuestionAnswer.position = CGPointMake(-800, button4.position.y);
            [correctQuestionAnswer runAction:moveOverlay];
        } else if (correctAnswer == 4) {
            //correctQuestionAnswer.position = button4.position;
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
        
        
    } else if (CGRectContainsPoint(explanationIcon.frame, location)) {
        
    }
    
    //}
}


@end
