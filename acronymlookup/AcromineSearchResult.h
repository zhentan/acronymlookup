//
//  AcromineSearchResult.h
//  acronymlookup
//
//  Created by zhen tan on 7/5/15.
//  Copyright (c) 2015 zhen tan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AcromineSearchResult : NSObject

- (id)initWithDictionary:(NSDictionary *)data;

@property (nonatomic, strong) NSArray *results;
//TODO: Probably should model the other fields in the response. For this app they are not used.
@end
