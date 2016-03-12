//
//  CustomCollectionViewCell.m
//  CustomLayout
//
//  Created by Fay on 16/3/12.
//  Copyright © 2016年 Fay. All rights reserved.
//

#import "CustomCollectionViewCell.h"

@interface CustomCollectionViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation CustomCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setImageName:(NSString *)imageName {
    _imageName = [imageName copy];
    
    self.imageView.image = [UIImage imageNamed:imageName];
}

@end
