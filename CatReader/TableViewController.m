//
//  TableViewController.m
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import "TableViewController.h"
#import "DetailViewController.h"
#import "CatBook.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    NSURL *apiURL = [NSURL URLWithString:@"http://www.kimonolabs.com/api/9hsr61i4?apikey=ViFuIaesOusUCdWE4Kl85HwLYp2GYgth"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDownloadTask *task = [session downloadTaskWithURL:apiURL completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSData *jsonData = [[NSData alloc] initWithContentsOfURL:location];
        
        NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
        self.catsArray = [[NSMutableArray alloc] init];
    
        //NSLog(@"cats array: %@", self.catsArray);

        NSDictionary *adoptionPostsDictionary = [dataDictionary objectForKey:@"results"];
        NSArray *adoptionPostsArray = [adoptionPostsDictionary objectForKey:@"collection1"];
    
        for (NSDictionary *apDictionary in adoptionPostsArray) {
            CatBook *adoptionPost = [[CatBook alloc] init];
            adoptionPost.petImageURLDictionary = [apDictionary objectForKey:@"ThumbnailImage"];
            adoptionPost.imageURL = [adoptionPost.petImageURLDictionary objectForKey:@"src"];
            adoptionPost.petDetailsArray = [apDictionary objectForKey:@"Name"];
            adoptionPost.petName = [adoptionPost.petDetailsArray objectAtIndex:0];
            adoptionPost.petDescription = [apDictionary objectForKey:@"description"];
            adoptionPost.petCode = [adoptionPost.petDetailsArray objectAtIndex:1];
        
            [self.catsArray addObject:adoptionPost];
        
    }
    
        dispatch_async(dispatch_get_main_queue(), ^ {
            [self.tableView reloadData];
        });
    }];
    [task resume];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.catsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    CatBook *adoptionPost = [self.catsArray objectAtIndex:indexPath.row];
    

    if( [adoptionPost.imageURL isKindOfClass:[NSString class]]) {
        NSData *imageData = [NSData dataWithContentsOfURL:adoptionPost.petImageURL];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        cell.imageView.image = image;
    }

        cell.textLabel.text = adoptionPost.petName;
        // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", blogPost.author, blogPost.date];
        
        return cell;
}

#pragma mark - Navigation


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqual:@"showDetailView"]) {
        
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        CatBook *adoptionPost = [self.catsArray objectAtIndex:indexPath.row];
        [segue.destinationViewController setImageURL:adoptionPost.petImageURL];
        [segue.destinationViewController setPetName:adoptionPost.petName];
        [segue.destinationViewController setPetDescription:adoptionPost.petDescription];
        [segue.destinationViewController setAdoptionPostURL:adoptionPost.adoptionPostURL];

        }
    
    
}


@end
