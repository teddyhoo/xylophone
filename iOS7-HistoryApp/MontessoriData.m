//
//  MontessoriData.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/28/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "MontessoriData.h"
#import "LowerCaseLetter.h"

static MontessoriData *sharedMyManager = nil;



@implementation MontessoriData


@synthesize letterA, letterB, letterC, letterD, letterE, letterF, letterG, letterH, letterI, letterJ, letterK, letterL, letterM, letterN, letterO, letterP, letterQ, letterR, letterS, letterT, letterU, letterV, letterW, letterX, letterY, letterZ;

CGPoint startPoint;

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
        
        letterA = [self createLetterA];
        letterB = [self createLetterB];
        letterC = [self createLetterC];
        letterD = [self createLetterD];
        letterE = [self createLetterE];
        letterF = [self createLetterF];
        letterG = [self createLetterG];
        letterH = [self createLetterH];
        letterI = [self createLetterI];
        letterJ = [self createLetterJ];
        letterK = [self createLetterK];
        letterL = [self createLetterL];
        letterM = [self createLetterM];
        letterN = [self createLetterN];
        letterO = [self createLetterO];
        letterP = [self createLetterP];
        letterQ = [self createLetterQ];
        letterR = [self createLetterR];
        letterS = [self createLetterS];
        letterT = [self createLetterT];
        letterU = [self createLetterU];
        letterV = [self createLetterV];
        letterW = [self createLetterW];
        letterX = [self createLetterX];
        letterY = [self createLetterY];
        letterZ = [self createLetterZ];
        
        
      
        
    }
    return self;
}

-(LowerCaseLetter *) createLetterA {
    
    startPoint = CGPointMake(900, 650);
    
    CGPoint letterAvalue1 = CGPointMake(400, 500);
    CGPoint letterAvalue2 = CGPointMake(385, 505);
    CGPoint letterAvalue3 = CGPointMake(370, 510);
    CGPoint letterAvalue4 = CGPointMake(355, 510);
    CGPoint letterAvalue5 = CGPointMake(340, 510);
    CGPoint letterAvalue6 = CGPointMake(325, 500);
    CGPoint letterAvalue7 = CGPointMake(310, 490);
    CGPoint letterAvalue8 = CGPointMake(300, 480);
    CGPoint letterAvalue9 = CGPointMake(290, 470);
    CGPoint letterAvalue10 = CGPointMake(280, 450);
    CGPoint letterAvalue11 = CGPointMake(277, 440);
    CGPoint letterAvalue12 = CGPointMake(275, 430);
    CGPoint letterAvalue13 = CGPointMake(273, 420);
    CGPoint letterAvalue14 = CGPointMake(270, 410);
    CGPoint letterAvalue15 = CGPointMake(270, 400);
    CGPoint letterAvalue16 = CGPointMake(270, 390);
    CGPoint letterAvalue17 = CGPointMake(270, 380);
    CGPoint letterAvalue18 = CGPointMake(270, 370);
    CGPoint letterAvalue19 = CGPointMake(280, 360);
    CGPoint letterAvalue20 = CGPointMake(290, 355);
    CGPoint letterAvalue21 = CGPointMake(300, 345);
    CGPoint letterAvalue22 = CGPointMake(310, 340);
    CGPoint letterAvalue23 = CGPointMake(320, 340);
    CGPoint letterAvalue24 = CGPointMake(330, 342);
    CGPoint letterAvalue25 = CGPointMake(340, 342);
    CGPoint letterAvalue26 = CGPointMake(350, 345);
    CGPoint letterAvalue27 = CGPointMake(360, 345);
    CGPoint letterAvalue28 = CGPointMake(370, 350);
    CGPoint letterAvalue29 = CGPointMake(380, 355);
    CGPoint letterAvalue30 = CGPointMake(390, 360);
    CGPoint letterAvalue31 = CGPointMake(400, 380);
    CGPoint letterAvalue32 = CGPointMake(402, 400);
    CGPoint letterAvalue33 = CGPointMake(405, 420);
    CGPoint letterAvalue34 = CGPointMake(407, 460);
    CGPoint letterAvalue35 = CGPointMake(410, 500);
    CGPoint letterAvalue36 = CGPointMake(410, 490);
    CGPoint letterAvalue37 = CGPointMake(412, 460);
    CGPoint letterAvalue38 = CGPointMake(414, 420);
    CGPoint letterAvalue39 = CGPointMake(415, 400);
    CGPoint letterAvalue40 = CGPointMake(425, 380);
    CGPoint letterAvalue41 = CGPointMake(430, 360);
    
    
    NSMutableArray *pointsForSprite = [[NSMutableArray alloc]init];
    
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue1]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue2]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue3]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue4]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue5]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue6]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue7]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue8]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue9]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue10]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue11]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue12]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue13]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue14]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue15]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue16]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue17]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue18]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue19]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue20]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue21]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue22]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue23]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue24]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue25]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue26]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue27]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue28]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue29]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue30]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue31]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue32]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue33]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue34]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue35]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue36]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue37]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue38]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue39]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue40]];
    [pointsForSprite addObject:[NSValue valueWithCGPoint:letterAvalue41]];
    
    letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"a_blue_600x600.png"];
    NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
    letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
    letterA.name = @"A";
    
    [letterA createControlPoints:pointsForSprite];
    
    return letterA;
    
    
    
}

