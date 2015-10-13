//
//  ViewController.m
//  FlickrView
//
//  Created by Adriana Vazquez on 10/11/15.
//  Copyright © 2015 Adriana Vazquez. All rights reserved.
//


#define flickrURL1 @"https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=72fd9a604245c4205627725f469531fc&text="

#define flickrURL2 @"&extras=url_m&format=json&nojsoncallback=1"

#import "SearchResultsViewController.h"

@interface SearchResultsViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation SearchResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self loadImagesFromFlickr:self.searchText];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.images.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    // We previously set the cell identifier in the storyboard.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    // We set the tag in the storyboard.
    UILabel *label = (UILabel *)[cell viewWithTag:1];
    NSMutableDictionary *image = [self.images objectAtIndex:indexPath.row];
    label.text = [image objectForKey:@"title"];
    
    UIImageView* imageView = (UIImageView *)[cell viewWithTag:2];
    
    NSString *imageUrl = [image objectForKey:@"url_m"];
    // Fetch and switch to a default priority background queue.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]];
        // Switch to Main Queue as we will be updating the UI.
        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = [UIImage imageWithData:imageData];
        });
    });

    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    //TODO
    /*
    self.selectedRow = [self.images objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:self];*/
}




- (void)loadImagesFromFlickr:(NSString*) queryString {
    // embed query into url
    NSString * queryURL = [[flickrURL1 stringByAppendingString: queryString ] stringByAppendingString: flickrURL2];
    
    NSURL *url = [NSURL URLWithString:queryURL];
    
    // Create a MutableURL request with the URL we just made.
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    // Begin a URL session with the request and then handle the recieved data.
    [[[NSURLSession sharedSession] dataTaskWithRequest:request
                                     completionHandler:
      ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
          // See blocks in the lecture slides.
          NSMutableDictionary *dictionary =
          [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
          self.images = [[[dictionary objectForKey:@"photos"] objectForKey:@"photo"] mutableCopy];
          
          [self setupTableView];
      }] resume];
    //**** Remember to include this resume snippet here or else the request won't be sent.
}


/*TODO maybe
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 if ([segue.identifier isEqualToString:@"detail"]) {
 DetailViewController *view = (DetailViewController *)segue.destinationViewController;
 view.image = self.selectedRow;
 }
 */



@end
