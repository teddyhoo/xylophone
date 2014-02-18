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
#import "DollarPGestureRecognizer.h"
#import "DollarDefaultGestures.h"
#import "LetterTrace.h"

@implementation ViewController {

    SKView *spriteView;
    GestureView *dollarPView;
    IntroScreen *theMainMenu;
    LetterTrace *traceScene;
    

    DollarPGestureRecognizer *dollarPGestureRecognizer;

    UIButton *buttonEval;
    UIButton *scoreEval;
    
    NSString *recognized;
    

}

float theScore;

- (BOOL)prefersStatusBarHidden {
    return YES;
}


-(void) viewWillLayoutSubviews {
    
    [super viewWillLayoutSubviews];
    
    if (!spriteView) {
        spriteView = [[SKView alloc] initWithFrame:self.view.bounds];
        theMainMenu = [[IntroScreen alloc]initWithSize:spriteView.bounds.size];
        theMainMenu.scaleMode = SKSceneScaleModeAspectFill;
        [spriteView presentScene:theMainMenu];
        [self.view addSubview:spriteView];
        
        NSLog(@"added sprite view");
        
    }
    
    dollarPView = [[GestureView alloc]initWithFrame:CGRectMake(0, 190, 300, 300)];
    dollarPView.backgroundColor = [UIColor whiteColor];
    dollarPView.alpha = 0.4;
    //[self.view addSubview:dollarPView];
    

    dollarPGestureRecognizer = [[DollarPGestureRecognizer alloc] initWithTarget:self
                                                                         action:@selector(gestureRecognized:)];
    [dollarPGestureRecognizer setPointClouds:[DollarDefaultGestures defaultPointClouds]];
    [dollarPGestureRecognizer setDelaysTouchesEnded:NO];
    [dollarPView addGestureRecognizer:dollarPGestureRecognizer];

    __weak ViewController *weakSelf = self;
    theMainMenu.gameOverBlock = ^(BOOL didWin) {
        [weakSelf gameOverWithWin:didWin];
    };
    
    __weak ViewController *weakSelf2 = self;
    theMainMenu.changeSceneBlock = ^(NSString *sceneName) {
        [weakSelf2 changeScene:sceneName];
    };
}

-(void)evaluate:(NSString*)string {
    [dollarPGestureRecognizer recognize];
    [self gestureRecognized:dollarPGestureRecognizer];
    
    
}

-(void)doItAgain:(NSString*)string {
    
    [dollarPView clearAll];
    [scoreEval setTitle:@"" forState:UIControlStateNormal];
    
}

-(void)changeScene:(NSString *)sceneName {
    
    /*GestureView *copyOfDollarP = dollarPView;
    copyOfDollarP.center = CGPointMake(600, 500);
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         dollarPView.center = copyOfDollarP.center;
                     }
                     completion:^(BOOL finished){
                         [dollarPView removeFromSuperview];
                     }];*/
    
    
    
    if ([sceneName isEqualToString:@"traceScene"]) {
        traceScene = [[LetterTrace alloc]initWithSize:CGSizeMake(1024,768) andGroup:[NSNumber numberWithInt:1]];
        SKTransition *reveal = [SKTransition revealWithDirection:SKTransitionDirectionLeft duration:0.1];
        [spriteView presentScene:traceScene transition:reveal];
        
        [dollarPView addObserver:traceScene
                      forKeyPath:@"pointCopy"
                         options:NSKeyValueObservingOptionNew
                         context:nil];
    }
    
    buttonEval = [UIButton buttonWithType:UIButtonTypeCustom];
    //[buttonEval setBackgroundImage:[UIImage imageNamed:@"checkmark"] forState:UIControlStateNormal];
    buttonEval = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    buttonEval.frame = CGRectMake(5, 5, 150, 150);
    [buttonEval setTitle:@"CHECK" forState:UIControlStateNormal];
    //buttonEval.titleLabel.font = [UIFont systemFontOfSize:30.0];
    [buttonEval setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    buttonEval.titleLabel.font = [UIFont fontWithName:@"Trickster" size:32];
    [buttonEval addTarget:self action:@selector(evaluate:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:buttonEval];
    
    scoreEval = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    scoreEval.frame = CGRectMake(5, 100, 350, 150);
    [scoreEval setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [scoreEval addTarget:self action:@selector(doItAgain:) forControlEvents:UIControlEventTouchUpInside];
    //[self.view addSubview:scoreEval];

}

-(void)gameOverWithWin:(BOOL)didWin {
    
    NSLog(@"game Over With Win called");
 
}

-(void)gestureRecognized:(DollarPGestureRecognizer *)sender {
    [sender recognize];
    DollarResult *result = [sender result];
    theScore = [result score];
    [scoreEval setTitle:[NSString stringWithFormat:@"LETTER: %@",[result name]] forState:UIControlStateNormal];
    scoreEval.titleLabel.font = [UIFont fontWithName:@"Trickster" size:24];

    NSLog(@"score: %.2f",[result score]);
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInView:self.view];
    //[traceScene touchesBegan:touches withEvent:event];
    
    
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {

    //[traceScene touchesMoved:touches withEvent:event];
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    
    UITouch *touch = [touches anyObject];
    CGPoint theTouch = [touch locationInView:self.view];
   //[traceScene touchesEnded:touches withEvent:event];

    //[dollarPGestureRecognizer recognize];
    
    
    
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
}


@end
