//
//  Tools.m
//  AudioInfo
//
//  Created by 叶世昌 on 2018/10/17.
//  Copyright © 2018 Luomi. All rights reserved.
//

#import "Tools.h"

void SoundfinishedPlaying(SystemSoundID sound_id, void *user_data) {
    AudioServicesRemoveSystemSoundCompletion(sound_id);
    AudioServicesDisposeSystemSoundID(sound_id);
}

