//
//  DemoViewController.m
//  TestTurbolinks
//
//  Created by Hendrik on 3/09/2016.
//  Copyright © 2016 Apin Ridwan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <WebKit/WebKit.h>
#import "DemoViewController.h"

@protocol Visitable;

@interface DemoViewController () <Visitable>

@end

@implementation DemoViewController

- (id)initWithURL:(NSURL *)URL {
    if (self = [super init]) {
        NSLog(@"Visitable inited");
        
        self.visitableView = [[VisitableView alloc] initWithFrame:CGRectZero];
        [self.visitableView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        self.visitableURL = URL;
    }
    
    return self;
}

- (void)installVisitableView {
    [self.view addSubview:self.visitableView];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:@{ @"view": self.visitableView }]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:@{ @"view": self.visitableView }]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Visitable presented");
    // Do any additional setup after loading the view, typically from a nib.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    [self installVisitableView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.visitableDelegate visitableViewWillAppear:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.visitableDelegate visitableViewDidAppear:self];
}

- (void)visitableDidRender {
    self.title = [[self.visitableView webView] title];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
