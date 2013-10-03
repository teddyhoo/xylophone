//
//  TopicPicker.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/12/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Quizzer.h"

@class TopicPicker;

@protocol TopicPickerDelegate <NSObject>

@optional
-(void)selectedTopic:(NSString *)theSelection;

@required

@end


@interface TopicPicker : SKSpriteNode {

    id <TopicPickerDelegate> _delegate;
    
    
}

-(void)setDelegate:(id)delegate;

@property (nonatomic,retain) SKLabelNode* topic1;
@property (nonatomic,retain) SKLabelNode* topic2;
@property (nonatomic,retain) SKLabelNode* topic3;
@property (nonatomic,retain) SKLabelNode* topic4;
@property (nonatomic,retain) SKLabelNode* topic5;
@property (nonatomic,retain) SKLabelNode* topic6;
@property (nonatomic,retain) SKLabelNode* topic7;
@property (nonatomic,retain) SKLabelNode* topic8;
@property (nonatomic,retain) SKLabelNode* topic9;
@property (nonatomic,retain) SKLabelNode* topic10;
@property (nonatomic,retain) SKLabelNode* topic11;
@property (nonatomic,retain) SKLabelNode* topic12;
@property (nonatomic,retain) SKLabelNode* topic13;
@property (nonatomic,retain) SKLabelNode* topic14;
@property (nonatomic,retain) SKLabelNode* topic15;
@property (nonatomic,retain) SKLabelNode* topic16;
@property (nonatomic,retain) SKLabelNode* topic17;
@property (nonatomic,retain) SKLabelNode* topic18;
@property (nonatomic,retain) SKLabelNode* topic19;
@property (nonatomic,retain) SKLabelNode* topic20;
@property (nonatomic,retain) SKLabelNode* topic21;
@property (nonatomic,retain) SKLabelNode* topic22;
@property (nonatomic,retain) SKLabelNode* topic23;


//@property (nonatomic,retain) id<TopicPickerDelegate> delegate;

@end
