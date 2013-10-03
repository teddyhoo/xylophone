//
//  SmoothLineView.m
//  Smooth Line View
//
//  Created by Levi Nunnink on 8/15/11.
//  Copyright 2011 culturezoo. All rights reserved.
//
//  modify by Hanson @ Splashtop

#import "SmoothLineView.h"
#import <QuartzCore/QuartzCore.h>
#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

#define DEFAULT_COLOR [UIColor redColor]
#define CORRECT_COLOR [UIColor redColor]
#define INCORRECT_COLOR [UIColor redColor]
#define DEFAULT_WIDTH 10.0f
#define DEFAULT_ALPHA 0.8f

@interface SmoothLineView () 

#pragma mark Private Helper function

CGPoint midPoint(CGPoint p1, CGPoint p2);

@end

@implementation SmoothLineView

ViewController *parentViewController;

@synthesize lineAlpha;
@synthesize lineColor;
@synthesize lineWidth;
@synthesize delegate;
@synthesize controlPointsLetter;
@synthesize checkControlPoints;
@synthesize allControlPoints;
@synthesize xSensitivity, ySensitivity;
@synthesize onQuestion;


int xSens;
int ySens;
BOOL allControlPointsHit;
BOOL startNewQuestion;
AVAudioPlayer *avSound;
AVAudioPlayer *whoopsMessage;
AVAudioPlayer *awesomeMessage;
AVAudioPlayer *magicalSweep;
AVAudioPlayer *gameShowLose;
AVAudioPlayer *letterAsound;

#pragma mark -

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        screenRect = [[UIScreen mainScreen] bounds];
        screenHeight = screenRect.size.height;
        screenWidth = screenRect.size.width;
        
        NSLog(@"screen height %f", screenHeight);
        NSLog(@"screen width %f", screenWidth);
        
        
        self.backgroundColor = [UIColor clearColor];
        self.lineWidth = DEFAULT_WIDTH;
        self.lineColor = DEFAULT_COLOR;
        self.lineAlpha = DEFAULT_ALPHA;
        self.correctColor = CORRECT_COLOR;
        self.incorrectColor = INCORRECT_COLOR;

        NSURL *letterAurl = [[NSBundle mainBundle]URLForResource:@"letterAsound" withExtension:@"mp3"];
        letterAsound = [[AVAudioPlayer alloc]initWithContentsOfURL:letterAurl error:nil];
        
        
        NSURL *soundURL = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_correct" withExtension:@"wav"];
        avSound = [[AVAudioPlayer alloc]initWithContentsOfURL:soundURL error:nil];

        NSURL *incorrectSound  = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_oops_try_again" withExtension:@"wav"];
        whoopsMessage = [[AVAudioPlayer alloc]initWithContentsOfURL:incorrectSound error:nil];
        
        NSURL *hitPoint  = [[NSBundle mainBundle]URLForResource:@"voice_girl_tween_awesome" withExtension:@"wav"];
        awesomeMessage = [[AVAudioPlayer alloc]initWithContentsOfURL:hitPoint error:nil];
        
        NSURL *magicalSweepURL  = [[NSBundle mainBundle]URLForResource:@"magical_sweep_01" withExtension:@"wav"];
        magicalSweep = [[AVAudioPlayer alloc]initWithContentsOfURL:magicalSweepURL error:nil];
        
        NSURL *gameShowLoseURL  = [[NSBundle mainBundle]URLForResource:@"game_show_lose_04" withExtension:@"wav"];
        gameShowLose = [[AVAudioPlayer alloc]initWithContentsOfURL:gameShowLoseURL error:nil];
        
        bufferArray=[[NSMutableArray alloc]init];
        lineArray=[[NSMutableArray alloc]init];
        colorArray=[[NSMutableArray alloc]init];
        
        xSensitivity = [NSNumber numberWithInteger:20];
        ySensitivity = [NSNumber numberWithInteger:20];
        
        xSens = [xSensitivity intValue];
        ySens = [ySensitivity intValue];
        
        allControlPointsHit = FALSE;
        startNewQuestion = FALSE;

    }
  
    return self;
}

