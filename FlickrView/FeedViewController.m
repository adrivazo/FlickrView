#define flickrURL @"https://api.flickr.com/services/rest/?method=flickr.photos.getRecent&api_key=edb03cecb73941fcce8e6ea834fc03fd&extras=url_m&format=json&nojsoncallback=1"

#import "FeedViewController.h"
#import "DetailViewController.h"

@interface FeedViewController () <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic) NSMutableArray *images;
@property(nonatomic) NSMutableDictionary *selectedRow;
@end

@implementation FeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadImagesFromFlickr];
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



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    self.selectedRow = [self.images objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"detail" sender:self];
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

    
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"detail"]) {
        DetailViewController *view = (DetailViewController *)segue.destinationViewController;
        view.image = self.selectedRow;
    }
}



@end
