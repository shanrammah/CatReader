//
//  CatBook.m
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import "CatBook.h"

@implementation CatBook

- (NSURL *)catImageURL
{
    return [NSURL URLWithString:self.imageURL];
}


- (NSURL *)adoptionPostURL
{
        NSString *defaultURL = @"http://www.oregonhumane.org/adopt/details/";
        NSString *adoptionPostURLString = [defaultURL stringByAppendingString:self.petCode];
        return [NSURL URLWithString:adoptionPostURLString];
}


@end
