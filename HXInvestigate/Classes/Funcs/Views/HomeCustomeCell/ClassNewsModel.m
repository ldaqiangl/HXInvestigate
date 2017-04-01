//
//  ClassNewsModel.m
//  ParentsMenu
//
//  Created by admin on 15/8/6.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "ClassNewsModel.h"

#import "MxlLabel.h"
#import "ILRegularExpressionManager.h"
#import "NSString+NSString_ILExtension.h"
#import "WFTextView.h"

#import "HXHomeCellHeadView.h"

/** 边距、视图之间间隔参数装箱 */
struct HXEdgeLength {
    CGFloat leftMargin;
    CGFloat upMargitn;
    CGFloat spaceMargin;
    CGFloat totalW;
    
    CGPoint beginP;
};
typedef struct HXEdgeLength HXEdgeLength;

//------------------------------ 分割线 -----------------------------

@implementation HXHomeCellContentBox
- (instancetype)init {
    if (self = [super init]) {
        _highLightLinkDataArr = [NSMutableArray array];
//        self.thumbnailPics = [NSMutableArray array];
//        self.originalPics = [NSMutableArray array];
        _isOpen = NO;
        _isHiddenIcon = NO;
        _isFinishedPicCal = NO;
        _isHiddenDelBtn = YES;
        _isHiddenSureBtn = YES;
        _resend = NO;
        _retrySending = NO;
    }
    return self;
}


@end

//------------------------------ 分割线 -----------------------------

@interface ClassNewsModel ()
{
    BOOL isReplyView;
    int tempInt;
}

@end
@implementation ClassNewsModel

#pragma mark - <初始化操作> -

- (instancetype)init {
    self = [super init];
    if (self) {
        
        _completionReplySource = [[NSMutableArray alloc] init];
        _attributedData = [[NSMutableArray alloc] init];
        _attributedDataWF = [[NSMutableArray alloc] init];
        _images = [[NSMutableArray alloc] init];
        _thumbups = [[NSMutableArray alloc]init];
        _retry = NO;
        _retrySending = NO;
        _foldOrNot = YES;
        _islessLimit = NO;
        
        //DAQIANG-ADD
        _cellContentBox = [[HXHomeCellContentBox alloc] init];
        _headViewF = HXHeadRectZero();
        _textViewF = HXTextRectZero();
        _mediaViewF = HXMediaRectZero();
        _footViewF = HXFootRectZero();
        //DAQIANG
        
    }
    return self;
}

//DAQIANG-ADD

#pragma mark - <本数据模型的数据处理、根据数据计算等操作> -

/** 数据预处理 */
- (void)preProcessingSelf {
    
    //1、处理头部信息
    //是否隐藏 头像 的显示
//    _cellContentBox.isHiddenIcon = _lable.integerValue == ClassNewsTypeContentRecommend;
    
    //角色显示
    NSArray *roles = @[@"老师",@"",@"园长"];
    if (_creator_role.integerValue < 3) {
        _cellContentBox.roleTitle = roles[_creator_role.integerValue];
    } else {
        _cellContentBox.roleTitle = @"";
    }
    
    //时间 显示判断 和 转换
//    _cellContentBox.time = _approval_at?[NSDate getUTCFormateDate:_approval_at]:[NSDate getUTCFormateDate:_created_at];
    
    //类型标签 判断和显示：[有无显示“通知”，标签具体显示内容]
    [self getTagLabelWouldDisplayContent];
    if (_lable.integerValue<2||_lable.integerValue>3) {
        _cellContentBox.labelPre = @"";
    } else {
        _cellContentBox.labelPre = @"通知";
    }
    
    //重新发送判断
#warning #DAQIANG-WARN:暂时这样衔接,之后需要前者替换后者起作用#
    _cellContentBox.resend = _retry;
    _cellContentBox.retrySending = _retrySending;
    if ((!_cellContentBox.resend)&&(!_cellContentBox.retrySending)) {
        _cellContentBox.resendTipContent = @"";
    } else {
        if (_cellContentBox.retrySending) {
            _cellContentBox.resendTipContent = HXHomeCellResendingText;
        } else {
            if (_cellContentBox.resend) {
                _cellContentBox.resendTipContent = HXHomeCellResendBtnText;
            } else {
                _cellContentBox.resendTipContent = @"";
            }
        }
    }
    
    //2、处理文本信息
    //是否折叠
    isReplyView = NO;
    NSString *matchString = _content;
    NSArray *itemIndexs = [ILRegularExpressionManager itemIndexesWithPattern:EmotionItemPattern inString:matchString];
    NSString *newString = [matchString replaceCharactersAtIndexes:itemIndexs withString:PlaceHolder];
//    [self matchString:newString fromView:isReplyView];
    //存新的
    _cellContentBox.textContent = newString;
    
    //3、处理图片的辅助判断性数据
    if (_images.count > 1 || _images.count == 0) {
        _cellContentBox.isFinishedPicCal = YES;
    }
    
    //4、
    //处理点赞者的模型，串联成字符串
    __block NSMutableString *praiseMulStr = [NSMutableString string];
    if (_thumbups.count > 0) {
        [_thumbups enumerateObjectsUsingBlock:^(ThumbupsModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [praiseMulStr appendFormat:@"%@,",obj.user_display_name];
        }];
        _cellContentBox.praisePeoplesStr = [praiseMulStr substringToIndex:praiseMulStr.length-1];
    } else {
        _cellContentBox.praisePeoplesStr = @"";
    }
    
    //点击确认的功能按钮状态判断
    if ([_already_read isEqualToString:@"0"]) {
        
        _cellContentBox.isHiddenSureBtn = NO;
        _cellContentBox.isSelectedSureBtn = NO;
    } else if ([_already_read isEqualToString:@"1"]) {
        
        _cellContentBox.isHiddenSureBtn = NO;
        _cellContentBox.isSelectedSureBtn = YES;
    } else {
        
        _cellContentBox.isHiddenSureBtn = YES;
    }
    
    //删除的功能按钮判断
    _cellContentBox.isHiddenDelBtn = ![_is_owner isEqualToString:@"1"];
    
    //当前用户是否点过赞（）
    _cellContentBox.isClickedPraise = _already_thumbup.intValue==1;
    
}

