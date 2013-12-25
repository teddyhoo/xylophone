//
//  MatchPix.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/19/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MatchPix : SKScene

@property (nonatomic,retain) SKSpriteNode* gridPaper;
@property (nonatomic,retain) SKSpriteNode* selectedImage;

-(id)initWithSize:(CGSize)size onWhichGroup:(NSNumber *)group;

@end
