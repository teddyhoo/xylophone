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
    
    letterA = [LowerCaseLetter spriteNodeWithImageNamed:@"a_blue_600x600.png"];
    NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"a" withExtension:@"aiff"];
    letterA.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
    letterA.name = @"A";

    
    return letterA;
    
    
    
}

-(LowerCaseLetter *) createLetterB {
    
    float beginx = 450;
    float beginy = 780;


    letterB = [LowerCaseLetter spriteNodeWithImageNamed:@"b_red_1000x600.png"];
    NSURL *letterBurl = [[NSBundle mainBundle]URLForResource:@"b" withExtension:@"aiff"];
    letterB.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterBurl error:nil];
    letterB.name = @"B";
    letterB.centerStage = FALSE;
    
    
    return letterB;
}

-(LowerCaseLetter *) createLetterC {
    
    
    
    letterC = [LowerCaseLetter spriteNodeWithImageNamed:@"c_600x600.png"];
    NSURL *letterCurl = [[NSBundle mainBundle]URLForResource:@"c" withExtension:@"aiff"];
    letterC.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterCurl error:nil];
    letterC.name = @"C";
    
    
    return letterC;
}

-(LowerCaseLetter *) createLetterD {
    letterD = [LowerCaseLetter spriteNodeWithImageNamed:@"d_1000x600.png"];
    letterD.anchorPoint = CGPointMake(1.0, 0.4);
    NSURL *letterDurl = [[NSBundle mainBundle]URLForResource:@"d" withExtension:@"aiff"];
    letterD.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterDurl error:nil];
    letterD.name = @"D";
    
    
    return letterD;
}

-(LowerCaseLetter *) createLetterE {
    letterE = [LowerCaseLetter spriteNodeWithImageNamed:@"e_600x600.png"];
    letterE.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterEurl = [[NSBundle mainBundle]URLForResource:@"e" withExtension:@"aiff"];
    letterE.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterEurl error:nil];
    letterE.name = @"E";
    
    
    return letterE;
}

-(LowerCaseLetter *) createLetterF {
    letterF = [LowerCaseLetter spriteNodeWithImageNamed:@"f_850x600.png"];
    letterF.anchorPoint = CGPointMake(1.0, 0.5);
    NSURL *letterFurl = [[NSBundle mainBundle]URLForResource:@"f2" withExtension:@"aiff"];
    letterF.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterFurl error:nil];
    return letterF;
    
}

-(LowerCaseLetter *) createLetterG {
    letterG = [LowerCaseLetter spriteNodeWithImageNamed:@"g_1000x600.png"];
    NSURL *letterGurl = [[NSBundle mainBundle]URLForResource:@"g" withExtension:@"aiff"];
    letterG.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterGurl error:nil];
    
    letterG.anchorPoint = CGPointMake(1.0,0.8);
    return letterG;
    
}

-(LowerCaseLetter *) createLetterH {
    letterH = [LowerCaseLetter spriteNodeWithImageNamed:@"h_1000x600.png"];
    letterH.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterHurl = [[NSBundle mainBundle]URLForResource:@"h2" withExtension:@"aiff"];
    letterH.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterHurl error:nil];
    return letterH;
}

-(LowerCaseLetter *) createLetterI {
    letterI = [LowerCaseLetter spriteNodeWithImageNamed:@"i_850x600.png"];
    NSURL *letterIurl = [[NSBundle mainBundle]URLForResource:@"i2" withExtension:@"aiff"];
    letterI.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterIurl error:nil];
    return letterI;
}

-(LowerCaseLetter *) createLetterJ {
    letterJ = [LowerCaseLetter spriteNodeWithImageNamed:@"j_1000x600.png"];
    letterJ.anchorPoint = CGPointMake(1.0, 0.8);
    
    NSURL *letterJurl = [[NSBundle mainBundle]URLForResource:@"j2" withExtension:@"aiff"];
    letterJ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterJurl error:nil];
    return letterJ;
}

-(LowerCaseLetter *) createLetterK {
    letterK = [LowerCaseLetter spriteNodeWithImageNamed:@"k_1000x600.png"];
    letterK.anchorPoint = CGPointMake(1.0, 0.4);
    NSURL *letterKurl = [[NSBundle mainBundle]URLForResource:@"k" withExtension:@"aiff"];
    letterK.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterKurl error:nil];
    return letterK;
}

-(LowerCaseLetter *)createLetterL {
    letterL = [LowerCaseLetter spriteNodeWithImageNamed:@"l_1000x600.png"];
    letterL.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterLurl = [[NSBundle mainBundle]URLForResource:@"l" withExtension:@"aiff"];
    letterL.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterLurl error:nil];
    return letterL;
}

-(LowerCaseLetter *)createLetterM {
    letterM = [LowerCaseLetter spriteNodeWithImageNamed:@"m_600x850.png"];
    NSURL *letterMurl = [[NSBundle mainBundle]URLForResource:@"m" withExtension:@"aiff"];
    letterM.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterMurl error:nil];
    return letterM;
}

