//
//  GridCollectionViewController.m
//  Flixer
//
//  Created by Oluwanifemi Kolawole on 6/17/22.
//

#import "GridCollectionViewController.h"
#import "GridCollectionViewCell.h"
#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@interface GridCollectionViewController ()<UICollectionViewDataSource, UICollectionViewDelegate>
@property (nonatomic, strong) NSArray *movies;

@end

@implementation GridCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;

    [self fetchMovies];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Do any additional setup after loading the view.
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=5e34499c7fbfe14e0563bffb51209b90"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) {
               NSLog(@"%@", [error localizedDescription]);
           }
           else {
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
               
               self.movies = dataDictionary[@"results"];
               for (NSDictionary *movie in self.movies){
                   NSLog(@"%@", movie [@"title" ]);
                   
               }
               [self.collectionView reloadData];

           }
       // [self.refreahControl endRefreshing];
       }];
    [task resume];
    

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return self.movies.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.movies.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
        GridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GridCollectionViewCell" forIndexPath:indexPath];

        NSDictionary *movie = self.movies[indexPath.row];

        NSString *baseURLString = @"https://image.tmdb.org/t/p/w92/";
        NSString *posterURLString = movie[@"poster_path"];
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];

        NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
        cell.posterView.image = nil;
        [cell.posterView setImageWithURL:posterURL];
    
        //cell.textLabel.text = movie[@"title"];
        //cell.textLabel.text = [NSString stringWithFormat:@"row: %d, section %d", indexPath.row, indexPath.section];//
    
        return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    int totalwidth = self.collectionView.bounds.size.width;
    int numberOfCellsPerRow = 3;
    int oddEven = indexPath.row / numberOfCellsPerRow % 4;
    int dimensions = (CGFloat)(totalwidth / numberOfCellsPerRow);
    if (oddEven == 0) {
        return CGSizeMake(dimensions, dimensions);
    } else {
        return CGSizeMake(dimensions, dimensions / 2);
    }
}


@end
