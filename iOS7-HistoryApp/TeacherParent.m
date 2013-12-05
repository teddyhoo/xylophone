//
//  TeacherParent.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/1/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TeacherParent.h"
#import "MontessoriData.h"
#import "RedrawLetter.h"
#import "LowerCaseLetter.h"

@implementation TeacherParent

MontessoriData *sharedData;
NSMutableArray *studentHistory;
NSMutableArray *studentSprites;
NSMutableArray *allTheLetters;
SKLabelNode *groupOne;
SKLabelNode *groupTwo;
SKLabelNode *groupThree;
SKLabelNode *groupFour;
SKLabelNode *groupFive;

int onWhichGroup;

LowerCaseLetter *letterA;
LowerCaseLetter *letterB;
LowerCaseLetter *letterC;
LowerCaseLetter *letterD;
LowerCaseLetter *letterE;
LowerCaseLetter *letterF;
LowerCaseLetter *letterG;
LowerCaseLetter *letterH;
LowerCaseLetter *letterI;
LowerCaseLetter *letterJ;
LowerCaseLetter *letterK;
LowerCaseLetter *letterL;
LowerCaseLetter *letterM;
LowerCaseLetter *letterN;
LowerCaseLetter *letterO;
LowerCaseLetter *letterP;
LowerCaseLetter *letterQ;
LowerCaseLetter *letterR;
LowerCaseLetter *letterS;
LowerCaseLetter *letterT;
LowerCaseLetter *letterU;
LowerCaseLetter *letterV;
LowerCaseLetter *letterW;
LowerCaseLetter *letterX;
LowerCaseLetter *letterY;
LowerCaseLetter *letterZ;

// Group 1: a, b, c, m, s, t
NSMutableArray *groupOneLetters;

// Group 2: g, r, d, f, o
NSMutableArray *groupTwoLetters;

// Group 3: p, n, l, h, i
NSMutableArray *groupThreeLetters;

// Group 4: z, e, x, k, q
NSMutableArray *groupFourLetters;

// Group 5: v, w, j, u, y
NSMutableArray *groupFiveLetters;

NSMutableArray *shapesForLetters;

CGFloat width;
CGFloat height;
    
