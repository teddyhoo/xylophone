//
//  MontessoriData.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/28/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "LowerCaseLetter.h"

@interface MontessoriData : NSObject {
    
    AVAudioPlayer *pronounceLetter;
    AVAudioPlayer *wordFromLetter1;
    AVAudioPlayer *wordFromLetter2;
    AVAudioPlayer *wordFromLetter3;
    
}

+(id)sharedManager;


@property (nonatomic,retain) NSMutableArray *letterDrawResults;
// Image of a lower case letter

@property (nonatomic,retain) LowerCaseLetter *letterA;
@property (nonatomic,retain) LowerCaseLetter *letterB;
@property (nonatomic,retain) LowerCaseLetter *letterC;
@property (nonatomic,retain) LowerCaseLetter *letterD;
@property (nonatomic,retain) LowerCaseLetter *letterE;
@property (nonatomic,retain) LowerCaseLetter *letterF;
@property (nonatomic,retain) LowerCaseLetter *letterG;
@property (nonatomic,retain) LowerCaseLetter *letterH;
@property (nonatomic,retain) LowerCaseLetter *letterI;
@property (nonatomic,retain) LowerCaseLetter *letterJ;
@property (nonatomic,retain) LowerCaseLetter *letterK;
@property (nonatomic,retain) LowerCaseLetter *letterL;
@property (nonatomic,retain) LowerCaseLetter *letterM;
@property (nonatomic,retain) LowerCaseLetter *letterN;
@property (nonatomic,retain) LowerCaseLetter *letterO;
@property (nonatomic,retain) LowerCaseLetter *letterP;
@property (nonatomic,retain) LowerCaseLetter *letterQ;
@property (nonatomic,retain) LowerCaseLetter *letterR;
@property (nonatomic,retain) LowerCaseLetter *letterS;
@property (nonatomic,retain) LowerCaseLetter *letterT;
@property (nonatomic,retain) LowerCaseLetter *letterU;
@property (nonatomic,retain) LowerCaseLetter *letterV;
@property (nonatomic,retain) LowerCaseLetter *letterW;
@property (nonatomic,retain) LowerCaseLetter *letterX;
@property (nonatomic,retain) LowerCaseLetter *letterY;
@property (nonatomic,retain) LowerCaseLetter *letterZ;

// Letter sounds
@property (nonatomic,retain) AVAudioPlayer *letterAsound;
@property (nonatomic,retain) AVAudioPlayer *letterBsound;
@property (nonatomic,retain) AVAudioPlayer *letterCsound;
@property (nonatomic,retain) AVAudioPlayer *letterDsound;
@property (nonatomic,retain) AVAudioPlayer *letterEsound;
@property (nonatomic,retain) AVAudioPlayer *letterFsound;
@property (nonatomic,retain) AVAudioPlayer *letterGsound;
@property (nonatomic,retain) AVAudioPlayer *letterHsound;
@property (nonatomic,retain) AVAudioPlayer *letterIsound;
@property (nonatomic,retain) AVAudioPlayer *letterJsound;
@property (nonatomic,retain) AVAudioPlayer *letterKsound;
@property (nonatomic,retain) AVAudioPlayer *letterLsound;
@property (nonatomic,retain) AVAudioPlayer *letterMsound;
@property (nonatomic,retain) AVAudioPlayer *letterNsound;
@property (nonatomic,retain) AVAudioPlayer *letterOsound;
@property (nonatomic,retain) AVAudioPlayer *letterPsound;
@property (nonatomic,retain) AVAudioPlayer *letterQsound;
@property (nonatomic,retain) AVAudioPlayer *letterRsound;
@property (nonatomic,retain) AVAudioPlayer *letterSsound;
@property (nonatomic,retain) AVAudioPlayer *letterTsound;
@property (nonatomic,retain) AVAudioPlayer *letterUsound;
@property (nonatomic,retain) AVAudioPlayer *letterVsound;
@property (nonatomic,retain) AVAudioPlayer *letterWsound;
@property (nonatomic,retain) AVAudioPlayer *letterXsound;
@property (nonatomic,retain) AVAudioPlayer *letterYsound;
@property (nonatomic,retain) AVAudioPlayer *letterZsound;



-(LowerCaseLetter *)createLetterA;
-(LowerCaseLetter *)createLetterB;
-(LowerCaseLetter *)createLetterC;
-(LowerCaseLetter *)createLetterD;
-(LowerCaseLetter *)createLetterE;
-(LowerCaseLetter *)createLetterF;
-(LowerCaseLetter *)createLetterG;
-(LowerCaseLetter *)createLetterH;
-(LowerCaseLetter *)createLetterI;
-(LowerCaseLetter *)createLetterJ;
-(LowerCaseLetter *)createLetterK;
-(LowerCaseLetter *)createLetterL;
-(LowerCaseLetter *)createLetterM;
-(LowerCaseLetter *)createLetterN;
-(LowerCaseLetter *)createLetterO;
-(LowerCaseLetter *)createLetterP;
-(LowerCaseLetter *)createLetterQ;
-(LowerCaseLetter *)createLetterR;
-(LowerCaseLetter *)createLetterS;
-(LowerCaseLetter *)createLetterT;
-(LowerCaseLetter *)createLetterU;
-(LowerCaseLetter *)createLetterV;
-(LowerCaseLetter *)createLetterW;
-(LowerCaseLetter *)createLetterX;
-(LowerCaseLetter *)createLetterY;
-(LowerCaseLetter *)createLetterZ;

-(void)archiveShapeDrawn:(NSMutableArray*)spriteCloudObjects
                   onDay:(NSDate*)dateDone
               firstLine:(NSNumber *)pointsMissed
              secondLine:(NSNumber *)secondPointsMissed
             whichLetter:(NSString *)letterName;

@end
