//
//  MainMenu.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/18/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "SmoothLineView.h"

@interface MainMenu : SKScene 
{
    SmoothLineView *slv;
    
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
    
}

@property BOOL contentCreated;

@property (nonatomic, retain) IBOutlet UIButton *undoButton;
@property (nonatomic, retain) IBOutlet UIButton *redoButton;
@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *eraserButton;
@property (nonatomic, retain) IBOutlet UIButton *save2FileButton;
@property (nonatomic, retain) IBOutlet UIButton *save2AlbumButton;
@property (nonatomic, retain) NSMutableArray *controlPointsLetterA;


@property (nonatomic, retain) SKSpriteNode *letterA;
@property (nonatomic, retain) SKSpriteNode *letterB;
@property (nonatomic, retain) SKSpriteNode *letterC;
@property (nonatomic, retain) SKSpriteNode *letterM;
@property (nonatomic, retain) SKSpriteNode *letterS;
@property (nonatomic, retain) SKSpriteNode *letterT;

@property (nonatomic, retain) SKSpriteNode *handTracer;
@property (nonatomic, retain) SKSpriteNode *handTracerLeft;
@property (nonatomic, retain) SKSpriteNode *handTracerBottom;
@property (nonatomic, retain) SKSpriteNode *handTracerRight;


@property (nonatomic, retain) SKSpriteNode *handStraight;
@property (nonatomic, retain) SKSpriteNode *handLeft;


-(void) setUndoButtonEnable:(NSNumber*)isEnable;
-(void) setRedoButtonEnable:(NSMutableArray*)controlPointsForLetter;
-(void) setClearButtonEnable:(NSNumber*)isEnable;
-(void) setEraserButtonEnable:(NSNumber*)isEnable;
-(void) setSave2FileButtonEnable:(NSNumber*)isEnable;
-(void) setSave2AlbumButtonEnable:(NSNumber*)isEnable;


@end
