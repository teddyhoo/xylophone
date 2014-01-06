//
//  RedrawLetter.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 11/5/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "LowerCaseLetter.h"

@interface RedrawLetter : SKNode

-(instancetype)initWithPosition:(CGPoint) position withKey:(NSNumber*)keyForLetter;
-(instancetype)initWithPosition:(CGPoint)position withLetter:(LowerCaseLetter*)letter;

-(void)addPointToNode:(SKSpriteNode*)drawnPoint;
-(NSMutableArray *)drawMyself;

@property (nonatomic,retain)NSNumber* timeToComplete;
@property (nonatomic,retain)NSString* representLetter;
@property (nonatomic,retain)NSString* representGroup;
@property (nonatomic,retain)LowerCaseLetter* letterData;
@property (nonatomic,retain)NSMutableArray *spritePointObjects;
@property (readonly,nonatomic)CGSize layerSize;
@property (nonatomic,retain)NSString *dateDrawn;


@end
