; //
//  main.m
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 7/21/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"


typedef int (*PYStdWriter)(void *, const char *, int);
static PYStdWriter _oldStdWrite;


int __pyStderrWrite(void *inFD, const char *buffer, int size)
{
    if ( strncmp(buffer, "AssertMacros:", 13) == 0 ) {
        return 0;
    }
    return _oldStdWrite(inFD, buffer, size);
}

void __iOS7B5CleanConsoleOutput()
{
    _oldStdWrite = stderr->_write;
    stderr->_write = __pyStderrWrite;
}



int main(int argc, char * argv[])
{
    
    __iOS7B5CleanConsoleOutput();
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
