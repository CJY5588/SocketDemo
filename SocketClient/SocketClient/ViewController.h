//
//  ViewController.h
//  SocketClient
//
//  Created by jianyi.chen on 2021/12/17.
//

#import <Cocoa/Cocoa.h>
#import "GCDAsyncSocket.h"
@interface ViewController : NSViewController <GCDAsyncSocketDelegate>
{
    dispatch_queue_t socketQueue;
    GCDAsyncSocket *sendSocket;
    BOOL isConnect;
}

@property (weak) IBOutlet NSTextField *txf_IP;
@property (weak) IBOutlet NSTextField *txf_PORT;
@property (weak) IBOutlet NSButton *btnConnect;
- (IBAction)btn_Connect:(id)sender;
@property (weak) IBOutlet NSButton *btnSendData;
- (IBAction)btn_SendData:(id)sender;
@property (unsafe_unretained) IBOutlet NSTextView *text_Content;

@end

