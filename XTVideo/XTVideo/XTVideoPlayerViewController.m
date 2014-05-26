//
//  XTVideoPlayerViewController.m
//  XTVideo
//
//  Created by tage on 14-5-26.
//  Copyright (c) 2014年 NULL. All rights reserved.
//

#import "XTVideoPlayerViewController.h"
#import "XTVideoPlayer.h"

@interface XTVideoPlayerViewController ()

@property (nonatomic, strong) id model;

@end

@implementation XTVideoPlayerViewController

- (id)initWithObject:(id)model
{
    if (self = [super init]) {
        _model = model;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        XTVideoPlayer *player = [[XTVideoPlayer alloc] initWithFrame:self.view.bounds videoModel:_model delegate:nil];
        [self.view addSubview:player];
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
