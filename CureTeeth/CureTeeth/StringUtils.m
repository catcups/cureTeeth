//
//  StringUtils.m
//  SCSDEnterprise
//
//  Created by  YangShengchao on 14-2-14.
//  Copyright (c) 2014年  YangShengchao. All rights reserved.
//

#import "StringUtils.h"
#import <CommonCrypto/CommonDigest.h>
#define SpecialCharPattern  @"[!@#$%^&*?()\\s,.，　．！＠＃＄％＾＆＊（）｛｝=＿\\-—/+＋<>？]"
#define UserNamePattern @"^(?!_)(?!.*?_$)[a-zA-Z0-9_u4e00-u9fa5]+$"
#define EmailPattern    @"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$"
#define PhonePattern    @"(^(01|1)[3,4,5,8][0-9])\\d{8}$" //@"^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$"

#define ImageThumbSizeNormal    200
#define ImageThumbSizeBig       400

static NSDictionary *viewControllerNames;

static NSString *_homePath;
static NSString *_resBaseUrl;

@implementation NSString (SCSD)

- (NSArray *)nonemptyComponentsSeparatedByString:(NSString *)separator {
    NSMutableArray *components = [NSMutableArray array];
    for (NSString *component in [self componentsSeparatedByString:separator]) {
        if ( ! [StringUtils isEmpty:component]) {
            [components addObject:component];
        }
    }
    return components;
}

- (BOOL)isContainString:(NSString *)subString {
     return [self rangeOfString:subString].location != NSNotFound;
}


-(CGFloat)textHeightWithFont:(UIFont *)font width:(int)width lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize constraint = CGSizeMake(width, MAXFLOAT);
    CGSize size = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:attributes context:nil].size;
    CGFloat height = ceilf(size.height);
    return height;
}


-(CGFloat)textWidthWithFont:(UIFont *)font height:(int)height lineBreakMode:(NSLineBreakMode)lineBreakMode{

    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize constraint = CGSizeMake(MAXFLOAT, height);
    CGSize size = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:attributes context:nil].size;
    CGFloat textWidth = ceilf(size.width);
    return textWidth;
}

-(CGSize)textSizeWithFont:(UIFont *)font constraint:(CGSize)constraint lineBreakMode:(NSLineBreakMode)lineBreakMode{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = lineBreakMode;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    CGSize size = [self boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading  attributes:attributes context:nil].size;
    return size;
}
@end

@implementation StringUtils

//+ (void)initialize {
//    viewControllerNames = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"viewControllerName" ofType:@"plist"]];
//    _homePath = NSHomeDirectory();
//    BOOL isDebugService = [[NSUserDefaults standardUserDefaults] boolForKey:@"AFIsDebugService"];
//    _resBaseUrl = isDebugService?kResPathBaseUrl:kResPathBaseUrl2;
//}

+ (NSString *)homePath {
    return _homePath;
}

+ (NSString *)resBaseUrl {
    return _resBaseUrl;
}

//+ (NSString *)changeResBaseUrl{
//    
//    BOOL isDebugService = ![[NSUserDefaults standardUserDefaults] boolForKey:@"AFIsDebugService"];
//   
//    [[NSUserDefaults standardUserDefaults] setBool:isDebugService forKey:@"AFIsDebugService"];
//    [[NSUserDefaults standardUserDefaults] synchronize];
//   
//    NSString *newResBaseUrl = isDebugService?kResPathBaseUrl:kResPathBaseUrl2;
//    _resBaseUrl = newResBaseUrl;
//    
//    return _resBaseUrl;
//}

