//
//  TweetViewController.m
//  twitter
//
//  Created by Nimish Manjarekar on 8/14/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "TweetViewController.h"
#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface TweetViewController ()

-(void)onReply;
-(void) onReTweet;

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
    [self.replyBtn setBackgroundImage:[UIImage imageNamed:@"Reply.png"] forState:UIControlStateNormal];
    [self.replyBtn addTarget:self action:@selector(onReply) forControlEvents: UIControlEventTouchUpInside];
    [self.retweetBtn setBackgroundImage:[UIImage imageNamed:@"retweet.png"] forState:UIControlStateNormal];
    [self.retweetBtn addTarget:self action:@selector(onReTweet) forControlEvents: UIControlEventTouchUpInside];
    [self.favBtn setBackgroundImage:[UIImage imageNamed:@"favorite.png"] forState:UIControlStateNormal];
    [self.favBtn addTarget:self action:@selector(onReply) forControlEvents: UIControlEventTouchUpInside];
    
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

-(void)onReply {
    ComposeViewController *composeViewController = [[ComposeViewController alloc] initWithNibName:@"ComposeViewController" bundle:nil tweet:self.tweet];
    composeViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
    UINavigationController *cntrol = [[UINavigationController alloc] initWithRootViewController:composeViewController];
    [self presentViewController:cntrol animated:YES completion:nil];
}

-(void) onReTweet {
    [[TwitterClient instance] reTweet:[self.tweet objectForKey:@"id"] success:^(AFHTTPRequestOperation *operation, id response) {
        self.retweetBtn.enabled = FALSE;
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"DSd");
    }];
}

@end