-(void) addControlPointsForNextProblem {
    
    [controlPointsLetter removeAllObjects];
    [checkControlPoints removeAllObjects];
    
    int questionNumber = [onQuestion intValue];
    
    NSLog(@"called addControlPointsForNextProblem: %i", questionNumber);
    
    
    if (questionNumber == 0) {
        //iPhone Retina values - portrait
        
        //float startPointX = 190;
        //float endPointY = 121;
        
        // iPad normal values - portrait
        float startPointX = 630;
        float endPointY = 455;
        
        
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX - 104, endPointY + 10);
        CGPoint controlPoint3 = CGPointMake(startPointX - 120, endPointY + 25);
        CGPoint controlPoint4 = CGPointMake(startPointX - 126, endPointY + 45);
        CGPoint controlPoint5 = CGPointMake(startPointX - 144, endPointY + 60);
        CGPoint controlPoint6 = CGPointMake(startPointX - 134, endPointY + 81);
        CGPoint controlPoint7 = CGPointMake(startPointX - 100, endPointY + 86);
        CGPoint controlPoint8 = CGPointMake(startPointX - 60, endPointY + 86);
        CGPoint controlPoint9 = CGPointMake(startPointX - 32, endPointY + 71);
        CGPoint controlPoint10 = CGPointMake(startPointX - 14, endPointY + 66);
        CGPoint controlPoint11 = CGPointMake(startPointX + 2, endPointY + 30);
        
        //iphone retina
        
        /*CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX - 52, endPointY + 10);
        CGPoint controlPoint3 = CGPointMake(startPointX - 60, endPointY + 25);
        CGPoint controlPoint4 = CGPointMake(startPointX - 63, endPointY + 45);
        CGPoint controlPoint5 = CGPointMake(startPointX - 72, endPointY + 60);
        CGPoint controlPoint6 = CGPointMake(startPointX - 67, endPointY + 81);
        CGPoint controlPoint7 = CGPointMake(startPointX - 50, endPointY + 86);
        CGPoint controlPoint8 = CGPointMake(startPointX - 30, endPointY + 86);
        CGPoint controlPoint9 = CGPointMake(startPointX - 16, endPointY + 71);
        CGPoint controlPoint10 = CGPointMake(startPointX - 7, endPointY + 66);
        CGPoint controlPoint11 = CGPointMake(startPointX +1, endPointY + 30);
        */
        
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
        
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [letterAsound play];
        
    } else if (questionNumber == 1) {
        
        float startPointX = 140;
        float endPointY = 60;
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX , endPointY + 10);
        CGPoint controlPoint3 = CGPointMake(startPointX, endPointY + 30);
        CGPoint controlPoint4 = CGPointMake(startPointX, endPointY + 50);
        CGPoint controlPoint5 = CGPointMake(startPointX, endPointY + 70);
        CGPoint controlPoint6 = CGPointMake(startPointX, endPointY + 90);
        CGPoint controlPoint7 = CGPointMake(startPointX, endPointY + 100);
        CGPoint controlPoint8 = CGPointMake(startPointX, endPointY + 120);
        CGPoint controlPoint9 = CGPointMake(startPointX, endPointY + 140);
        CGPoint controlPoint10 = CGPointMake(startPointX, endPointY + 160);
        CGPoint controlPoint11 = CGPointMake(startPointX, endPointY + 180);
    
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
    
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        
    } else if (questionNumber == 2) {
        float startPointX = 200;
        float endPointY = 66;
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX - 40 , endPointY + 0);
        CGPoint controlPoint3 = CGPointMake(startPointX - 55, endPointY + 25);
        CGPoint controlPoint4 = CGPointMake(startPointX - 65, endPointY + 45);
        CGPoint controlPoint5 = CGPointMake(startPointX - 70, endPointY + 70);
        CGPoint controlPoint6 = CGPointMake(startPointX - 70, endPointY + 90);
        CGPoint controlPoint7 = CGPointMake(startPointX - 65, endPointY + 120);
        CGPoint controlPoint8 = CGPointMake(startPointX - 60, endPointY + 160);
        CGPoint controlPoint9 = CGPointMake(startPointX - 30, endPointY + 170);
        CGPoint controlPoint10 = CGPointMake(startPointX - 10, endPointY + 175);
        //CGPoint controlPoint11 = CGPointMake(startPointX +1, endPointY + 30);
        
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
        
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        /* [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
         [checkControlPoints addObject:[NSNumber numberWithInt:0]];*/
        
    } else if (questionNumber == 3) {
        float startPointX = 200;
        float endPointY = 80;
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX , endPointY + 10);
        CGPoint controlPoint3 = CGPointMake(startPointX, endPointY + 40);
        CGPoint controlPoint4 = CGPointMake(startPointX, endPointY + 70);
        CGPoint controlPoint5 = CGPointMake(startPointX, endPointY + 100);
        CGPoint controlPoint6 = CGPointMake(startPointX, endPointY + 130);
        CGPoint controlPoint7 = CGPointMake(startPointX - 30, endPointY + 130);
        CGPoint controlPoint8 = CGPointMake(startPointX - 45, endPointY + 135);
        CGPoint controlPoint9 = CGPointMake(startPointX - 60, endPointY + 145);
        CGPoint controlPoint10 = CGPointMake(startPointX - 45, endPointY + 165);
        CGPoint controlPoint11 = CGPointMake(startPointX - 30, endPointY + 165);
        
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
        
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        
    } else if (questionNumber == 4) {
        
        float startPointX = 135;
        float endPointY = 60;
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX , endPointY + 10);
        CGPoint controlPoint3 = CGPointMake(startPointX, endPointY + 40);
        CGPoint controlPoint4 = CGPointMake(startPointX, endPointY + 80);
        CGPoint controlPoint5 = CGPointMake(startPointX, endPointY + 110);
        CGPoint controlPoint6 = CGPointMake(startPointX, endPointY + 150);
        CGPoint controlPoint7 = CGPointMake(startPointX, endPointY + 110);
        CGPoint controlPoint8 = CGPointMake(startPointX, endPointY + 140);
        CGPoint controlPoint9 = CGPointMake(startPointX, endPointY + 170);
        CGPoint controlPoint10 = CGPointMake(startPointX, endPointY + 200);
        CGPoint controlPoint11 = CGPointMake(startPointX, endPointY + 210);
        
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
        
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
         
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
    } else if (questionNumber == 5) {
        
        float startPointX = 160;
        float endPointY = 60;
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX - 10, endPointY);
        CGPoint controlPoint3 = CGPointMake(startPointX - 10, endPointY + 10);
        CGPoint controlPoint4 = CGPointMake(startPointX - 30, endPointY + 40);
        CGPoint controlPoint5 = CGPointMake(startPointX - 20, endPointY + 70);
        CGPoint controlPoint6 = CGPointMake(startPointX - 10, endPointY + 100);
        CGPoint controlPoint7 = CGPointMake(startPointX + 10, endPointY + 140);
        CGPoint controlPoint8 = CGPointMake(startPointX + 15, endPointY + 170);
        CGPoint controlPoint9 = CGPointMake(startPointX + 20, endPointY + 190);
        CGPoint controlPoint10 = CGPointMake(startPointX + 20, endPointY + 210);
        CGPoint controlPoint11 = CGPointMake(startPointX - 20, endPointY + 210);
        
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
        
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
    } else if (questionNumber == 6) {
        
        float startPointX = 135;
        float endPointY = 60;
        controlPointsLetter = [[NSMutableArray alloc]init];
        checkControlPoints = [[NSMutableArray alloc]init];
        CGPoint controlPoint1 = CGPointMake(startPointX, endPointY);
        CGPoint controlPoint2 = CGPointMake(startPointX , endPointY + 10);
        CGPoint controlPoint3 = CGPointMake(startPointX, endPointY + 40);
        CGPoint controlPoint4 = CGPointMake(startPointX, endPointY + 80);
        CGPoint controlPoint5 = CGPointMake(startPointX, endPointY + 110);
        CGPoint controlPoint6 = CGPointMake(startPointX, endPointY + 150);
        CGPoint controlPoint7 = CGPointMake(startPointX, endPointY + 110);
        CGPoint controlPoint8 = CGPointMake(startPointX, endPointY + 140);
        CGPoint controlPoint9 = CGPointMake(startPointX, endPointY + 170);
        CGPoint controlPoint10 = CGPointMake(startPointX, endPointY + 200);
        CGPoint controlPoint11 = CGPointMake(startPointX, endPointY + 210);
        
        NSValue *controlPoint1CG = [NSValue valueWithCGPoint:controlPoint1];
        
        [controlPointsLetter addObject:controlPoint1CG];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint2]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint3]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint4]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint5]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint6]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint7]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint8]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint9]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint10]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        [controlPointsLetter addObject:[NSValue valueWithCGPoint:controlPoint11]];
        [checkControlPoints addObject:[NSNumber numberWithInt:0]];
        
        
    }
}


