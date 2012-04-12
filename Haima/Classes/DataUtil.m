//
//  DataUtil.m
//
//  Created by Luke Shi on 10-3-1.
//  Copyright 2010 OpenConcept Systems, Inc.. All rights reserved.
//

#import "DataUtil.h"

@implementation DataUtil


+ (NSArray *)readArrayFromFile: (NSString *)fileName
{
	NSString *filePath = [[NSBundle mainBundle] pathForResource: fileName ofType: @"plist"];
	return [NSArray arrayWithContentsOfFile:filePath];
}

+ (NSArray *)readArrayFromDataFile: (NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent: [NSString stringWithFormat:@"%@.plist", fileName]];
	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath])
		return [NSArray arrayWithContentsOfFile:filePath];
	
	// Read from system resource if user data not found
	return [DataUtil readArrayFromFile: fileName];
}

+ (NSDictionary *)readDictionaryFromFile: (NSString *)fileName
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString *plistPath;
	NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
															  NSUserDomainMask, YES) objectAtIndex:0];
	plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
	if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
		plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
	}
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	return (NSDictionary *)[NSPropertyListSerialization
						propertyListFromData:plistXML
							mutabilityOption:NSPropertyListMutableContainersAndLeaves
									  format:&format
							errorDescription:&errorDesc];
}

+ (NSDictionary *)readDictionaryFromBundleFile: (NSString *)fileName
{
	NSString *errorDesc = nil;
	NSPropertyListFormat format;
	NSString *plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
	NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
	return (NSDictionary *)[NSPropertyListSerialization
                            propertyListFromData:plistXML
							mutabilityOption:NSPropertyListMutableContainersAndLeaves
                            format:&format
							errorDescription:&errorDesc];
}

+ (BOOL)writeArray: (NSArray *)array toDataFile: (NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
	
	BOOL result = [array writeToFile:filePath atomically:YES];
	return result;
}

+ (BOOL)writeDictionary: (NSDictionary *)dictionary toDataFile: (NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]];
	
	BOOL result = [dictionary writeToFile:filePath atomically:YES];
	return result;
}

//

+ (UIImage *)readImageFromDataFile: (NSString *)fileName
{
	UIImage *image = [UIImage imageNamed:fileName];
	if (image != nil)
		return image;
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent: fileName];

	if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
		return [UIImage imageWithContentsOfFile:filePath];
	}
	return nil;
}

+ (BOOL)writeImage: (UIImage *)image toDataFile: (NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	NSString *filePath = [documentsDirectory stringByAppendingPathComponent:fileName];
	
	NSData *imageData = UIImagePNGRepresentation(image);
	
	BOOL result = [imageData writeToFile:filePath atomically:YES];
	return result;
}

//


+ (BOOL) loadFromNetwork
{
	return NO;
	//return YES;
}


+ (NSString *) getCurrentDateString
{
    return [DataUtil getDateString: [NSDate date]];
}

+ (NSString *) getDateString: (NSDate *)date
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *) getDisplayDateString: (NSDate *)date
{
    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
    [dateFormatter setDateFormat:@"yyyy年MM月dd日"];
    return [dateFormatter stringFromDate:date];
}

@end
