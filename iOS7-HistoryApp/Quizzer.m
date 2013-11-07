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

@implementation Quizzer

@synthesize answerButton1, answerButton2, answerButton3, answerButton4;
@synthesize quizQuestions, quizAnswers, quizWrongOne, quizWrongTwo, quizWrongThree, quizWrongFour, questionClue, questionSection, tagFirst, tagSecond, difficultyLevel, imageList, forward, goForward;
@synthesize currentlySelectedTerm;

SKLabelNode *scoreActual;
SKLabelNode *score;
SKLabelNode *totalTime;
SKLabelNode *questionCategory;
SKLabelNode *correctQuestions;
SKLabelNode *totalScore;
SKLabelNode *explanationText; // from xml
SKLabelNode *explanationTextForQuestion;
SKLabelNode *questionExplanation;
SKLabelNode *categoryName; // from xml
SKLabelNode *numberOfCorrect;
SKLabelNode *totalScoreNow; //auto-calculated
SKLabelNode *totalQuestionsComplete; // dynamic
SKLabelNode *classifyQuestionCategory; // from xml
SKLabelNode *totalTimeDisplay; // dynamic


SKSpriteNode *correctQuestionAnswer;
SKSpriteNode *wrongQuestionAnswer;
SKSpriteNode *birdie;
SKSpriteNode *timerOutline;
SKSpriteNode *imageForQuestion;
SKSpriteNode *firstAnswer;
SKSpriteNode *secondAnswer;
SKSpriteNode *thirdAnswer;
SKSpriteNode *fourthAnswer;
SKSpriteNode *background;
SKSpriteNode *scoreBackground;
SKSpriteNode *explanationIcon;
SKSpriteNode *explanationButton;
SKSpriteNode *backToMainMenuArrow;
SKSpriteNode *renderLabel;
SKSpriteNode *renderLabel2;
SKSpriteNode *renderLabel3;
SKSpriteNode *renderLabel4;
SKSpriteNode *renderLabel5;


HistoryData *sharedData;
TopicPicker *pickTopic;

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

int questionTextWidth;

CGPoint _score_pos;
CGPoint _scoreActual_pos;
CGPoint _totalTime_pos;
CGPoint _totalScore_pos; // Label: Tot Quest:
CGPoint _birdie_pos;
CGPoint _questionCategory_pos;
CGPoint _totalQuestionsComplete_pos;
CGPoint _totalScoreNow_pos;
CGPoint _totalTime_pos;
CGPoint _total_Actual_Time;
CGPoint _setOfAnswers;
CGPoint _totalScoreCounter;
CGPoint answerRelativeToButton;
CGPoint _pointForTitlePosition;
CGPoint _timerCounterPos;
CGPoint _explanation_pos;
CGPoint answerPosition;

CGSize winSize;


