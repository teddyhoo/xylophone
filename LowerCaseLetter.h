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
    
}

@property (nonatomic,retain) AVAudioPlayer *baseSound;
@property (nonatomic,retain) AVAudioPlayer *wordSample1;
@property (nonatomic,retain) AVAudioPlayer *wordSample2;
@property (nonatomic,retain) AVAudioPlayer *wordSample3;
@property (nonatomic,retain) AVAudioPlayer *wordSample4;



-(void) playTheSound;
-(void) playWordSample:(NSNumber *)wordNumber;
-(void) createControlPoints:(NSMutableArray *)controlPointsForLetter;
@end
