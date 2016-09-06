//
//  DemoViewController.h
//  TestTurbolinks
//
//  Created by Hendrik on 3/09/2016.
//  Copyright © 2016 Apin Ridwan. All rights reserved.
//

#ifndef DemoViewController_h
#define DemoViewController_h

#import <UIKit/UIKit.h>
#import <Turbolinks/Turbolinks-Swift.h>

@interface DemoViewController : UIViewController

@property (nonatomic, weak) id <VisitableDelegate> visitableDelegate;
@property NSURL *visitableURL;
@property VisitableView *visitableView;

- (id)initWithURL:(NSURL *)URL;

@end

#endif /* DemoViewController_h */