-(void) animateActionsForNextQuestion {


}

- (void)drawRect:(CGRect)rect
{
    
    switch (drawStep) {
        case DRAW:
        {
            [curImage drawAtPoint:CGPointMake(0, 0)];
            CGPoint mid1 = midPoint(previousPoint1, previousPoint2); 
            CGPoint mid2 = midPoint(currentPoint, previousPoint1);
            CGContextRef context = UIGraphicsGetCurrentContext(); 
            
            [self.layer renderInContext:context];
            CGContextMoveToPoint(context, mid1.x, mid1.y);
            CGContextAddQuadCurveToPoint(context, previousPoint1.x, previousPoint1.y, mid2.x, mid2.y); 
            CGContextSetLineCap(context, kCGLineCapButt);
            CGContextSetLineWidth(context, self.lineWidth);
            CGContextSetStrokeColorWithColor(context, self.lineColor.CGColor);
            CGContextSetAlpha(context, self.lineAlpha);
            CGContextStrokePath(context);            
            [super drawRect:rect];
            //[curImage release];
            
        }
            break;
        case CLEAR:
        {
            CGContextRef context = UIGraphicsGetCurrentContext(); 
            CGContextClearRect(context, rect);
            break;
        }
        case ERASE:
        {
            [curImage drawAtPoint:CGPointMake(0, 0)];
            CGContextRef context = UIGraphicsGetCurrentContext(); 
            CGContextClearRect(context, rect);
            [super drawRect:rect];
            //[curImage release];
            
        }
            break;
        case UNDO:
        {
            [curImage drawInRect:self.bounds];   
            break;
        }
        case REDO:
        {
            [curImage drawInRect:self.bounds];   
            break;
        }
            
        default:
            break;
    }
    
    int control_point_count = 0;
    BOOL prevControlPointHit = FALSE;
    BOOL currControlPointHit = FALSE;
    
    int atPoint = 0;

    UIImage *controlPointImage = [[UIImage alloc]init];
    [controlPointImage drawAtPoint:CGPointMake(0, 0)];
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.layer renderInContext:context];
    CGContextMoveToPoint(context, 20, 20);
    CGContextAddLineToPoint(context, 40, 20);

    CGContextSetLineCap(context, kCGLineCapButt);
    CGContextSetLineWidth(context, 4);
    CGContextSetStrokeColorWithColor(context, self.correctColor.CGColor);
    CGContextSetAlpha(context, self.lineAlpha);
    CGContextStrokePath(context);
    [super drawRect:rect];
    //[controlPointImage release];
    
    for (NSValue *controlPointMarkers in controlPointsLetter) {
        
        
        NSNumber *control_point_flag = [checkControlPoints objectAtIndex:control_point_count];
        int control_point_bool = [control_point_flag intValue];
        CGPoint theControlPoint = [controlPointMarkers CGPointValue];
        
        if (control_point_bool == 1 && allControlPointsHit == FALSE) {
            
            if (atPoint == 0) {
                prevControlPointHit = TRUE;
                currControlPointHit = TRUE;
                
                NSLog(@"correct");
                
                CGPoint theControlPoint = [controlPointMarkers CGPointValue];

                UIImage *controlPointImage = [[UIImage alloc]init];
                [controlPointImage drawAtPoint:CGPointMake(0, 0)];
                CGContextRef context = UIGraphicsGetCurrentContext();
                [self.layer renderInContext:context];
                CGContextMoveToPoint(context, theControlPoint.x, theControlPoint.y);
                CGContextAddLineToPoint(context, theControlPoint.x+5, theControlPoint.y+12);
                CGContextAddLineToPoint(context, theControlPoint.x+15, theControlPoint.y-10);
                CGContextSetLineCap(context, kCGLineCapButt);
                CGContextSetLineWidth(context, 4);
                CGContextSetStrokeColorWithColor(context, self.correctColor.CGColor);
                CGContextSetAlpha(context, self.lineAlpha);
                CGContextStrokePath(context);
                [super drawRect:rect];
                //[controlPointImage release];
    
        
            } else {
                NSNumber *control_point_flag_inner = [checkControlPoints objectAtIndex:control_point_count-1];
                int control_point_bool_inner = [control_point_flag_inner intValue];

                if (control_point_bool_inner == 0) {
                    
                    CGPoint theControlPoint = [controlPointMarkers CGPointValue];

                    
                    UIImage *controlPointImage = [[UIImage alloc]init];
                    [controlPointImage drawAtPoint:CGPointMake(0, 0)];
                    
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    [self.layer renderInContext:context];
                    
                    CGContextMoveToPoint(context, theControlPoint.x, theControlPoint.y);
                    CGContextAddLineToPoint(context, theControlPoint.x+5, theControlPoint.y+12);
                    CGContextAddLineToPoint(context, theControlPoint.x+15, theControlPoint.y-10);
                    CGContextSetLineCap(context, kCGLineCapButt);
                    CGContextSetLineWidth(context, 4);
                    CGContextSetStrokeColorWithColor(context, self.incorrectColor.CGColor);
                    CGContextSetAlpha(context, self.lineAlpha);
                    CGContextStrokePath(context);
                    [super drawRect:rect];
                    //[controlPointImage release];
                    
                } else {
                    
                    currControlPointHit = TRUE;
                    prevControlPointHit = TRUE;
                    
                    NSLog(@"correct");
                    
                    CGPoint theControlPoint = [controlPointMarkers CGPointValue];
                    
                    UIImage *controlPointImage = [[UIImage alloc]init];
                    [controlPointImage drawAtPoint:CGPointMake(0, 0)];
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    [self.layer renderInContext:context];
                    CGContextMoveToPoint(context, theControlPoint.x, theControlPoint.y);
                    CGContextAddLineToPoint(context, theControlPoint.x+5, theControlPoint.y+12);
                    CGContextAddLineToPoint(context, theControlPoint.x+15, theControlPoint.y-10);
                    CGContextSetLineCap(context, kCGLineCapButt);
                    CGContextSetLineWidth(context, 4);
                    CGContextSetStrokeColorWithColor(context, self.correctColor.CGColor);
                    CGContextSetAlpha(context, self.lineAlpha);
                    CGContextStrokePath(context);
                    [super drawRect:rect];
                    //[controlPointImage release];
                }
            }
        }
        
        control_point_count++;
        atPoint++;
        
    }
    //}
    
}

