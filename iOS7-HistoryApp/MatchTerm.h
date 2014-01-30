//
//  MatchTerm.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 1/27/14.
//  Copyright (c) 2014 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface MatchTerm : SKSpriteNode

@property BOOL matched;


-(void)causes:(NSString *)cause1 cause2:(NSString*)cause2 cause3:(NSString*)cause3;
-(void)effects:(NSString *)effect1 effect2:(NSString*)effect2 effect3:(NSString*)effect3;

-(instancetype)initWithDirection:(NSString *)direction;


@end
