//
//  BNRItemCell.m
//  YWHDemo
//
//  Created by Yiwei Huang on 2/6/16.
//  Copyright © 2016 Big Nerd Ranch. All rights reserved.
//

#import "BNRItemCell.h"

@implementation BNRItemCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showImage:(id)sender {
    if (self.actionBlcok) {
        self.actionBlcok();
    }
}

@end
