//
//  ApplicationControl.m
//  VampireDetector
//
//  Created by Michael Bruno on 8/14/15.
//  Copyright (c) 2015 Apollonarius. All rights reserved.
//

#import "ApplicationControl.h"

@implementation ApplicationControl

const float FOCUSRATE = 5.0f;
const float VIDEOW = 1280.0f;
const float VIDEOH = 720.0;

#pragma mark Singleton Methods
- (id)init{
    
    self = [super init];
    
    cwidth = 0;
    cheight = 0;
    swidth = 0;
    sheight = 0;
    colorMode = 1;
    effectMode = false;
    displayState = 0;
    detectionState = 0;
    lightOn = false;
    lightAvailable = false;
    detectionActive = false;
    bufferSize = 0;
    dx = 0;
    dy = 0;
    dist = 0;
    detected = 0;
    FDCLIP_RIGHT = 0.4f;
    FDCLIP_LEFT = 0.25f;
    FDCLIP_TOP = 0.20f;
    FDCLIP_BOTTOM = 0.20f;
    
    
    // assume 1280x720 for video
    
    cwidth = 1280;
    cheight = 720;
    
    //pixels = malloc((1280 * 720) * sizeof(int));
    //detectionPixels = malloc((1280 * 720) * sizeof(int));
    
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGFloat screenWidth = screenRect.size.width * [UIScreen mainScreen].scale;
    CGFloat screenHeight = screenRect.size.height * [UIScreen mainScreen].scale;
    
    swidth = screenWidth;
    sheight = screenHeight;
    
    float aspect = swidth/sheight;
    multi = (float)sheight/(float)cheight;
    
    #ifdef DEBUG
    NSLog(@"Screen aspect is %f, width:%f x height:%f", aspect, swidth, sheight);
    #endif

    displayBounds[0] = 0;
    displayBounds[1] = 0;
    displayBounds[2] = multi * cwidth;
    displayBounds[3] = sheight;
    
    lastx = swidth/2;
    lasty = sheight/2;
    
    return self;
}

+ (ApplicationControl *)getInstance{
    static ApplicationControl *applicationControl = nil;
    @synchronized(self) {
        if (applicationControl == nil)
            applicationControl = [[self alloc] init];
    }
    return applicationControl;
}

- (void)dealloc {
    // Should never be called, but just here for clarity really.
    //free(pixels);
    //free(detectionPixels);
}

@end
