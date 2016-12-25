//
//  WebServiceAPI.h
//  Signinout
//
//  Created by yaochenxu on 2016/12/25.
//  Copyright © 2016年 maiasoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking.h>

@interface WebServiceAPI : NSObject

@property (nonatomic, copy) void (^finishBlock) (id);
@property (nonatomic, copy) void (^failBlock) (int,int);

- (id)initWithFinishBlock:(void (^)(id))finishBlockToRun failBlock:(void (^)(int,int))failBlockToRun;

+ (WebServiceAPI *) requestWithFinishBlock:(void (^)(id object))finishBlockToRun failBlock:(void (^)(int statusCode,int errorCode))failBlockToRun;

- (void) doLoginGetTokenWithEnterpriseId:(NSString *) enterpriseId withUserName:(NSString *) userName withPassword:(NSString *) password;
@end
