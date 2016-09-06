//
//  ViewController.h
//  asdasd
//
//  Created by Apin Ridwan on 9/5/16.
//  Copyright © 2016 Apin Ridwan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WebKit/WebKit.h>
#import "Turbolinks/Turbolinks-Swift.h"

@interface ViewController : UIViewController <WKScriptMessageHandler>

@property NSURL                     *URL;
@property WKProcessPool             *webViewProcessPool;
@property WKUserContentController   *userContentController;
@property WKWebViewConfiguration    *webViewConfiguration;
@property Session                   *session;

@end

