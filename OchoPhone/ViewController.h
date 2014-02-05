//
//  ViewController.h
//  OchoPhone
//
//  Created by Nico on 2/4/2014.
//  Copyright (c) 2014 UManitobaOcho. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SocketIO.h"
@interface ViewController : UIViewController <SocketIODelegate>
@property (nonatomic,strong) SocketIO* socketIO;

@end
