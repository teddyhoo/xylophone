//
//  ViewController.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 7/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "ViewController.h"
#import "MyScrollView.h"
#import "MainMenu.h"
#import "IntroScreen.h"
#import "WorldHistoryMainMenu.h"


@implementation ViewController

@synthesize myScrollView;
@synthesize introScreen;
MainMenu *theMainMenu;


/*
- (void)viewDidLoad
{
    [super viewDidLoad];
 
    // Configure the view.
    //SKView * skView = (SKView *)self.view;
    //skView.showsFPS = YES;
    //skView.showsNodeCount = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *imageToLoad = [UIImage imageNamed:@"Arrow-blue-longest.png"];
    UIImageView *myImageView = [[UIImageView alloc]initWithImage:imageToLoad];
    myScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 500, 1000, 1000)];
    myScrollView.contentSize = CGSizeMake(1000,10000);
    [myScrollView setAlpha:1.0];
    myScrollView.showsHorizontalScrollIndicator = YES;
    [myScrollView addSubview:myImageView];
    //[self.view addSubview:myScrollView ];
    
    for (int p=0; p < 10; p++) {
        UIImage *loadImage = [UIImage imageNamed:@"Arrow-blue-longest.png"];
        UIImageView *theImageView = [[UIImageView alloc]initWithImage:loadImage];
        theImageView.center = CGPointMake(10+1000*.5*p,100*p);
        [myScrollView addSubview:theImageView];
        
    }
    
}
*/


-(void) viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    spriteView = (SKView *)self.view;
    spriteView.showsFPS = YES;
    spriteView.showsNodeCount = YES;
    
    if(!spriteView.scene) {
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];
        introScreen = [IntroScreen sceneWithSize:spriteView.bounds.size];
        //introScreen.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:introScreen transition:reveal];
    }
    
}


//-(void)viewWillAppear:(BOOL)animated {
    
    //introScreen = [[IntroScreen alloc]initWithSize:CGSizeMake(768,1024)];
    //introScreen = [[WorldHistoryMainMenu alloc]initWithSize:CGSizeMake(768,1024)];
    
    //theMainMenu = [[IntroScreen alloc]initWithSize:CGSizeMake(768, 1024)];
    
    //WorldHistoryMainMenu *worldHistoryIntro = [[WorldHistoryMainMenu alloc]initWithSize:CGSizeMake(768,1024)];
    //spriteView = (SKView *)self.view;
    //SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionDown duration:1.0];

    //[spriteView presentScene:introScreen transition:reveal];
    //[spriteView presentScene:worldHistoryIntro transition:reveal];
    //worldHistoryIntro.scaleMode = SKSceneScaleModeResizeFill;
    
//}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    myScrollView.alpha = 0.50;
    
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    myScrollView.alpha = 1.0;
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    myScrollView.alpha = 1.0;
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInView:self.view];
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInView:self.view];
    
    
}

-(void) setUndoButtonEnable:(NSNumber*)isEnable
{
}
-(void) setRedoButtonEnable:(NSNumber*)isEnable
{
}
-(void) setClearButtonEnable:(NSNumber*)isEnable
{
}
-(void) setEraserButtonEnable:(NSNumber*)isEnable
{
}
-(void) setSave2FileButtonEnable:(NSNumber*)isEnable
{
}
-(void) setSave2AlbumButtonEnable:(NSNumber*)isEnable
{
}


- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

@end
