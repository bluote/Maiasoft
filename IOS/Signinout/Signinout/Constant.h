//
//  Constant.h
//  Signinout
//
//  Created by yaochenxu on 2017/3/23.
//  Copyright © 2017年 Yaochenxu. All rights reserved.
//

#import <UIKit/UIKit.h>


/** サービスの利用ができません。 */
static NSString* const CONST_SERVICE_NOT_AVAILABLE = @"サービスの利用ができません。";
/** 企業ID、ユーザID、パスワード不正 */
static NSString* const CONST_LOGIN_FAIL_MSG = @"企業ID、ユーザID、パスワード不正";

/** パスワードの変更に失敗しました。 */
static NSString* const CONST_PASSWORD_UPDATE_ERROR_TITLE = @"パスワードの変更に失敗しました。";
/** 入力値を確認してください。 */
static NSString* const CONST_PASSWORD_UPDATE_ERROR_MSG = @"入力値を確認してください。";
/** パスワードが変更されました。 */
static NSString* const CONST_PASSWORD_UPDATE_SUCCESSED_MSG = @"パスワードが変更されました。";

/////////////////////////////////////PunchViewController

/** 位置情報の取得に失敗しました。 */
static NSString* const CONST_LOCATION_INTELLIGENCE_FAILURE = @"位置情報の取得に失敗しました。";
/** 社員基本情報の取得に失敗しました。 */
static NSString* const CONST_GET_EMPLOYEE_BASEINFO_ERROR = @"社員基本情報の取得に失敗しました。";
/** 社員月間情報の取得に失敗しました。 */
static NSString* const CONST_GET_EMPLOYEE_MONTHLY_INFO_ERROR = @"社員月間情報の取得に失敗しました。";
/** 表示画面の取得に失敗しました。 */
static NSString* const CONST_GET_PAGE_FLAG_ERROR = @"表示画面の取得に失敗しました。";
/** 出勤開始時間の提出に失敗しました。 */
static NSString* const CONST_SUBMIT_WORKSTART_INFO_ERROR = @"出勤開始時間の提出に失敗しました。";
/** 出勤終了時間の提出に失敗しました。 */
static NSString* const CONST_SUBMIT_WORKEND_INFO_ERROR = @"出勤終了時間の提出に失敗しました。";
/** 勤務レポートの提出に失敗しました。 */
static NSString* const CONST_SUBMIT_REPORT_INFO_ERROR = @"勤務レポートの提出に失敗しました。";
/** ＜      開始：%@      ＞ */
static NSString* const CONST_START_FORMAT = @"＜      開始：%@      ＞";
/** ＜      終了：%@      ＞ */
static NSString* const CONST_END_FORMAT = @"＜      終了：%@      ＞";
/** ＜      控除：%@(分)      ＞ */
static NSString* const CONST_EXCEPT_FORMAT = @"＜      控除：%@(分)      ＞";
/** ＜      控除：%@      ＞ */
static NSString* const CONST_EXCEPT_FORMAT_2 = @"＜      控除：%@      ＞";
/** ＜      控除：%02d:%02d      ＞ */
static NSString* const CONST_EXCEPT_FORMAT_3 = @"＜      控除：%02d:%02d      ＞";
/** ＜      合計：%.1f(時間)      ＞ */
static NSString* const CONST_TOTAL_TIME_FORMAT = @"＜      合計：%.1f(時間)      ＞";
/** 合計：%02d：%02d */
static NSString* const CONST_TOTAL_TIME_FORMAT_2 = @"合計：%02d：%02d";
/** 当月出勤：%@日　　出勤：%.2f時間 */
static NSString* const CONST_MONTHLY_WORK_INFO_FORMAT = @"当月出勤：%@日　　出勤：%.2f時間";
/** 位置情報取得中・・・ */
static NSString* const CONST_POSITION_INFO_MSG = @"位置情報取得中・・・";

/** 出勤情報の更新に失敗しました。 */
static NSString* const CONST_CHANGE_WORK_REPORT_FAIL_TITLE = @"出勤情報の更新に失敗しました。";
/** 出勤情報の更新に失敗しました。 */
static NSString* const CONST_CHANGE_WORK_REPORT_FAIL_MSG = @"出勤情報の更新に失敗しました。";

/** メッセージ表示ダイアログ */
#define SHOW_MSG(TITLE, MESSAGE, QUVC) UIAlertController *alert = [UIAlertController alertControllerWithTitle:TITLE message:MESSAGE preferredStyle: UIAlertControllerStyleActionSheet]; \
    [alert addAction:[UIAlertAction actionWithTitle:@"閉じる" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) { }]]; \
    [QUVC presentViewController:alert animated:true completion:nil];