#pragma mark Private Helper function


CGPoint midPoint(CGPoint p1, CGPoint p2)
{
    return CGPointMake((p1.x + p2.x) * 0.5, (p1.y + p2.y) * 0.5);
}

#pragma mark Gesture handle
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInView:self];
    
    previousPoint1 = [touch locationInView:self];
    previousPoint2 = [touch locationInView:self];
    currentPoint = [touch locationInView:self];
  
    NSLog(@"x: %f, y: %f", currentPoint.x, currentPoint.y);
    
    int arrayPosition = 0;
    
    for (NSValue *controlPointValue in controlPointsLetter) {
        
        CGPoint theControlPoint = [controlPointValue CGPointValue];
       
        CGRect hitRect = CGRectMake(theControlPoint.x-10, theControlPoint.y, 140, 140);
        
        if (CGRectContainsPoint(hitRect, theTouch)) {
            
            [checkControlPoints replaceObjectAtIndex:arrayPosition withObject:[NSNumber numberWithInt:1]];
            
        }
        
        arrayPosition++;
    }
    
    [delegate performSelectorOnMainThread:@selector(setRedoButtonEnable:)
                               withObject:controlPointsLetter
                            waitUntilDone:NO];

    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    UITouch *touch  = [touches anyObject];
    CGPoint theTouch = [touch locationInView:self];
    
    
    previousPoint2  = previousPoint1;
    previousPoint1  = currentPoint;
    currentPoint    = [touch locationInView:self];
    
    if(drawStep != ERASE) drawStep = DRAW;
    [self calculateMinImageArea:previousPoint1 :previousPoint2 :currentPoint];
    
    int arrayPosition = 0;

    for (NSValue *controlPointValue in controlPointsLetter) {
        
        CGPoint theControlPoint = [controlPointValue CGPointValue];
        CGRect hitRect = CGRectMake(theControlPoint.x-10, theControlPoint.y, xSens, ySens);
        
        if (CGRectContainsPoint(hitRect, theTouch)) {
            
            NSLog(@"---> hit control point moved, %f, %f",theControlPoint.x, theControlPoint.y);
            NSLog(@"---> number of control points: %i", [checkControlPoints count]);
            for (NSNumber *controlPointHits in checkControlPoints) {
                NSLog(@"values of control Point Hit Bool: %i", [controlPointHits intValue]);
                
            }
            [checkControlPoints replaceObjectAtIndex:arrayPosition withObject:[NSNumber numberWithInt:1]];
            [magicalSweep play];
            
        }
        
        // check second array, only when first array has been completed
        
        // code here
        
        //
        
        
        arrayPosition++;
    }
    
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    curImage = UIGraphicsGetImageFromCurrentImageContext();
    //[curImage retain];
    UIGraphicsEndImageContext();
    
    NSDictionary *lineSegmentInfo = [NSDictionary dictionaryWithObjectsAndKeys:curImage, @"IMAGE",nil];
    
    [lineSegmentArray addObject:lineSegmentInfo];
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
    

    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    curImage = UIGraphicsGetImageFromCurrentImageContext();
    //[curImage retain];
    UIGraphicsEndImageContext();
    
    NSDictionary *lineInfo = [NSDictionary dictionaryWithObjectsAndKeys:curImage, @"IMAGE",nil];
    
    [lineArray addObject:lineInfo];
    
    UITouch *touch = [touches anyObject];
    CGPoint currentLocation = [touch locationInView:self];
    //[curImage release];
    [self checkDrawStatus];
    
    int control_points = 0;
    
    
    allControlPoints = TRUE;
    
    for (NSNumber *controlPointHits in checkControlPoints) {
        
        if (control_points != 0) {
            NSNumber *control_point_flag = [checkControlPoints objectAtIndex:control_points-1];
            int control_point_bool = [control_point_flag intValue];
            int current_control_point_bool = [controlPointHits intValue];
            
            
            // All of the control points have to be ticked off
            if (control_point_bool == 0) {
                allControlPoints = FALSE;
            }
            
            // And the control points must be done in order
            if (control_point_bool != current_control_point_bool) {
                allControlPoints = FALSE;
            }
        }
        control_points++;
    }
    
    if (allControlPoints == TRUE) {
        
        [controlPointsLetter removeAllObjects];

        startNewQuestion = TRUE;

        [delegate performSelectorOnMainThread:@selector(setUndoButtonEnable:)
                                   withObject:[NSNumber numberWithBool:YES]
                                waitUntilDone:YES];
        
        
        
        [avSound play];

    }
    
    //allControlPoints = FALSE;
    //[self addControlPointsForNextProblem];
    
    
}


