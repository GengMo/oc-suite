//
//  _net_date_parser.m
//  consumer
//
//  Created by fallen.ink on 9/22/16.
//
//

#import "_net_date_parser.h"

@implementation _NetDateParser

- (NSDate *)gh_parseISO8601: (NSString *) dateString {
    if (!dateString) return nil;
    return [[self gh_iso8601DateFormatter] dateFromString: dateString];
}

+ (NSDate *)gh_parseISO8601: (NSString *) dateString {
    if (!dateString) return nil;
    return [[self gh_iso8601DateFormatter] dateFromString: dateString];
}

- (NSDate *)gh_parseRFC822: (NSString *) dateString {
    if (!dateString) return nil;
    return [[self gh_rfc822DateFormatter] dateFromString: dateString];
}

+ (NSDate *)gh_parseRFC822: (NSString *) dateString {
    if (!dateString) return nil;
    return [[self gh_rfc822DateFormatter] dateFromString: dateString];
}

- (NSDate *)gh_parseHTTP: (NSString *) dateString {
    if (!dateString) return nil;
    NSDate *parsed = nil;
    parsed = [[self gh_rfc1123DateFormatter] dateFromString: dateString];
    if (parsed) return parsed;
    parsed = [[self gh_rfc850DateFormatter] dateFromString: dateString];
    if (parsed) return parsed;
    parsed = [[self gh_ascTimeDateFormatter] dateFromString: dateString];
    return parsed;
}

+ (NSDate *)gh_parseHTTP: (NSString *) dateString {
    if (!dateString) return nil;
    NSDate *parsed = nil;
    parsed = [[self gh_rfc1123DateFormatter] dateFromString: dateString];
    if (parsed) return parsed;
    parsed = [[self gh_rfc850DateFormatter] dateFromString: dateString];
    if (parsed) return parsed;
    parsed = [[self gh_ascTimeDateFormatter] dateFromString: dateString];
    return parsed;
}

- (NSDate *)gh_parseTimeSinceEpoch: (id) timeSinceEpoch {
    return [self gh_parseTimeSinceEpoch: timeSinceEpoch withDefault: timeSinceEpoch];
}

+ (NSDate *)gh_parseTimeSinceEpoch: (id) timeSinceEpoch {
    return [self gh_parseTimeSinceEpoch: timeSinceEpoch withDefault: timeSinceEpoch];
}

- (NSDate *)gh_parseTimeSinceEpoch: (id) timeSinceEpoch withDefault: (id) value {
    if (!timeSinceEpoch) return value;
    return [NSDate dateWithTimeIntervalSince1970: [timeSinceEpoch longLongValue]];
}

+ (NSDate *)gh_parseTimeSinceEpoch: (id) timeSinceEpoch withDefault: (id) value {
    if (!timeSinceEpoch) return value;
    return [NSDate dateWithTimeIntervalSince1970: [timeSinceEpoch longLongValue]];
}

- (NSString *)gh_formatRFC822 {
    return [[self gh_rfc822DateFormatter] stringFromDate: self];
}

- (NSString *)gh_formatHTTP {
    return [[self gh_rfc1123DateFormatter] stringFromDate: self];
}

- (NSString *)formatHTTPDate: (NSDate *) date {
    return [[self gh_rfc1123DateFormatter] stringFromDate: date];
}

+ (NSString *)formatHTTPDate: (NSDate *) date {
    return [[self gh_rfc1123DateFormatter] stringFromDate: date];
}

- (NSString *)gh_formatISO8601 {
    return [[self gh_iso8601DateFormatter] stringFromDate: self];
}

+ (NSDateFormatter *)gh_rfc822DateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior: NSDateFormatterBehavior10_4];
    // Need to force US locale when generating otherwise it might not be 822 compatible
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
    [dateFormatter setDateFormat: @"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
    
    return dateFormatter;
}

- (NSDateFormatter *)gh_rfc822DateFormatter {
    if (nil == gh_rfc822DateFormatter) {
        gh_rfc822DateFormatter = [[self class] gh_rfc822DateFormatter];
    }
    
    return gh_rfc822DateFormatter;
}

+ (NSDateFormatter *)gh_iso8601DateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior: NSDateFormatterBehavior10_4];
    // Need to force US locale when generating otherwise it might not be 8601 compatible
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
    [dateFormatter setDateFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    
    return dateFormatter;
}

- (NSDateFormatter *)gh_iso8601DateFormatter {
    // Example: 2007-10-18T16:05:10.000Z
    if (nil == gh_is8601DateFormatter) {
        gh_is8601DateFormatter = [[self class] gh_iso8601DateFormatter];
    }
    
    return gh_is8601DateFormatter;
}

+ (NSDateFormatter *)gh_rfc1123DateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior: NSDateFormatterBehavior10_4];
    // Need to force US locale when generating otherwise it might not be 822 compatible
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
    [dateFormatter setDateFormat: @"EEE, dd MMM yyyy HH:mm:ss zzz"];
    
    return dateFormatter;
}

- (NSDateFormatter *)gh_rfc1123DateFormatter {
    // Example: "Wed, 01 Mar 2006 12:00:00 GMT"
    if (nil == gh_rfc1123DateFormatter) {
        gh_rfc1123DateFormatter = [[self class] gh_rfc1123DateFormatter];
    }
    
    return gh_rfc1123DateFormatter;
}

+ (NSDateFormatter *)gh_rfc850DateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior: NSDateFormatterBehavior10_4];
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
    [dateFormatter setDateFormat: @"EEEE, dd-MMM-yy HH:mm:ss zzz"];
    
    return dateFormatter;
}

- (NSDateFormatter *)gh_rfc850DateFormatter {
    // Example: Sunday, 06-Nov-94 08:49:37 GMT
    if (nil == gh_rfc850DateFormatter) {
        gh_rfc850DateFormatter = [[self class] gh_rfc850DateFormatter];
    }
    
    return gh_rfc850DateFormatter;
}

+ (NSDateFormatter *)gh_ascTimeDateFormatter {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setFormatterBehavior: NSDateFormatterBehavior10_4];
    [dateFormatter setLocale: [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"]];
    [dateFormatter setTimeZone: [NSTimeZone timeZoneForSecondsFromGMT: 0]];
    [dateFormatter setDateFormat: @"EEE MMM d HH:mm:ss yyyy"];
    
    return dateFormatter;
}

- (NSDateFormatter *)gh_ascTimeDateFormatter {
    // Example: Sun Nov  6 08:49:37 1994
    if (nil == gh_ascTimeDateFormatter) {
        gh_ascTimeDateFormatter = [[self class] gh_ascTimeDateFormatter];
    }
    
    return gh_ascTimeDateFormatter;
}

@end
