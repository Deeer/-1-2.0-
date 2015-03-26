//
//  SettingItemController.m
//  SettingPro
//
//  Created by zjsruxxxy3 on 15/2/14.
//  Copyright (c) 2015年 wrcj. All rights reserved.
//

#import "SettingItemController.h"

#import "SettingViewCell.h"

#import "SettingGroup.h"
#import "SettingItem.h"

#import "AboutAuthor/AboutAuthor.h"
#import "AppCommend/Controller/AppCommend.h"

#import "HFStretchableTableHeaderView.h"

@interface SettingItemController ()

@property (weak, nonatomic) IBOutlet UIImageView *HeadImageView;

@property(nonatomic,strong)NSMutableArray *groupArray;

@property (nonatomic, strong) HFStretchableTableHeaderView* stretchableTableHeaderView;

@end

@implementation SettingItemController

-(NSArray *)groupArray
{
    if (_groupArray == nil)
    {
        _groupArray = [NSMutableArray array];
        
    }
    
    return _groupArray;
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self addGroup2];

    [self addGroup1];
    

    [self addGroup3];
    
    _stretchableTableHeaderView = [HFStretchableTableHeaderView new];
    
    [_stretchableTableHeaderView stretchHeaderForTableView:self.tableView withView:self.HeadImageView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [_stretchableTableHeaderView scrollViewDidScroll:scrollView];
}

- (void)viewDidLayoutSubviews
{
    [_stretchableTableHeaderView resizeView];
}



-(void)addGroup1
{
    SettingItem *item1_0 = [SettingItem setupWithTitleName:@"应用评分"];
    
    item1_0.option = ^{
        
        NSLog(@"应用评分");
        
        /*
        
        int m_appleID = 0;
        
        NSString *str = [NSString stringWithFormat:
                         @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple Software&id=%d",
                         
                         m_appleID ];
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
         */
        
        
        
    };
    
    SettingItem *item1_1 = [SettingItem setupWithTitleName:@"意见反馈"];
    
    item1_1.option = ^{
        
        NSLog(@"意见反馈");
        
#warning          *  modal a viewcontroller to send e-mail

        /**
         *  send e-mail;
         */
        
    };
    
    SettingItem *item1_2 = [SettingItem setupWithTitleName:@"分享好友"];
    
    item1_2.option = ^{

    };
    
    SettingItem *item1_3 = [SettingItem setupWithTitleName:@"功能引导"];
    
    item1_3.option = ^{
        
        NSLog(@"功能引导");

#warning  modal a viewcontroller with feature guide

        
    };
    
    
    SettingGroup *group_1 = [[SettingGroup alloc]init];
    
    group_1.items = @[item1_0,item1_1,item1_2,item1_3];
    
    [self.groupArray addObject:group_1];
    
}



-(void)addGroup2
{
    SettingItem *item2_0 = [SettingItem setupWithIcon:nil Title:@"关于作者" DestineClass:[AboutAuthor class]];
    
    SettingItem *item2_1 = [SettingItem setupWithIcon:nil Title:@"应用推荐" DestineClass:[AppCommend class]];

    
    SettingGroup *group_2 = [[SettingGroup alloc]init];
    
    group_2.headerTitle = @"欢迎,用户";
    
    group_2.items = @[item2_1,item2_0];
    
    [self.groupArray addObject:group_2];
    
}

-(void)addGroup3
{
    SettingItem *item3_0 = [SettingItem setupWithTitleName:@"版本检测"];
    
    item3_0.option = ^{
        
        NSLog(@"版本检测");
        /**
         *  add a MHUBView
         */
        
    };
    
    SettingGroup *group_3 = [[SettingGroup alloc]init];
    
    group_3.items = @[item3_0];
    
    [self.groupArray addObject:group_3];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return self.groupArray.count;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    
    SettingGroup *group = self.groupArray[section];
    
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingViewCell *cell = [SettingViewCell setupCellWithTableView:tableView];

    SettingGroup *group = self.groupArray[indexPath.section];
    
    cell.item = group.items[indexPath.row];
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    SettingViewCell *cell = (SettingViewCell *) [tableView cellForRowAtIndexPath:indexPath];
    
    if (cell.item.option)
    {
        cell.item.option();
        
    }
    
    SettingGroup *group = self.groupArray[indexPath.section];
    
    SettingItem *item = group.items[indexPath.row];
    
    if (item.controllerClass)
    {
        
        AboutAuthor *Vc = [[item.controllerClass alloc]init];
        
        Vc.title = item.title;
        
        [self.navigationController pushViewController:Vc animated:YES];
        
    }
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    SettingGroup *group =self.groupArray[section];
    
    return group.headerTitle;
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
