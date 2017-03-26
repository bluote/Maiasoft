//
//  PunchViewController.m
//  Signinout
//
//  Created by yaochenxu on 2016/08/02.
//  Copyright © 2016年 Yaochenxu. All rights reserved.
//

#import "PunchViewController.h"
#import "WebServiceAPI.h"
#import "Constant.h"
#import <CoreLocation/CoreLocation.h>

@interface PunchViewController ()<CLLocationManagerDelegate>

- (IBAction)setStartTime:(UIButton *)sender;
- (IBAction)setEndTime:(UIButton *)sender;
- (IBAction)setExceptTime:(UIButton *)sender;

- (IBAction)submitPage1:(UIButton *)sender;
- (IBAction)submitPage2:(UIButton *)sender;
- (IBAction)submitPage3:(UIButton *)sender;


@property (weak, nonatomic) IBOutlet UILabel     *positionInfo;
@property (weak, nonatomic) IBOutlet UIButton    *submitPage1Btn;
@property (weak, nonatomic) IBOutlet UIButton    *submitPage2Btn;
@property (weak, nonatomic) IBOutlet UIButton    *submitPage3Btn;

@property (weak, nonatomic) IBOutlet UIStackView *page3Stack;
@property (weak, nonatomic) IBOutlet UIStackView *page4Stack;

@property (weak, nonatomic) IBOutlet UIButton    *startTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton    *endTimeBtn;
@property (weak, nonatomic) IBOutlet UIButton    *exceptTimeBtn;
@property (weak, nonatomic) IBOutlet UILabel     *userNameJP;
@property (weak, nonatomic) IBOutlet UILabel     *userMonthlyInfo;
@property (weak, nonatomic) IBOutlet UILabel    *totalTime;
@property (weak, nonatomic) IBOutlet UILabel    *startTimeLab;
@property (weak, nonatomic) IBOutlet UILabel    *endTimeLab;
@property (weak, nonatomic) IBOutlet UILabel    *exceptTimeLab;
@property (weak, nonatomic) IBOutlet UILabel    *totalTimeLab;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, retain) NSString  *strStartTime;
@property (nonatomic, retain) NSString  *strEndTime;
@property (nonatomic, retain) NSString  *strExceptTime;
@property (nonatomic, retain) NSString  *strTotalMinute;


@end

@implementation PunchViewController 

NSString *strLongitude = nil;
NSString *strLatitude = nil;

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(viewDidAppear:) name:UIApplicationDidBecomeActiveNotification object:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

- (void)applicationWillTerminate:(UIApplication *)application{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

/**
 Get location information and set strLongitude/strLatitude.
 Get placemarks by Longitude/Latitude.

 @param manager <#manager description#>
 @param locations <#locations description#>
 */
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    CLLocation *currLocation = [locations lastObject];
    strLongitude = [NSString stringWithFormat:@"%3.11f", currLocation.coordinate.longitude];
    strLatitude = [NSString stringWithFormat:@"%3.11f", currLocation.coordinate.latitude];
    CLGeocoder * geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation:currLocation completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        if(error)
        {
            self.positionInfo.text = CONST_LOCATION_INTELLIGENCE_FAILURE;
        }
        else if([placemarks count] > 0)
        {
            CLPlacemark *placemrk = placemarks[0];
            self.positionInfo.text = placemrk.name;
        }
    }];

}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"locationManager error:%@",error);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 1.Get location info and show it.
 2.Get employee base info, and show name of JP, show defalut work start/end/except time.
 3.Get and show monthly attendances infomation.
 4.show UI Controller&Info according page_flag.

 @param animated <#animated description#>
 */
