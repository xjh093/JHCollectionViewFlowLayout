# JHCollectionViewFlowLayout
CollectionView horizontal layout
- CollectionView横向排版
    
--- 

# What
System layout

![image](https://github.com/xjh093/JHCollectionViewFlowLayout/blob/master/system.png)

Custom layout

![image](https://github.com/xjh093/JHCollectionViewFlowLayout/blob/master/custom.png)

---

# Log

### 2019-11-8
- add `showLastPageFull`

---

# API
.h
```
#import <UIKit/UIKit.h>

@interface JHCollectionViewFlowLayout : UICollectionViewFlowLayout
///一页展示行数
@property (nonatomic, assign) NSInteger row;
///一页展示列数
@property (nonatomic, assign) NSInteger column;
///行间距
@property (nonatomic, assign) CGFloat rowSpacing;
///列间距
@property (nonatomic, assign) CGFloat columnSpacing;
///item大小
@property (nonatomic, assign) CGSize size;
///一页的宽度
@property (nonatomic, assign) CGFloat pageWidth;
///默认YES。根据最后一页的个数，是否展示完整的一页
@property (nonatomic, assign) BOOL showLastPageFull;
@end
```

.m
```
#import "JHCollectionViewFlowLayout.h"

@interface JHCollectionViewFlowLayout()
@property (strong,  nonatomic) NSMutableArray   *attributesArray;
@end

@implementation JHCollectionViewFlowLayout

- (instancetype)init
{
    self = [super init];
    if (self) {
        _showLastPageFull = YES;
    }
    return self;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    _attributesArray = @[].mutableCopy;
    if (_pageWidth == 0) {
        _pageWidth = [UIScreen mainScreen].bounds.size.width;
    }
    self.itemSize = self.size;
    self.minimumLineSpacing = self.rowSpacing;
    self.minimumInteritemSpacing = self.columnSpacing;
    
    NSUInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i<count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        [_attributesArray addObject:attributes];
    }
}

//计算每个item的frame
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    NSInteger index = indexPath.item;
    
    NSInteger page = index / (_row * _column);
    
    // % 运算 确定 x 是 0,1,2 ... _column-1
    CGFloat x = index % _column * (_size.width + _columnSpacing) + page * _pageWidth;
    // / 运算 确定 y 是 在哪行(一行有 column 个)， % 确定在 0,1,2 ... _row-1 行内的哪行
    CGFloat y = (index / _column % _row) * (_size.height + _rowSpacing);
    
    attribute.frame = CGRectMake(x, y, _size.width, _size.height);
    
    return attribute;
    
}

//返回所有item的frame
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect{
    return _attributesArray;
}

//返回总的可见尺寸
//避免一页未排满，滑动显示不全
- (CGSize)collectionViewContentSize{
    CGFloat width = (CGFloat)ceil(_attributesArray.count/(_row * _column * 1.0)) * _pageWidth;
    if (!_showLastPageFull) {
        NSInteger lastCount = _attributesArray.count%(_row * _column);
        if (lastCount > 0 && lastCount < _column) {
            width = _attributesArray.count/(_row * _column) * _pageWidth;
            width += (_size.width + _columnSpacing)*lastCount;
        }
    }
    return CGSizeMake(width, 0);
}

@end
```
