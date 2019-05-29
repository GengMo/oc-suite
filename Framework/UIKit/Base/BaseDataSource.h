#import <Foundation/Foundation.h>

typedef NSInteger (^ NumberOfSectionsBlock)(void);
typedef NSInteger (^ NumberOfRowsBlock)(NSInteger section);
typedef id (^ ModelForRowBlock)(NSInteger section, NSInteger row);

@interface BaseDataSource : NSObject

+ (instancetype)withName:(NSString *)name
        numberOfSections:(NumberOfSectionsBlock)numberOfSectionHandler
            numberOfRows:(NumberOfRowsBlock)numberOfRowsHandler
             modelForRow:(ModelForRowBlock)modelForRowHandler;


// MARK: - 数据源
@property (nonatomic, readonly) NSString *name;

- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (id)modelForRowAtSection:(NSInteger)section row:(NSInteger)row;

@end
