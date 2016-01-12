//
//  CatBook.m
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import "CatBook.h"

@implementation CatBook

- (NSURL *)petImageURL
{
    return [NSURL URLWithString:self.imageURL];
}


- (NSURL *)adoptionPostURL
{
        // This method returns the URL for the adoption post, it combines the default URL path with the pet code
        NSString *defaultURL = @"http://www.oregonhumane.org/adopt/details/"; //This is the start of every adoption post URL from the Oregon Humane Society
        NSString *adoptionPostURLString = [defaultURL stringByAppendingString:self.petCode];
        return [NSURL URLWithString:adoptionPostURLString];
}


@end
