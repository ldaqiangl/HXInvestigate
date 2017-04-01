//
//  HomeModelViewController.m
//  框架演示demo
//
//  Created by 董富强 on 16/7/16.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "HomeModelViewController.h"
#import "BSCycleScrollView.h"

#define Log(...) NSLog(__VA_ARGS__)
#define CZLog(s,...)  \
NSLog(@"<%p %@:(%d)> %@", \
self, \
[[NSString stringWithUTF8String:__FILE__] lastPathComponent], \
__LINE__, \
[NSString stringWithFormat:(s), ##__VA_ARGS__])
#define LogDetail(message, obj) NSLog(@"类名称:%@ 方法名称:%s 行数:%d %@%@", [self class], __FUNCTION__, __LINE__, message, obj)


#define BSLog(format, ...) do {fprintf(stderr,"<%s : %d> %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__,__func__);(NSLog)((format),##__VA_ARGS__);fprintf(stderr,"--------\n");} while(0)


#define BSLogRect(rect) BSLog(@"%s x:%.4f, y:%.4f, w:%.4f, h:%.4f", #rect, rect.origin.x, rect.origin.y, rect.size.width, rect.size.height)
#define BSLogSize(size) BSLog(@"%s w:%.4f, h:%.4f", #size, size.width, size.height)
#define BSLogPoint(point) BSLog(@"%s x:%.4f, y:%.4f", #point, point.x, point.y)




#import "XZLTextView.h"

@interface HomeModelViewController ()
//<BSCycleScrollViewDelegate>

@end

@implementation HomeModelViewController

- (IBAction)backClick:(id)sender {
    
//    if (self.delegateSigal) {
//        [self.delegateSigal sendNext:nil];
//    }
    
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    /*
     
     UIView *v = [[UIView alloc] initWithFrame:CGRectMake(20, 100, 300, 400)];
     v.backgroundColor = [UIColor redColor];
     [self.view addSubview:v];
     
     BSLogRect(v.frame);
     BSLogSize(v.frame.size);
     BSLogPoint(v.frame.origin);
     */
    
//    NSArray *imagesURLStrings = @[
//                                  @"http://pic21.nipic.com/20120530/10116020_112329148129_2.jpg",
//                                  @"http://pic1.nipic.com/2008-10-20/20081020191125403_2.jpg",
//                                  @"http://www.dabaoku.com/sucai/renwu/yingerxiaohai/139fi.jpg"
//                                  ];
//    
//    
//    BSCycleScrollView *cycleScrollView = [BSCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 100, kScreenWidth, 260) delegate:self placeholderImage:nil];
//    [self.view addSubview:cycleScrollView];
//    
//    cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    
}



- (NSString *)getUrl {
    return @"http://www.ldaqiangl.com";
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
