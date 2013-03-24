//
//  MONewsViewController.m
//  myoschina
//
//  Created by user on 13-3-17.
//  Copyright (c) 2013年 iso1030. All rights reserved.
//

#import "MONewsViewController.h"

@interface MONewsViewController ()

@property (nonatomic, retain) UISegmentedControl *segmentedControl;

@end

@implementation MONewsViewController

#pragma makr - dealloc
- (void)dealloc
{
    [_segmentedControl release];_segmentedControl = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        NSArray *_segmentText = [NSArray arrayWithObjects:@"咨询", @"博客", @"推荐阅读", nil];
        
        _segmentedControl = [[UISegmentedControl alloc] initWithItems:_segmentText];
        _segmentedControl.selectedSegmentIndex = 0;
        _segmentedControl.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
        _segmentedControl.frame = CGRectMake(0, 0, 300, 30);
        [_segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
        
        self.navigationItem.titleView = self.segmentedControl;
        
        UIBarButtonItem *searchBtn = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleBordered target:self action:@selector(searchAction:)];
        self.navigationItem.rightBarButtonItem = searchBtn;
        [searchBtn release];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"动弹";
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - search click
- (void)searchAction:(id)sender
{
    NSLog(@"search");
}

#pragma mark - segmentd click
- (void)segmentAction:(id)sender
{
    NSLog(@"click");
}

#pragma mark - tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdetifier = @"newsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdetifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdetifier] autorelease];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%d", indexPath.row];
    
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.hidesBottomBarWhenPushed = indexPath.row % 2 == 0;
    [self.navigationController pushViewController:viewController animated:YES];
    [viewController release];
}

@end