/** 根据自身已有的数据信息 启动自身计算内部子视图布局 */
- (void)startCalculateSelf {
#define PX_TO_PT(px) px*kScreenWidth/750.0
#define HXNR(r) NSStringFromCGRect(r)
#define HXTextSize(text,fontSize) [text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:fontSize]}]
    
    [self preProcessingSelf];
    
    //开始伟大的纯粹数学计算工作（依次从上到下，完成一个方法后，紧接着开始另一个计算方法）
    __block HXEdgeLength edgeL;
    edgeL.leftMargin = LeftDistance;
    edgeL.upMargitn = edgeL.leftMargin;
    edgeL.spaceMargin = edgeL.leftMargin;
    edgeL.totalW = screenWidth;
    [self calHeadViewWithEdge:edgeL];
    
}

#pragma mark - <拆解的各个子视图分别计算方法实现> -

//一、根据数据 计算 headView 中的视图布局
- (void)calHeadViewWithEdge:(HXEdgeLength)edgeL {
    
    CGFloat leftMargin = edgeL.leftMargin,upMargin = edgeL.upMargitn;
    CGFloat spaceMargin = edgeL.spaceMargin;
    CGFloat totalW = edgeL.totalW;
    
    NSString *nameContent = [NSString stringWithFormat:@"%@",_creator_display_name];
    NSString *roleTtitle = [NSString stringWithFormat:@"%@",_cellContentBox.roleTitle];
    NSString *timeContent = [NSString stringWithFormat:@"%@",_cellContentBox.time];
    NSString *tagTitle = [NSString stringWithFormat:@"%@",_cellContentBox.labelPre];
    NSString *tagLabelConent = [NSString stringWithFormat:@"%@",_cellContentBox.labelContent];
    
    CGFloat constHeadHeight = HeadImageWidth;
    //1.头像
    CGFloat iconL = _cellContentBox.isHiddenIcon?0:constHeadHeight;
    CGFloat iconX = leftMargin, iconY = upMargin;
    CGRect iconF = CGRectMake(iconX, iconY, iconL, iconL);
    
    CGFloat nameH = constHeadHeight * 0.5, nameY = iconY;
    CGSize roleTitleSize = HXTextSize(roleTtitle,TimeSize);
    CGFloat roleTitleW = roleTitleSize.width, roleTitleH = roleTitleSize.height;
    
    //2.标签整体视图 所占大小 和位置
    CGFloat tagSpace = PX_TO_PT(10);
    CGSize tagTitleSize = [tagTitle sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TapLabelSize]}];
    CGSize tagLabelSize = [tagLabelConent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TapLabelSize]}];
    
    CGRect tagTitleF = (CGRect){0,0,tagTitleSize};
    CGRect tagLabelF = (CGRect){CGRectGetMaxX(tagTitleF)+tagSpace, 0, tagLabelSize};
    
    CGFloat tagW = tagTitleSize.width + tagSpace + tagLabelSize.width;
    CGFloat tagH = tagTitleSize.height;
    CGFloat tagX = totalW - tagW - leftMargin, tagY = nameY + (nameH - tagH)*0.5;
    CGRect tagViewF = CGRectMake(tagX, tagY, tagW, tagH);
    
    //3.名称
    CGFloat nameX = CGRectGetMaxX(iconF) + spaceMargin;
    //关于name 所占长度的两种可能（最大可占据长度 和 文字需要占据的长度）
    CGFloat nameMaxW = tagX - nameX - roleTitleW - spaceMargin*2;
    CGSize nameContentSize = [nameContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:NameSize]}];
    CGFloat nameContentW = nameContentSize.width;
    
    CGFloat nameW = nameContentW>nameMaxW?nameMaxW:nameContentW;
    CGRect nameF = CGRectMake(nameX, nameY, nameW, nameH);
    
    //4.角色名称
    CGFloat roleTitleX = CGRectGetMaxX(nameF) + spaceMargin;
    CGFloat roleTitleY = nameY + (nameH - roleTitleH) * 0.5;
    CGRect roleTitleF = CGRectMake(roleTitleX, roleTitleY, roleTitleW, roleTitleH);
    
    //5.时间
    CGSize timeSize = [timeContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:TimeSize]}];
    CGFloat timeW = timeSize.width, timeH = constHeadHeight * 0.5;
    CGFloat timeX = nameX, timeY = CGRectGetMaxY(nameF);
    CGRect timeF = CGRectMake(timeX, timeY, timeW, timeH);
    
    //6.重发按钮计算
    CGSize resendBtnSize = [_cellContentBox.resendTipContent sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]}];
    CGFloat resendBtnX = CGRectGetMaxX(timeF) + spaceMargin, resendBtnY = timeY + (timeH-resendBtnSize.height)*0.5;
    CGRect resendBtnF = (CGRect){resendBtnX,resendBtnY,resendBtnSize};
    
    CGFloat headX = 0, headY = 0;
    CGFloat headW = totalW, headH = MAX(CGRectGetMaxY(iconF), CGRectGetMaxY(timeF)) + upMargin;
    CGRect headViewF = CGRectMake(headX, headY, headW, headH);
    
    HXHomeCellHeadRect headRect;
    headRect.headViewF = headViewF;
    headRect.iconF = iconF;
    headRect.nameLabelF = nameF;
    headRect.roleTitleF = roleTitleF;
    headRect.timeLabelF = timeF;
    headRect.resendBtnF = resendBtnF;
    HXTagRect tagRect;
    tagRect.tagViewF = tagViewF;
    tagRect.tagTitleF = tagTitleF;
    tagRect.tagLabelF = tagLabelF;
    headRect.tagViewF = tagRect;
    
    headRect.headViewH = CGRectGetHeight(headViewF);
    _headViewF = HXStringFromHXHomeCellHeadRect(headRect);
    
    //
    edgeL.beginP.x = headRect.nameLabelF.origin.x;
    edgeL.beginP.y = CGRectGetMaxY(headRect.headViewF);
    [self calTextViewWithEdge:edgeL];
    
}