#pragma mark Private Helper function


- (void) calculateMinImageArea:(CGPoint)pp1 :(CGPoint)pp2 :(CGPoint)cp
{
    
    // calculate mid point
    CGPoint mid1    = midPoint(pp1, pp2); 
    CGPoint mid2    = midPoint(cp, pp1);
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, mid1.x, mid1.y);
    CGPathAddQuadCurveToPoint(path, NULL, pp1.x, pp1.y, mid2.x, mid2.y);
    CGRect bounds = CGPathGetBoundingBox(path);
    CGPathRelease(path);
    
    CGRect drawBox = bounds;
    
    //Pad our values so the bounding box respects our line width
    drawBox.origin.x        -= self.lineWidth * 2;
    drawBox.origin.y        -= self.lineWidth * 2;
    drawBox.size.width      += self.lineWidth * 4;
    drawBox.size.height     += self.lineWidth * 4;
    
    UIGraphicsBeginImageContext(drawBox.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    curImage = UIGraphicsGetImageFromCurrentImageContext();
    //[curImage retain];
    UIGraphicsEndImageContext();
    
    [self setNeedsDisplayInRect:drawBox];
    
    //http://stackoverflow.com/a/4766028/489594
    [[NSRunLoop currentRunLoop] runMode: NSDefaultRunLoopMode beforeDate: [NSDate date]];
    
}



