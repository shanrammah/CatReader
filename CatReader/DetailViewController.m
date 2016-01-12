//
//  DetailViewController.m
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.imageURL];
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    self.detailPetImage.image = image;
    
    self.navigationItem.title = self.petName;
    
    NSLog(@" %@", self.petDescription);
    
    self.petDescriptionLabel.text = self.petDescription;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showWebView"]) {
        
        [segue.destinationViewController setAdoptionPostURL:self.adoptionPostURL];
        
    }
}



@end
