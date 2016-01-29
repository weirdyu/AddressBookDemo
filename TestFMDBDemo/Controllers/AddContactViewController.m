//
//  PresentModalViewController.m
//  TestFMDBDemo
//
//  Created by Mac on 16/1/18.
//  Copyright © 2016年 Beacon. All rights reserved.
//

#import "AddContactViewController.h"
#import "UserInfoEditTableViewCell.h"
#import "ContactModel.h"
#import "ContactsDatabaseOption.h"

@interface AddContactViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ContactModel *userInfo;

@end

@implementation AddContactViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"编辑信息";
    
    _userInfo = [[ContactModel alloc]init];
    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonClicked)];
    self.navigationItem.rightBarButtonItem = rightButton;
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc]init];
    _tableView.separatorInset = UIEdgeInsetsMake(0, 50, 0, 0);
    [self.view addSubview:_tableView];
}

#pragma mark Button Action
- (void)doneButtonClicked {
    
    if ([_userInfo.name isEqualToString:@""]||_userInfo.name == nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"联系人姓名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
        
    } else if ([_userInfo.phone isEqualToString:@""]||_userInfo.phone ==nil) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"联系人电话不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alert show];
    
    } else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [ContactsDatabaseOption insertData:_userInfo];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        });
    }
}

#pragma mark TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 2;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"cell";
    UserInfoEditTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UserInfoEditTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell setTitle:[self setTitleText:indexPath]];
    [cell setInputText:@"" withPlaceholder:[self setTextFieldPlaceholder:indexPath]];
    cell.inputTF.tag = indexPath.row;
    [cell.inputTF addTarget:self action:@selector(textFieldWithText:) forControlEvents:UIControlEventEditingChanged];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return [UserInfoEditTableViewCell calculateCellHeight];
}

- (NSString *)setTitleText:(NSIndexPath *)indexPath {

    switch (indexPath.row) {
        case 0:
            return @"姓名";
            break;
           
        case 1:
            return @"电话";
            break;
            
        default:
            break;
    }
    return @"";
}

- (void)textFieldWithText:(UITextField *)textField
{
    switch (textField.tag) {
        case 0:
            _userInfo.name = textField.text;
            break;
            
        case 1:
            _userInfo.phone = textField.text;
            break;
            
        default:
            break;
    }
}

- (NSString *)setTextFieldPlaceholder:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
            return @"请输入姓名";
            break;
            
        case 1:
            return @"请输入电话";
            break;
            
        default:
            break;
    }
    return @"";
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
