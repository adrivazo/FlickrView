//
//  SearchViewController.m
//  FlickrView
//
//  Created by Adriana Vazquez on 10/11/15.
//  Copyright © 2015 Adriana Vazquez. All rights reserved.
//


#import "SearchViewController.h"
#import "SearchResultsViewController.h"

@interface SearchViewController ()
@property (weak, nonatomic) IBOutlet UITextField *searchField;
@property (weak, nonatomic) IBOutlet UIButton *searchButton;
@property(nonatomic) NSMutableArray *images;

@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




//prepare for segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"searchDetail"]) {
        SearchResultsViewController *view = (SearchResultsViewController *)segue.destinationViewController;
    
        view.searchText = _searchField.text;
        
       // [self loadImagesFromFlickr:_searchField.text];
        //[view setupTableView];
        //view.images = self.images;
        //populate table view of search detail view controller
    }
}
@end
