//
//  MODetailViewController.m
//  myoschina
//
//  Created by user on 13-4-9.
//  Copyright (c) 2013年 iso1030. All rights reserved.
//

#import "MODetailViewController.h"

@interface MODetailViewController ()

@end

@implementation MODetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    UIWebView *view = [[UIWebView alloc] init];
    self.view = view;
    [view release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UIWebView *view = (UIWebView *)self.view;
    [view loadHTMLString:@"<a href=\"http://163.com\">163.com</a>" baseURL:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
