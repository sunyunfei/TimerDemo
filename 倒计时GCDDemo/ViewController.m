//
//  ViewController.m
//  倒计时GCDDemo
//
//  Created by 孙云 on 15/9/8.
//  Copyright (c) 2015年 Haidai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic,weak)UILabel *timerLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    UILabel *label = [[UILabel alloc]init];
    label.layer.cornerRadius = 10;
    label.layer.masksToBounds = YES;
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
    self.timerLabel = label;
    
    //适配
    [self.timerLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    //x
    NSLayoutConstraint *conx = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    
    //y
    NSLayoutConstraint *cony = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0f constant:100.0f];
    
    //w
    NSLayoutConstraint *conw = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeWidth multiplier:0.8f constant:0.0f];
    
    //h
    NSLayoutConstraint *conh = [NSLayoutConstraint constraintWithItem:self.timerLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:30.0f];
    
    NSArray *array = @[conx,cony,conw];
    [self.view addConstraints:array];
    [self.timerLabel addConstraint:conh];
    
    
    __block int timeout=10; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                self.timerLabel.text = @"是否重新发送";
            });
        }else{
            //int minutes = timeout / 60;
            int seconds = timeout % 60;
            
            NSString *strTime = [NSString stringWithFormat:@"%.2d秒后重新获取验证码", seconds];
            
            //回到主界面
            dispatch_async(dispatch_get_main_queue(), ^{
            
                self.timerLabel.text = strTime;
            });
            
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
            });
            timeout--;
            
            
        }
    });

    dispatch_resume(_timer);
    
}



@end
