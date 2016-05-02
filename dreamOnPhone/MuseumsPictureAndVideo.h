//
//  MuseumsPictureAndVideo.h
//  dreamOnPhone
//
//  Created by admin on 16/1/8.
//  Copyright © 2016年 xukun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface MuseumsPictureAndVideo : UIViewController<NSURLConnectionDataDelegate,UIPopoverControllerDelegate>


    {
        NSMutableData * receiveData;
        AVAudioPlayer * player;
        UIProgressView * progress;
        CGFloat allLength;
        
    }
@property(strong,nonatomic) NSString  *ider;

@end
