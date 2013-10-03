//
//  Parallax.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 9/19/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Parallax : SKNode

@property (nonatomic, assign) CGFloat parallaxSpeed;

- (instancetype)initWithBackground:(NSString *)file size:(CGSize)size;
- (instancetype)initWithBackgrounds:(NSArray *)files size:(CGSize)size;
- (void)update:(NSTimeInterval)currentTime;

@end

