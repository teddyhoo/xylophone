//
//  RecordSound.m
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/25/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "RecordSound.h"
#import <SpriteKit/SpriteKit.h>

@implementation RecordSound

AVAudioRecorder *recorder;
AVAudioPlayer *player;
NSTimer *timer;

NSMutableArray *labelArray;

SKSpriteNode *soundIcon;
SKSpriteNode *playIcon;
SKSpriteNode *stopIcon;
SKSpriteNode *background;

SKLabelNode *recordingLabel;
SKLabelNode *finishedRecordLabel;
SKLabelNode *playbackLabel;
SKLabelNode *titleForRecording;

#define FILEPATH [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:[self dateString]]


-(instancetype)initWithPosition:(CGPoint)position {
    
    
    _layerSize = CGSizeMake(400, 400);
    if (self = [super init]) {
        self.userInteractionEnabled = YES;
        recordingLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        finishedRecordLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        playbackLabel = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        titleForRecording = [SKLabelNode labelNodeWithFontNamed:@"Carton-Slab"];
        
        titleForRecording.text = @"Record yourself";
        titleForRecording.fontSize = 32;
        titleForRecording.fontColor = [UIColor greenColor];
        titleForRecording.position = CGPointMake(750, 620);
        titleForRecording.name = @"label";
        
        recordingLabel.text = @"Recording...";
        recordingLabel.fontSize = 32;
        recordingLabel.fontColor = [UIColor redColor];
        recordingLabel.position = CGPointMake(745, 615);
        recordingLabel.name = @"label";
        
        finishedRecordLabel.text = @"Stopped...";
        finishedRecordLabel.fontSize = 32;
        finishedRecordLabel.fontColor = [UIColor redColor];
        finishedRecordLabel.position = CGPointMake(745, 615);
        finishedRecordLabel.name = @"label";
        
        playbackLabel.text = @"Playing...";
        playbackLabel.fontSize = 40;
        playbackLabel.fontColor = [UIColor orangeColor];
        playbackLabel.position = CGPointMake(750, 620);
        finishedRecordLabel.name = @"label";
        
        //[self addChild:titleForRecording];
        

        background = [SKSpriteNode spriteNodeWithImageNamed:@"audioContainer.png"];
        background.position = CGPointMake(800, 600);
        [self addChild:background];
        
        stopIcon = [SKSpriteNode spriteNodeWithImageNamed:@"playAudio.png"];
        stopIcon.position = CGPointMake(700, 600);
        stopIcon.scale = 0.55;
        [self addChild:stopIcon];
        
        soundIcon = [SKSpriteNode spriteNodeWithImageNamed:@"speaker-button-200x206.png"];
        soundIcon.position = CGPointMake(700, 600);
        soundIcon.scale = 0.55;

        [self addChild:soundIcon];
        
    }
    
    return self;
    
}


- (BOOL) record
{
	NSError *error;
	
    titleForRecording.alpha = 0.0;
    recordingLabel.alpha = 1.0;
    
	// Recording settings
	NSMutableDictionary *settings = [NSMutableDictionary dictionary];
    settings[AVFormatIDKey] = @(kAudioFormatLinearPCM);
    settings[AVSampleRateKey] = @(8000.0f);
    settings[AVNumberOfChannelsKey] = @(1); // mono
    settings[AVLinearPCMBitDepthKey] = @(16);
    settings[AVLinearPCMIsBigEndianKey] = @NO;
    settings[AVLinearPCMIsFloatKey] = @NO;
	
	NSURL *url = [NSURL fileURLWithPath:FILEPATH];
	
	recorder = [[AVAudioRecorder alloc] initWithURL:url settings:settings error:&error];
	if (!recorder)
	{
		NSLog(@"Error establishing recorder: %@", error.localizedFailureReason);
		return NO;
	}

    
    recorder.delegate = self;
	recorder.meteringEnabled = YES;
	
	if (![recorder prepareToRecord])
	{
		NSLog(@"Error: Prepare to record failed");
		//[self say:@"Error while preparing recording"];
		return NO;
	}
    
	if (![recorder record])
	{
		NSLog(@"Error: Record failed");
		//[self say:@"Error while attempting to record audio"];
		return NO;
	}
    
	return YES;
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
	// Prepare UI for recording
	//self.title = nil;
	//meter1.hidden = NO;
	//meter2.hidden = NO;
	//{
		// Return to play and record session
		NSError *error;
		if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
		{
			NSLog(@"Error: %@", error.localizedFailureReason);
			return;
		}
		//self.navigationItem.rightBarButtonItem = BARBUTTON(@"Record", @selector(record));
	//}
    
}

- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)aRecorder successfully:(BOOL)flag
{
	
    
    /*[self enumerateChildNodesWithName:@"label" usingBlock:^(SKNode *node, BOOL *stop) {
        SKLabelNode *label = (SKLabelNode*)node;
        [label removeFromParent];
    }];*/
    // Stop monitoring levels, time
	[timer invalidate];
	//meter1.progress = 0.0f;
	//meter1.hidden = YES;
	//meter2.progress = 0.0f;
	//meter2.hidden = YES;
	//self.navigationItem.leftBarButtonItem = nil;
	//self.navigationItem.rightBarButtonItem = nil;
    
    if (!flag)
        NSLog(@"Recording was flagged as unsuccessful");
    
    NSURL *url = recorder.url;
    NSString *result = [NSString stringWithFormat:@"File saved to %@", [url.path lastPathComponent]];
	//[self say:result];
    
    NSError *error;
	
	// Start playback
	player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    if (!player)
    {
        NSLog(@"Error establishing player for %@: %@", recorder.url, error.localizedFailureReason);
        return;
    }
	player.delegate = self;
	
	// Change audio session for playback
	if (![[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:&error])
	{
		NSLog(@"Error updating audio session: %@", error.localizedFailureReason);
		return;
	}
    
    [player prepareToPlay];
	[player play];
}


- (BOOL) startAudioSession
{
	// Prepare the audio session
	NSError *error;
	AVAudioSession *session = [AVAudioSession sharedInstance];
	
	if (![session setCategory:AVAudioSessionCategoryPlayAndRecord error:&error])
	{
		NSLog(@"Error setting session category: %@", error.localizedFailureReason);
		return NO;
	}
	
	if (![session setActive:YES error:&error])
	{
		NSLog(@"Error activating audio session: %@", error.localizedFailureReason);
		return NO;
	}
	
	return session.inputAvailable; // used to be inputIsAvailable
}
- (NSString *) dateString
{
	// return a formatted string for a file name
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	formatter.dateFormat = @"ddMMMYY_hhmmssa";
	return [[formatter stringFromDate:[NSDate date]] stringByAppendingString:@".aif"];
}


- (NSString *) formatTime: (int) num
{
	// return a formatted ellapsed time string
	int secs = num % 60;
	int min = num / 60;
	if (num < 60) return [NSString stringWithFormat:@"0:%02d", num];
	return	[NSString stringWithFormat:@"%d:%02d", min, secs];
}

- (void) stopRecording
{
    
	[recorder stop];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    CGPoint touchLocation  = [touch locationInNode:self];
    
    if(CGRectContainsPoint(soundIcon.frame, touchLocation)) {
        //[self addChild:recordingLabel];
        [self startAudioSession];
        [self record];
        [soundIcon removeFromParent];

    } else if (CGRectContainsPoint(stopIcon.frame, touchLocation)) {
        //[self stopRecording];
        NSLog(@"prepare to play");
        [player prepareToPlay];
        NSLog(@" play");
        [player play];
        //[self removeFromParent];
        
    }
    
}

@end
