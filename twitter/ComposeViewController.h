//
//  ComposeViewController.h
//  twitter
//
//  Created by Nimish Manjarekar on 8/19/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ComposeViewController : UIViewController <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *tweetText;
@property (strong, nonatomic) IBOutlet UILabel *remainingCount;

@end
