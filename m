From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.13-rc0
Date: Sat, 8 Jul 2017 09:52:15 -0700
Message-ID: <20170708165215.GA12908@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f194.google.com ([209.85.192.194]:34407 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752843AbdGHQwT (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Sat, 8 Jul 2017 12:52:19 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new driver for STM FingerTip touchscreen

- a new driver for D-Link DIR-685 touch keys

- updated list of supported devices in xpad driver

- other assorted updates and fixes.

Changelog:
---------

Andi Shyti (1):
      Input: add support for the STMicroelectronics FingerTip touchscreen

Arnd Bergmann (1):
      Input: stmfts - mark all PM functions as __maybe_unused

Arvind Yadav (1):
      Input: s3c2410_ts - handle return value of clk_prepare_enable

Benjamin Valentin (2):
      Input: xpad - sync supported devices with 360Controller
      Input: xpad - sync supported devices with XBCD

Dan Carpenter (1):
      Input: synaptics-rmi4 - change a char type to u8

Dmitry Torokhov (5):
      Input: elan_i2c - check if device is there before really probing
      Input: sparse-keymap - remove sparse_keymap_free()
      Input: synaptics-rmi4 - use %phN to form F34 configuration ID
      Input: introduce KEY_ASSISTANT
      MAINTAINERS: update input subsystem patterns

Hans de Goede (1):
      Input: axp20x-pek - add wakeup support

KT Liao (2):
      Input: elan_i2c - add support for fetching chip type on newer hardware
      Input: elantech - force relative mode on a certain module

Linus Walleij (1):
      Input: add D-Link DIR-685 touchkeys driver

Markus Elfring (3):
      Input: use seq_putc() in input_seq_print_bitmap()
      Input: use seq_puts() in input_devices_seq_show()
      Input: switch to using sizeof(*type) when allocating memory

Oleksandr Andrushchenko (1):
      Input: xen-kbdfront - use string constants from PV protocol

Wolfram Sang (4):
      Input: lm8323 - move header file out of I2C realm
      Input: mcs - move header file out of I2C realm
      Input: mms114 - move header file out of I2C realm
      Input: tsc2007 - move header file out of I2C realm

Diffstat:
--------

 .../bindings/input/dlink,dir685-touchkeys.txt      |  21 +
 .../bindings/input/touchscreen/st,stmfts.txt       |  43 ++
 MAINTAINERS                                        |   8 +
 arch/sh/boards/mach-ecovec24/setup.c               |   2 +-
 drivers/input/input.c                              |  12 +-
 drivers/input/joystick/xpad.c                      |  87 +++
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/dlink-dir685-touchkeys.c    | 155 ++++
 drivers/input/keyboard/lm8323.c                    |   2 +-
 drivers/input/keyboard/mcs_touchkey.c              |   2 +-
 drivers/input/misc/axp20x-pek.c                    |  28 +
 drivers/input/misc/xen-kbdfront.c                  |  22 +-
 drivers/input/mouse/elan_i2c.h                     |   3 +-
 drivers/input/mouse/elan_i2c_core.c                |  40 +-
 drivers/input/mouse/elan_i2c_i2c.c                 |  71 +-
 drivers/input/mouse/elan_i2c_smbus.c               |   9 +-
 drivers/input/mouse/elantech.c                     |  11 +
 drivers/input/rmi4/rmi_f34v7.c                     |  24 +-
 drivers/input/sparse-keymap.c                      |  14 -
 drivers/input/touchscreen/Kconfig                  |  11 +
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/mcs5000_ts.c             |   2 +-
 drivers/input/touchscreen/mms114.c                 |   2 +-
 drivers/input/touchscreen/s3c2410_ts.c             |   8 +-
 drivers/input/touchscreen/stmfts.c                 | 822 +++++++++++++++++++++
 drivers/input/touchscreen/tsc2007_core.c           |   2 +-
 drivers/mfd/timberdale.c                           |   2 +-
 include/linux/input/sparse-keymap.h                |   1 -
 include/linux/{i2c => platform_data}/lm8323.h      |   0
 include/linux/{i2c => platform_data}/mcs.h         |   0
 include/linux/{i2c => platform_data}/mms114.h      |   0
 include/linux/{i2c => platform_data}/tsc2007.h     |   2 +-
 include/uapi/linux/input-event-codes.h             |   1 +
 34 files changed, 1349 insertions(+), 71 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/dlink,dir685-touchkeys.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/st,stmfts.txt
 create mode 100644 drivers/input/keyboard/dlink-dir685-touchkeys.c
 create mode 100644 drivers/input/touchscreen/stmfts.c
 rename include/linux/{i2c => platform_data}/lm8323.h (100%)
 rename include/linux/{i2c => platform_data}/mcs.h (100%)
 rename include/linux/{i2c => platform_data}/mms114.h (100%)
 rename include/linux/{i2c => platform_data}/tsc2007.h (94%)

Thanks.


-- 
Dmitry
