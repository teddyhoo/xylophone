//
//  FilterFrame.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 10/30/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreImage/CoreImage.h>

@interface FilterFrame : CIFilter


@property (nonatomic,retain) CIImage* inputImage;


@end
