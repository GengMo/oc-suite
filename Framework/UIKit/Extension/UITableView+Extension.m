#import "UITableView+Extension.h"
#import "UIIndexPath+Extension.h"

@implementation UITableView ( Extension )

+ (instancetype)instanceWithDelegate:(id<UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource background:(UIColor *)background {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.backgroundColor = background;
    tableView.tableFooterView = [[UIView alloc] init];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return tableView;
}

- (void)normally {
    [self trimBlankCells];
    
    [self noneSeparatorHeadingMarginSpace];
    
    [self noneScrollIndicator];
    
    self.backgroundColor = [UIColor clearColor];
}

- (void)setFixedRowHeight:(CGFloat)height {
    self.rowHeight = height;
}

- (void)trimBlankCells {
    self.tableFooterView = [UIView new];
}

- (void)noneSeparator {
    self.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)noneScrollIndicator {
    self.showsVerticalScrollIndicator = NO;
    self.showsHorizontalScrollIndicator = NO;
}

- (void)rotateToHorizontalScrollable {
    self.transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.decelerationRate = UIScrollViewDecelerationRateFast;
    
    // 关闭其他属性
    self.scrollsToTop = NO;
}

- (void)noneSeparatorHeadingMarginSpace {
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([self respondsToSelector:@selector(setLayoutMargins:)]) {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)autoEstimateRowHeightWithPrefered:(CGFloat)height {
    self.estimatedRowHeight = 68.0;
    self.rowHeight = UITableViewAutomaticDimension;
}

/**
 *  -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
 [tableView deselectRowAtIndexPath:indexPath animated:true];
 UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 UILabel *label = [cell.contentView viewWithTag:1000];
 [tableView beginUpdates];
 
 if (label.numberOfLines == 0) {
 label.numberOfLines = 1;
 }else{
 label.numberOfLines = 0;
 }
 
 [tableView endUpdates];
 }
 */
- (void)updateTableViewWithIndexPath:(NSIndexPath *)indexPath handlingBlock:(ObjectBlock)handlingBlock {
    UITableViewCell *cell = [self cellForRowAtIndexPath:indexPath];
    [self beginUpdates];
    
    if (handlingBlock) handlingBlock(cell);
    
    [self endUpdates];
}

- (void)updateTableViewWithHandlingBlock:(Block)handlingBlock {
    [self beginUpdates];
    
    if (handlingBlock) handlingBlock();
    
    [self endUpdates];
}

// MARK: -

- (void)performUpdate:(UITableUpdate *)update {
    [self performUpdate:update deleteAnimation:UITableViewRowAnimationLeft insertAnimation:UITableViewRowAnimationTop];
}

- (void)performUpdate:(UITableUpdate *)update deleteAnimation:(UITableViewRowAnimation)deleteAnimation insertAnimation:(UITableViewRowAnimation)insertAnimation {
    [self beginUpdates];
    [self insertRowsAtIndexPaths:update.insert withRowAnimation:insertAnimation];
    [self deleteRowsAtIndexPaths:update.remove withRowAnimation:deleteAnimation];
    for (NSMoveIndexPath *move in update.move)
        [self moveRowAtIndexPath:move.from toIndexPath:move.to];
    [self endUpdates];
    [self reloadRowsAtIndexPaths:update.reload withRowAnimation:UITableViewRowAnimationNone];
}

- (void)insertRow:(NSUInteger)row inSection:(NSUInteger)section {
    [self insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)reloadRow:(NSUInteger)row inSection:(NSUInteger)section {
    [self reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)deleteRow:(NSUInteger)row inSection:(NSUInteger)section {
    [self deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:row inSection:section]] withRowAnimation:UITableViewRowAnimationFade];
}

- (void)insertSection:(NSUInteger)section {
    [self insertSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)reloadSection:(NSUInteger)section {
    [self reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

- (void)autoScrollToTop {
    [self scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

- (void)autoScrollToTopWithoutTableHeaderView {
    [self scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end

// MARK: - UITableViewDiff

@interface UITableViewDiff : NSObject

@property (nonatomic, readonly) NSArray *moves;      // Array of `NSMoveIndexPath`s
@property (nonatomic, readonly) NSArray *deletions;  // array of `NSIndexPath`s
@property (nonatomic, readonly) NSArray *insertions; // Array of `NSIndexPath`s

@end

@implementation UITableViewDiff

+ (instancetype)diffInitial:(NSArray *)initial final:(NSArray *)final {
    NSParameterAssert(initial); NSParameterAssert(final);
    
    NSSet *initialSet = [NSSet setWithArray:initial];
    NSSet *finalSet   = [NSSet setWithArray:final];
    NSSet *insertSet  = ({
        NSMutableSet *set = finalSet.mutableCopy;
        [set minusSet:initialSet];
        set.copy;
    });
    NSSet *deleteSet  = ({
        NSMutableSet *set = initialSet.mutableCopy;
        [set minusSet:finalSet];
        set.copy;
    });
    
    NSArray *moves      = [UITableViewDiff indexPathsForMovesFrom:initial to:final withInsertions:insertSet andDeletions:deleteSet];
    NSArray *deletions  = [UITableViewDiff indexPathsForDeletions:deleteSet inArray:initial];
    NSArray *insertions = [UITableViewDiff indexPathsForInsertions:insertSet inArray:final];
    return [[UITableViewDiff alloc] initWithMoves:moves deletions:deletions andInsertions:insertions];
}

- (id)initWithMoves:(NSArray *)move deletions:(NSArray *)delete andInsertions:(NSArray *)insert {
    NSParameterAssert(move); NSParameterAssert(delete); NSParameterAssert(insert);
    
    self = [super init];
    if (self) {
        _moves      = move;
        _deletions  = delete;
        _insertions = insert;
    }
    
    return self;
}

+ (NSArray *)indexPathsForMovesFrom:(NSArray *)initial to:(NSArray *)final withInsertions:(NSSet *)insertions andDeletions:(NSSet *)deletions {
    __block NSInteger delta = 0;
    NSMutableArray *moves   = [NSMutableArray array];
    
    [initial enumerateObjectsUsingBlock:^(id objInitial, NSUInteger leftIdx, BOOL *stop) {
        if ([deletions containsObject:objInitial]) {
            delta++;
            return;
        }
        
        NSUInteger localDelta = delta;
        
        for (NSUInteger rightIdx = 0; rightIdx < final.count; rightIdx++) {
            id objFinal = final[rightIdx];
            if ([insertions containsObject:objFinal]) {
                localDelta--;
                continue;
            }
            
            if ([objFinal isEqual:objInitial]) {
                NSInteger adjustedRightIdx = rightIdx + localDelta;
                if (leftIdx != rightIdx && adjustedRightIdx != leftIdx) {
                    NSIndexPath *from = [NSIndexPath indexPathForRow:leftIdx inSection:0];
                    NSIndexPath *to   = [NSIndexPath indexPathForRow:rightIdx inSection:0];
                    [moves addObject:[NSMoveIndexPath moveFrom:from to:to]];
                }
            }
        }
    }];
    
    return moves.copy;
}

+ (NSArray *)indexPathsForInsertions:(NSSet *)insert inArray:(NSArray *)final {
    NSMutableArray *result = [NSMutableArray array];
    [final enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([insert containsObject:obj])
            [result addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    return result.copy;
}

+ (NSArray *)indexPathsForDeletions:(NSSet *)delete inArray:(NSArray *)initial {
    NSMutableArray *result = [NSMutableArray array];
    [initial enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([delete containsObject:obj])
            [result addObject:[NSIndexPath indexPathForRow:idx inSection:0]];
    }];
    
    return result.copy;
}

@end

// MARK: - UITableUpdate

@implementation UITableUpdate

+ (instancetype)firstSectionInsert:(NSIndexSet *)insert delete:(NSIndexSet *)delete  moveFrom:(NSIndexSet *)from moveTo:(NSIndexSet *)to reload:(NSIndexSet *)reload {
    NSArray *removals   = [NSIndexPath indexPathsInSection:0 withIndexes:delete];
    NSArray *insertions = [NSIndexPath indexPathsInSection:0 withIndexes:insert];
    NSArray *moveFrom   = [NSIndexPath indexPathsInSection:0 withIndexes:from];
    NSArray *moveTo     = [NSIndexPath indexPathsInSection:0 withIndexes:to];
    NSArray *refreshes  = [NSIndexPath indexPathsInSection:0 withIndexes:reload];
    
    return [[UITableUpdate alloc] initWithInsertions:insertions andDeletions:removals andRefreshes:refreshes moveFrom:moveFrom to:moveTo];
}

+ (instancetype)updateInsert:(NSArray *)insert delete:(NSArray *)delete moveFrom:(NSArray *)from moveTo:(NSArray *)to reload:(NSArray *)reload {
    return [[self alloc] initWithInsertions:insert andDeletions:delete andRefreshes:reload moveFrom:from to:to];
}

+ (instancetype)updateFromDataSource:(NSArray *)initial toDataSource:(NSArray *)final {
    return [[self alloc] initWithTableViewDiff:[UITableViewDiff diffInitial:initial final:final]];
}

- (id)init {
    self = [super init];
    if (self) {
        _insert = @[];
        _remove = @[];
        _move   = @[];
        _reload = @[];
    }
    
    return self;
}

- (id)initWithTableViewDiff:(UITableViewDiff *)diff {
    NSParameterAssert(diff);
    
    self = [super init];
    if (self) {
        _insert = diff.insertions;
        _remove = diff.deletions;
        _move   = diff.moves;
        _reload = ({
            NSMutableArray *reloads = [NSMutableArray array];
            for (NSMoveIndexPath *move in diff.moves)
                [reloads addObject:move.to];
            reloads.copy;
        });
    }
    
    return self;
}

- (id)initWithInsertions:(NSArray *)insertions andDeletions:(NSArray *)deletions andRefreshes:(NSArray *)refreshes moveFrom:(NSArray *)from to:(NSArray *)to {
    NSParameterAssert(deletions); NSParameterAssert(insertions); NSParameterAssert(refreshes); NSParameterAssert(from && to);
    NSParameterAssert(from.count == to.count);
    
    self = [super init];
    if (self) {
        _insert = insertions;
        _remove = deletions;
        _move   = [NSMoveIndexPath movesWithInitialIndexPaths:from andFinalIndexPaths:to];
        _reload = refreshes;
    }

    return self;
}

@end
