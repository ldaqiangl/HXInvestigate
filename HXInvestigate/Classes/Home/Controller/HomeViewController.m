//
//  HomeViewController.m
//  框架演示demo
//
//  Created by 董富强 on 16/7/16.
//  Copyright © 2016年 董富强. All rights reserved.
//

#import "HomeViewController.h"

#import "ReactiveCocoa.h"
#import "HomeTwoViewController.h"
#import "HomeModelViewController.h"
#import "Person.h"
#import "BSBlurView.h"
#import "CustomeView.h"

#define EmotionItemPattern @"\\[em:(\\d+):\\]"
#define PlaceHolder @" "

#import "AutoLayoutViewController.h"
#import "BabyRhythm.h"

@interface HomeViewController () <UIAlertViewDelegate,
                                  NSStreamDelegate>

{
    HomeModelViewController *modelVc;
    CustomeView *cView;
}

@property (weak, nonatomic) IBOutlet UIButton *login;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordFeild;

@property (nonatomic, strong) RACCommand *command;

@property (nonatomic, assign) NSInteger gCount;
@end
static int _count = 0;


@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"autoLayout" style:UIBarButtonItemStylePlain target:self action:@selector(pushToAutoLayout)];
        
    //[self raccommandUse];
}

- (void)pushToAutoLayout {
    
    AutoLayoutViewController *autoLayoutVc = [[AutoLayoutViewController alloc] init];
    [self.navigationController pushViewController:autoLayoutVc animated:YES];
}

- (IBAction)loginClick:(id)sender {
    HomeTwoViewController *twoVc =
    [[HomeTwoViewController alloc] initWithNibName:@"HomeTwoViewController"
                                            bundle:nil];
    twoVc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:twoVc animated:YES];
}

- (IBAction)registerClick:(id)sender {
    
    modelVc = [[HomeModelViewController alloc] initWithNibName:@"HomeModelViewController" bundle:nil];

    //RACSubject 替换代理
    //    [self racsubjectChangeDelegate];

    [self presentViewController:modelVc animated:YES completion:^{

    }];
}

- (Person *)getPersonInfoWith:(NSString *)name andAge:(NSString *)age andSex:(NSString *)sex {
    Person *p = [[Person alloc] init];
    p.name = name;
    p.age = age;
    
    return p;
}


#pragma mark - RACSbuject 使用：
- (void)racSubject {
    //1.创建信号
    RACSubject *subject = [RACSubject subject];

    //2.订阅信号
    [subject subscribeNext:^(id x) {
        //blck 调用时刻：当信号发出新的值，就回调用
        NSLog(@"first subscriber：%@", x);
    }];

    [subject subscribeNext:^(id x) {
        //
        NSLog(@"second subscriber:%@", x);
    }];

    //3.发送信号
    [subject sendNext:@"123"];
}

#pragma mark - RACReplaySubject 使用：
- (void)racReplaySubject {
    //1.创建信号
    RACReplaySubject *replaysubject = [RACReplaySubject subject];

    //2.发送信号
    [replaysubject sendNext:@"11111"];
    [replaysubject sendNext:@"222222"];

    //3.订阅信号
    [replaysubject subscribeNext:^(id x) {
        NSLog(@"first subscriber：%@", x);
    }];

    [replaysubject subscribeNext:^(id x) {
        NSLog(@"second subscriber:%@", x);
    }];
}

#pragma mark - RACSubject 替换代理
- (void)racsubjectChangeDelegate {
    //设置代理信号
    modelVc.delegateSigal = [RACSubject subject];
    //订阅信号
    [modelVc.delegateSigal subscribeNext:^(id x) {
        NSLog(@"返回按钮被点击了");
    }];
}

#pragma mark - RACSequence和RACTuple简单使用
- (void)racsequenceAndTuple {
    //[RACSignal combineLatest:<#(id<NSFastEnumeration>)#> reduce:<#^id(void)reduceBlock#>];

    //1.字典转模型
    NSArray *numbers = @[ @1, @2, @3, @4 ];

    //这里其实是三步
    /**
     第一步：把数组转换成集合RACSequence numbers.rac_sequence
     第二步：把集合RACSequence转换成RACSignal信号类，numbers.rac_sequence.sigal
     第三步：订阅信号，激活信号，会自动把集合中的所有制，遍历出来
     */
    [numbers.rac_sequence.signal subscribeNext:^(id x) {
        NSLog(@"%@ -- > %@", [NSThread currentThread], x);
    }];


    //2. 遍历字典，遍历出来的键值对会敖壮成RACTuple（元组对象）
    NSDictionary *dict = @{ @"name" : @"dfq",
                            @"age" : @"28" };
    [dict.rac_sequence.signal subscribeNext:^(RACTuple *x) {
        //解包元组，会把元素的值，按顺序给参数里面的变量赋值
        RACTupleUnpack(NSString * key, NSString * value) = x;
        //
        //        NSString *key = x[0];
        //        NSString *value = x[1];
        

        NSLog(@"%@ ==  %@ %@", [NSThread currentThread], key, value);

    } completed:^{

    }];

    //3.字典转模型
    //3.1 OC写法
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"persons.plist" ofType:nil];
    NSArray *personDictsArr = [NSArray arrayWithContentsOfFile:filePath];

    NSMutableArray *persons = [NSMutableArray array];
    [personDictsArr.rac_sequence.signal subscribeNext:^(id x) {

        Person *person = [Person personWithDict:x];
        [persons addObject:person];

        NSLog(@"--- %@", [NSThread currentThread]);

    } completed:^{

        NSLog(@"result:%@", persons);
        [persons.rac_sequence.signal subscribeNext:^(Person *x){

        }];

    }];
}