+ (NSString *)trimString:(NSString *)source {
    if (source == nil) {
        return @"";
    }
    return [source stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}



+ (NSString *)nonnilString:(NSString *)originString {
    if ( ! originString) {
        return @"";
    }
    return originString;
}

+ (NSString *)nonemptyString:(NSString *)firstString andString:(NSString *)secondString {
    if ([firstString length] && [[firstString stringByReplacingOccurrencesOfString:@" " withString:@""] length]) {
        return firstString;
    }
    if ([secondString length] && [[secondString stringByReplacingOccurrencesOfString:@" " withString:@""] length]) {
        return secondString;
    }
    return @"";
}

//字符串判空
+ (BOOL)isEmpty:(NSString *)string {
    return !([string length] && [[string stringByReplacingOccurrencesOfString:@" " withString:@""] length]);
}

#pragma mark - 正则表达式

//邮箱
+ (BOOL)isEmail:(NSString *)email {
    NSString *emailRegex = @"^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}$";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}


//手机号码验证
+ (BOOL)isMobilePhone:(NSString *)mobile {
    NSString *phoneRegex = @"(^(01|1)[3,4,5,7,8][0-9])\\d{8}$" ;
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:mobile];
}

//用户名
+ (BOOL)isUserName:(NSString *)name {
    NSString *userNameRegex = @"^[A-Za-z0-9]{6,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    BOOL B = [userNamePredicate evaluateWithObject:name];
    return B;
}

//密码
+ (BOOL)isPassword:(NSString *)passWord {
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:passWord];
}

//昵称
+ (BOOL)isNickname:(NSString *)nickname {
    NSString *nicknameRegex = @"^[\u4E00-\u9FA5A-Za-z0-9_]+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:nickname];
}

//身份证号
+ (BOOL)isIdentityCard:(NSString *)identityCard {
    if (identityCard.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:identityCard];
}

//是否全为数字
+ (BOOL)isAllNumbers:(NSString *)string {
    NSString *numberRegex = @"^[0-9]\\d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [predicate evaluateWithObject:string];
    return YES;
}

//是否为金额
+ (BOOL)isPrice:(NSString *)string {
    //
    NSString *numberRegex = @"^(0|[1-9][0-9]{0,9})(\\.{0,1}([0-9]{0,2}))?$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",numberRegex];
    return [predicate evaluateWithObject:string];
}


+ (NSString*) sha1FromString:(NSString *)string{
    const char *cstr = [string UTF8String];
    NSData *data = [NSData dataWithBytes:cstr length:string.length];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, (CC_LONG)strlen(cstr), digest);
    
    NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
        [output appendFormat:@"%02x", digest[i]];
    
    return output;
}  


+ (NSString *)md5FromString:(NSString *)string {
    if ([StringUtils isEmpty:string]) {
        return @"";
    }
    const char *str = [string UTF8String];
    unsigned char r[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)strlen(str), r);
    NSString *md5String = [NSString stringWithFormat:@"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
                          r[0], r[1], r[2], r[3], r[4], r[5], r[6], r[7], r[8], r[9], r[10], r[11], r[12], r[13], r[14], r[15]];
    
    return md5String;
}

+ (NSString *)deviceTokenFromString:(NSString *)string {
    NSString *deviceToken = [string stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"< >"]];
    deviceToken = [deviceToken stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [self nonnilString:[deviceToken stringByReplacingOccurrencesOfString:@" " withString:@""]];
}

+ (BOOL)searchResult:(NSString *)string searchText:(NSString *)searchT {
	NSComparisonResult result = [string compare:searchT
                                        options:NSCaseInsensitiveSearch
                                          range:NSMakeRange(0, searchT.length)];
	if (result == NSOrderedSame) {
		return YES;
    }
	else {
		return NO;
    }
}

+ (NSURL *)fullUrlWithPicturePath:(NSString *)picturePath {
    if ([StringUtils isEmpty:picturePath]) {
        return nil;
    }
    return [NSURL URLWithString:[self fullPathWithPicturePath:picturePath]];
}

+ (NSURL *)thumbnailUrlWithPicturePath:(NSString *)picturePath wantedWidth:(NSInteger)pictureWidth {
    if ([StringUtils isEmpty:picturePath]) {
        return nil;
    }
    return [NSURL URLWithString:[self thumbnailPathFromOriginPath:picturePath wantedWidth:pictureWidth]];
}

