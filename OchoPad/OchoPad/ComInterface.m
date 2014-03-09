//
//  ComInterface.m
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import "ComInterface.h"

@interface ComInterface()
@end

@implementation ComInterface

@synthesize delegate;

+ (ComInterface *)sharedInstance
{
    static ComInterface *sharedInstance = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id) init
{
    NSDictionary *cookieProperties = [NSDictionary dictionaryWithObjectsAndKeys:
                                      @"ec2-54-201-63-66.us-west-2.compute.amazonaws.com", NSHTTPCookieDomain,
                                      @"\\", NSHTTPCookiePath,
                                      @"express.sid", NSHTTPCookieName,
                                      @"s:test", NSHTTPCookieValue,
                                      nil];
    
    _socketIO = [[SocketIO alloc] initWithDelegate:self];
    [_socketIO connectToHost:@"ec2-54-201-63-66.us-west-2.compute.amazonaws.com" onPort:8080 withParams:[NSDictionary dictionaryWithObjectsAndKeys:@"express.sid", @"cookie", nil] withCookieParams:cookieProperties];
    
    return self;
}

- (void) socketIODidConnect:(SocketIO *)socket
{
    NSLog(@"socket.io connected.");
}

- (void) socketIO:(SocketIO *)socket didReceiveEvent:(SocketIOPacket *)packet
{
    NSError *e = nil;
    NSDictionary *JSON = [NSDictionary dictionaryWithDictionary:packet.dataAsJSON];
    NSArray *ns = JSON[@"args"];
    NSLog(@"didReceiveEvent >>> data: ");
    [delegate receivedPacket:packet.dataAsJSON];
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