- (void)viewDidAppear:(BOOL)animated{
    // 1.Get location info and show it.
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    self.locationManager.distanceFilter = 100.0f;
    
    [self.locationManager requestWhenInUseAuthorization];
    [self.locationManager startUpdatingLocation];
    
    self.positionInfo.hidden = YES;
    self.submitPage1Btn.hidden = YES;
    self.submitPage2Btn.hidden = YES;
    self.page3Stack.hidden = YES;
    self.page4Stack.hidden = YES;
    
    
    NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
    
    // 2.Get employee base info, and show name of JP, show defalut work start/end/except time.
    [[WebServiceAPI requestWithFinishBlock:^(id object) {
        NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
        if ([resultCodeObj integerValue] < 0)
        {
            // get EmployeeBaseInfo error
            SHOW_MSG(@"", CONST_GET_EMPLOYEE_BASEINFO_ERROR, self);
        } else {
            self.userNameJP.text = [object objectForKey:@"name_jp"];
            
            self.strStartTime = [object objectForKey:@"default_work_start_time"];
            NSString *strDefalutWorkStartTime = [NSString stringWithFormat:CONST_START_FORMAT,self.strStartTime];
            [self.startTimeBtn setTitle:strDefalutWorkStartTime forState:UIControlStateNormal];
            
            self.strEndTime = [object objectForKey:@"default_work_end_time"];
            NSString *strDefalutWorkEndTime = [NSString stringWithFormat:CONST_END_FORMAT, self.strEndTime];
            [self.endTimeBtn setTitle:strDefalutWorkEndTime forState:UIControlStateNormal];
            
            self.strExceptTime = [NSString stringWithFormat:@"%@",[object objectForKey:@"default_except_minutes"]];
            int intDefalutWorkExceptTime = [self.strExceptTime intValue];
            int hour = intDefalutWorkExceptTime / 60;
            int minut = intDefalutWorkExceptTime % 60;
            
            NSString *strDefalutWorkExceptTime = [NSString stringWithFormat:CONST_EXCEPT_FORMAT_3, hour, minut];
            [self.exceptTimeBtn setTitle:strDefalutWorkExceptTime forState:UIControlStateNormal];
            
            // calculate total time
            self.strTotalMinute = [self dateTimeDifferenceWithStartTime:self.strStartTime endTime:self.strEndTime exceptTime:self.strExceptTime];
        }
    } failBlock:^(int statusCode, int errorCode) {
        // web service not available
        SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
        
    }] getEmployeeBaseInfoWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"]  withUserName:[userDefault stringForKey:@"token"] withPassword:@"" ];
    
    // 3.Get and show monthly attendances infomation.
    // get NSCalendar object
    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    // get system date
    NSDate* dt = [NSDate date];
    // define flags to get system year and month
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
    NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
    NSString *searchYear = [NSString stringWithFormat:@"%ld",(long)comp.year];
    NSString *searchMonth = [NSString stringWithFormat:@"%ld",(long)comp.month];
    
    [[WebServiceAPI requestWithFinishBlock:^(id object) {
        NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
        if ([resultCodeObj integerValue] < 0)
        {
            // get EmployeeMonthlyInfo error
            SHOW_MSG(@"", CONST_GET_EMPLOYEE_MONTHLY_INFO_ERROR, self);
        } else {
            // show monthly info
            self.userMonthlyInfo.text = [NSString stringWithFormat:CONST_MONTHLY_WORK_INFO_FORMAT, [object objectForKey:@"total_days"],[[object objectForKey:@"total_hours"] floatValue] / 60.0f ];
            
            // get today's work report info from [monthly_work_time_list]
            NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"d"];
            NSString *strCurrentDay = [dateFormatter stringFromDate:[NSDate date]];
            int dayIndex = [strCurrentDay intValue] - 1;
            NSMutableArray* objects = [object objectForKey:@"monthly_work_time_list"];
            NSMutableDictionary*  dict = objects[dayIndex];
            // get report info from dictionary and make format to HH:MM
            self.strStartTime = [dict objectForKey:@"report_start_time"];
            if([self.strStartTime intValue] != 0){
                if([self.strStartTime length] > 5)
                    self.strStartTime = [self.strStartTime substringToIndex:5];
                self.strEndTime = [dict objectForKey:@"report_end_time"];
                if([self.strEndTime length] > 5)
                    self.strEndTime = [self.strEndTime substringToIndex:5];
                self.strExceptTime = [dict objectForKey:@"report_exclusive_minutes"];
                self.strTotalMinute = [dict objectForKey:@"report_total_minutes"];
            }
            // show report info
            self.startTimeLab.text = [NSString stringWithFormat:CONST_START_FORMAT, self.strStartTime];
            self.endTimeLab.text = [NSString stringWithFormat:CONST_END_FORMAT, self.strEndTime];
            self.exceptTimeLab.text = [NSString stringWithFormat:CONST_EXCEPT_FORMAT, self.strExceptTime];
            double totalTemp = self.strTotalMinute.integerValue / 60.0f;
            self.totalTimeLab.text = [NSString stringWithFormat:CONST_TOTAL_TIME_FORMAT, totalTemp];
        }
    } failBlock:^(int statusCode, int errorCode) {
        // web service not available
        SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
        
    }] getEmployeeMonthlyInfoWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"]  withUserName:[userDefault stringForKey:@"token"] withPassword:@"" withSearchYear:searchYear withSearchMonth:searchMonth];
    
    // 4.show UI Controller&Info according page_flag.
    [[WebServiceAPI requestWithFinishBlock:^(id object) {
        NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
        NSNumber *pageFlagObj = [object objectForKey:@"page_flag"];
        if ([resultCodeObj integerValue] < 0)
        {
            // get page flag error
            SHOW_MSG(@"", CONST_GET_PAGE_FLAG_ERROR, self);
        } else {
            if ([pageFlagObj integerValue] == 1)
            {
                // show page1
                self.positionInfo.hidden = NO;
                self.submitPage1Btn.hidden = NO;
            }
            else if ([pageFlagObj integerValue] == 2)
            {
                // show page2
                self.positionInfo.hidden = NO;
                self.submitPage2Btn.hidden = NO;
            }
            else if ([pageFlagObj integerValue] == 3)
            {
                // show page3
                self.page3Stack.hidden = NO;
            }
            else if ([pageFlagObj integerValue] == 4)
            {
                // show page4
                self.page4Stack.hidden = NO;
            }
        }
    } failBlock:^(int statusCode, int errorCode) {
        // web service not available
        SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
        
    }] getPageFlagWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"] withUserName:[userDefault stringForKey:@"token"] withPassword:@""];
}


/**
 submit work start infomation.

 @param sender <#sender description#>
 */
- (IBAction)submitPage1:(UIButton *)sender {
    NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
    [self.locationManager startUpdatingLocation];

    if(strLatitude != nil)
    {
        [[WebServiceAPI requestWithFinishBlock:^(id object) {
            NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
            if ([resultCodeObj integerValue] < 0)
            {
                // WorkStartInfo submit error
                SHOW_MSG(@"", CONST_SUBMIT_WORKSTART_INFO_ERROR, self);
            } else {
                self.submitPage1Btn.hidden = YES;
                self.submitPage2Btn.hidden = NO;
            }
        } failBlock:^(int statusCode, int errorCode) {
            // web service not available
            SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
            
        }] submitWorkStartInfoWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"]  withUserName:[userDefault stringForKey:@"token"] withPassword:@"" withLongitude:strLongitude withLatitude:strLatitude spotName:self.positionInfo.text];
    }
    else
    {
        self.positionInfo.text = CONST_POSITION_INFO_MSG;
    }
    strLatitude = nil;
    strLongitude = nil;
}

/**
 submit work end infomation.

 @param sender <#sender description#>
 */
- (IBAction)submitPage2:(UIButton *)sender {
    NSUserDefaults  * userDefault = [NSUserDefaults standardUserDefaults];
    [self.locationManager startUpdatingLocation];
    if(strLatitude != nil)
    {
        [[WebServiceAPI requestWithFinishBlock:^(id object) {
            NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
            if ([resultCodeObj integerValue] < 0)
            {
                // WorkEndInfo submit error
                SHOW_MSG(@"", CONST_SUBMIT_WORKEND_INFO_ERROR, self);
            } else {
                self.submitPage1Btn.hidden = YES;
                self.submitPage2Btn.hidden = YES;
                self.positionInfo.hidden = YES;
                self.page3Stack.hidden = NO;
                self.page4Stack.hidden = YES;
            }
        } failBlock:^(int statusCode, int errorCode) {
            // web service not available
            SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
            
        }] submitWorkEndInfoWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"]  withUserName:[userDefault stringForKey:@"token"] withPassword:@"" withLongitude:strLongitude withLatitude:strLatitude spotName:self.positionInfo.text];
    }
    else
    {
        self.positionInfo.text = CONST_POSITION_INFO_MSG;
    }
    strLatitude = nil;
    strLongitude = nil;
}

/**
 submit work report infomation.
 
 @param sender <#sender description#>
 */
- (IBAction)submitPage3:(UIButton *)sender {
    NSUserDefaults  *userDefault = [NSUserDefaults standardUserDefaults];
    
    [[WebServiceAPI requestWithFinishBlock:^(id object) {
        NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
        if ([resultCodeObj integerValue] < 0)
        {
            // WorkReportInfo submit error
            SHOW_MSG(@"", CONST_SUBMIT_REPORT_INFO_ERROR, self);
        } else {
            self.startTimeLab.text = [NSString stringWithFormat:CONST_START_FORMAT, self.strStartTime];
            self.endTimeLab.text = [NSString stringWithFormat:CONST_END_FORMAT, self.strEndTime];
            self.exceptTimeLab.text = [NSString stringWithFormat:CONST_EXCEPT_FORMAT, self.strExceptTime];
            double totalTemp = self.strTotalMinute.integerValue / 60.0f;
            self.totalTimeLab.text = [NSString stringWithFormat:CONST_TOTAL_TIME_FORMAT, totalTemp];
            
            self.submitPage1Btn.hidden = YES;
            self.submitPage2Btn.hidden = YES;
            self.positionInfo.hidden = YES;
            self.page3Stack.hidden = YES;
            self.page4Stack.hidden = NO;
            
            // show monthly attendances infomation
            NSCalendar *gregorian = [[NSCalendar alloc]
                                     initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            // get system date
            NSDate* dt = [NSDate date];
            // define flags to get system year and month
            unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth;
            NSDateComponents* comp = [gregorian components: unitFlags fromDate:dt];
            NSString *searchYear = [NSString stringWithFormat:@"%ld",(long)comp.year];
            NSString *searchMonth = [NSString stringWithFormat:@"%ld",(long)comp.month];
            
            [[WebServiceAPI requestWithFinishBlock:^(id object) {
                NSNumber *resultCodeObj = [object objectForKey:@"result_code"];
                if ([resultCodeObj integerValue] < 0)
                {
                    // get EmployeeMonthlyInfo error
                    SHOW_MSG(@"", CONST_GET_EMPLOYEE_MONTHLY_INFO_ERROR, self);
                } else {
                    self.userMonthlyInfo.text = [NSString stringWithFormat:CONST_MONTHLY_WORK_INFO_FORMAT, [object objectForKey:@"total_days"],[[object objectForKey:@"total_hours"] floatValue] / 60.0f ];
                }
            } failBlock:^(int statusCode, int errorCode) {
                // web service not available
                SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
                
            }] getEmployeeMonthlyInfoWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"]  withUserName:[userDefault stringForKey:@"token"] withPassword:@"" withSearchYear:searchYear withSearchMonth:searchMonth];
        }
    } failBlock:^(int statusCode, int errorCode) {
        // web service not available
        SHOW_MSG(@"", CONST_SERVICE_NOT_AVAILABLE, self);
        
    }] submitWorkReportInfoWithEnterpriseId:[userDefault stringForKey:@"enterpriseId"]  withUserName:[userDefault stringForKey:@"token"] withPassword:@"" withStartTime:self.strStartTime withEndTime:self.strEndTime withExclusiveMinutes:self.strExceptTime withTotalMinutes:self.strTotalMinute];
}

/**
 calculate total minute with start/end/except time.

 @param startTime <#startTime description#>
 @param endTime <#endTime description#>
 @param exceptTime <#exceptTime description#>
 @return <#return value description#>
 */
- (NSString *)dateTimeDifferenceWithStartTime:(NSString *)startTime endTime:(NSString *)endTime exceptTime:(NSString *)exceptTime{
    NSDateFormatter *date = [[NSDateFormatter alloc]init];
    [date setDateFormat:@"HH:mm"];
    
    NSDate *startD =[date dateFromString:startTime];
    NSDate *endD = [date dateFromString:endTime];
    NSTimeInterval start = [startD timeIntervalSince1970]*1;
    NSTimeInterval end = [endD timeIntervalSince1970]*1;
    NSTimeInterval value = end - start;
    
    //int second = (int)value %60;
    int minute = (int)value /60%60;
    int house = (int)value / 3600%3600;
    //int day = (int)value / (24 * 3600);
    
    int totalMinute = (house*60) + minute;
    totalMinute = totalMinute - [exceptTime intValue];
    
    house = totalMinute / 60;
    minute = totalMinute % 60;
    self.totalTime.text = [NSString stringWithFormat:CONST_TOTAL_TIME_FORMAT_2, house, minute];
    
    NSString *str = [NSString stringWithFormat:@"%d",totalMinute];
    return str;
}

/**
 Show a dialog to setup report time for work start.

 @param sender <#sender description#>
 */
- (IBAction)setStartTime:(UIButton *)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert.view addSubview:datePicker];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        // create NSDateFormatter instance and set time format
        [dateFormat setDateFormat:@"HH:mm"];
        // show the time in startTimeBtn
        self.strStartTime = [dateFormat stringFromDate:datePicker.date];
        NSString *strDefalutWorkStartTime = [NSString stringWithFormat:CONST_START_FORMAT, self.strStartTime];
        [self.startTimeBtn setTitle:strDefalutWorkStartTime forState:UIControlStateNormal];
        // calculate total time
        self.strTotalMinute = [self dateTimeDifferenceWithStartTime:self.strStartTime endTime:self.strEndTime exceptTime:self.strExceptTime];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}

/**
 Show a dialog to setup report time for work end.

 @param sender <#sender description#>
 */
- (IBAction)setEndTime:(UIButton *)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeTime;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert.view addSubview:datePicker];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        // create NSDateFormatter instance and set time format
        [dateFormat setDateFormat:@"HH:mm"];
        // show the time in endTimeBtn
        self.strEndTime = [dateFormat stringFromDate:datePicker.date];
        NSString *strDefalutWorkEndTime = [NSString stringWithFormat:CONST_END_FORMAT, self.strEndTime];
        [self.endTimeBtn setTitle:strDefalutWorkEndTime forState:UIControlStateNormal];
        // calculate total time
        self.strTotalMinute = [self dateTimeDifferenceWithStartTime:self.strStartTime endTime:self.strEndTime exceptTime:self.strExceptTime];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
    
}

/**
 Show a dialog to setup report time for except.

 @param sender <#sender description#>
 */
- (IBAction)setExceptTime:(UIButton *)sender {
    UIDatePicker *datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeCountDownTimer;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert.view addSubview:datePicker];
    UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        NSDateFormatter* dateFormat = [[NSDateFormatter alloc] init];
        // create NSDateFormatter instance and set time format
        [dateFormat setDateFormat:@"HH:mm"];
        // show the time in exceptTimeBtn
        self.strExceptTime = [dateFormat stringFromDate:datePicker.date];
        NSString *strDefalutWorkExceptTime = [NSString stringWithFormat:CONST_EXCEPT_FORMAT_2,self.strExceptTime];
        [self.exceptTimeBtn setTitle:strDefalutWorkExceptTime forState:UIControlStateNormal];
        
        // convert time to minutes
        NSArray *array = [self.strExceptTime componentsSeparatedByString:@":"];
        int intExceptTime = [array[0] intValue] * 60 + [array[1] intValue];
        self.strExceptTime = [NSString stringWithFormat:@"%d",intExceptTime];
        
        // calculate total time
        self.strTotalMinute = [self dateTimeDifferenceWithStartTime:self.strStartTime endTime:self.strEndTime exceptTime:self.strExceptTime];
    }];
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
    }];
    [alert addAction:ok];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:^{ }];
}

@end
