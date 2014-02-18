#import <Foundation/Foundation.h>

@interface GestureView : UIView {
    NSMutableDictionary *currentTouches;
    NSMutableArray *completeStrokes;
}

@property (nonatomic, strong) NSValue *pointCopy;

- (void)clearAll;

@end