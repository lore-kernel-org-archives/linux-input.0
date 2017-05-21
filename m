From: Wolfram Sang <wsa@the-dreams.de>
Subject: [PATCH 0/4] input: move include files out of include/linux/i2c
Date: Sun, 21 May 2017 22:40:08 +0200
Message-ID: <20170521204013.6623-1-wsa@the-dreams.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from sauhun.de ([88.99.104.3]:55117 "EHLO pokefinder.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752119AbdEUUkT (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Sun, 21 May 2017 16:40:19 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-i2c@vger.kernel.org
Cc: Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-sh@vger.kernel.org

It doesn't make sense to use include/linux/i2c for client drivers which may in
fact rather be hwmon or input or whatever devices. As a result, I want to
deprecate include/linux/i2c for good. This series moves the include files to a
better location, for the input subsystem to include/linux/input. If you prefer
include/linux/platform_data, because that is what most of the moved include
files contain, let me know. Note that some files don't seem to have upstream
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


Wolfram Sang (4):
  input: lm8323: move header file out of I2C realm
  input: mcs: move header file out of I2C realm
  input: mms114: move header file out of I2C realm
  input: tsc2007: move header file out of I2C realm

 arch/sh/boards/mach-ecovec24/setup.c     | 2 +-
 drivers/input/keyboard/lm8323.c          | 2 +-
 drivers/input/keyboard/mcs_touchkey.c    | 2 +-
 drivers/input/touchscreen/mcs5000_ts.c   | 2 +-
 drivers/input/touchscreen/mms114.c       | 2 +-
 drivers/input/touchscreen/tsc2007_core.c | 2 +-
 drivers/mfd/timberdale.c                 | 2 +-
 include/linux/{i2c => input}/lm8323.h    | 0
 include/linux/{i2c => input}/mcs.h       | 0
 include/linux/{i2c => input}/mms114.h    | 0
 include/linux/{i2c => input}/tsc2007.h   | 2 +-
 11 files changed, 8 insertions(+), 8 deletions(-)
 rename include/linux/{i2c => input}/lm8323.h (100%)
 rename include/linux/{i2c => input}/mcs.h (100%)
 rename include/linux/{i2c => input}/mms114.h (100%)
 rename include/linux/{i2c => input}/tsc2007.h (95%)

-- 
2.11.0