+ (NSString *)fullPathWithPicturePath:(NSString *)picturePath {
    NSString *newPicturePath = [self trimString:picturePath];//去掉字符串的空格
    if ([self isEmpty:newPicturePath]) {
        return @"";
    }
    NSString *suffixPath = [newPicturePath stringByReplacingOccurrencesOfString:[StringUtils resBaseUrl] withString:@""];
    NSString *fullPath = [[[StringUtils resBaseUrl] stringByAppendingString:suffixPath] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"full picture path = %@", fullPath);
    return fullPath;
}

+ (NSString *)thumbnailPathFromOriginPath:(NSString *)picturePath {
    return [self thumbnailPathFromOriginPath:picturePath wantedWidth:ImageThumbSizeNormal];
}

+ (NSString *)thumbnailBigPathFromOriginPath:(NSString *)picturePath {
    return [self thumbnailPathFromOriginPath:picturePath wantedWidth:ImageThumbSizeBig];
}

+ (NSString *)thumbnailPathFromOriginPath:(NSString *)picturePath wantedWidth:(NSInteger)pictureWidth {
    if ( ! [picturePath hasSuffix:@"."]) {
//        if ( ! [picturePath hasSuffix:@".png"]) {
            NSMutableString *thumbPath = [NSMutableString stringWithFormat:@"%@", picturePath];
            NSRange rangeOfDot = [thumbPath rangeOfString:@"." options:NSBackwardsSearch];
            [thumbPath insertString:[NSString stringWithFormat:@"_%dx%d", pictureWidth, pictureWidth]
                            atIndex:rangeOfDot.location == NSNotFound ? [thumbPath length] : rangeOfDot.location];

            return [self fullPathWithPicturePath:thumbPath];
//        }
    }
    return [self fullPathWithPicturePath:picturePath];
}

+ (NSString *)fullPathWithAudioPath:(NSString *)audioPath {
    if ([audioPath rangeOfString:[self homePath]].length) {     //本地路径
        return audioPath;
    }
    NSString *suffixPath = [audioPath stringByReplacingOccurrencesOfString:[StringUtils resBaseUrl] withString:@""];
    if ( ! suffixPath) {
        return @"";
    }
    return [[StringUtils resBaseUrl] stringByAppendingString:suffixPath];
}

+ (NSString *)distanceWithMeters:(NSInteger)meter {
    return [NSString stringWithFormat:@"%d%@", (meter > 1000 ? meter / 1000  : meter), (meter > 1000 ? @"千米" : @"米")];
}

+ (NSString *)friendlyNameForViewController:(NSString *)viewControllerClassName {
    NSString *viewControllerName = viewControllerNames[viewControllerClassName];
    if ( ! viewControllerName) {
        viewControllerName = [viewControllerClassName copy];
    }
    
    return viewControllerName;
}


#pragma mark UTF8编码解码

+ (NSString *)UTF8EncodedString:(NSString *)source {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                           (CFStringRef)source,
                                                                           NULL,
                                                                           CFSTR("!*'();:@&=+$,/?%#[]"),
                                                                           kCFStringEncodingUTF8));
}
+ (NSString *)UTF8DecodedString:(NSString *)source {
    return (NSString *)CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                                 (CFStringRef)source,
                                                                                                 CFSTR(""),
                                                                                                 kCFStringEncodingUTF8));
}

#pragma mark 格式化字符串

/**
 *  常用的价格字符串格式化方法（默认：显示¥、显示小数点）
 *
 *  @param price 价格参数
 *
 *  @return
 */
+ (NSString *)formatPrice:(NSNumber *)price {
    return [self formatPrice:price showMoneyTag:YES showDecimalPoint:YES useUnit:NO];
}

/**
 *  常用的价格字符串格式化方法（默认：显示¥、显示小数点、显示元）
 *
 *  @param price
 *
 *  @return
 */
