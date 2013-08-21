//
//  TweetViewController.m
//  twitter
//
//  Created by Nimish Manjarekar on 8/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetViewController.h"

@interface TweetViewController ()

-(void) onComposeBtn;
@end

@implementation TweetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tweet:(Tweet *) tweet
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Tweet";
        self.tweet = tweet;
    }
    return self;
}

- (void)viewDidLoad
{
    NSDictionary *user = [self.tweet objectForKey:@"user"];
    self.profileImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[user objectForKey:@"profile_image_url"]]]];
    self.userName.text = [user objectForKey:@"name"];
    self.userScreenName.text = [@"@" stringByAppendingString:[user objectForKey:@"screen_name"]];
    
    //get text height
    NSString *text = [self.tweet objectForKey:@"text"];
    CGSize maximumLabelSize = CGSizeMake(296, FLT_MAX);
    CGSize expectedLabelSize = [text sizeWithFont:self.text.font constrainedToSize:maximumLabelSize lineBreakMode:self.text.lineBreakMode];
    //adjust the label the the new height.
    CGRect newFrame = self.text.frame;
    newFrame.size.height = expectedLabelSize.height;
    self.text.frame = newFrame;
    self.text.text = text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark Private methods


@end