//二、根据数据 计算 textView 中的视图布局
- (void)calTextViewWithEdge:(HXEdgeLength)edgeL {
    
    CGFloat spaceMargin = edgeL.spaceMargin;
    CGFloat totalW = edgeL.totalW;
    
    CGFloat textViewX = edgeL.beginP.x, textViewY = edgeL.beginP.y;
    CGFloat textViewW = totalW - textViewX - spaceMargin;
    
    WFTextView *_wfcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(0,0, totalW, 0)];
    _wfcoreText.isDraw = NO;
    [_wfcoreText setOldString:_content andNewString:_cellContentBox.textContent];
    BOOL isNeedDisplayControlBtn = !([_wfcoreText getTextLines] <= limitline);
    _cellContentBox.isHiddenControlBtn = !isNeedDisplayControlBtn;
    _wfcoreText.isFold = isNeedDisplayControlBtn?(!_cellContentBox.isOpen):NO;//!_cellContentBox.isOpen;
    
    CGFloat textContentH = [_wfcoreText getTextHeight];
    CGRect textContentF = (CGRect){0,0,textViewW,textContentH};
    
    HXHomeCellTextRect textViewF;
    textViewF.textContentF = textContentF;
    
    CGRect controlBtnF = CGRectZero;
    if (!_cellContentBox.isHiddenControlBtn) {
        controlBtnF = CGRectMake(0, CGRectGetMaxY(textContentF), 30, 30);
        textViewF.textViewF = CGRectMake(textViewX, textViewY, textViewW, CGRectGetMaxY(controlBtnF));
    } else {
        textViewF.textViewF = CGRectMake(textViewX, textViewY, textViewW, CGRectGetMaxY(textContentF));
    }
    textViewF.controlBtnF = controlBtnF;
    
    textViewF.textViewH = CGRectGetHeight(textViewF.textViewF);
    _textViewF = HXStringFromHXHomeCellTextRect(textViewF);
    
    
    //
    edgeL.beginP.y = CGRectGetMaxY(textViewF.textViewF) + edgeL.spaceMargin;
    [self calMediaViewWithEdge:edgeL];
}