+ (NSString *)formatPriceWithUnit:(NSNumber *)price {
    return [self formatPrice:price showMoneyTag:YES showDecimalPoint:YES useUnit:YES];
}

/**
 *  格式化价格字符串输出
 *
 *  @param price     价格
 *  @param useTag    是否显示¥
 *  @param isDecimal 是否显示小数点
 *
 *  @return 组装好的字符串
 */
+ (NSString *)formatPrice:(NSNumber *)price showMoneyTag:(BOOL)isTagUsed showDecimalPoint:(BOOL) isDecimal useUnit:(BOOL)isUnitUsed {
    NSString *formatedPrice = @"";
    //是否保留2位小数
    if (isDecimal) {
        formatedPrice = [NSString stringWithFormat:@"%0.2f", [price doubleValue]];
    }
    else {
        formatedPrice = [NSString stringWithFormat:@"%d", [price integerValue]];
    }
    
    //是否添加前缀 ¥
    if (isTagUsed) {
        formatedPrice = [NSString stringWithFormat:@"¥%@", formatedPrice];
    }
    
    //是否添加后缀 元
    if(isUnitUsed) {
        formatedPrice = [NSString stringWithFormat:@"%@元", formatedPrice];
    }
    
    return formatedPrice;
}

#pragma mark 打电话

+ (void)makeCall:(NSString *)phoneNumber {
    if ([self isEmpty:phoneNumber]) {
        return;
    }
    phoneNumber = [phoneNumber stringByReplacingOccurrencesOfString:@"-" withString:@""];//去掉-
    NSURL *phoneURL = [NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@",[self trimString:phoneNumber]]];
    [[UIApplication sharedApplication] openURL:phoneURL];
//    UIAlertView *alertView = [UIAlertView bk_alertViewWithTitle:@"提示"
//                                                        message:[NSString stringWithFormat:@"确定要拨打电话：%@？", phoneNumber]];
//    [alertView bk_addButtonWithTitle:@"确定" handler:^{
//        [[UIApplication sharedApplication] openURL:phoneURL];
//    }];
//    [alertView bk_setCancelButtonWithTitle:@"取消" handler:nil];
//    [alertView show];
}

+ (NSString *)timeChange:(NSString *)str
{
    NSTimeInterval t = [str doubleValue];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:t];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *timeStrOne = [formatter stringFromDate:confromTimesp];
    return timeStrOne;
}

/**
 *  通过时间戳比较时间先后顺序
 *
 *  @return 通过时间戳比较时间先后顺序
 */

 + (int)compareDate:(NSString*)startDate withDate:(NSString*)endDate{
    
    int comparisonResult;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date1 = [[NSDate alloc] init];
    NSDate *date2 = [[NSDate alloc] init];
    date1 = [formatter dateFromString:startDate];
    date2 = [formatter dateFromString:endDate];
    NSComparisonResult result = [date1 compare:date2];
    NSLog(@"result==%ld",(long)result);
    switch (result)
    {
            //date02比date01大
        case NSOrderedAscending:
            comparisonResult = 1;
            break;
            //date02比date01小
        case NSOrderedDescending:
            comparisonResult = -1;
            break;
            //date02=date01
        case NSOrderedSame:
            comparisonResult = 0;
            break;
        default:
            NSLog(@"erorr dates %@, %@", date1, date2);
            break;
    }
    return comparisonResult;
}

+ (NSString *)getCurrentTime {
    // 获取系统当前时间
    NSDate * date = [NSDate date];
    NSTimeInterval sec = [date timeIntervalSinceNow];
    NSDate * currentDate = [[NSDate alloc] initWithTimeIntervalSinceNow:sec];
    
    //设置时间输出格式：
    NSDateFormatter * df = [[NSDateFormatter alloc] init ];
    [df setDateFormat:@"yyyy-MM-dd"];
    NSString * na = [df stringFromDate:currentDate];
    return na;
}

+ (NSString *)getCurrentSpTime {
    NSDate *datenow = [NSDate date];
    return [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
}
@end