-(LowerCaseLetter *) createLetterB {
    
    float beginx = 450;
    float beginy = 780;


    letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"b_red_1000x600.png"];
    NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
    letterB.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterBurl error:nil];
    letterB.name = @"B";

    //[letterB createControlPoints:pointsForSprite];
    
    
    return letterB;
}

-(LowerCaseLetter *) createLetterC {
    
    
    
    letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"c_600x600.png"];
    NSURL *letterCurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
    letterC.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterCurl error:nil];
    letterC.name = @"C";
    
    
    return letterC;
}

-(LowerCaseLetter *) createLetterD {
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"d_1000x600.png"];
    NSURL *letterDurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
    letterD.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterDurl error:nil];
    letterD.name = @"D";
    
    
    return letterD;
}

-(LowerCaseLetter *) createLetterE {
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"e_600x600.png"];
    NSURL *letterEurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
    letterE.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterEurl error:nil];
    letterE.name = @"E";
    
    
    return letterE;
}

-(LowerCaseLetter *) createLetterF {
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"f_850x600.png"];
    return letterF;
    
}

-(LowerCaseLetter *) createLetterG {
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"g_1000x600.png"];
    return letterG;
    
}

-(LowerCaseLetter *) createLetterH {
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"h_1000x600.png"];
    return letterH;
}

-(LowerCaseLetter *) createLetterI {
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"i_850x600.png"];
    return letterI;
}

-(LowerCaseLetter *) createLetterJ {
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"j_1000x600.png"];
    return letterJ;
}

-(LowerCaseLetter *) createLetterK {
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"k_1000x600.png"];
    return letterK;
}

-(LowerCaseLetter *)createLetterL {
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"l_1000x600.png"];
    return letterL;
}

-(LowerCaseLetter *)createLetterM {
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"m_600x850.png"];
    return letterM;
}

-(LowerCaseLetter *)createLetterN {
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"n_600x600.png"];
    return letterN;
}

-(LowerCaseLetter *)createLetterO {
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"o_600x600.png"];
    return letterO;
}

-(LowerCaseLetter *)createLetterP {
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"p_1000x600.png"];
    return letterP;
}

-(LowerCaseLetter *)createLetterQ {
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"q_1000x620.png"];
    return letterQ;
}

-(LowerCaseLetter *)createLetterR {
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"r_600x600.png"];
    return letterR;
}

-(LowerCaseLetter *)createLetterS {
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"s_600x600.png"];
    return letterS;
}

-(LowerCaseLetter *)createLetterT {
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"t_850x600.png"];
    return letterT;
}

-(LowerCaseLetter *)createLetterU {
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"u_600x600.png"];
    return letterU;
}

-(LowerCaseLetter *)createLetterV {
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"v_600x600.png"];
    return letterV;
}

-(LowerCaseLetter *)createLetterW {
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"w_600x850.png"];
    return letterW;
}

-(LowerCaseLetter *)createLetterX {
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"x_600x600.png"];
    return letterX;
}

-(LowerCaseLetter *) createLetterY {
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"y_1000x600.png"];
    return letterY;
}

-(LowerCaseLetter *)createLetterZ {
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"z_600x600.png"];
    return letterZ;
}


@end
