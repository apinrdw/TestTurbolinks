//
//  ViewController.m
//  TestTurbolinks
//
//  Created by Apin Ridwan on 9/2/16.
//  Copyright © 2016 Apin Ridwan. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (id)init {
    if (self = [super init]) {
        self.URL = [NSURL URLWithString:@"https://id.crowdvoice.com"];
        self.webViewProcessPool = [[WKProcessPool alloc] init];
        
        self.userContentController = [[WKUserContentController alloc] init];
        [self.userContentController addScriptMessageHandler:self name:@"iOSTurbolinksCV"];
        
        self.webViewConfiguration = [[WKWebViewConfiguration alloc] init];
        self.webViewConfiguration.userContentController = self.userContentController;
        self.webViewConfiguration.processPool = self.webViewProcessPool;
        self.webViewConfiguration.applicationNameForUserAgent = @"iOSTurbolinksCV";
        
        self.session = [[Session alloc] initWithWebViewConfiguration:self.webViewConfiguration];
        // self.session.delegate = self;
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self presentVisitableForSession:self.session URL:self.URL];
}

- (void)presentVisitableForSession:(Session *)session URL:(NSURL *)URL {
    NSLog(@"Presenting visitable ...");
    // TODO: Open DemoViewController
    
    DemoViewController *visitable = [[DemoViewController alloc] init];
    
    /*
    if action == .Advance {
        pushViewController(visitable, animated: true)
    } else if action == .Replace {
        popViewControllerAnimated(false)
        pushViewController(visitable, animated: false)
    }
     */
    
    [self.navigationController pushViewController:visitable animated:true];
    //[self.session visit: visitable];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message {
    NSLog(@"Received event %@", message.body);
    
    if (![message.body isEqualToString:@""]) {
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Turbolinks" message:message.body preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:okAction];
        [self presentViewController:alertController animated:true completion:nil];
    }
}

@end
