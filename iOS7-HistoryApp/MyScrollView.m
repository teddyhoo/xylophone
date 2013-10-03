//
//  MyScrollView.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 7/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

@synthesize myImageView;
@synthesize myScrollView;

-(void)viewDidLoad {
    
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIImage *imageToLoad = [UIImage imageNamed:@"Arrow-blue-longest.png"];
    self.myImageView = [[UIImageView alloc]initWithImage:imageToLoad];
    self.myScrollView = [[UIScrollView alloc]initWithFrame:self.view.bounds];
    [self.myScrollView addSubview:self.myImageView];
    self.myScrollView.contentSize = self.myImageView.bounds.size;
    //[self.view addSubview:self.myScrollView];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    self.myScrollView.alpha = 0.50;
    
}

-(void) scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    self.myScrollView.alpha = 1.0;
    
}


-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    
    self.myScrollView.alpha = 1.0;
    
}


@end
