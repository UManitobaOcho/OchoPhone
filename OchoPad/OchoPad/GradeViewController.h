//
//  GradeViewController.h
//  OchoPad
//
//  Created by Junjie Huang on 2014-03-19.
//  Copyright (c) 2014 Team Ocho (8). All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SocketIO.h"
#import "ComInterface.h"

@interface GradeViewController : UIViewController<SocketIOConnectionDelegate>

@property (weak, nonatomic) IBOutlet UITextView *GradeInputBox;

@end
