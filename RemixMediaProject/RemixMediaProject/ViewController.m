//
//  ViewController.m
//  RemixMediaProject
//
//  Created by Jose Alvarado on 5/26/15.
//  Copyright (c) 2015 Jose Alvarado. All rights reserved.
//

#import "ViewController.h"
#import "ImgurTableViewCell.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    list = [[NSMutableArray alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchButtonPressed:(id)sender {
    
    [list removeAllObjects];
    
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration delegate:self delegateQueue:nil];
    
//    NSString *params = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/earthporn/time/"];

    //    NSString *params = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/funny/top"];
//        NSString *params = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/cat/"];
//    NSString *params = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/funny/top/?q=cat"];

//    NSString *params = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/q=%@", _searchTextField.text];

    
    NSString *params = [NSString stringWithFormat:@"https://api.imgur.com/3/gallery/r/%@/", _searchTextField.text];

    NSURL *url = [NSURL URLWithString:params];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url
                                    
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                    
                                                       timeoutInterval:60.0];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request addValue:@"application/json" forHTTPHeaderField:@"Accept"];

    [request addValue:@"Client-ID 94f1cb3655e8f3e" forHTTPHeaderField:@"Authorization"];

    [request setHTTPMethod:@"GET"];
    
//    NSError *error;
//    NSDictionary *mapData = [[NSDictionary alloc] init ];
//    mapData = @{@"q" : _searchTextField.text};
//    
//    NSData *postData = [NSJSONSerialization dataWithJSONObject:mapData options:0 error:&error];
//    
//    [request setHTTPBody:postData];
    
    NSURLSessionDataTask *postDataTask = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        
//        NSLog(@"data %@", data);
//        
//        NSLog(@"response %@", response);
//        
//        NSLog(@"erorr %@", error);
        
        if (!error) {
            
            NSLog(@"COrrect");
            
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
            
            long status_code = (long)[httpResponse statusCode];
            
            NSLog(@"response status code: %ld", status_code);
            
            
            if (status_code == 200) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSError* error;
                    
                    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
                    //                NSLog(@"json: %@", json);
                    
                    NSMutableArray *data = [json objectForKey:@"data"];
                    
                    NSLog(@"size %lu", (unsigned long)data.count);
                    
                    
                    for (int i =0; i < data.count; i++) {
                        NSDictionary *post = [data objectAtIndex:i];
                        NSString *type = [post objectForKey:@"type"];
                        if ([type isEqualToString:@"image/gif"]) {
                            [list addObject:post];
                        }
                    }
                    
                    NSLog(@"size of list now %lu", list.count);
                   
                    // Assuming you've added the table view as a subview to the current view controller
//                    UITableView *tableView = (UITableView *)[self.view viewWithTag:1];
                    
                    [_tableView reloadData];
                    
                });
                
//                "account_id" = "<null>";
//                "account_url" = "<null>";
//                animated = 1;
//                bandwidth = 2357056983;
//                "comment_count" = "<null>";
//                "comment_preview" = "<null>";
//                datetime = 1421562671;
//                description = "<null>";
//                downs = 0;
//                favorite = 0;
//                gifv = "http://i.imgur.com/euTaB52.gifv";
//                height = 205;
//                id = euTaB52;
//                "is_album" = 0;
//                link = "http://i.imgur.com/euTaB52.gif";
//                looping = 1;
//                mp4 = "http://i.imgur.com/euTaB52.mp4";
//                nsfw = 0;
//                "reddit_comments" = "/r/cat/comments/2st6wq/this_made_me_laugh_a_lot_more_than_rfunny/";
//                score = 324;
//                section = cat;
//                size = 716213;
//                title = "This made me laugh a lot more than /r/funny";
//                type = "image/gif";
//                ups = 5;
//                views = 3291;
//                vote = "<null>";
//                webm = "http://i.imgur.com/euTaB52.webm";
//                width = 250;
                
                
            } else {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed" message:@"Something did not work" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                    
                    [alert show];
                    
                });
                
            }
        } else {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"No network connection" message:@"You must be connected to the internet to use this app." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
                
                [alert show];
                
            });
            
        }
        
    }];
    
    [postDataTask resume];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSLog(@"size of list now %lu", list.count);
    
    return [list count];
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    
//    
//    return 80.0;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ImgurCell";
    ImgurTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ImgurTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    NSDictionary *profile = [list objectAtIndex:indexPath.row];
    
    cell.titleLabel.text = [NSString stringWithFormat:@"Title: %@", [profile objectForKey:@"title"]];
    cell.viewsLabel.text = [NSString stringWithFormat:@"Views: %@", [profile objectForKey:@"views"]];
    cell.upsLabel.text = [NSString stringWithFormat:@"Ups: %@", [profile objectForKey:@"ups"]];
    cell.downsLabel.text = [NSString stringWithFormat:@"Downs: %@", [profile objectForKey:@"downs"]];
    
    
    
    
    BOOL nsfw = [profile objectForKey:@"nsfw"];
    
    if (nsfw) {
        cell.nsfwLabel.text = [NSString stringWithFormat:@"NSFW: NO"];
    } else {
        cell.nsfwLabel.text = [NSString stringWithFormat:@"NSFW: YES"];
    }
    
    

    NSString *fullURL = [profile objectForKey:@"link"];
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [cell.webView loadRequest:requestObj];
    
    NSLog(@"here %@", [profile objectForKey:@"title"]);

    return cell;
}

@end
