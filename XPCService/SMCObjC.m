#import "AlPanel-Bridging-Header.h"
#import "SMCObjC.h"
#import "lib/smc.h"

@implementation SMCObjC : NSObject

+(double)calculateTemp {
    double value = calculate();
    return value;
}

@end
