//
//  RecordSound.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/25/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <SpriteKit/SpriteKit.h>

@interface RecordSound : SKNode <AVAudioPlayerDelegate, AVAudioRecorderDelegate>

-(instancetype)initWithPosition:(CGPoint)position;


@property (readonly,nonatomic)CGSize layerSize;


@end
