//
//  ViewController.h
//  SocketServer
//
//  Created by jianyi.chen on 2021/12/17.
//

#import <Cocoa/Cocoa.h>
#import "GCDAsyncSocket.h"

@interface ViewController : NSViewController <GCDAsyncSocketDelegate>
{
    dispatch_queue_t socketQueue;
    GCDAsyncSocket *listenSocket;
    NSMutableArray *connectedSockets;
    BOOL isRunning;
}
@property (weak) IBOutlet NSTextField *txf_IP;
@property (weak) IBOutlet NSTextField *txf_PORT;
@property (weak) IBOutlet NSButton *btnStart;
@property (unsafe_unretained) IBOutlet NSTextView *text_Content;
- (IBAction)btn_Start:(id)sender;


@end