//三、根据数据 计算 mediaView 中的视图布局
- (void)calMediaViewWithEdge:(HXEdgeLength)edgeL {
    
    CGFloat spaceMargin = edgeL.spaceMargin*0.5;
    CGFloat totalW = edgeL.totalW - edgeL.beginP.x * 2;
    
    HXHomeCellMediaRect mediaR = HXHomeCellMediaRectFromString(_mediaViewF);
    __block CGFloat mediaViewH = mediaR.mediaViewF.size.height;
    
    NSArray *imageArr = self.images;
    __block CGSize perPicSize = CGSizeZero;
    
    if (imageArr.count == 0) { //0 张不操作，多媒体视图高度为0
        
        [self setupMediaViewFWith:perPicSize andH:mediaViewH andEdgeL:edgeL];
    } else if (imageArr.count > 1) {
        
        NSInteger picCount = imageArr.count;
        CGFloat perPicW = 0, perPicH = 0;
        int totalCol;
        //2 3 4 5 6 7 8  9
        
        if (picCount == 2 || picCount == 4) {
            
            perPicW = (totalW - spaceMargin)*0.5;
            totalCol = 2;
            
        } else {
            
            perPicW = (totalW - spaceMargin*2)/3;
            totalCol = 3;
        }
        
        perPicH = perPicW;
        perPicSize = CGSizeMake(perPicW, perPicH);
        
        int rows = (int)round(picCount/totalCol);
        mediaViewH = perPicH * rows + spaceMargin * (rows - 1);
        
        [self setupMediaViewFWith:perPicSize andH:mediaViewH andEdgeL:edgeL];
    } else {
        
        id imageData = [imageArr lastObject];
        __weak __typeof(self)weakSelf = self;
        
        if ([imageData isKindOfClass:[NSObject class]]) {
            
            NSArray *imageArray = @[];//LLGetPictureFromCachePathName([(SendCLassNewsImageModel *)imageData imagePath]);
            UIImage *myImage = [imageArray firstObject];
            
            perPicSize = [self calImageWithImage:myImage];
            
            mediaViewH = perPicSize.height;
            [self setupMediaViewFWith:perPicSize andH:mediaViewH andEdgeL:edgeL];
            
        } else {
            
            //保护机制，保证每个数据模型的网络图片，只进行一次下载计算操作
            if (!_cellContentBox.isFinishedPicCal) {
                
                //没有去下载图片之前，先给一个默认值
                perPicSize = CGSizeMake(180, 180);
                [self setupMediaViewFWith:perPicSize andH:perPicSize.height andEdgeL:edgeL];
                
                NSString *oneImgStr = @"";//[NSString stringWithFormat:@"%@/%@?p=0",[EnvironmentConfigModel sharedEnvironmentConfigModel].env_configs.zimg_download_endpoint, imageData];
                NSURL *oneImageUrl = [NSURL URLWithString:oneImgStr];
                
                //^^^异步进行,需要完成后回调给调用者,进行处理^^^
                
                [[SDWebImageDownloader sharedDownloader] downloadImageWithURL:oneImageUrl options:SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
                    
                } completed:
                 ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
                    
                    weakSelf.cellContentBox.isFinishedPicCal = YES;
                    
                    perPicSize = [weakSelf calImageWithImage:image];
                    
                    [weakSelf setupMediaViewFWith:perPicSize andH:perPicSize.height andEdgeL:edgeL];
                    
                    if ([weakSelf.mydelegate respondsToSelector:@selector(finishedImageHeight)]) {
                        [weakSelf.mydelegate finishedImageHeight];
                    }
                    
                }];
            } else { //点击cell中的按钮如：全文（收起）时 需要reloadTableView 重新计算位置
                
//                mediaR.mediaViewF = (CGRect){mediaR.mediaViewF.origin.x, edgeL.beginP.y, totalW, mediaViewH>0?mediaViewH:200};
//                _mediaViewF = HXStringFromHXHomeCellMediaRect(mediaR);
                [self setupMediaViewFWith:CGSizeMake(mediaR.perPicW, mediaR.perPicH) andH:mediaViewH andEdgeL:edgeL];
                
//                [self calFootViewWithEdge:edgeL];
                
            }
        }
    }

}

