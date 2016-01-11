//
//  TableViewController.m
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import "TableViewController.h"
#import "CatBook.h"


@interface TableViewController ()

@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSLog(@"viewDidLoad");
    
    NSURL *apiURL = [NSURL URLWithString:@"http://www.kimonolabs.com/api/9hsr61i4?apikey=ViFuIaesOusUCdWE4Kl85HwLYp2GYgth"];
    
    NSData *jsonData = [NSData dataWithContentsOfURL:apiURL];
    
    NSError *error = nil;
    
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error]; //you have to pass the reference for an error
    // NSLog(@"%@", dataDictionary);
    
    self.catsArray = [[NSMutableArray alloc] init]; //blogPosts
    
    NSLog(@"cats array: %@", self.catsArray);

    NSDictionary *adoptionPostsDictionary = [dataDictionary objectForKey:@"results"];
    NSArray *adoptionPostsArray = [adoptionPostsDictionary objectForKey:@"collection1"];
    
    for (NSDictionary *apDictionary in adoptionPostsArray) {
        CatBook *adoptionPost = [[CatBook alloc] init];
        adoptionPost.thumbnailImage = [apDictionary objectForKey:@"ThumbnailImage"];
        adoptionPost.imageURL = [adoptionPost.thumbnailImage objectForKey:@"src"];
        adoptionPost.name = [apDictionary objectForKey:@"Name"];
        adoptionPost.catName = [adoptionPost.name objectAtIndex:0];
        
        [self.catsArray addObject:adoptionPost];
        
    }

    
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
        NSData *imageData = [NSData dataWithContentsOfURL:adoptionPost.catImageURL];
        UIImage *image = [[UIImage alloc] initWithData:imageData];
        cell.imageView.image = image;
    }

        cell.textLabel.text = adoptionPost.catName;
        // cell.detailTextLabel.text = [NSString stringWithFormat:@"%@, %@", blogPost.author, blogPost.date];
        
        return cell;
}

#pragma mark - Segues



@end
