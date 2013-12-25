//
//  MatchImage.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/16/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface MatchImage : SKSpriteNode

-(id)init:(NSString*)imageFile;

@property (nonatomic,retain) NSString* letter;


@end
