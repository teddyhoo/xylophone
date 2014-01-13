//
//  ArrowWithEmitter.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/10/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h> 


@interface ArrowWithEmitter : SKSpriteNode;

@property (nonatomic,retain) NSString* directionArrow;

-(instancetype)initWithDirection:(NSString*)direction;
-(void)fireEmitter;
-(void)setDirection:(NSString*)direction;

@end
