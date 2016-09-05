//
//  DemoViewController.m
//  TestTurbolinks
//
//  Created by Hendrik on 3/09/2016.
//  Copyright © 2016 Apin Ridwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DemoViewController.h"

@implementation DemoViewController

- (id)init {
    if (self = [super init]) {
        NSLog(@"Visitable inited");
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Visitable presented");
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end