From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 00/11] Face lift for bu21013_ts driver
Date: Fri,  9 Aug 2019 17:20:28 -0700
Message-ID: <20190810002039.95876-1-dmitry.torokhov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

So your patch has prompted me to take a look at the driver and
try to clean it up. I am sure I screwed up somewhere, but you said
you have the device, so please take a look at the series and
see if you can salvage them

Thanks!

Dmitry Torokhov (10):
  ARM: ux500: improve BU21013 touchpad bindings
  Input: bu21013_ts - rename some variables
  Input: bu21013_ts - annotate supend/resume methods as __maybe_unused
  Input: bu21013_ts - remove useless comments
  Input: bu21013_ts - convert to using managed resources
  Input: bu21013_ts - remove support for platform data
  Input: bu21013_ts - use interrupt from I2C client
  Input: bu21013_ts - fix suspend when wake source
  Input: bu21013_ts - switch to using MT-B (slotted) protocol
  Input: bu21013_ts - switch to using standard touchscreen properties

Linus Walleij (1):
  Input: bu21013_ts - convert to use GPIO descriptors

 .../bindings/input/touchscreen/bu21013.txt    |  27 +-
 arch/arm/boot/dts/ste-hrefprev60-stuib.dts    |  14 +-
 arch/arm/boot/dts/ste-hrefv60plus-stuib.dts   |  14 +-
 drivers/input/touchscreen/bu21013_ts.c        | 740 ++++++++----------
 include/linux/input/bu21013.h                 |  34 -
 5 files changed, 362 insertions(+), 467 deletions(-)
 delete mode 100644 include/linux/input/bu21013.h

-- 
Dmitry
