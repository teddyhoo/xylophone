//
//  IntroScreen.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/27/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MainMenu.h"
#import "MatchPix.h"
#import "LetterTrace.h"
#import "Credits.h"
#import "TeacherParent.h"
#import "Spelling.h"

@interface IntroScreen : SKScene
{
    SKView *spriteView;
    
    CGRect screenRect;
    CGFloat screenHeight;
    CGFloat screenWidth;
    
}

@property (nonatomic,retain) SKLabelNode *introductionLabel;
@property (nonatomic,retain) SKSpriteNode *getStartedButton;
@property (nonatomic,retain) MainMenu *myMainMenu;
@property (nonatomic,retain) MatchPix *matchingScene;
@property (nonatomic,retain) LetterTrace *traceScene;
@property (nonatomic,retain) Credits *credits;
@property (nonatomic,retain) TeacherParent *teacherReview;
@property (nonatomic,retain) Spelling *spellingScene;


@end
