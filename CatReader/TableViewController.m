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
#import <SAMCache/SAMCache.h>


@interface TableViewController ()

@property (nonatomic, strong) NSMutableArray *catsArray;


@end

@implementation TableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self refresh];

}

- (void) refresh {
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [NSURL URLWithString:@"http://www.kimonolabs.com/api/9hsr61i4?apikey=ViFuIaesOusUCdWE4Kl85HwLYp2GYgth"]; //This is the API URL from Kimono Labs
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
            completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
            {
                NSData *data = [[NSData alloc] initWithContentsOfURL:location];
                NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                
                self.catsArray = [responseDictionary valueForKeyPath:@"results"];
                                          
                self.catsArray = [[NSMutableArray alloc] init];
                                          
                NSDictionary *adoptionPostsDictionary = [responseDictionary objectForKey:@"results"];
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
    
    


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.catsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    CatBook *adoptionPost = [self.catsArray objectAtIndex:indexPath.row];
    
    /*
    
    NSString *key =
    UIImage *image = [[SAMCache sharedCache] imageForKey:key];

    */
     
    NSURLSession *session = [NSURLSession sharedSession];
    NSURL *url = [[NSURL alloc] initWithString:adoptionPost.imageURL];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];

    NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
        completionHandler:^(NSURL * _Nullable location, NSURLResponse * _Nullable response, NSError * _Nullable error)
    {
                                                        
                                                        
        NSData *data = [[NSData alloc] initWithContentsOfURL:location];
        UIImage *image = [[UIImage alloc] initWithData:data];

        
                                                        
            dispatch_async(dispatch_get_main_queue(), ^{
            
            cell.imageView.image = image;
            cell.textLabel.text = adoptionPost.petName;
                
            });
        }];
    
    [task resume];
    
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
