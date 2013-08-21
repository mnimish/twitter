//
//  TweetViewController.h
//  twitter
//
//  Created by Nimish Manjarekar on 8/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *userName;
@property (strong, nonatomic) IBOutlet UILabel *userScreenName;
@property (strong, nonatomic) IBOutlet UIImageView *profileImage;
@property (strong, nonatomic) IBOutlet UILabel *text;

@property (strong, nonatomic) IBOutlet UIButton *replyBtn;
@property (strong, nonatomic) IBOutlet UIButton *retweetBtn;
@property (strong, nonatomic) IBOutlet UIButton *favBtn;

@property (nonatomic, strong) Tweet *tweet;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tweet:(Tweet *) tweet;

@end
