From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/1] hid: move include files out of include/linux/i2c
Date: Sun, 21 May 2017 22:30:32 +0200
Message-ID: <20170521203033.6146-1-wsa@the-dreams.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, largely include/platform_data because that is what most of the
moved include files contain. Note that some files don't seem to have upstream
users in board code, so they maybe could even be removed? I didn't check for
that now, but I did it for one i2c master driver recently. So, it may be
possible.

I prefer the series to go upstream via the subsystem tree; if you prefer that I
take it via I2C, just let me know.

No runtime testing because of no HW, but buildbot is happy with this series at
least. A branch can be found here:

git://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/platform_data

Thanks and kind regards,

   Wolfram


Wolfram Sang (1):
  hid: i2c-hid: move header file out of I2C realm

 drivers/hid/i2c-hid/i2c-hid.c                  | 2 +-
 include/linux/{i2c => platform_data}/i2c-hid.h | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename include/linux/{i2c => platform_data}/i2c-hid.h (100%)

-- 
2.11.0
