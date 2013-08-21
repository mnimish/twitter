//
//  ComposeViewController.m
//  twitter
//
//  Created by Nimish Manjarekar on 8/19/13.
//  Copyright (c) 2013 codepath. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"

@interface ComposeViewController ()

-(void)onBack;
-(void)onTweet;
-(void) close;

@end

@implementation ComposeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil tweet:(Tweet *) tweet
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"New Tweet";
        if(tweet) {
            self.tweet = tweet;
        }
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.tweetText becomeFirstResponder];
    self.tweetText.delegate = self;
    
    if(self.tweet) {
        NSDictionary *user = [self.tweet objectForKey:@"user"];
        [self.tweetText setText: [@"@" stringByAppendingString: [[NSString alloc] initWithFormat:@"%@ ", [user objectForKey:@"screen_name"]]]];
        self.remainingCount.text = [NSString stringWithFormat:@"%d", 140 - [[self.tweetText text] length]];
    }
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStyleDone target:self action:@selector(onBack)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStyleDone target:self action:@selector(onTweet)];
    self.navigationItem.rightBarButtonItem.enabled = FALSE;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private methods
-(void) close {
    [self dismissViewControllerAnimated:YES completion:^{}];
}

-(void) onBack {
    [self close];
}

-(void) onTweet {
    if(self.tweet) {
        [[TwitterClient instance] postTweetReply:self.tweetText.text toTweetId:[self.tweet objectForKey:@"id"] success:^(AFHTTPRequestOperation *operation, id response) {
            [self close];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // Do nothing
        }];
    } else {
        [[TwitterClient instance] postTweet:self.tweetText.text success:^(AFHTTPRequestOperation *operation, id response) {
            [self close];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            // Do nothing
        }];
    }
}

#pragma mark - textview delegates
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if ([[textView text] length] - range.length + text.length > 140) {
        return NO;
    } else {
        return YES;
    }
}

- (void)textViewDidChange:(UITextView *)textView {
    int remaining = 140 - [[textView text] length];
    
    //enable/disable tweet
    if(remaining < 140) {
        self.navigationItem.rightBarButtonItem.enabled = TRUE;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = FALSE;
    }
    //show warning
    if(remaining < 10) {
        self.remainingCount.textColor = [UIColor redColor];
    } else {
        self.remainingCount.textColor = [UIColor blackColor];
    }
    //update remaining count
    self.remainingCount.text = [NSString stringWithFormat:@"%d", remaining];
}

@end