//四、根据数据 计算 footView 中的视图布局
- (void)calFootViewWithEdge:(HXEdgeLength)edgeL {
    
    CGFloat spaseMargin = edgeL.spaceMargin;
    
    CGFloat footViewX = edgeL.beginP.x, footViewY = edgeL.beginP.y;
    CGFloat footViewW = edgeL.totalW - footViewX - edgeL.leftMargin;
    CGFloat footViewH = 0;
    
    CGRect sureBtnF,delBtnF;
    
    CGFloat sureBtnX = 0, sureBtnY = 0;
    CGFloat sureBtnW = _cellContentBox.isSelectedSureBtn?65:80, sureBtnH = 22;
    if (_cellContentBox.isHiddenSureBtn) {
        sureBtnW = sureBtnH = 0;
    }
    sureBtnF = CGRectMake(sureBtnX, sureBtnY, sureBtnW, sureBtnH);
    
    CGFloat delBtnX = 0, delBtnY = 0;
    CGFloat delBtnW = 32, delBtnH = 20;
    if (_cellContentBox.isHiddenDelBtn) {
        delBtnW = delBtnH = 0;
    }
    delBtnF = CGRectMake(delBtnX, delBtnY, delBtnW, delBtnH);
    
    CGFloat praiseBW = 40, praiseBH = 30;
    CGFloat praiseBX = footViewW - praiseBW;
    CGFloat praiseBY = 0;
    CGRect praiseBF = CGRectMake(praiseBX, praiseBY, praiseBW, praiseBH);
    
    CGRect separateLineF = CGRectZero;
    
    CGRect praisePeopleLF = (CGRect){0,CGRectGetMaxY(separateLineF)+spaseMargin,0};;
    if (_cellContentBox.praisePeoplesStr.length) {
        separateLineF = CGRectMake(0, CGRectGetMaxY(praiseBF), footViewW, 5);
        CGSize praisePeopleSize = CGSizeMake(kScreenWidth, 0);//[_cellContentBox.praisePeoplesStr textSizeWithFont:[UIFont systemFontOfSize:TextSize] andMaxSize:CGSizeMake(footViewW, MAXFLOAT)];
        praisePeopleLF = (CGRect){0,CGRectGetMaxY(separateLineF)+edgeL.spaceMargin,praisePeopleSize};
    }
    
    
    
    footViewH = MAX(CGRectGetMaxY(praisePeopleLF), CGRectGetMaxY(praiseBF));
    HXHomeCellFootRect footR;
    footR.footViewF = CGRectMake(footViewX, footViewY, footViewW, footViewH);
    footR.footViewH = footViewH;
    footR.sureBtnF = sureBtnF;
    footR.delBtnF = delBtnF;
    footR.praiseBtnF = praiseBF;
    footR.lineViewF = separateLineF;
    footR.praiserLF = praisePeopleLF;
    _footViewF = HXStringFromHXHomeCellFootRect(footR);
    
    //
    edgeL.beginP.y = CGRectGetMaxY(footR.footViewF);
    _cellContentBox.cellH = edgeL.beginP.y + edgeL.upMargitn;
    
}

#pragma mark - <工具方法> -