-(LowerCaseLetter *)createLetterN {
    letterN = [LowerCaseLetter spriteNodeWithImageNamed:@"n_600x600.png"];
    letterN.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterNurl = [[NSBundle mainBundle]URLForResource:@"n" withExtension:@"aiff"];
    letterN.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterNurl error:nil];
    return letterN;
}

-(LowerCaseLetter *)createLetterO {
    letterO = [LowerCaseLetter spriteNodeWithImageNamed:@"o_600x600.png"];
    letterO.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterOurl = [[NSBundle mainBundle]URLForResource:@"o" withExtension:@"aiff"];
    letterO.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterOurl error:nil];
    return letterO;
}

-(LowerCaseLetter *)createLetterP {
    letterP = [LowerCaseLetter spriteNodeWithImageNamed:@"p_1000x600.png"];
    letterP.anchorPoint = CGPointMake(1.0, 0.8);
    
    NSURL *letterPurl = [[NSBundle mainBundle]URLForResource:@"p" withExtension:@"aiff"];
    letterP.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterPurl error:nil];
    return letterP;
}

-(LowerCaseLetter *)createLetterQ {
    letterQ = [LowerCaseLetter spriteNodeWithImageNamed:@"q_1000x620.png"];
    letterQ.anchorPoint = CGPointMake(1.0, 0.8);
    NSURL *letterQurl = [[NSBundle mainBundle]URLForResource:@"q" withExtension:@"aiff"];
    letterQ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterQurl error:nil];
    return letterQ;
}

-(LowerCaseLetter *)createLetterR {
    letterR = [LowerCaseLetter spriteNodeWithImageNamed:@"r_600x600.png"];
    letterR.anchorPoint = CGPointMake(1.0,0.65);
    
    NSURL *letterRurl = [[NSBundle mainBundle]URLForResource:@"r" withExtension:@"aiff"];
    letterR.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterRurl error:nil];
    return letterR;
}

-(LowerCaseLetter *)createLetterS {
    letterS = [LowerCaseLetter spriteNodeWithImageNamed:@"s_600x600.png"];
    NSURL *letterSurl = [[NSBundle mainBundle]URLForResource:@"s" withExtension:@"aiff"];
    letterS.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterSurl error:nil];
    return letterS;
}

-(LowerCaseLetter *)createLetterT {
    letterT = [LowerCaseLetter spriteNodeWithImageNamed:@"t_850x600.png"];
    NSURL *letterTurl = [[NSBundle mainBundle]URLForResource:@"t2" withExtension:@"aiff"];
    letterT.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterTurl error:nil];
    return letterT;
}

-(LowerCaseLetter *)createLetterU {
    letterU = [LowerCaseLetter spriteNodeWithImageNamed:@"u_600x600.png"];
    NSURL *letterUurl = [[NSBundle mainBundle]URLForResource:@"u" withExtension:@"aiff"];
    letterU.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterUurl error:nil];
    return letterU;
}

-(LowerCaseLetter *)createLetterV {
    letterV = [LowerCaseLetter spriteNodeWithImageNamed:@"v_600x600.png"];
    NSURL *letterVurl = [[NSBundle mainBundle]URLForResource:@"v" withExtension:@"aiff"];
    letterV.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterVurl error:nil];
    return letterV;
}

-(LowerCaseLetter *)createLetterW {
    letterW = [LowerCaseLetter spriteNodeWithImageNamed:@"w_600x850.png"];
    NSURL *letterWurl = [[NSBundle mainBundle]URLForResource:@"w" withExtension:@"aiff"];
    letterW.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterWurl error:nil];
    return letterW;
}

-(LowerCaseLetter *)createLetterX {
    letterX = [LowerCaseLetter spriteNodeWithImageNamed:@"x_600x600.png"];
    letterX.anchorPoint = CGPointMake(1.0, 0.65);
    
    NSURL *letterXurl = [[NSBundle mainBundle]URLForResource:@"x" withExtension:@"aiff"];
    letterX.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterXurl error:nil];
    return letterX;
}

-(LowerCaseLetter *) createLetterY {
    letterY = [LowerCaseLetter spriteNodeWithImageNamed:@"y_1000x600.png"];
    letterY.anchorPoint = CGPointMake(1.0, 0.8);
    NSURL *letterYurl = [[NSBundle mainBundle]URLForResource:@"y" withExtension:@"aiff"];
    letterY.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterYurl error:nil];
    return letterY;
}

-(LowerCaseLetter *)createLetterZ {
    letterZ = [LowerCaseLetter spriteNodeWithImageNamed:@"z_600x600.png"];
    letterZ.anchorPoint = CGPointMake(1.0, 0.65);
    NSURL *letterZurl = [[NSBundle mainBundle]URLForResource:@"z" withExtension:@"aiff"];
    letterZ.baseSound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterZurl error:nil];
    return letterZ;
}


@end