-(void)redrawLine
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    CGContextSetStrokeColorWithColor(UIGraphicsGetCurrentContext(), self.correctColor.CGColor);
    NSDictionary *lineInfo = [lineSegmentArray lastObject];
    curImage = (UIImage*)[lineInfo valueForKey:@"IMAGE"];
    UIGraphicsEndImageContext();
    [self setNeedsDisplayInRect:self.bounds];    
}


#pragma mark Button Handle

-(void)undoButtonClicked
{
    if([lineArray count]>0){
        NSMutableArray *_line=[lineArray lastObject];
        [bufferArray addObject:[_line copy]];
        [lineArray removeLastObject];
        drawStep = UNDO;
        [self redrawLine];
    }
    [self checkDrawStatus];
}

-(void)redoButtonClicked:(NSMutableArray*)controlPoints
{
    if([bufferArray count]>0){
        NSMutableArray *_line=[bufferArray lastObject];
        [lineArray addObject:_line];
        [bufferArray removeLastObject];
        drawStep = REDO;
        [self redrawLine];
    }
    [self checkDrawStatus];
}
-(void)clearButtonClicked
{    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    curImage = UIGraphicsGetImageFromCurrentImageContext();
    //[curImage retain];
    UIGraphicsEndImageContext();
    drawStep = CLEAR;
    [self setNeedsDisplayInRect:self.bounds];
    [lineArray removeAllObjects];
    [bufferArray removeAllObjects];
    [self checkDrawStatus];
}

