//
//  IAHelper.h
//  iOS7-HistoryApp
//
//  Created by Ted Hooban on 1/18/14.
//  Copyright (c) 2014 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^RequestProductsCompletionHandler)(BOOL success, NSArray * products);

@interface IAPHelper : NSObject

- (id)initWithProductIdentifiers:(NSSet *)productIdentifiers;
- (void)requestProductsWithCompletionHandler:(RequestProductsCompletionHandler)completionHandler;

@end