- (id)initWithSize:(CGSize)size
{
    self = [super initWithSize:size];
    if (self) {
        
        winSize = CGSizeMake(680, 1150);
        
        answerPosition = CGPointMake(450, 700);
        
        _score_pos = CGPointMake(200, 100); // POINTS label
        _totalScoreCounter = CGPointMake(300, 100); // Aggregated score number
        
        _totalTime_pos = CGPointMake(300, 200); // Total Time Count Label
        _total_Actual_Time = CGPointMake(400, 200); // Total Time Counter
        
        _totalScore_pos = CGPointMake(300, 300); // % Label
        _totalScoreNow_pos = CGPointMake(400, 300); // % value
        
        _timerCounterPos = CGPointMake(300, 400);
        
        _explanation_pos = CGPointMake(400, 400);
        
        
        
        //************OFF**************
        //_totalQuestionsComplete_pos = ccp(winSize.width/2.8,winSize.height/8.0); // Questions #
        //_scoreActual_pos = ccp(winSize.width/1.5, winSize.height/8.0); // OFF
        
        //*****************************
        
        [self setUserInteractionEnabled:YES];
        
        _setOfAnswers = CGPointMake(100,900);
        _pointForTitlePosition = CGPointMake(400, 700);
        
        questionTextWidth = 220;
        answerRelativeToButton = CGPointMake(30,20);
        
        //
        // ***************************************************************
        //
        
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
        
        
        SKSpriteNode *background = [SKSpriteNode spriteNodeWithImageNamed:@"old-image-background.jpg"];
        background.position = CGPointMake(-200,600);
        [self addChild:background];
        
        forward = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-right.png"];
        forward.position = CGPointMake(700, 24);
        [self addChild:forward];
        
        backToMainMenuArrow = [SKSpriteNode spriteNodeWithImageNamed:@"arrow-left.png"];
        backToMainMenuArrow.position = CGPointMake(50, 50);
        [self addChild:backToMainMenuArrow];
        
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
    [firstAnswer removeFromParent];
    [secondAnswer removeFromParent];
    [thirdAnswer removeFromParent];
    [fourthAnswer removeFromParent];
    [correctQuestionAnswer removeFromParent];
    [wrongQuestionAnswer removeFromParent];

    if (questionCounter+1 > [quizQuestions count]) {
        
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
    int yValue = 30;
    
   
    for (int rows = 0; rows < totalRows; rows++) {
        
        for (int i = 0; i < circlesPerRow; i++) {
            
            SKSpriteNode *blankCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
            [self addChild:blankCircle];
            blankCircle.position = CGPointMake(60+offsetCircle, yValue);
            offsetCircle += 25;
            [scoreKeeperSprites addObject:blankCircle];
            totalSlots--;
            
            
        }
        
        yValue += 15;
        offsetCircle = 0;
        
    }
    
    for (int p = 0; p < totalSlots; totalSlots--) {
        
        SKSpriteNode *blankCircle = [SKSpriteNode spriteNodeWithImageNamed:@"circle.png"];
        [self addChild:blankCircle];
        blankCircle.position = CGPointMake(60+offsetCircle, yValue);
        offsetCircle += 25;
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
        
        // We are at the end
        
        // Disable the next button
        
        
        
    } else {
        
        
        amountOfTime = 0;
        timerOn = TRUE;
        [self updateScoreSection];
        
        firstAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"quiz-button-torquoise.png"];
        secondAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Answer-button-ipadhd.png"];
        thirdAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Answer-button-ipadhd.png"];
        fourthAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Answer-button-ipadhd.png"];
        
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
        UILabel *firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 0, 600, 300)];
        firstLabel.text = currentQuestion;
        firstLabel.textColor = [UIColor blackColor];
        firstLabel.font = [UIFont fontWithName:@"Carton-Slab" size:20.0];
        firstLabel.numberOfLines = 5;
        firstLabel.preferredMaxLayoutWidth = 600;
        UIImage *imageToRender = [self makeImageFromLabel:firstLabel];
        SKTexture *labelTexture = [SKTexture textureWithImage:imageToRender];
        renderLabel = [SKSpriteNode spriteNodeWithTexture:labelTexture];
        renderLabel.position = CGPointMake(300,900);
        [self addChild:renderLabel];
        
        question = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        question.text = currentQuestion;
        question.fontColor = [UIColor blackColor];
        question.fontSize = 20;
        question.position = CGPointMake(answerPosition.x, answerPosition.y + 140);
        question.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        question.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        //[self addChild:question];
        
        
        
        NSString *answer1 = [quizAnswers objectAtIndex:questionCounter];
        UILabel *secondLabel = [[UILabel alloc]initWithFrame:CGRectMake(200, 0, 400, 300)];
        secondLabel.text = currentQuestion;
        secondLabel.textColor = [UIColor blackColor];
        secondLabel.font = [UIFont fontWithName:@"Carton-Slab" size:20.0];
        secondLabel.numberOfLines = 5;
        secondLabel.preferredMaxLayoutWidth = 400;

        UIImage *answer1Render = [self makeImageFromLabel:secondLabel];
        SKTexture *labelTexture2 = [SKTexture textureWithImage:answer1Render];
        renderLabel2 = [SKSpriteNode spriteNodeWithTexture:labelTexture2];
        renderLabel2.position = CGPointMake(300, 700);
        //[self addChild:renderLabel2];
        
        /*answer1 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        answer1.text = firstAnswerPrint;
        answer1.fontSize = 20;
        answer1.fontColor = [UIColor blackColor];
        answer1.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        answer1.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
           */
                   
        answer2 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        answer2.text = secondAnswerPrint;
        answer2.fontColor = [UIColor blackColor];
        answer2.fontSize = 20;
        answer2.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        answer2.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        answer3 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        answer3.text = thirdAnswerPrint;
        answer3.fontColor = [UIColor blackColor];
        answer3.fontSize = 20;
        answer3.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        answer3.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        answer4 = [SKLabelNode labelNodeWithFontNamed:@"TipoType - Fenix"];
        answer4.text = fourthAnswerPrint;
        answer4.fontColor = [UIColor blackColor];
        answer4.fontSize = 20;
        answer4.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;
        answer4.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
        
        firstAnswer.position = answerPosition;
        secondAnswer.position = CGPointMake(answerPosition.x, answerPosition.y - 175);
        thirdAnswer.position = CGPointMake(answerPosition.x, answerPosition.y - 350);
        fourthAnswer.position = CGPointMake(answerPosition.x, answerPosition.y - 525);
        
        //[firstAnswer addChild:answer1];
        [firstAnswer addChild:renderLabel2];
        [secondAnswer addChild:answer2];
        [thirdAnswer addChild:answer3];
        [fourthAnswer addChild:answer4];
        
        [self addChild:firstAnswer];
        [self addChild:secondAnswer];
        [self addChild:thirdAnswer];
        [self addChild:fourthAnswer];

        //answer1.position = answerRelativeToButton;
        answer2.position = answerRelativeToButton;
        answer3.position = answerRelativeToButton;
        answer4.position = answerRelativeToButton;
        
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
}

