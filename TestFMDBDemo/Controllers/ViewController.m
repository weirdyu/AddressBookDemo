//
//  ViewController.m
//  TestFMDBDemo
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import "ViewController.h"
#import "AddContactViewController.h"
#import "ContactsDatabaseOption.h"
#import "ContactModel.h"
#import "ContactsTableViewCell.h"

#import "ContactsSearchBar.h"
#import "UIView+Toast.h"
#import "UIView+Size.h"
#import "UIColor+Hex.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate, SearchBarDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property(nonatomic, weak) ContactsSearchBar *searchBar;
@property (nonatomic, strong)NSMutableArray *contactsArray;     //  联系人数组
@property (nonatomic, strong)NSMutableArray *fliterArray;       //  搜索筛选数组

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"通讯录";
    
    [DatabaseUtil shareInstance];
    _contactsArray = [[NSMutableArray alloc]initWithCapacity:0];
    _fliterArray = [[NSMutableArray alloc]initWithCapacity:0];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(selectRightAction)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableHeaderView = [[UIView alloc]init];
    _tableView.tableFooterView = [[UIView alloc]init];
    [self.view addSubview:_tableView];
    
    [self setupSearchBar];
}

- (void)viewWillAppear:(BOOL)animated{
    [self getDataSourceFromDatabase];
}

- (void)setupSearchBar
{
    ContactsSearchBar *searchBar = [[ContactsSearchBar alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 44)];
    searchBar.delegate = self;
    _searchBar = searchBar;
    
    [_tableView setTableHeaderView:_searchBar];
}

#pragma mark -Get DataSource from datebase
- (void)getDataSourceFromDatabase {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        _contactsArray = [ContactsDatabaseOption queryData];
        _fliterArray = _contactsArray;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [_tableView reloadData];
        });
    });
}

#pragma mark Button Action
- (void)selectRightAction {

    AddContactViewController *vc = [[AddContactViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark SearchBar Delegate
- (void)searchBar:(SearchBar *)searchBar textDidChange:(NSString *)text{

    NSString *searchString = text;
    
    NSPredicate *p1 = [NSPredicate predicateWithFormat:@"name CONTAINS[c] %@", searchString];
    NSPredicate *p2 = [NSPredicate predicateWithFormat:@"phone CONTAINS[c] %@", searchString];
    NSPredicate *predicate = [NSCompoundPredicate orPredicateWithSubpredicates:@[p1, p2]];
    
    if ([text isEqualToString:@""]) {
        self.fliterArray = _contactsArray;
    } else {
        //过滤数据
        self.fliterArray= [NSMutableArray arrayWithArray:[_contactsArray filteredArrayUsingPredicate:predicate]];
    }
    [self.tableView reloadData];
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _fliterArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    static NSString *CellIdentifier = @"cell";
    ContactsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[ContactsTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    if (_fliterArray.count!=0) {

        ContactModel *contact = _fliterArray[indexPath.row];
        [cell setName:contact.name];
        [cell setPhoneNumber:contact.phone];
        NSLog(@"%d==%@==%@",contact.contactID,contact.name,contact.phone);
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    [tableView deselectRowAtIndexPath:indexPath animated:YES]; 

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [ContactsTableViewCell calculateCellHeight];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
