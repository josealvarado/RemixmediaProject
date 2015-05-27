//
//  ImgurTableViewCell.h
//  RemixMediaProject
//
//  Created by Jose Alvarado on 5/26/15.
//  Copyright (c) 2015 Jose Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImgurTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UILabel *viewsLabel;
@property (weak, nonatomic) IBOutlet UILabel *upsLabel;
@property (weak, nonatomic) IBOutlet UILabel *downsLabel;
@property (weak, nonatomic) IBOutlet UILabel *nsfwLabel;

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
