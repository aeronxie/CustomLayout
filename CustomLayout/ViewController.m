//
//  ViewController.m
//  CustomLayout
//
//  Created by Fay on 16/3/12.
//  Copyright © 2016年 Fay. All rights reserved.
//

#import "ViewController.h"
#import "LineLayout.h"
#import "CircleLayout.h"
#import "CustomCollectionViewCell.h"

static NSString *const cellID = @"custom";

@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *imageNames;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.collectionView];
    
}


//点击换属性
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    if ([self.collectionView.collectionViewLayout isKindOfClass:[LineLayout class]]) {
        [self.collectionView setCollectionViewLayout:[[CircleLayout alloc]init] animated:YES];
    
    }else{
         LineLayout *layout = [[LineLayout alloc]init];
        layout.itemSize = CGSizeMake(160, 160);
        [self.collectionView setCollectionViewLayout:layout animated:YES];
       
    }
    
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return self.imageNames.count;

}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    cell.imageName = self.imageNames[indexPath.item];
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.imageNames removeObjectAtIndex:indexPath.item];
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
}


#pragma mark - getter and setter
-(UICollectionView *)collectionView {
    
    if (!_collectionView) {
        CircleLayout *layout = [[CircleLayout alloc]init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 300) collectionViewLayout:layout];
        
        [_collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:cellID];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
    
}

- (NSMutableArray *)imageNames
{
    if (!_imageNames) {
        _imageNames = [NSMutableArray array];
        for (int i = 0; i<20; i++) {
            [_imageNames addObject:[NSString stringWithFormat:@"%d", i + 1]];
        }
    }
    return _imageNames;
}

@end
