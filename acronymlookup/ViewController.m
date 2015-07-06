//
//  ViewController.m
//  acronymlookup
//
//  Created by zhen tan on 7/1/15.
//  Copyright (c) 2015 zhen tan. All rights reserved.
//

#import "ViewController.h"
#import "ZTHelper.h"
#import "ZTTextFieldLabeled.h"
#import "ZTSimpleCell.h"
#import "AcromineSearchResult.h"

@interface ViewController ()

@property (nonatomic, strong) IBOutlet ZTTextFieldLabeled *searchBox;
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *longforms;

@end

@implementation ViewController

- (void)viewDidLoad {
    [AcromineClient instance];
    [super viewDidLoad];
    self.searchBox.label.text = @"ACRONYM";
    self.searchBox.textField.placeholder = @"Enter Term to Look Up Here";
    self.searchBox.textField.returnKeyType = UIReturnKeySearch;
    self.searchBox.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchBox.textField.delegate = self;
    [self.searchBox.button setTitle:@"Seach" forState:UIControlStateNormal];
    __weak ZTTextFieldLabeled *weaksb = self.searchBox;
    weaksb.buttonActionBlock = ^{
        if (!weaksb.textField.text || [weaksb.textField.text isEqualToString:@""])
            [ZTHelper showOKAlertWithTitle:@"Error" message:@"Please enter an acronym."];
        else
            [self searchAcronym:weaksb.textField.text];
    };
    
//    self.tableView.estimatedRowHeight = 44.0;
//    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)searchAcronym:(NSString *)searchTerm {
    __weak ViewController *weakSelf = self;
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [AcromineClient getAcronym:searchTerm
                       success:^(NSURLSessionDataTask *task, id response) {
                           dispatch_async(dispatch_get_main_queue(), ^{
                               [MBProgressHUD hideHUDForView:self.view animated:YES];
                               //response is always a single item array so we get the first element
                               if(((NSArray*)response).count > 0) {
                                   AcromineSearchResult *searchResult = [[AcromineSearchResult alloc] initWithDictionary:response[0]];
                                   weakSelf.longforms = [searchResult.results mutableCopy];
                                   [weakSelf.tableView reloadData];
                               } else {
                                   [ZTHelper showOKAlertWithTitle:@"Error" message:@"Acronym not found."];
                               }
                           });
                       }
                       failure:^(NSURLSessionDataTask *task, NSError *error) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                [MBProgressHUD hideHUDForView:self.view animated:YES];
                                [ZTHelper showOKAlertWithError:error];
                            });
                       }
     ];
}

#pragma mark - Text Field delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    [self.searchBox.buttonActionBlock invoke];
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.longforms.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ZTSimpleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"defcell" forIndexPath:indexPath];
    cell.label.text = self.longforms[indexPath.row][@"lf"];
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        cell.layoutMargins = UIEdgeInsetsZero;
    }
}


@end
