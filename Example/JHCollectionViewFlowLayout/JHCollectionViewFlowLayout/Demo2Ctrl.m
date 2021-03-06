//
//  Demo2Ctrl.m
//  JHCollectionViewFlowLayout
//
//  Created by HaoCold on 2020/4/22.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "Demo2Ctrl.h"
#import "DemoCell.h"
#import "JHCollectionViewFlowLayout.h"

@interface Demo2Ctrl ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,  strong) UICollectionView *collectionView;
@property (nonatomic,  strong) NSMutableArray *dataArray;

@end

@implementation Demo2Ctrl

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dataArray = @[].mutableCopy;
    NSMutableArray *marr = @[].mutableCopy;
    for (int i = 0; i < 15; ++i) {
        [marr addObject:@[@""]];
    }
    self.dataArray.array = marr;
    
    [self.view addSubview:[[UIView alloc] init]];
    [self.view addSubview:self.collectionView];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (NSInteger) collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UICollectionViewCell*) collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    DemoCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"DemoCell" forIndexPath:indexPath];
    cell.nameLabel.text = [NSString stringWithFormat:@"第%@个",@(indexPath.item)];
    cell.nameLabel.backgroundColor = [UIColor colorWithRed:(arc4random()%256)/255.0 green:(arc4random()%256)/255.0 blue:(arc4random()%256)/255.0 alpha:1];
    return cell;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {

        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        JHCollectionViewFlowLayout *layout = [[JHCollectionViewFlowLayout alloc] init];
        CGFloat W = (width-3)/4;
        layout.scrollDirection = 1; //左右滚动
        layout.size = CGSizeMake(W, W-.5);
        layout.columnSpacing = 2;
        layout.rowSpacing = 2;
        layout.row = 3;
        layout.column = 4;
        layout.showLastPageFull = NO; // 不完全展示最后一页
        layout.pageWidth = width;
        //layout.pageWidth = width - 50;
        //layout.sectionInset = UIEdgeInsetsZero;
        layout.sectionInset = UIEdgeInsetsMake(20, 10, 20, 10);
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, layout.collectionViewSize.width, layout.collectionViewSize.height) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor lightGrayColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.pagingEnabled = YES;
        [_collectionView registerClass:[DemoCell class] forCellWithReuseIdentifier:@"DemoCell"];
    }
    return _collectionView;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