-(void) updateScoreSection {
    
    
}


-(void)checkAnswer:(NSNumber*) index {

    
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
        rowStar += 20;
        
    } else if (determineRow == 2 && currentRow == 1) {
        currentRow = 2;
        rowStar += 20;
    } else if (determineRow == 3 && currentRow == 2) {
        currentRow = 3;
        rowStar += 20;
    }
    
    
    if (correctAnswer == theIndex) {
        
        alreadyAnswered = TRUE;
        [scoreActual removeFromParent];
        //[questionTimer stopAllActions];
        
        correctQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Correct-button-iphone.png"];
        wrongQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Incorrect-iphone.png"];
        
        
        /****************************SCORING UPDATE***************************************/
        
        // Update the scoring
        amountOfTime = (100-amountOfTime)/2;
        
        scoreOnQuestion = scoreFactor * amountOfTime;
        
        totalWeightedScore += scoreOnQuestion;
        
        /*****************************************************************************/
        NSString *scoreWithFactor = [NSString stringWithFormat:@"%i", totalWeightedScore];
        scoreActual = [SKLabelNode labelNodeWithFontNamed:@"StalinistOne-Regular"];
        scoreActual.text = scoreWithFactor;
        scoreActual.fontColor = [UIColor redColor];
        scoreActual.position = _totalScoreCounter;
        [self addChild:scoreActual];
        
        numberCorrectAnswers++;
        
        // Drop the star with animation sequence of flying bird
        
        SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"gold-star.png"];
        star.position = CGPointMake(300,800);
        [self addChild:star];
        [allStar addObject:star];
        
        NSString *openEmitterEffect = [[NSBundle mainBundle]pathForResource:@"happyExplode" ofType:@"sks"];
        SKEmitterNode *openEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:openEmitterEffect];
        openEffect.position = CGPointMake(100, 200);
        openEffect.targetNode = star;
        [star addChild:openEffect];

        NSString *landEmitterEffect = [[NSBundle mainBundle]pathForResource:@"SmokeEffect" ofType:@"sks"];
        SKEmitterNode *landEffect = [NSKeyedUnarchiver unarchiveObjectWithFile:landEmitterEffect];
        landEffect.position = CGPointMake(70, 80);
        landEffect.targetNode = star;
        [self addChild:landEffect];
        
        SKAction *dropIt = [SKAction moveTo:CGPointMake(star.position.x - 300 + offsetStar, 30) duration:1.0];
        [star runAction:dropIt];
        
        SKAction *dropStar =[SKAction scaleBy:2.4 duration:0.1];
        //[star runAction:dropStar];
        
        SKAction *dropStar2 = [SKAction scaleTo:1.0 duration:0.6];
        //[star runAction:dropStar2];
        
        SKAction *sequence = [SKAction sequence:@[dropStar,dropStar2]];
        [star runAction:sequence];
        
        offsetStar += 25;
        
        NSMutableArray *answerArchive = [[NSMutableArray alloc]init];
        
        
        if (theIndex == 0) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/1.8);
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/1.8);
            //[answerA runAction:explodeUnexplode];
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
            
        } else if (theIndex == 1) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/2.4);
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/2.4);
            //[answerB runAction:explodeUnexplode];
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 2) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/3.8);
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/3.8);
            //[answerC runAction:explodeUnexplode];
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 3) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/6.0);
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.2,winSize.height/6.0);
            //[answerD runAction:explodeUnexplode];
            
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
        
        SKSpriteNode *star = [SKSpriteNode spriteNodeWithImageNamed:@"red-x-4.png"];
        star.position = CGPointMake(550,550);
        [self addChild:star];
        [allXimg addObject:star];
        
        /*SKAction *flyTogther = [CCMoveTo actionWithDuration:.9 position:CGPointMake(300,400)];
        [birdie runAction:flyTogther];
        [star runAction:flyTogther];
         
        CCAction *dropStar =[CCMoveTo actionWithDuration:.9 position:CGPointMake(300+offsetStar, 160+rowStar)];
        [birdie runAction:birdPath];
        [star runAction:dropStar];
        */
        
        wrongQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Incorrect.png"];
        correctQuestionAnswer = [SKSpriteNode spriteNodeWithImageNamed:@"Correct-button-iphone.png"];
        
        NSMutableArray *answerArchive = [[NSMutableArray alloc]init];
        
        if (theIndex == 0) {
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/1.4);
            //[answerA runAction:explodeUnexplode];
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 1) {
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/1.7);
            //[answerB runAction:explodeUnexplode];
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            [reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 2) {
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/2.3);
            //[answerC runAction:explodeUnexplode];
            
            [answerArchive addObject:[quizQuestions objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizAnswers objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongOne objectAtIndex:questionCounter]];
            [answerArchive addObject:[quizWrongTwo objectAtIndex:questionCounter]];
            
            [answerArchive addObject:[quizWrongThree objectAtIndex:questionCounter]];
            [answerArchive addObject:[NSNumber numberWithInt:correctAnswer]];
            [answerArchive addObject:[NSNumber numberWithInt:theIndex]];
            //[reviewAnswers setObject:answerArchive forKey:[NSNumber numberWithInt:questionCounter]];
            
        } else if (theIndex == 3) {
            wrongQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/3.42);
            //[answerD runAction:explodeUnexplode];
            
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
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/1.7);
        } else if (correctAnswer == 1) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/2.0);
        } else if (correctAnswer == 2) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/3.8);
        } else if (correctAnswer == 3) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/4.0);
        } else if (correctAnswer == 4) {
            correctQuestionAnswer.position = CGPointMake(winSize.width/6.0,winSize.height/6.0);
        }
        
        [self addChild:wrongQuestionAnswer];
        [self addChild:correctQuestionAnswer];
        
        
        //CCFadeIn *fadeIn = [CCFadeIn actionWithDuration:2];
        //[wrongQuestionAnswer runAction:fadeIn];
        //[correctQuestionAnswer runAction:fadeIn];
        
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
    
    if (CGRectContainsPoint(firstAnswer.frame, location)) {
        
        [self checkAnswer:[NSNumber numberWithInt:0]];
    
    } else if (CGRectContainsPoint(secondAnswer.frame, location)) {
    
        [self checkAnswer:[NSNumber numberWithInt:1]];
    
    } else if (CGRectContainsPoint(thirdAnswer.frame, location)) {
    
        [self checkAnswer:[NSNumber numberWithInt:2]];
    
    } else if (CGRectContainsPoint(fourthAnswer.frame, location)) {
    
        [self checkAnswer:[NSNumber numberWithInt:3]];
    
    } else if (CGRectContainsPoint(forward.frame, location)) {
        
        [self nextQuestion];
        
    }
    
    
    //}
}

@end
