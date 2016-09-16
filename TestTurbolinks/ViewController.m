//
//  ViewController.m
//  asdasd
//
//  Created by Apin Ridwan on 9/5/16.
//  Copyright © 2016 Apin Ridwan. All rights reserved.
//

#import "ViewController.h"
#import "DemoViewController.h"

@protocol SessionDelegate;
@protocol Visitable;

@interface ViewController () <SessionDelegate, Visitable>

@end

@implementation ViewController

- (id)init {
    self = [super init];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.URL = [NSURL URLWithString:@"http://id.crowdvoice.me:3000/test_submit"];
    self.webViewProcessPool = [[WKProcessPool alloc] init];
    
    self.userContentController = [[WKUserContentController alloc] init];
    [self.userContentController addScriptMessageHandler:self name:@"iOSTurbolinksCV"];
    
    self.webViewConfiguration = [[WKWebViewConfiguration alloc] init];
    self.webViewConfiguration.userContentController = self.userContentController;
    self.webViewConfiguration.processPool = self.webViewProcessPool;
    self.webViewConfiguration.applicationNameForUserAgent = @"iOSTurbolinksCV";
    
    self.session = [[Session alloc] initWithWebViewConfiguration:self.webViewConfiguration];
    self.session.delegate = self;
    
    [self presentVisitableForSession:self.session URL:self.URL];
}

- (void)presentVisitableForSession:(Session *)session URL:(NSURL *)URL {
    [self presentVisitableForSession:session URL:URL action:ActionAdvance];
}

- (void)presentVisitableForSession:(Session *)session URL:(NSURL *)URL action:(Action)action {
    NSLog(@"Presenting visitable ...");
    // TODO: Open DemoViewController
    
    DemoViewController *visitable = [[DemoViewController alloc] initWithURL:URL];
    
    if (action == ActionAdvance) {
        [self.navigationController pushViewController:visitable animated:YES];
    }
    else if (action == ActionReplace) {
        [self.navigationController popViewControllerAnimated:NO];
        [self.navigationController pushViewController:visitable animated:NO];
    }
    
//    [self.navigationController pushViewController:visitable animated:true];
    [self.session visit: visitable];
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

- (void)session:(Session *)session didProposeVisitToURL:(NSURL *)URL withAction:(enum Action)action {
    [self presentVisitableForSession:session URL:URL action:action];
}

- (void)session:(Session *)session didFailRequestForVisitable:(id<Visitable>)visitable withError:(NSError *)error {
    NSLog(@"session did fail request for visitable");
}

- (void)sessionDidLoadWebView:(Session *)session {
    session.webView.navigationDelegate = session;
}

- (void)sessionDidStartRequest:(Session *)session {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)sessionDidFinishRequest:(Session *)session {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

@end
