#import "XPCService.h"
#import "SMCObjC.h"
#import <Foundation/Foundation.h>
#import <Cocoa/Cocoa.h>

@implementation XPCService

- (void)calculateTemp:_ withReply:(void (^)(double))reply {
    double response = SMCObjC.calculateTemp;
    reply(response);
}

- (void)purgeCacheMemory {
    NSTask *task;
    task = [[NSTask alloc] init];
    [task setLaunchPath: @"/usr/sbin/purge"];
    [task launch];
}

@end
