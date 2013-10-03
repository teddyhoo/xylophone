//
//  ViewController.h
//  iOS7-HistoryApp
//

//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>
#import "SmoothLineView.h"
#import "IntroScreen.h"

@interface ViewController : UIViewController <UIScrollViewDelegate>
{
    SmoothLineView *slv;
    
    SKView *spriteView;
}

@property (nonatomic, retain) IBOutlet UIButton *undoButton;
@property (nonatomic, retain) IBOutlet UIButton *redoButton;
@property (nonatomic, retain) IBOutlet UIButton *clearButton;
@property (nonatomic, retain) IBOutlet UIButton *eraserButton;
@property (nonatomic, retain) IBOutlet UIButton *save2FileButton;
@property (nonatomic, retain) IBOutlet UIButton *save2AlbumButton;

-(void) setUndoButtonEnable:(NSNumber*)isEnable;
-(void) setRedoButtonEnable:(NSNumber*)isEnable;
-(void) setClearButtonEnable:(NSNumber*)isEnable;
-(void) setEraserButtonEnable:(NSNumber*)isEnable;
-(void) setSave2FileButtonEnable:(NSNumber*)isEnable;
-(void) setSave2AlbumButtonEnable:(NSNumber*)isEnable;

@property (nonatomic,strong) UIImageView *myImageView;
@property (nonatomic,strong) UIScrollView *myScrollView;
@property (nonatomic,strong) IntroScreen *introScreen;



@end
