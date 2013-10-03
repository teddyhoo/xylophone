//
//  HistoryTerm.h
//  iOS7-HistoryApp
//
//  Created by Edward Hooban on 8/2/13.
//  Copyright (c) 2013 Melanie Taylor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryTerm : NSObject

@property (nonatomic,retain) NSString *theTerm;
@property (nonatomic,retain) NSString *startDate;
@property (nonatomic,retain) NSString *endDate;
@property (nonatomic,retain) NSMutableArray *plotPoints;
@property (nonatomic,retain) NSMutableArray *conflicts;
@property (nonatomic,retain) NSMutableDictionary *causesOfTerm; //NSArray of Dictionaries
@property (nonatomic,retain) NSMutableDictionary *effectsOfTerm; //NSArray of Dictionaries

/*
 
 key         val
 ---         ---
 cause       Agricultural Revolution [or id#]
 begDate     1500
 endDate     1700
 degree      0...10
 length      0,1,2,3
 
*/
@end
