//
//  ComInterface.h
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"
#import "SocketIOPacket.h"

@protocol SocketIOConnectionDelegate <NSObject>
@required
- (void) receivedPacket:(id)packet;
@end

@interface ComInterface : NSObject <SocketIODelegate>
{
    id <SocketIOConnectionDelegate> delegate;
}
@property (nonatomic,strong) SocketIO* socketIO;
@property (retain) id <SocketIOConnectionDelegate> delegate;
@property (nonatomic) NSInteger userId;
@property (nonatomic) BOOL isProf;
+ (ComInterface *) sharedInstance;

@end
