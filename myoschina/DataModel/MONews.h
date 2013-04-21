//
//  MONews.h
//  myoschina
//
//  Created by user on 13-3-31.
//  Copyright (c) 2013年 iso1030. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MONews : NSObject

@property (nonatomic, retain) NSString *nid;
@property (nonatomic, retain) NSString *title;
@property (nonatomic, assign) long commentCount;
@property (nonatomic, retain) NSString *author;
@property (nonatomic, retain) NSString *authorid;
@property (nonatomic, retain) NSString *pubtime;
@property (nonatomic, retain) NSString *url;
@property (nonatomic, assign) int type;
@property (nonatomic, retain) NSString *authoruid2;

@end
