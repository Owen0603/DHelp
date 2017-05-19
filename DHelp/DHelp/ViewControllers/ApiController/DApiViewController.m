//
//  DApiViewController.m
//  DHelp
//
//  Created by 姚凤 on 2017/3/7.
//  Copyright © 2017年 姚凤. All rights reserved.
//

#import "DApiViewController.h"
#import "DKeyValueModel.h"
#import "NSView+Frame.h"

NSString * const headerKey = @"headerKey";
NSString * const headerValue = @"headerValue";

@interface DApiViewController ()<NSControlTextEditingDelegate,NSTableViewDelegate,NSTableViewDataSource>
@property(nonatomic, strong) NSMutableArray *paramsKeyValueArray;
@property(nonatomic, strong) NSMutableArray *headerKeyValueArray;

@end

@implementation DApiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do view setup here.

}

#pragma mark - rquest

- (IBAction)getDataButtonPressed:(id)sender {
    if (nil == (self.urlTextField).stringValue || [(self.urlTextField).stringValue isEqualToString:@""]) {
        return;
    }
    
    (self.urlTextField).stringValue = [self.urlTextField.stringValue stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    NSString *escapedString = [(self.urlTextField).stringValue stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding] ;

    
    DRequest *request = [[DRequest alloc] initWithBaseUrl:escapedString params:self.paramsKeyValueArray Header:self.headerKeyValueArray httpMethod:self.httpMethodRadioButtons.selectedColumn];
    [request dRequestStart:^{
        if (self.delegate) {
            [self.delegate apiRequestSuccessResult:request];
        }
    } end:^(YTKBaseRequest *result) {
        if (self.delegate) {
            [self.delegate apiRequestSuccessResult:request];
        }

    }];
    
    
    // ******************************************
    // SUCCESS BLOCK
    // ******************************************
    void (^successBlock)(NSURLResponse *response,id object) = ^(NSURLResponse *response,id object){
        
        NSString *parsedString  = [[NSString alloc] initWithData:object encoding:NSUTF8StringEncoding];
        
        NSError *error = nil;
        parsedString = [parsedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        NSData *data = [parsedString dataUsingEncoding:NSUTF8StringEncoding];
        
        if (data == nil) {
            NSAlert *testAlert = [NSAlert alertWithMessageText:NSLocalizedString(@"An Error Occurred", @"Title of an alert if there is an error getting content of a url")
                                                 defaultButton:NSLocalizedString(@"OK", @"Button to dismiss an action sheet")
                                               alternateButton:nil
                                                   otherButton:nil
                                     informativeTextWithFormat:NSLocalizedString(@"alert.message.notValidData", @"Alert body when trying to download a file and it is not in the right format")];
            [testAlert runModal];
            return;
        }
        
        // Just for testing
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        
        if (error == nil) {
            id output = [NSJSONSerialization dataWithJSONObject:jsonObject options:NSJSONWritingPrettyPrinted error:&error];
            NSString *outputString = [[NSString alloc] initWithData:output encoding:NSUTF8StringEncoding];
            
        } else {
        }
    };
    
    // ******************************************
    // ERROR BLOCK
    // ******************************************
    
    void (^errorBlock)(NSURLResponse *response, NSError *error) = ^(NSURLResponse *response, NSError *error){
        
//        if (response == nil) {
            NSString *informativeText = error.localizedDescription;
            
            if (informativeText == nil) {
                informativeText = @"";
            }
            NSAlert *testAlert = [NSAlert alertWithMessageText:NSLocalizedString(@"An Error Occurred", @"Title of an alert if there is an error getting content of a url")
                                                 defaultButton:NSLocalizedString(@"OK", @"Button to dismiss an action sheet")
                                               alternateButton:nil
                                                   otherButton:nil
                                     informativeTextWithFormat:@"%@", informativeText];
            [testAlert runModal];
//        }
//        else {
//            NSString *statusCode = [NSString stringWithFormat:@"%ld", response.statusCode];
//            NSString *localizedStatusCode = [NSHTTPURLResponse localizedStringForStatusCode:response.statusCode];
//            NSString *contatenatedString = [NSString stringWithFormat:@"%@ - %@", statusCode, localizedStatusCode ];
//            
//            NSAlert *alert = [NSAlert alertWithMessageText:NSLocalizedString(@"An Error Occurred", @"Title of an alert if there is an error getting content of a url")
//                                             defaultButton:NSLocalizedString(@"OK", @"Button to dismiss an action sheet")
//                                           alternateButton:nil
//                                               otherButton:nil
//                                 informativeTextWithFormat:contatenatedString, nil];
//            [alert runModal];
//        }
    };

}

#pragma mark - requestParams

//type 0 : request params   1: post header
- (void)deleteEmptyData:(int) type{
    //删除空数据
    if (type==0) {
        for (int i = (int)self.paramsKeyValueArray.count-1; i>=0; i--) {
            DKeyValueModel *model = self.paramsKeyValueArray[i];
            if ([model isEmpty]) {
                [self.paramsKeyValueArray removeObject:model];
            }else{
                break;
            }
        }
    }else{
        for (int i = (int)self.headerKeyValueArray.count-1; i>=0; i--) {
            DKeyValueModel *model = self.headerKeyValueArray[i];
            if ([model isEmpty]) {
                [self.headerKeyValueArray removeObject:model];
            }else{
                break;
            }
        }
    }
 
}

- (IBAction)addParamsClicked:(id)sender {
    [self deleteEmptyData:0];
    if (_paramsKeyField.stringValue != nil && ![_paramsKeyField.stringValue isEqualToString:@""] && _paramsValueField.stringValue != nil && ![_paramsValueField.stringValue isEqualToString:@""]) {
        [self.paramsKeyValueArray addObject:[[DKeyValueModel alloc] initWithKey:_paramsKeyField.stringValue value:_paramsValueField.stringValue]];
        [self.paramsTableView reloadData];
    }
}

- (IBAction)paramsPlusClicked:(id)sender {
    [self deleteEmptyData:0];
    [self.paramsKeyValueArray addObject:[[DKeyValueModel alloc] initWithKey:@"" value:@""]];
    [self.paramsTableView reloadData];
    [_paramsTableView editColumn:0 row:(_headerTableView.numberOfRows - 1) withEvent:nil select:YES];
}

- (IBAction)paramsMinusClicked:(id)sender {
    NSInteger row = _paramsTableView.selectedRow;
    if (row>=0) {
        [self.paramsKeyValueArray removeObjectAtIndex:row];
        [_paramsTableView reloadData];
    }
}

#pragma mark - post Header

- (IBAction)addHeaderClicked:(id)sender {
    [self deleteEmptyData:1];
    if (_headerKeyField.stringValue != nil && ![_headerKeyField.stringValue isEqualToString:@""] && _headerValueField.stringValue != nil && ![_headerValueField.stringValue isEqualToString:@""]) {
        [self.headerKeyValueArray addObject:[[DKeyValueModel alloc] initWithKey:_headerKeyField.stringValue value:_headerValueField.stringValue]];
        [self.headerTableView reloadData];
    }
}

- (IBAction)headerPlusClicked:(id)sender {
    [self deleteEmptyData:1];
    [self.headerKeyValueArray addObject:[[DKeyValueModel alloc] initWithKey:@"" value:@""]];
    [self.headerTableView reloadData];
    [_headerTableView editColumn:0 row:(_headerTableView.numberOfRows - 1) withEvent:nil select:YES];
}

- (IBAction)headerMinusClicked:(id)sender {
    NSInteger row = _headerTableView.selectedRow;
    if (row>=0) {
        [self.headerKeyValueArray removeObjectAtIndex:row];
        [_headerTableView reloadData];
    }
}

#pragma mark - tableView代理方法
//返回表格的行数
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView{
    
    if (tableView == self.paramsTableView) {
        return self.paramsKeyValueArray.count;
    }
    return self.headerKeyValueArray.count;
}

//用了下面那个函数来显示数据就用不上这个，但是协议必须要实现，所以这里返回nil
- (id)tableView:(NSTableView *)tableView objectValueForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row
{
    return nil;
}

//
- (void)tableView:(NSTableView *)tableView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row{
    
    DKeyValueModel *model;
    if (tableView == self.paramsTableView) {
        model = self.paramsKeyValueArray[row];
    }else{
        model = self.headerKeyValueArray[row];
    }
    
    NSString *identifier = [tableColumn identifier];
    
    if ([identifier isEqualToString:@"key"]) {
        NSTextFieldCell *textCell = cell;
        [textCell setTitle:model.keyString];
    }
    else if ([identifier isEqualToString:@"value"])
    {
        NSTextFieldCell *textCell = cell;
        [textCell setTitle:model.valueString];
    }
}


#pragma mark - set\get
- (NSMutableArray *)paramsKeyValueArray{
    if (_paramsKeyValueArray == nil) {
        _paramsKeyValueArray= [NSMutableArray array];
    }
    return _paramsKeyValueArray;
}

- (NSMutableArray *)headerKeyValueArray{
    if (_headerKeyValueArray == nil) {
        _headerKeyValueArray = [NSMutableArray array];
    }
    return _headerKeyValueArray;
}

@end
