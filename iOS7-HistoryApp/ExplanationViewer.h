//
//  ExplanationViewer.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 12/24/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//
#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface ExplanationViewer : SKNode

@property (readonly,nonatomic)CGSize layerSize;

-(void)setSize:(CGSize)size;

@end
