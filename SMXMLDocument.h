//
//  SMXMLDocument.h
//  LeashTimeManager3
//
//  Created by Edward Hooban on 11/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

extern NSString *const SMXMLDocumentErrorDomain;

@class SMXMLDocument;

@interface SMXMLElement : NSObject<NSXMLParserDelegate> {
@private
	SMXMLDocument *document; // nonretained
	SMXMLElement *parent; // nonretained
	NSString *name;
	NSMutableString *value;
	NSMutableArray *children;
	NSDictionary *attributes;
}

@property (nonatomic, assign) SMXMLDocument *document;
@property (nonatomic, assign) SMXMLElement *parent;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, retain) NSString *value;
@property (nonatomic, retain) NSArray *children;
@property (nonatomic, readonly) SMXMLElement *firstChild, *lastChild;
@property (nonatomic, retain) NSDictionary *attributes;

- (id)initWithDocument:(SMXMLDocument *)document;
- (SMXMLElement *)childNamed:(NSString *)name;
- (NSArray *)childrenNamed:(NSString *)name;
- (SMXMLElement *)childWithAttribute:(NSString *)attributeName value:(NSString *)attributeValue;
- (NSString *)attributeNamed:(NSString *)name;
- (SMXMLElement *)descendantWithPath:(NSString *)path;
- (NSString *)valueWithPath:(NSString *)path;

@end

@interface SMXMLDocument : NSObject<NSXMLParserDelegate> {
@private
	SMXMLElement *root;
	NSError *error;
}

@property (nonatomic, retain) SMXMLElement *root;
@property (nonatomic, retain) NSError *error;

- (id)initWithData:(NSData *)data error:(NSError **)outError;

+ (SMXMLDocument *)documentWithData:(NSData *)data error:(NSError **)outError;

@end
