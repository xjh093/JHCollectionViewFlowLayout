//
//  DemoCell.m
//  JHCollectionViewFlowLayout
//
//  Created by HaoCold on 2020/4/22.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "DemoCell.h"

@implementation DemoCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UILabel *label = [[UILabel alloc] init];
        label.frame = self.bounds;
        label.text = @"";
        label.textColor = [UIColor whiteColor];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:label];
        _nameLabel = label;
    }
    return self;
}

@end
