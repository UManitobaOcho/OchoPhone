//
//  ViewController.m
//  OchoPhone
//
//  Created by Nico on 2/4/2014.
//  Copyright (c) 2014 UManitobaOcho. All rights reserved.
//

#import "SocketIOPacket.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"loaded the view");
    _socketIO = [[SocketIO alloc] initWithDelegate:self];
    [_socketIO connectToHost:@"localhost" onPort:3000];
    [_socketIO sendEvent:@"connect" withData:@"iOSuser"];
}

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSLog(@"didReceiveEvent()");
    
    if([packet.name isEqualToString:@"message"])
    {
        NSArray* args = packet.args;
        NSDictionary* arg = args[0];
        
        _msgLog.text = [_msgLog.text stringByAppendingFormat:@"%@\n",arg[@"message"]];
        
    }
}

- (void) socketIO:(SocketIO *)socket onError:(NSError *)error
{
    NSLog(@"onError() %@", error);
}


- (void) socketIODidDisconnect:(SocketIO *)socket disconnectedWithError:(NSError *)error
{
    NSLog(@"socket.io disconnected. did error occur? %@", error);
}

@end
