//
//  ViewController.h
//  OchoPhone
//
//  Copyright (c) 2014 UManitobaOcho. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"

@interface ViewController : UIViewController <SocketIODelegate>
@property (nonatomic,strong) SocketIO* socketIO;

@property (nonatomic,assign) IBOutlet UITextView* msgLog;

@end
