//
//  DetailViewController.h
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface DetailViewController : UIViewController



@property (weak, nonatomic) IBOutlet UIImageView *detailPetImage;
@property (strong, nonatomic) NSURL *imageURL;
@property (weak, nonatomic) NSString *petName;
@property (strong, nonatomic) NSString *petDescription;
@property (strong, nonatomic) IBOutlet UILabel *petDescriptionLabel;
@property (strong, nonatomic) NSURL *adoptionPostURL;


@end
