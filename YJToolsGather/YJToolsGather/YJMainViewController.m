//
//  YJMainViewController.m
//  YJToolsGather
//
//  Created by YJHou on 16/10/12.
//  Copyright © 2016年 YJHou. All rights reserved.
//

#import "YJMainViewController.h"
#import "MonitorMuteManager.h"
#import "SegmentationViewController.h"
#import "ConvertTypeViewController.h"

@interface YJMainViewController () <UITableViewDataSource, UITableViewDelegate, MonitorMuteManagerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray * dataSource;
@property (nonatomic, strong) UILabel * muteModelLabel; /**< 手机静音模式 */

@end

@implementation YJMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _setUpMainNavView];
    [self _setUpMainView];
}

- (void)_setUpMainNavView{
    self.navigationItem.title = @"测试";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.muteModelLabel];
}

- (void)_setUpMainView{
    
    self.tableView.tableFooterView = [UIView new];
    
    NSArray * dataSource = @[@"查看手机是否静音", @"测试中文分词功能", @"类型转换"];
    
    self.dataSource = [NSMutableArray arrayWithArray:dataSource];
    
    [MonitorMuteManager sharedInstance].delegate = self;
}

#pragma mark - tableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString * testCellId = @"";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:testCellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:testCellId];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", self.dataSource[indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    UIViewController * pushVc = nil;
    if (indexPath.row == 0) { // 查看手机是否静音
        [[MonitorMuteManager sharedInstance] detectMuteSwitch];
    }else if (indexPath.row == 1){
        SegmentationViewController * seg = [[SegmentationViewController alloc] init];
        pushVc = seg;
    }else if (indexPath.row == 2){
        
        ConvertTypeViewController * convert = [[ConvertTypeViewController alloc] init];
        pushVc = convert;
    }
    [self.navigationController pushViewController:pushVc animated:YES];
}

#pragma mark - MonitorMuteManagerDelegate
- (void)volumeModeMuted:(BOOL)muted{
    NSString * mutedMessage = muted?@"静音":@"响亮";
    self.muteModelLabel.text = mutedMessage;
}

#pragma mark - Lazy
- (NSMutableArray *)dataSource{
    if (_dataSource == nil) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (UILabel *)muteModelLabel{
    if (_muteModelLabel == nil) {
        _muteModelLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        _muteModelLabel.font = [UIFont systemFontOfSize:14.0f];
        _muteModelLabel.textColor = [UIColor redColor];
    }
    return _muteModelLabel;
}


@end
