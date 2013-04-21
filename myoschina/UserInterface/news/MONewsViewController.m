//
//  MONewsViewController.m
//  myoschina
//
//  Created by user on 13-3-17.
//  Copyright (c) 2013年 iso1030. All rights reserved.
//

#import "MONewsViewController.h"
#import "ASIHTTPRequest.h"
#import "TBXML.h"
#import "MONews.h"
#import "MODetailViewController.h"
#import "MOCommentViewController.h"
#import "MOShareViewController.h"

@interface MONewsViewController ()

@property (nonatomic, retain) NSMutableArray *newsArray;
@property (nonatomic, retain) UISegmentedControl *segmentedControl;
@property (nonatomic, retain) EGORefreshTableHeaderView *egoRefreshTableHeaderView;
@property (nonatomic, assign) BOOL reloading;

@end

@implementation MONewsViewController

#pragma makr - dealloc
- (void)dealloc
{
    [_newsArray release];_newsArray = nil;
    [_segmentedControl release];_segmentedControl = nil;
    [_egoRefreshTableHeaderView release];_egoRefreshTableHeaderView = nil;
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _newsArray = [[NSMutableArray alloc] initWithCapacity:0];
        
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
    self.title = @"综合";
    if (!_egoRefreshTableHeaderView)
    {
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0, 0 - self.tableView.bounds.size.height, self.view.frame.size.width, self.view.frame.size.height)];
        view.delegate = self;
        [self.tableView addSubview:view];
        _egoRefreshTableHeaderView = view;
        [view release];
    }
    [_egoRefreshTableHeaderView refreshLastUpdatedDate];
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
    [self getData];
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
    return _newsArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdetifier = @"newsCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdetifier];
    if (!cell)
    {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdetifier] autorelease];
    }
    MONews *news = [_newsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = news.title;
    return cell;
}

#pragma mark - tableview delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MODetailViewController *detailController = [[MODetailViewController alloc] init];
    detailController.tabBarItem.title = @"详情";
    
    MOCommentViewController *commentController = [[MOCommentViewController alloc] init];
    commentController.tabBarItem.title = @"评论";
    
    MOShareViewController *shareController = [[MOShareViewController alloc] init];
    shareController.tabBarItem.title = @"分享";
    
    UITabBarController *tabBarController = [[UITabBarController alloc] init];
    tabBarController.viewControllers =[NSArray arrayWithObjects:detailController, commentController, shareController, nil];
    
    [detailController release];
    [commentController release];
    [shareController release];
    
    tabBarController.hidesBottomBarWhenPushed = indexPath.row % 2 == 0;
    [self.navigationController pushViewController:tabBarController animated:YES];
    [tabBarController release];
}

#pragma makr - UISCrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_egoRefreshTableHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_egoRefreshTableHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

#pragma mark - egoRefreshTableView delegate
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView *)view
{
    [self reloadTableViewDataSource];
    [self getData];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView *)view
{
    return _reloading;
}

- (NSDate *)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView *)view
{
    return [NSDate date];
}

#pragma makr - reload datasource from ego
- (void)reloadTableViewDataSource
{
    _reloading = YES;
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
    [_egoRefreshTableHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

#pragma mark - get data
- (void)getData
{
    NSURL *url = [NSURL URLWithString:@"http://www.oschina.net/action/api/news_list?catalog=1&pageIndex=0&pageSize=20"];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setDelegate:self];
    [request startAsynchronous];
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    [self doneLoadingTableViewData];
    [_newsArray removeAllObjects];
    NSString *responseString = [request responseString];
    //NSData *responseData = [request responseData];
    NSLog(@"%@", responseString);
    
    TBXML *xml = [[TBXML alloc] initWithXMLString:responseString error:nil];
    
    TBXMLElement *root = [xml rootXMLElement];
    TBXMLElement *newsList = [TBXML childElementNamed:@"newslist" parentElement:root];
    if (newsList)
    {
        TBXMLElement *newsElement = [TBXML childElementNamed:@"news" parentElement:newsList];
        while (newsElement) {
            TBXMLElement *_id = [TBXML childElementNamed:@"id" parentElement:newsElement];
            TBXMLElement *title = [TBXML childElementNamed:@"title" parentElement:newsElement];
            TBXMLElement *commentCount = [TBXML childElementNamed:@"commentCount" parentElement:newsElement];
            TBXMLElement *author = [TBXML childElementNamed:@"author" parentElement:newsElement];
            TBXMLElement *authorid = [TBXML childElementNamed:@"authorid" parentElement:newsElement];
            TBXMLElement *pubDate = [TBXML childElementNamed:@"pubDate" parentElement:newsElement];
            TBXMLElement *url = [TBXML childElementNamed:@"url" parentElement:newsElement];
            TBXMLElement *newstype = [TBXML childElementNamed:@"newstype" parentElement:newsElement];
            TBXMLElement *type = [TBXML childElementNamed:@"type" parentElement:newstype];
            TBXMLElement *authoruid2 = [TBXML childElementNamed:@"authoruid2" parentElement:newstype];
            
            MONews *news = [[MONews alloc] init];
            news.nid = [TBXML textForElement:_id];
            news.title = [TBXML textForElement:title];
            news.commentCount = [[TBXML textForElement:commentCount] intValue];
            news.author = [TBXML textForElement:author];
            news.authorid = [TBXML textForElement:authorid];
            news.pubtime = [TBXML textForElement:pubDate];
            news.url = [TBXML textForElement:url];
            news.type = [[TBXML textForElement:type] intValue];
            news.authoruid2 = [TBXML textForElement:authoruid2];
            
            [_newsArray addObject:news];
            [news release];
            
            newsElement = [TBXML nextSiblingNamed:@"news" searchFromElement:newsElement];
        }
    }
    [xml release];
    [[self tableView] reloadData];}

- (void)requestFailed:(ASIHTTPRequest *)request
{
    NSError *error = [request error];
    NSLog(@"%@", error);
}

@end
