//
//  GroupLetterNode.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 11/13/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GroupLetterNode : SKNode


@property (nonatomic,retain) NSString* groupID;
@property (nonatomic,retain) NSMutableArray* drawnShapeData;

-(void)initWithGroupID:(NSString *)IDforGroup;

-(void)moveToShow;
-(void)moveOffScreen;
-(void)playTheSound;
-(void)displayLetterHistory;
-(void)addNodeForLetter:(NSArray *)shapeSpritesForNode;


@end
