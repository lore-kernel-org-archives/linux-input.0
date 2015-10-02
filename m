From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.3-rc3
Date: Fri, 2 Oct 2015 13:27:00 -0700
Message-ID: <20151002202700.GA14012@dtor-ws>
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

to receive updates for the input subsystem. You will get fixes for 2
recent regressions (in Synaptics PS/2 and uinput drivers) and some more
driver fixups.

Changelog:
---------

Andrew Morton (1):
      Input: zhenhua - ensure we have BITREVERSE

Daniel Drake (1):
      Input: elan_i2c - don't require known iap version

Daniel Martin (1):
      Input: fix typo in MT documentation

Dmitry Torokhov (3):
      Input: walkera0701 - fix abs() calculations on 64 bit values
      Input: uinput - fix crash when using ABS events
      Revert "Input: synaptics - fix handling of disabling gesture mode"

Dmitry Vyukov (1):
      Input: psmouse - fix data race in __ps2_command

Dudley Du (1):
      Input: cyapa - fix address of Gen3 devices in device tree documentation

Duson Lin (2):
      Input: elan_i2c - add ic type 0x03
      Input: elan_i2c - expand maximum product_id form 0xFF to 0xFFFF

Fabio Estevam (4):
      Input: imx6ul_tsc - propagate the errors
      Input: imx6ul_tsc - check for negative return value
      Input: imx6ul_tsc - use the preferred method for kzalloc()
      Input: imx6ul_tsc - fix controller name

Javier Martinez Canillas (2):
      Input: pm8941-pwrkey - remove unneded semicolon
      Input: mms114 - remove unneded semicolons

Sudip Mukherjee (2):
      Input: serio - fix blocking of parport
      Input: omap4-keypad - fix memory leak

duson (1):
      Input: elan_i2c - add all valid ic type for i2c/smbus


Diffstat:
--------

 .../devicetree/bindings/input/cypress,cyapa.txt    |  2 +-
 Documentation/input/multi-touch-protocol.txt       |  2 +-
 drivers/input/joystick/walkera0701.c               |  4 +--
 drivers/input/keyboard/omap4-keypad.c              |  2 +-
 drivers/input/misc/pm8941-pwrkey.c                 |  2 +-
 drivers/input/misc/uinput.c                        |  2 +-
 drivers/input/mouse/elan_i2c.h                     |  2 +-
 drivers/input/mouse/elan_i2c_core.c                | 26 ++++++++++++-----
 drivers/input/mouse/elan_i2c_i2c.c                 |  4 +--
 drivers/input/mouse/elan_i2c_smbus.c               |  4 +--
 drivers/input/mouse/synaptics.c                    | 12 +++-----
 drivers/input/serio/libps2.c                       | 22 +++++++++-----
 drivers/input/serio/parkbd.c                       |  1 +
 drivers/input/touchscreen/imx6ul_tsc.c             | 34 ++++++++++++++--------
 drivers/input/touchscreen/mms114.c                 |  4 +--
 15 files changed, 74 insertions(+), 49 deletions(-)

-- 
Dmitry
