//
//  MONews.m
//  myoschina
//
//  Created by user on 13-3-31.
//  Copyright (c) 2013年 iso1030. All rights reserved.
//

#import "MONews.h"

@implementation MONews

- (void)dealloc
{
    [_nid release];_nid = nil;
    [_title release];_title = nil;
    [_author release];_author = nil;
    [_authorid release];_authorid = nil;
    [_pubtime release];_pubtime = nil;
    [_url release];_url = nil;
    [_authoruid2 release];_authoruid2 = nil;
    [super dealloc];
}

@end