#pragma mark - RACCommand 使用
- (void)raccommandUse {
    //1.创建命令
    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"--执行命令");
        //创建空信号，必须返回信号
        //        return [RACSignal empty];

        //创建信号，用来传递数据
        RACSignal *s = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];

            return nil;
        }];

        NSLog(@"--- 创建命令返回一个信号：%@", s);
        return s;
    }];

    //强引用命令，不要被销毁，否则接受不到数据
    _command = command;

    //3.订阅RACCommand中的信号
    [_command.executionSignals subscribeNext:^(id x) {

        NSLog(@"--- 订阅者收到发送过来的信号:%@", x);
        [x subscribeNext:^(id x) {

            NSLog(@"%@", x);
        }];
    }];

    //switchToLatest:
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {

        NSLog(@"获取传递中的信号:%@", x);
    }];


    [_command execute:@"111111111"];
}

#pragma mark - RACMulticastConnection 解决多次订阅会出发多次创建信号的block执行
- (void)multicastConnection {
    /**
     RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
     
     NSLog(@"-- > 发送请求");
     
     [subscriber sendNext:[NSString stringWithFormat:@"发送请求：%d",_count]];
     _count ++;
     
     return nil;
     }];
     
     
     [signal subscribeNext:^(id x) {
     
     NSLog(@"接受数据:%@",x);
     }];
     
     [signal subscribeNext:^(id x) {
     
     NSLog(@"接受数据:%@",x);
     }];

     */


    //解决每次订阅都会出发请求的问题
    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        NSLog(@"-- > 发送请求");
        _count++;

        [subscriber sendNext:[NSString stringWithFormat:@"发送请求：%d", _count]];

        return nil;
    }];

    //1.创建连接
    RACMulticastConnection *connect = [signal publish];


    //2.订阅信号
    for (int i = 0; i < 3; i++) {
        [connect.signal subscribeNext:^(id x) {
            NSLog(@"订阅者%d信号:%@", i, x);
        }];
    }

    [connect.signal subscribeNext:^(id x) {

        NSLog(@"接受数据:%@", x);
    }];


    //3.连接 ， 激活信号 发送
    [connect connect];
}

#pragma mark - 事件 （代替代理、监听、通知、文本框文字改变、KVO）
- (void)insteadEvent {
    //1.代替代理
    [[cView rac_signalForSelector:@selector(customeBtnClick:)] subscribeNext:^(id x) {
        //        NSLog(@"~~~~~ 点击了自定义视图中的按钮:%@",x);
        cView.center = CGPointMake(cView.center.x - 1, cView.center.y + 1);
    }];

    //2.KVO
    [[cView rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {

        NSLog(@"-- > 自定义view的center属性发生了改变:%@", x);
    }];

    //3.监听事件 把按钮点击事件转换为信号，点击按钮，就回发送信号
    [[cView.customBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {

        NSLog(@"~~~~~ 点击了自定义视图中的按钮:%@", x);

    }];

    //4.代替通知 把监听到的通知转换成信号
    [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIKeyboardWillShowNotification object:nil] subscribeNext:^(id x) {
        NSLog(@"键盘弹出%@", x);
    }];

    //5.监听文本框文字改变
    [[self.userNameField.rac_textSignal map:^id(id value) {
        NSLog(@"-- %@", value);
        return [NSString stringWithFormat:@">%@", value];
    }] subscribeNext:^(id x) {
        NSLog(@"当前文字为:%@", x);
    }];

    //6.处理多个请求，都返回结果的时候，统一做处理
    RACSignal *requestS1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        //发送请求1
        [subscriber sendNext:@"发送第一个请求"];

        return nil;
    }];

    RACSignal *requestS2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {

        [subscriber sendNext:@"发送第二个请求"];
        return nil;
    }];

    //几个信号，参数一的方法就几个参数，每个参数对应信号发出的数据
    [self rac_liftSelector:@selector(updateUIChange:andOther:) withSignals:requestS1, requestS2, nil];
    //    [self rac_liftSelector:@selector(updateUIChange:andOther:) withSignalsFromArray:@[requestS1,requestS2]];
}

- (void)updateUIChange:(id)data1 andOther:(id)data2 {
    NSLog(@"更新改变UI：%@,%@", data1, data2);
}

/**
 Remember to call |StringWithoutSpaces("foo bar baz")|
 */
- (void)doSomethingWithIndex:(NSInteger)count {
    
}

@end
