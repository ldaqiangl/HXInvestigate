//
//  HomeTwoViewController.m
//  框架演示demo
//
//  Created by 董富强 on 16/7/16.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "HomeTwoViewController.h"
#import "CustomeView.h"

#import "CTDisplayView.h"
#import "HXSelectedClassesView.h"
#import "HXClassInfoItem.h"
#import "UIImageView+WebCache.h"

@interface MyCustomCell : UITableViewCell

@end
@implementation MyCustomCell

- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = CGRectMake(5,5,40,32.5);
    float limgW =  self.imageView.image.size.width;
    if(limgW > 0) {
        self.textLabel.frame = CGRectMake(55,self.textLabel.frame.origin.y,self.textLabel.frame.size.width,self.textLabel.frame.size.height);
        self.detailTextLabel.frame = CGRectMake(55,self.detailTextLabel.frame.origin.y,self.detailTextLabel.frame.size.width,self.detailTextLabel.frame.size.height);
    }
}

@end


@interface HomeTwoViewController ()
<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, weak) CustomeView *cView;
@property (nonatomic, weak) UITableView *tableView;
@end

@implementation HomeTwoViewController
- (IBAction)backBtnClick:(id)sender {
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor cyanColor];
    self.navigationItem.title = @"ReactCocoa";
    
    /*
     
     UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
     tableView.delegate = self;
     tableView.dataSource = self;
     self.tableView = tableView;
     [self.view addSubview:self.tableView];
     */
}


- (void)createView01 {
    
    CTDisplayView *ctView = [[CTDisplayView alloc] initWithFrame:CGRectMake(10, 64, 350, 600)];
    [self.view addSubview:ctView];
    
    CTFrameParserConfig *config = [[CTFrameParserConfig alloc] init];
    config.textColor = [UIColor blackColor];
    config.width = ctView.bounds.size.width;
    ctView.config = config;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    CoreTextData *data = [CTFrameParser parseTemplateFile:path config:config];
    /*
     CoreTextData *data = [CTFrameParser parseContent:@"我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，✋🏃我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，\n\n\n✋🏃我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，✋🏃我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，✋🏃我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，✋🏃我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，✋🏃我们都是好孩子啊，这就是我的领域，我的风！😁哈哈哈哈哈！你能说什么歌，✋🏃" config:config];
     */
    ctView.data = data;
    ctView.frameHeight_Ext = data.height;
    ctView.backgroundColor = [UIColor yellowColor];
    
    
    //    [self addCustomeView];
    //
    //    [self subscribeCustomeViewEventSignal];

}

- (void)crateView002 {
    
    HXSelectedClassesView *selectedClassesView =
    [[HXSelectedClassesView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64-49)];
    [self.view addSubview:selectedClassesView];
    
    NSArray *arr = @[@"我们都是一班的呢",@"二班",
                     @"三班",@"四班",
                     @"五班",@"六班",@"七班",@"八班",@"旧版",@"十班",@"十一班",
                     @"我们都是一班的呢",@"二班",
                     @"三班",@"四班",
                     @"五班",@"六班",@"七班",@"八班",@"旧版",@"十班",@"十一班",
                     @"我们都是一班的呢",@"二班",
                     @"三班",@"四班",
                     @"五班",@"六班",@"七班",@"八班",@"旧版",@"十班",@"十一班",
                     @"我们都是一班的呢",@"二班",
                     @"三班",@"四班",
                     @"五班",@"六班",@"七班",@"八班",@"旧版",@"十班",@"十一班",
                     @"我们都是一班的呢",@"二班",
                     @"三班",@"四班",
                     @"五班",@"六班",@"七班",@"八班",@"旧版",@"十班",@"十一班"];
    NSMutableArray *dataSource = [NSMutableArray array];
    for (int i = 0; i < arr.count; i++) {
        HXClassInfoItem *item = [[HXClassInfoItem alloc] init];
        item.className = [arr objectAtIndex:i];
        item.isSelected = i%2==0;
        [dataSource addObject:item];
    }
    selectedClassesView.classesItemArr = dataSource;

}

- (void)subscribeCustomeViewEventSignal {
    
    //1.组件CustomeView 信号订阅
    [[self.cView customeViewEventSigalWith:eCustomeViewBlueBtnClickedEventType] subscribeNext:^(id x) {
        NSLog(@"点击了CustomeView中eCustomeViewBlueBtnClickedEventType类型事件 -- >> %@",x);
        
    }];
    
    //2.组件CustomeView1 信号订阅
    
    
    //3.组件CustomeView2 信号订阅
    
    
    //4.......等等
    

}

- (void)loadNetData {
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    MyCustomCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[MyCustomCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:@"http://h.hiphotos.baidu.com/zhidao/pic/item/6d81800a19d8bc3ed69473cb848ba61ea8d34516.jpg"]
                   placeholderImage:[UIImage imageNamed:@"placeholder_max"]];
    cell.textLabel.text = [NSString stringWithFormat:@"这是第%ld",(long)indexPath.row];
    return cell;
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