/** 对mediaView多媒体视图的布局赋值 */
- (void)setupMediaViewFWith:(CGSize)perPicSize andH:(CGFloat)mediaViewH andEdgeL:(HXEdgeLength)edgeL {
    
    CGFloat mediaViewX = edgeL.beginP.x, mediaViewY = edgeL.beginP.y;
    CGFloat mediaViewW = edgeL.totalW - mediaViewX - edgeL.leftMargin;
    
    HXHomeCellMediaRect mediaViewF;
    mediaViewF.mediaViewH = mediaViewH;
    mediaViewF.mediaViewF = CGRectMake(mediaViewX, mediaViewY, mediaViewW, mediaViewH);
    mediaViewF.spaceL = edgeL.spaceMargin*0.5;
    mediaViewF.perPicW = perPicSize.width;
    mediaViewF.perPicH = perPicSize.height;
    
    _mediaViewF = HXStringFromHXHomeCellMediaRect(mediaViewF);
    
    edgeL.beginP.y = _images.count>0?(CGRectGetMaxY(mediaViewF.mediaViewF)+edgeL.spaceMargin):edgeL.beginP.y;
    [self calFootViewWithEdge:edgeL];
}

/** 一张图片的时候 计算图片缩略图应该显示的大小 */
- (CGSize)calImageWithImage:(UIImage *)image {
    
    CGFloat scale;
    CGSize perPicSize;
    if (image) {
        
        if (image.size.width<180&&image.size.height <180) {
            
            perPicSize = CGSizeMake(image.size.width, image.size.height);
            
        } else {
            
            if (image.size.width>image.size.height) {
                
                scale = bigImageFixLine/image.size.width;
                perPicSize = CGSizeMake(bigImageFixLine/2, image.size.height*scale/2);
                
            } else if (image.size.width<image.size.height) {
                
                scale = bigImageFixLine/image.size.height;
                perPicSize = CGSizeMake(image.size.width*scale/2, bigImageFixLine/2);
                
            } else {
                
                perPicSize = CGSizeMake(bigImageFixLine/2, bigImageFixLine/2);
                
            }
        }
        
    } else {
        
        perPicSize = CGSizeMake(180, 180);
        
    }
    
    return perPicSize;
}

/** 得到不同类别的cell要显示的标签内容 和内容颜色 */
- (void)getTagLabelWouldDisplayContent {
#define LABELTITLE @"title"
#define LABELTITLECOLOR @"titleColor"
    NSDictionary *labelToConentDic = @{@"1":@{LABELTITLE:@{@"0":@"精彩瞬间",
                                                           @"1":@"精彩瞬间",
                                                           @"2":@"园所风采"},
                                              LABELTITLECOLOR:@"f0a088"
                                              },
                                       @"2":@{LABELTITLE:@{@"0":@"班级通知",
                                                           @"1":@"班级通知",
                                                           @"2":@"园所通知"},
                                              LABELTITLECOLOR:@"89abd5"
                                              },
                                       @"3":@{LABELTITLE:@{@"0":@"课程计划",
                                                           @"1":@"课程计划",
                                                           @"2":@"课程计划"},
                                              LABELTITLECOLOR:@"a2c77e"
                                              },
                                       @"4":@{LABELTITLE:@{@"0":@"每周食谱",
                                                           @"1":@"每周食谱",
                                                           @"2":@"每周食谱"},
                                              LABELTITLECOLOR:@"ebb659"
                                              },
                                       @"5":@{LABELTITLE:@{@"0":@"行为记录",
                                                           @"1":@"行为记录",
                                                           @"2":@"行为记录"},
                                              LABELTITLECOLOR:@"ebb659"
                                              },
                                       @"6":@{LABELTITLE:@{@"0":@"考勤记录",
                                                           @"1":@"考勤记录",
                                                           @"2":@"考勤记录"},
                                              LABELTITLECOLOR:@"ebb659"
                                              },
                                       @"7":@{LABELTITLE:@{@"0":@"内容资源推荐",
                                                           @"1":@"内容资源推荐",
                                                           @"2":@"内容资源推荐"},
                                              LABELTITLECOLOR:@"ebb659"
                                              },
                                       };
    
    _cellContentBox.labelContent = [[[labelToConentDic objectForKey:[NSString stringWithFormat:@"%@",self.lable]] objectForKey:LABELTITLE] objectForKey:[NSString stringWithFormat:@"%@",self.creator_role]];
    _cellContentBox.labelColor = [[labelToConentDic objectForKey:[NSString stringWithFormat:@"%@",self.lable]] objectForKey:LABELTITLECOLOR];
    
}

//DAQIANG


+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"thumbups" : [ThumbupsModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"lable" : @"label_type"
             };
}
@end
