#import <Foundation/Foundation.h>
#import "_DateTimePeriodGroup.h"

@interface DTTimePeriodCollection : DTTimePeriodGroup

#pragma mark - Custom Init / Factory Methods
+(DTTimePeriodCollection *)collection;

#pragma mark - Collection Manipulation
-(void)addTimePeriod:(DTTimePeriod *)period;
-(void)insertTimePeriod:(DTTimePeriod *)period atIndex:(NSInteger)index;
-(void)removeTimePeriodAtIndex:(NSInteger)index;

#pragma mark - Sorting
-(void)sortByStartAscending;
-(void)sortByStartDescending;
-(void)sortByEndAscending;
-(void)sortByEndDescending;
-(void)sortByDurationAscending;
-(void)sortByDurationDescending;

#pragma mark - Collection Relationship
-(DTTimePeriodCollection *)periodsInside:(DTTimePeriod *)period;
-(DTTimePeriodCollection *)periodsIntersectedByDate:(NSDate *)date;
-(DTTimePeriodCollection *)periodsIntersectedByPeriod:(DTTimePeriod *)period;
-(DTTimePeriodCollection *)periodsOverlappedByPeriod:(DTTimePeriod *)period;
-(BOOL)isEqualToCollection:(DTTimePeriodCollection *)collection considerOrder:(BOOL)considerOrder;

#pragma mark - Helper Methods
-(DTTimePeriodCollection *)copy;

#pragma mark - Updates
-(void)updateVariables;
@end
