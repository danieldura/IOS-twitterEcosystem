//
//  ViewController.m
//  twitterEcosistem
//
//  Created by Daniel Durà on 06/04/17.
//  Copyright © 2017 mobincube. All rights reserved.
//

#import "ViewController.h"
#import <Fabric/Fabric.h>
#import <TwitterKit/TwitterKit.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  // Do any additional setup after loading the view, typically from a nib.
}


- (void)loadView{
  
  [super loadView];
  TWTRLogInButton *logInButton = [TWTRLogInButton buttonWithLogInCompletion:^(TWTRSession *session, NSError *error) {
    if (session) {
      NSLog(@"signed in as %@", [session userName]);
      NSString *userID = [session userID];
      TWTRAPIClient *client = [[TWTRAPIClient alloc]initWithUserID:userID];
      NSURLRequest *request = [client URLRequestWithMethod:@"GET"
                                                       URL:@"https://api.twitter.com/1.1/account/verify_credentials.json"
                                                parameters:@{@"include_email": @"true", @"skip_status": @"true"}
                                                     error:nil];
      
      [client sendTwitterRequest:request completion:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSError* error;
          NSDictionary* json = [[NSDictionary alloc]init];
          if(data){
        json = [NSJSONSerialization JSONObjectWithData:data
                                                             options:kNilOptions
                                                               error:&error];
          }
        //        NSArray* latestLoans = [json objectForKey:@"loans"];
        
        NSLog(@"loans: %@", json);
//
          NSString *mail = [json objectForKey:@"email"];
          NSLog(@"Respuesta: %@",mail);
//        NSLog(@"JSON: %@",data);
      }];
      
      
    } else {
      NSLog(@"error: %@", [error localizedDescription]);
    }
  }];
    logInButton.loginMethods = TWTRLoginMethodWebBased;

  logInButton.center = self.view.center;
  [self.view addSubview:logInButton];
  
  
}

- (void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}



@end