-(id)initWithSize:(CGSize)size {
    
    self = [super initWithSize:size];
    
    if (self) {
        
        onWhichGroup = 0;
        
        sharedData = [MontessoriData sharedManager];

        self.backgroundColor = [SKColor colorWithRed:0.8 green:1.0 blue:1.0 alpha:1.0];
        self.userInteractionEnabled = YES;
        width = self.size.width;
        height = self.size.height;
        
        groupOneLetters = [[NSMutableArray alloc]init];
        groupTwoLetters = [[NSMutableArray alloc]init];
        groupThreeLetters = [[NSMutableArray alloc]init];
        groupFourLetters = [[NSMutableArray alloc]init];
        groupFiveLetters = [[NSMutableArray alloc]init];
        allTheLetters = [[NSMutableArray alloc]init];
        shapesForLetters = [[NSMutableArray alloc]init];
        
        [self getDataHistory];
        
        
        NSMutableArray *studentSprites = [[NSMutableArray alloc]init];
        NSArray *studentNames = [[NSArray alloc]initWithObjects:
                                 @"Student: Ted Hooban",
                                 //@"Teacher: Ms. Stage",
                                 //@"Age: 3 years 2 months",
                                 //@"Session: Mornings",
                                 //@"Assistant Teacher: Darla",
                                 nil];
        
        int i = 0;
        
        for (NSString *studentName in studentNames) {
            
            SKLabelNode *nameLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
            nameLabel.text = studentName;
            nameLabel.name = studentName;
            nameLabel.fontColor = [UIColor blackColor];
            nameLabel.fontSize = 20;
            nameLabel.position = CGPointMake(550, 700 - (30*i));
            [self addChild:nameLabel];
            [studentSprites addObject:nameLabel];
            i++;
            
        }
        
    }
    
    letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"a_blue_600x600.png"];
    letterA.name = @"A";
    
    letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"b_850x600.png"];
    letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"c_600x600.png"];
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"d_1000x600.png"];;
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"e_600x600.png"];;
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"f_850x600.png"];;
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"g_1000x600.png"];;
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"h_1000x600.png"];;
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"i_850x600.png"];;
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"j_1000x600.png"];;
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"k_1000x600.png"];;
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"l_1000x600.png"];;
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"m_600x850.png"];;
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"n_600x600.png"];;
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"o_600x600.png"];;
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"p_1000x600.png"];;
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"q_1000x620.png"];;
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"r_600x600.png"];;
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"s_600x600.png"];;
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"t_850x600.png"];;
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"u_600x600.png"];;
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"v_600x600.png"];;
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"w_600x850.png"];;
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"x_600x600.png"];;
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"y_1000x600.png"];;
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"z_600x600.png"];;
    
    
    [allTheLetters addObject:letterA];
    [allTheLetters addObject:letterB];
    [allTheLetters addObject:letterC];
    [allTheLetters addObject:letterD];
    [allTheLetters addObject:letterE];
    [allTheLetters addObject:letterF];
    [allTheLetters addObject:letterG];
    [allTheLetters addObject:letterH];
    [allTheLetters addObject:letterI];
    [allTheLetters addObject:letterJ];
    [allTheLetters addObject:letterK];
    [allTheLetters addObject:letterL];
    [allTheLetters addObject:letterM];
    [allTheLetters addObject:letterN];
    [allTheLetters addObject:letterO];
    [allTheLetters addObject:letterP];
    [allTheLetters addObject:letterQ];
    [allTheLetters addObject:letterR];
    [allTheLetters addObject:letterS];
    [allTheLetters addObject:letterT];
    [allTheLetters addObject:letterU];
    [allTheLetters addObject:letterV];
    [allTheLetters addObject:letterW];
    [allTheLetters addObject:letterX];
    [allTheLetters addObject:letterY];
    [allTheLetters addObject:letterZ];
    
    [groupOneLetters addObject:letterA];
    [groupOneLetters addObject:letterB];
    [groupOneLetters addObject:letterC];
    [groupOneLetters addObject:letterM];
    [groupOneLetters addObject:letterS];
    [groupOneLetters addObject:letterT];
    [groupTwoLetters addObject:letterO];
    [groupTwoLetters addObject:letterG];
    [groupTwoLetters addObject:letterR];
    [groupTwoLetters addObject:letterD];
    [groupTwoLetters addObject:letterF];
    [groupThreeLetters addObject:letterI];
    [groupThreeLetters addObject:letterP];
    [groupThreeLetters addObject:letterN];
    [groupThreeLetters addObject:letterL];
    [groupThreeLetters addObject:letterH];
    [groupFourLetters addObject:letterE];
    [groupFourLetters addObject:letterZ];
    [groupFourLetters addObject:letterX];
    [groupFourLetters addObject:letterK];
    [groupFourLetters addObject:letterQ];
    [groupFiveLetters addObject:letterU];
    [groupFiveLetters addObject:letterV];
    [groupFiveLetters addObject:letterW];
    [groupFiveLetters addObject:letterJ];
    [groupFiveLetters addObject:letterY];
    
    groupOne = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    groupOne.text = @"Group 1";
    groupOne.name = @"group1";
    groupOne.fontColor = [UIColor redColor];
    groupOne.fontSize = 40;
    groupOne.position = CGPointMake(150, 700);
    [self addChild:groupOne];
    
    
    groupTwo = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    groupTwo.text = @"Group 2";
    groupTwo.name = @"group2";
    groupTwo.fontColor = [UIColor redColor];
    groupTwo.fontSize = 40;
    groupTwo.position = CGPointMake(150, 600);
    [self addChild:groupTwo];
    
    groupThree = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    groupThree.text = @"Group 3";
    groupThree.name = @"group3";
    groupThree.fontColor = [UIColor redColor];
    groupThree.fontSize = 40;
    groupThree.position = CGPointMake(150, 500);
    [self addChild:groupThree];
    
    groupFour = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    groupFour.text = @"Group 4";
    groupFour.name = @"group4";
    groupFour.fontColor = [UIColor redColor];
    groupFour.fontSize = 40;
    groupFour.position = CGPointMake(150, 400);
    [self addChild:groupFour];
    
    
    groupFive = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
    groupFive.text = @"Group 5";
    groupFive.name = @"group5";
    groupFive.fontColor = [UIColor redColor];
    groupFive.fontSize = 40;
    groupFive.position = CGPointMake(150, 300);
    [self addChild:groupFive];
    
    
    return self;
}


