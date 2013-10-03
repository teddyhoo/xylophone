//
//  DTTimelineScene.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/2/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SmoothLineView.h"

@interface DTTimelineScene : SKScene
{
   
    
}

-(BOOL)checkCollision:(CGPoint)begX :(CGPoint)begY;
-(BOOL)checkCollisionEnd:(CGPoint)begX :(CGPoint)begY;


@end
