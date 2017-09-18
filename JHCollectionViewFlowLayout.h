//
//  JHCollectionViewFlowLayout.h
//  JHKit
//
//  Created by HaoCold on 2017/9/13.
//  Copyright © 2017年 HaoCold. All rights reserved.
//

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

@end
