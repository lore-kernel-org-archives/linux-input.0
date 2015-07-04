From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.2-rc0 (round 2)
Date: Sat, 4 Jul 2015 00:01:18 -0700
Message-ID: <20150704070118.GA4902@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive second round of updates for the input subsystem. you will get
a new driver for Weida wdt87xx touch controllers, and a bunch of fixups
for other drivers.

Changelog:
---------

Anshul Garg (1):
      Input: use for_each_set_bit() where appropriate

Dmitry Torokhov (4):
      Input: edt-ft5x06 - mark as direct input device
      Input: improve parsing OF parameters for touchscreens
      Input: wdt87xx_i2c - fix format warning
      Input: wdt87xx_i2c - remove stray newline in diagnostic message

Fabio Estevam (1):
      Input: imx_keypad - check for clk_prepare_enable() error

Hans de Goede (1):
      Input: axp20x-pek - fix reporting button state as inverted

HungNien Chen (2):
      Input: add a driver for wdt87xx touchscreen controller
      Input: wdt87xx_i2c - add a scaling factor for TOUCH_MAJOR event

Pavel Rojtberg (1):
      Input: xpad - re-send LED command on present event

Pierre-Loup A. Griffais (1):
      Input: xpad - set the LEDs properly on XBox Wireless controllers

Sebastian Ott (1):
      Input: arc_ps2 - add HAS_IOMEM dependency


Diffstat:
--------

 drivers/input/input.c                      |   34 +-
 drivers/input/joystick/xpad.c              |   78 +-
 drivers/input/keyboard/imx_keypad.c        |    4 +-
 drivers/input/misc/axp20x-pek.c            |    8 +-
 drivers/input/serio/Kconfig                |    1 +
 drivers/input/touchscreen/Kconfig          |   12 +
 drivers/input/touchscreen/Makefile         |    1 +
 drivers/input/touchscreen/edt-ft5x06.c     |    9 +-
 drivers/input/touchscreen/of_touchscreen.c |   69 +-
 drivers/input/touchscreen/tsc2005.c        |    2 +-
 drivers/input/touchscreen/wdt87xx_i2c.c    | 1149 ++++++++++++++++++++++++++++
 include/linux/input/touchscreen.h          |    5 +-
 12 files changed, 1296 insertions(+), 76 deletions(-)
 create mode 100644 drivers/input/touchscreen/wdt87xx_i2c.c

-- 
Dmitry
