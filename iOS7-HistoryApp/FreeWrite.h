#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Options.h"
@import CoreImage;

@interface FreeWrite : SKScene <AVAudioPlayerDelegate,AVAudioRecorderDelegate,OptionsDelegate> {

    Options *optionsDisplay;
    
}

@property (nonatomic,strong) SKSpriteNode* background;
@property (nonatomic,strong) SKSpriteNode* selectedNode;


-(id)initWithSize:(CGSize)size;

@end
