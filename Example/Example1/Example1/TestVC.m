//
//  TestVC.m
//  Example1
//
//  Created by Michael Raber on 5/8/14.
//  Copyright (c) 2014 Innoruptor. All rights reserved.
//

#import "TestVC.h"
#import "TimeService.h"

@interface TestVC ()

@end

@implementation TestVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  // Do any additional setup after loading the view.
  
  timeButton = [UIButton buttonWithType:UIButtonTypeCustom];
  [timeButton setTitle:@"Retrieve Time" forState:UIControlStateNormal];
  timeButton.backgroundColor = [UIColor blueColor];
  [timeButton addTarget:self action:@selector(retrieveTime) forControlEvents:UIControlEventTouchUpInside];
  
  timeButton.frame = CGRectMake(30, 100, 260, 40);
  [self.view addSubview:timeButton];
  
  timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 150, 260, 30)];
  timeLabel.backgroundColor = [UIColor lightGrayColor];
  timeLabel.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:timeLabel];

  counterLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 190, 260, 30)];
  counterLabel.backgroundColor = [UIColor lightGrayColor];
  counterLabel.textAlignment = NSTextAlignmentCenter;
  [self.view addSubview:counterLabel];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) retrieveTime{
  NSString *currentTime = [[TimeService sharedSingleton] getCurrentTime];
  
  counter++;
  
  timeLabel.text = currentTime;
  counterLabel.text = [NSString stringWithFormat:@"counter: %i", counter];
}

@end
