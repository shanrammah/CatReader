//
//  DetailViewController.h
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CatBook;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) CatBook *catBook;

@property (weak, nonatomic) IBOutlet UIImageView *detailCatImage;
@property (strong, nonatomic) NSURL *imageURL;



@end
