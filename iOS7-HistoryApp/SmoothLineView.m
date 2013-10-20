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
    previousPoint2  = previousPoint1;
    previousPoint1  = currentPoint;
    currentPoint    = [touch locationInView:self];
    
    if(drawStep != ERASE) drawStep = DRAW;
    [self calculateMinImageArea:previousPoint1 :previousPoint2 :currentPoint];
    
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


