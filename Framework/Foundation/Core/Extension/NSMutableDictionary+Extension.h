
#import <Foundation/Foundation.h>
#import "NSDictionary+Extension.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSMutableDictionary (Extension)

+ (NSMutableDictionary *_Nullable)nonRetainingDictionary;
+ (NSMutableDictionary *)keyValues:(id)first, ...;

- (BOOL)setObject:(NSObject *)obj atPath:(NSString *)path;
- (BOOL)setObject:(NSObject *)obj atPath:(NSString *)path separator:(NSString *)separator;
- (BOOL)setKeyValues:(id)first, ...;

- (id)objectForOneOfKeys:(NSArray *)array remove:(BOOL)flag;

//- (NSNumber *)numberForOneOfKeys:(NSArray *)array remove:(BOOL)flag;
//- (NSString *)stringForOneOfKeys:(NSArray *)array remove:(BOOL)flag;

@end

@interface __GENERICS(NSMutableDictionary, KeyType, ObjectType) (Function)

/** Filters a mutable dictionary to the key/value pairs matching the block.
 */
- (void)performSelect:(BOOL (^)(KeyType key, ObjectType obj))block;

/** Filters a mutable dictionary to the key/value pairs not matching the block,
 the logical inverse to select:.
 */
- (void)performReject:(BOOL (^)(KeyType key, ObjectType obj))block;

/** Transform each value of the dictionary to a new value, as returned by the
 block.
 */
- (void)performMap:(id (^)(KeyType key, ObjectType obj))block;

@end

NS_ASSUME_NONNULL_END

