//
//  LetterTrace.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
@import CoreImage;

@interface LetterTrace : SKScene {

    int drawStep;
    SKEffectNode *effectNode;
    CIFilter *filter;
    
    
}


@property (nonatomic,strong) SKSpriteNode* background;
@property (nonatomic,strong) SKSpriteNode* selectedNode;
@property (nonatomic,retain) NSTimer *timeForQuestion;

@end
