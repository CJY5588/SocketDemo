//
//  ViewController.m
//  SocketClient
//
//  Created by jianyi.chen on 2021/12/17.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btnSendData.enabled = false;
    _txf_IP.enabled = true;
    _txf_PORT.enabled = true;
    isConnect = false;
    // Do any additional setup after loading the view.
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (void)socket:(GCDAsyncSocket *)sock didConnectToHost:(NSString *)host port:(uint16_t)port {
    NSLog(@"%s %d", __FUNCTION__, __LINE__);
    [sendSocket readDataWithTimeout:-1 tag:0];
}

- (void)onSocket:(GCDAsyncSocket *)sock didWriteDataWithTag:(long)tag
{
    NSLog(@"%s %d, tag = %ld", __FUNCTION__, __LINE__, tag);

    [sendSocket readDataWithTimeout:-1 tag:0];
}

// 这里必须要使用流式数据
- (void)onSocket:(GCDAsyncSocket *)sock didReadData:(NSData *)data withTag:(long)tag
{
    NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];

    NSLog(@"%s %d, msg = %@", __FUNCTION__, __LINE__, msg);

    [sendSocket readDataWithTimeout:-1 tag:0];
}

- (void)onSocketDidDisconnect:(GCDAsyncSocket *)sock
{
    NSLog(@"%s %d", __FUNCTION__, __LINE__);

    sendSocket = nil;
}

- (IBAction)btn_Connect:(id)sender {
    
    if ([_txf_IP.stringValue isEqualToString:@""] || [_txf_PORT.stringValue isEqualToString:@""]) {
        return;
    }
    if ([[sender title] isEqualToString:@"Connect"]) {
        if (!sendSocket)
        {
            socketQueue = dispatch_queue_create("socketQueue", NULL);
            sendSocket = [[GCDAsyncSocket alloc] initWithDelegate:self delegateQueue:socketQueue];

            NSError *error;
            
            isConnect = [sendSocket connectToHost:_txf_IP.stringValue onPort:[_txf_PORT.stringValue intValue] error: &error];
            
            if (!isConnect)
            {
                NSLog(@"connect error: %@", error);
                return;
            }
            _btnConnect.title = @"DisConnect";
            _btnSendData.enabled = true;
            _txf_IP.enabled = false;
            _txf_PORT.enabled = false;
            [self.view.window makeFirstResponder:self.text_Content];
        }
    }else {
        [sendSocket disconnect];
        sendSocket = nil;
        isConnect = false;
        _btnSendData.enabled = false;
        _txf_IP.enabled = true;
        _txf_PORT.enabled = true;
        _btnConnect.title = @"Connect";
    }
}
- (IBAction)btn_SendData:(id)sender {
    NSData* data = [[NSString stringWithFormat:@"%@\r\n", _text_Content.string] dataUsingEncoding: NSUTF8StringEncoding];
   
    if (isConnect) {
        [sendSocket writeData: data withTimeout: -1 tag: 0];
    }
}
@end
