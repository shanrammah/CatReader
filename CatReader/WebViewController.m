//
//  WebViewController.m
//  CatReader
//
//  Created by Shan Rammah on 1/11/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import "WebViewController.h"

@interface WebViewController ()

@property (strong, nonatomic) NSURLConnection *connectionManager;
@property (strong, nonatomic) NSMutableData *downloadedMutableData;
@property (strong, nonatomic) NSURLResponse *urlResponse;

@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.adoptionPostURL];
    
    self.downloadedMutableData = [[NSMutableData alloc] init];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:self.adoptionPostURL
                                                cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                            timeoutInterval:60.0];
    
    // [self.webView loadRequest:urlRequest];
    
    self.connectionManager = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

#pragma mark - Delegate Methods

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"didRecieveResponse: %lld", response.expectedContentLength);
    self.urlResponse = response;
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.downloadedMutableData appendData:data];
    self.progressView.progress = ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length)/100;
    if (self.progressView.progress == 1) {
        self.progressView.hidden = YES;
    } else {
        self.progressView.hidden = NO;
    }
    NSLog(@"didRecieveData %.0f%%", ((100.0/self.urlResponse.expectedContentLength)*self.downloadedMutableData.length));
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection {
    NSLog(@"Finished");
    [self.webView loadData:self.downloadedMutableData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:self.adoptionPostURL];
    return;
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
