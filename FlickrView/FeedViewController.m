#define flickrURL @"https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=edb03cecb73941fcce8e6ea834fc03fd&extras=url_m&format=json&nojsoncallback=1"

#import "FeedViewController.h"


@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSMutableArray *images;

@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loadImagesFromFlickr {
    // See the defined URL above.
    NSURL *url = [NSURL URLWithString:flickrURL];
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

- (void)setupTableView {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
}



@end
