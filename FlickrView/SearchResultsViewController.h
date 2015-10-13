//
//  ViewController.h
//  FlickrView
//
//  Created by Adriana Vazquez on 10/11/15.
//  Copyright © 2015 Adriana Vazquez. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchResultsViewController : UIViewController

@property(nonatomic) NSMutableArray *images;
@property(weak, nonatomic) NSString *searchText;


@end