-(void)eraserButtonClicked
{    
    if(drawStep!=ERASE)
    {
        drawStep = ERASE;
    }
    else 
    {
        drawStep = DRAW;
    }
}

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {  
    NSString *message;  
    NSString *title;  
    if (!error) {  
        title = NSLocalizedString(@"SaveSuccessTitle", @"");  
        message = NSLocalizedString(@"SaveSuccessMessage", @"");  
    } else {  
        title = NSLocalizedString(@"SaveFailedTitle", @"");  
        message = [error description];  
    }  
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title  
                                                    message:message  
                                                   delegate:nil  
                                          cancelButtonTitle:NSLocalizedString(@"ButtonOK", @"")  
                                          otherButtonTitles:nil];  
    [alert show];  
    //[alert release];
}  

-(void)setColor:(float)r g:(float)g b:(float)b a:(float)a
{
    self.lineColor = [UIColor colorWithRed:r green:g blue:b alpha:a];
}

-(void)save2FileButtonClicked
{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MM-yyyy HH:mm:ss"];
    NSString *dateString = [dateFormat stringFromDate:today];
    
    NSString  *pngPath = [NSTemporaryDirectory() stringByAppendingPathComponent:[NSString stringWithFormat:@"Screenshot %@.png",dateString]];
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *saveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [UIImagePNGRepresentation(saveImage) writeToFile:pngPath atomically:YES];
    
}

//ref: http://iphoneincubator.com/blog/tag/uigraphicsbeginimagecontext
-(void)save2AlbumButtonClicked
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *saveImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    CGContextRef context = UIGraphicsGetCurrentContext(); 
    UIImageWriteToSavedPhotosAlbum(saveImage, self, @selector(imageSavedToPhotosAlbum: didFinishSavingWithError: contextInfo:),context);
}

#pragma mark toolbarDelegate Handle
- (void) checkDrawStatus
{

}

@end


