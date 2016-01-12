//
//  WebViewController.h
//  CatReader
//
//  Created by Shan Rammah on 1/11/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WebViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (strong, nonatomic) NSURL *adoptionPostURL;

@end
