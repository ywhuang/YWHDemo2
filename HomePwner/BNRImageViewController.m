//
//  BNRImageViewController.m
//  YWHDemo
//
//  Created by Yiwei Huang on 2/6/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

#import "BNRImageViewController.h"

@implementation BNRImageViewController



//Create View programatically in the loadView method

- (void)loadView {
    UIImageView * imageView = [[UIImageView alloc]init];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    //set the view (don't read it)
    self.view = imageView;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */


-(void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    ((UIImageView *)self.view).image = self.image;
    
}
@end
