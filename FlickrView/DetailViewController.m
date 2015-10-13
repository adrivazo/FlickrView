//
//  DetailViewController.m
//  FlickrView
//
//  Created by Adriana Vazquez on 10/12/15.
//  Copyright © 2015 Adriana Vazquez. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property(nonatomic) NSData *imageData;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleLabel.text = [self.image objectForKey:@"title"];
    NSString *imageUrl = [self.image objectForKey:@"url_m"];
    // Fetch and switch to a default priority background queue.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        self.imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        // Switch to Main Queue as we will be updating the UI.
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayImage];
        });
    });
}

- (void)displayImage {
    self.imageView.image = [UIImage imageWithData:self.imageData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
