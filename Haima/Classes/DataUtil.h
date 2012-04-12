//
//  DataUtil.h
//
//  Created by Luke Shi on 10-3-1.
//  Copyright 2010 OpenConcept Systems, Inc.. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DataUtil : NSObject {
}

+ (NSArray *)readArrayFromFile: (NSString *)fileName;
+ (NSDictionary *)readDictionaryFromFile: (NSString *)fileName;
+ (NSDictionary *)readDictionaryFromBundleFile: (NSString *)fileName;
+ (NSArray *)readArrayFromDataFile: (NSString *)fileName;
+ (BOOL) writeArray: (NSArray *)array toDataFile: (NSString *)fileName;
+ (BOOL)writeDictionary: (NSDictionary *)dictionary toDataFile: (NSString *)fileName;

+ (UIImage *) readImageFromDataFile: (NSString *)fileName;
+ (BOOL) writeImage: (UIImage *)image toDataFile: (NSString *)fileName;


+ (BOOL) loadFromNetwork;
+ (NSString *) getCurrentDateString;
+ (NSString *) getDateString: (NSDate *)date;
+ (NSString *) getDisplayDateString: (NSDate *)date;

@end