-(void)getDataHistory {
    
    for (NSDictionary *results in sharedData.letterDrawResults) {
        for (NSString *key in results) {
            if ([key isEqualToString:@"shape"]) {
                NSString *letterOn = [results objectForKey:@"letter"];
                
                NSDate *dateOf = [results objectForKey:@"dateDone"];
                NSDateFormatter *dateFormatted = [[NSDateFormatter alloc]init];
                [dateFormatted setTimeStyle:NSDateFormatterShortStyle];
                [dateFormatted setDateStyle:NSDateFormatterLongStyle];
                NSString *formatDate = [dateFormatted stringFromDate:dateOf];

                RedrawLetter *redrawLetterNode = [[RedrawLetter alloc]initWithPosition:CGPointMake(0, 0) withKey:letterOn];

                redrawLetterNode.dateDrawn = formatDate;
                
                NSMutableArray *theCloudObjects = [results objectForKey:key];
                for (SKSpriteNode *drawSprite in theCloudObjects) {
                    SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
                    newCloud.position = drawSprite.position;
                    newCloud.scale = 0.25;
                    [redrawLetterNode addPointToNode:newCloud];
                }
                
                SKLabelNode *dateLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
                dateLabel.text = formatDate;
                dateLabel.fontColor = [UIColor purpleColor];
                dateLabel.fontSize = 20;
                dateLabel.position = CGPointMake(200, 300);
                SKLabelNode *totalPoints = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
                
                
                [redrawLetterNode addChild:dateLabel];
                redrawLetterNode.position = CGPointMake(-200,-200);
                [shapesForLetters addObject:redrawLetterNode];
            }
        }
    }
    
}

-(void)letterTouch:(LowerCaseLetter *)letterOn {
    
    SKAction *moveAction = [SKAction moveTo:CGPointMake(width / 2, height / 2 + 150) duration:1.0];
    SKAction *scaleUp = [SKAction scaleTo:0.5 duration:0.4];
    [letterOn runAction:moveAction];
    [letterOn runAction:scaleUp];
    int xposition = 250;
    int yposition = 180;
    
    for (RedrawLetter *letterShapes in shapesForLetters) {
        
        if ([letterOn.name isEqualToString:letterShapes.name]) {
            NSLog(@"match");
        }
        NSMutableArray *spritesToDraw = [letterShapes drawMyself];
        for (SKSpriteNode *drawSprite in spritesToDraw) {
            SKSpriteNode *newCloud = [SKSpriteNode spriteNodeWithImageNamed:@"cartoon-cloud2.png"];
            newCloud.position = drawSprite.position;
            newCloud.scale = 0.3;
            [letterShapes addChild:newCloud];
        }
        [self addChild:letterShapes];
        
        letterShapes.position = CGPointMake(xposition, yposition);
        letterShapes.scale = 0.4;
        
        xposition += 245;
        if (xposition > 800) {
            xposition = 250;
            yposition -= 150;
        }
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInNode:self];
    
    for (LowerCaseLetter *touchLetter in allTheLetters) {
        if (CGRectContainsPoint(touchLetter.frame,theTouch)) {
            [self letterTouch:touchLetter];
  
        }
    }
    

    if (CGRectContainsPoint(groupOne.frame, theTouch)) {
        
        int i = 0;
        for (LowerCaseLetter *letterSprite in groupOneLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(150 + i, 650);
            
            [self addChild:letterSprite];
            i += 90;
            onWhichGroup = 1;
        }
        
    } else if (CGRectContainsPoint(groupTwo.frame, theTouch)) {
        
        int i = 0;
        for (LowerCaseLetter *letterSprite in groupTwoLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(150 + i, 550);
            [self addChild:letterSprite];
            i += 90;
            onWhichGroup = 2;
        }
        
    } else if (CGRectContainsPoint(groupThree.frame, theTouch)) {
        
        int i = 0;
        for (LowerCaseLetter *letterSprite in groupThreeLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(150 + i, 450);
            [self addChild:letterSprite];
            i += 100;
            onWhichGroup = 3;
        }
        
    } else if (CGRectContainsPoint(groupFour.frame, theTouch)) {
        
        int i = 0;
        
        for (LowerCaseLetter *letterSprite in groupFourLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(150 + i, 350 );
            [self addChild:letterSprite];
            i += 70;
            onWhichGroup = 4;
        }
        
    } else if (CGRectContainsPoint(groupFive.frame, theTouch)) {
        int i = 0;
        for (LowerCaseLetter *letterSprite in groupFiveLetters) {
            letterSprite.scale = 0.1;
            letterSprite.position = CGPointMake(150 + i, 250);
            [self addChild:letterSprite];
            i += 70;
            onWhichGroup = 5;
        }
        
    }

    for (SKLabelNode *studentLabel in studentSprites) {
        NSLog(@"text: %@", studentLabel.text);
        
        if (CGRectContainsPoint(studentLabel.frame,theTouch)) {
            SKAction *setToHeadLine = [SKAction moveTo:CGPointMake(400, 600) duration:1.0];
            [studentLabel runAction:setToHeadLine];
        }
        
    }

}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
}

@end
