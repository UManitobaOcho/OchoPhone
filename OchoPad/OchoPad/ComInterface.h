//
//  ComInterface.h
//  OchoPad
//
//  Created by Nicolas Richard on 2014-03-06.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SocketIO.h"

@interface ComInterface : NSObject <SocketIODelegate>
@property (nonatomic,strong) SocketIO* socketIO;

@end
