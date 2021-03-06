//
//  LowerCaseLetter.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/10/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface LowerCaseLetter : SKSpriteNode {
    
    SKSpriteNode *imageForLetter;

    NSString *nameOfLetter;
    NSString *phoneticPronunciation;
    NSString *audioFilePlayback;
    
    NSMutableArray *controlPoints;
    NSMutableArray *controlPointsForLandscape;
    NSMutableArray *controlPointsForiPad;
    NSMutableArray *controlPointsForiPadForLandscape;
    NSMutableArray *controlPointsForiPadRetina;
    NSMutableArray *controlPointsForiPadRetinaLandscape;
    
    NSMutableDictionary *wordsForLetter;
    
}

@property (nonatomic,retain) AVAudioPlayer *baseSound;
@property (nonatomic,retain) AVAudioPlayer *wordSample1;
@property (nonatomic,retain) AVAudioPlayer *wordSample2;
@property (nonatomic,retain) AVAudioPlayer *wordSample3;
@property (nonatomic,retain) AVAudioPlayer *wordSample4;
@property (nonatomic,retain) NSMutableDictionary *wordsForLetter;

@property (nonatomic,retain) SKEmitterNode *emitFire;
@property (nonatomic,retain) NSNumber *numberAttempts;
@property (nonatomic,retain) NSNumber *timeForTrace;
@property (nonatomic,retain) NSString *whichLetter;
@property BOOL centerStage;

-(void) playTheSound;
-(void) playWordSample:(NSNumber *)wordNumber;
-(void) createControlPoints:(NSMutableArray *)controlPointsForLetter;
-(void) atCenterStage;
-(void) fireEmitter;





@end
