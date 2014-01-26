//
//  LetterTrace.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Options.h"
@import CoreImage;

@interface LetterTrace : SKScene <AVAudioPlayerDelegate,AVAudioRecorderDelegate,OptionsDelegate> {

    int drawStep;
    SKEffectNode *effectNode;
    CIFilter *filter;
    
    Options *optionsDisplay;
}



@property (nonatomic,strong) SKSpriteNode* background;
@property (nonatomic,strong) SKSpriteNode* selectedNode;
@property (nonatomic,retain) NSTimer *timeForQuestion;
@property (nonatomic,strong) AVAudioRecorder *audioRecorder;
@property (nonatomic,strong) AVAudioPlayer *audioPlayer;

-(id)initWithSize:(CGSize)size andGroup:(NSNumber *)groupID;

@end
