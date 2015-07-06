//
//  AcromineSearchResult.m
//  acronymlookup
//
//  Created by zhen tan on 7/5/15.
//  Copyright (c) 2015 zhen tan. All rights reserved.
//

#import "AcromineSearchResult.h"

@interface AcromineSearchResult ()

@property (nonatomic, strong) NSDictionary *data;

@end

@implementation AcromineSearchResult

@synthesize data=_data;

- (id)init {
    if (self = [self initWithDictionary:nil]) {
    }
    return self;
}

- (id)initWithDictionary:(NSDictionary *)data {
    if (self = [super init]) {
        _data = data;
        if (_data == nil) {
            _data = [NSDictionary dictionary];
        }
    }
    return self;
}

- (NSArray *)results {
    return self.data[@"lfs"];
}


@end
