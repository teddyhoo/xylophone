//
//  SmoothLineView.h
//  Smooth Line View
//
//  Created by Levi Nunnink on 8/15/11.
//  Copyright 2011 culturezoo. All rights reserved.
//
//  modify by Hanson @ Splashtop

#import <UIKit/UIKit.h>

enum
{
	DRAW					= 0x0000,
	CLEAR					= 0x0001,
	ERASE					= 0x0002,
	UNDO					= 0x0003,
	REDO					= 0x0004,
};

@interface SmoothLineView : UIView {
    
    id delegate;
    
    NSMutableArray *pathArray;
    NSMutableArray *lineArray;
    NSMutableArray *bufferArray;
    NSMutableArray *colorArray;
    NSMutableArray *lineSegmentArray;
    
    
    CGPoint currentPoint;
    CGPoint previousPoint1;
    CGPoint previousPoint2;
    CGFloat lineWidth;
    UIColor *lineColor;
    CGFloat lineAlpha;
    
    
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
    
    
    UIImage *curImage;
    
    int drawStep;

}
@property (nonatomic, retain) UIColor *lineColor;
@property (nonatomic, retain) UIColor *correctColor;
@property (nonatomic, retain) UIColor *incorrectColor;
@property (readwrite) CGFloat lineWidth;
@property (readwrite) CGFloat lineAlpha;
@property (atomic, retain) NSMutableArray *controlPointsLetter;
@property (atomic, retain) NSMutableArray *checkControlPoints;
@property BOOL allControlPoints;
@property (nonatomic, retain) NSNumber *xSensitivity;
@property (nonatomic, retain) NSNumber *ySensitivity;
@property (nonatomic,retain) NSNumber *onQuestion;
@property(assign) id delegate;



- (void)calculateMinImageArea:(CGPoint)pp1 :(CGPoint)pp2 :(CGPoint)cp;
- (void)redoButtonClicked;
- (void)undoButtonClicked:(NSMutableArray*)controlPointsForLetter;
- (void)clearButtonClicked;
- (void)eraserButtonClicked;
- (void)save2FileButtonClicked;
- (void)save2AlbumButtonClicked;
- (void)addControlPointsForNextProblem;


- (void)setColor:(float)r g:(float)g b:(float)b a:(float)a;

- (void)checkDrawStatus;


@end
