//
//  ViewController.h
//  RemixMediaProject
//
//  Created by Jose Alvarado on 5/26/15.
//  Copyright (c) 2015 Jose Alvarado. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<NSURLSessionDelegate, UITableViewDataSource, UITableViewDelegate>{
    
    NSMutableArray *list;
}

@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (IBAction)searchButtonPressed:(id)sender;

@end

