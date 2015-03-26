//
//  remainModel.m
//  提醒精灵1.0
//
//  Created by zjsruxxxy3 on 14-9-26.
//  Copyright (c) 2014年 wrcj. All rights reserved.
//

#import "remainModel.h"
#import "AccessTokenTool.h"

@implementation remainModel


-(instancetype)initWithDic:(NSDictionary *)dic
{
    if (self = [super init])
    {
        [self setValuesForKeysWithDictionary:dic];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        dateFormatter.dateFormat = @"MMddHHmm";
        
        self.idenity = [dateFormatter stringFromDate:self.date];
        
        self.access_token = [AccessTokenTool getCurrentTokenFromFile].current_access_token;
        
    }
    
    return self;
}

+(instancetype)remainModelWithDic:(NSDictionary *)dic
{
    return [[self alloc]initWithDic:dic];
    
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"timesNum-%d,handlOff-%d,new-%d",self.timesNum,self.isHandleOff,self.New];
    
}
@end
