#import <UIKit/UIKit.h>
#import <Framework/_Foundation.h>

@class UITableUpdate;

@interface UITableView ( Extension )

+ (instancetype)instanceWithDelegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource background:(UIColor *)background;

- (void)normally; // 自以为是的常规管理配置

- (void)setFixedRowHeight:(CGFloat)height; // 如果你展示在每个cell的高度是固定的，那么heightForRow是不建议让代理去实现的，而是通过tableView的rowHeight属性来代替

// 详细配置

- (void)trimBlankCells; // 去除多余的横线
- (void)noneSeparator; // 去除分割线
- (void)noneScrollIndicator;
- (void)noneSeparatorHeadingMarginSpace; // 分割线磨人开头空15像素点，改为0

/**
 *  Usage 
 * 
 *  这两行代码必须配合约束来使用
 *
 */
- (void)autoEstimateRowHeightWithPrefered:(CGFloat)height;

- (void)updateTableViewWithIndexPath:(NSIndexPath *)indexPath handlingBlock:(ObjectBlock)handlingBlock;

- (void)updateTableViewWithHandlingBlock:(Block)handlingBlock;

- (void)performUpdate:(UITableUpdate *)update;
- (void)performUpdate:(UITableUpdate *)update deleteAnimation:(UITableViewRowAnimation)deleteAnimation insertAnimation:(UITableViewRowAnimation)insertAnimation;

- (void)insertRow:(NSUInteger)row inSection:(NSUInteger)section;
- (void)reloadRow:(NSUInteger)row inSection:(NSUInteger)section;
- (void)deleteRow:(NSUInteger)row inSection:(NSUInteger)section;
- (void)insertSection:(NSUInteger)section;
- (void)reloadSection:(NSUInteger)section;

// Scroll to top include tableHeaderView
- (void)autoScrollToTop;

- (void)autoScrollToTopWithoutTableHeaderView;

@end

@interface UITableUpdate : NSObject

+ (instancetype)firstSectionInsert:(NSIndexSet *)insert delete:(NSIndexSet *)remove moveFrom:(NSIndexSet *)from moveTo:(NSIndexSet *)to reload:(NSIndexSet *)reload;
+ (instancetype)updateInsert:(NSArray *)insert delete:(NSArray *)remove moveFrom:(NSArray *)from moveTo:(NSArray *)to reload:(NSArray *)reload;
+ (instancetype)updateFromDataSource:(NSArray *)initial toDataSource:(NSArray *)final;

@property (nonatomic, readonly) NSArray *insert;
@property (nonatomic, readonly) NSArray *remove;
@property (nonatomic, readonly) NSArray *move;
@property (nonatomic, readonly) NSArray *reload;

@end
