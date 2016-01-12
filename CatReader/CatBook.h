//
//  CatBook.h
//  CatReader
//
//  Created by Shan Rammah on 1/10/16.
//  Copyright © 2016 Shan Rammah. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CatBook : NSObject

@property (nonatomic, strong) NSArray *collection1;
@property (nonatomic, strong) NSDictionary *thumbnailImage;
@property (nonatomic, strong) NSArray *name;
@property (nonatomic, strong) NSString *petName;
@property (nonatomic, strong) NSString *imageURL;
@property (nonatomic, strong) NSString *petDescription;
@property (nonatomic, strong) NSString *petCode;


- (NSURL *)adoptionPostURL;

- (NSURL *)catImageURL;



@end
