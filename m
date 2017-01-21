From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 00/13] Input: Automated coccinelle cleanup (take 2)
Date: Sat, 21 Jan 2017 10:45:52 -0800
Message-ID: <1485024365-3368-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:48217 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751012AbdAUSq0 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sat, 21 Jan 2017 13:46:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

This patch series is the result of applying a set of coccinelle semantic
patches to the input subsystem. The patches are only cleanup patches;
there is little or no change in functionality.

This time around, the patches are combined into groups instead of per-file.
Each patch has only a single coccinelle rule applied, and only affects a
single directory in the input subsystem. 

As with the previous patch series, removed calls to platform_set_drvdata()
and i2c_set_clientdata() deserve extra scrutiny from reviewers.

The conversion was done automatically with coccinelle using various semantic
patches. The semantic patches and the scripts used to generate this commit
log are either attached to the commits, or they are available at
https://github.com/groeck/coccinelle-patches.

The series was build tested on kerneltests.org and by the 0day build system.

The patch series is based on v4.10-rc4, with input/next (sha 72d1f2346ded5)
merged on top. For convenience, the series is available at:
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git input-base

----------------------------------------------------------------
Guenter Roeck (13):
      Input: keyboard - Drop calls to platform_set_drvdata and i2c_set_clientdata
      Input: misc - Drop calls to platform_set_drvdata and i2c_set_clientdata
      Input: touchscreen - Drop calls to platform_set_drvdata and i2c_set_clientdata
      Input: keyboard - Use local variables consistently
      Input: misc - Use local variables consistently
      Input: mouse  Use local variables consistently
      Input: rmi4 - Use local variables consistently
      Input: touchscreen - Use local variables consistently
      Input: keyboard - drop unnecessary calls to device_init_wakeup
      Input: misc - drop unnecessary calls to device_init_wakeup
      Input: touchscreen - drop unnecessary calls to device_init_wakeup
      Input: serio - drop unnecessary calls to device_init_wakeup
      Input: misc - drop empty remove functions

 drivers/input/keyboard/adc-keys.c           |  2 --
 drivers/input/keyboard/cap11xx.c            |  1 -
 drivers/input/keyboard/davinci_keyscan.c    |  4 +--
 drivers/input/keyboard/gpio_keys.c          | 26 +++++++---------
 drivers/input/keyboard/gpio_keys_polled.c   |  7 ++---
 drivers/input/keyboard/jornada680_kbd.c     |  2 --
 drivers/input/keyboard/matrix_keypad.c      |  2 --
 drivers/input/keyboard/max7359_keypad.c     |  1 -
 drivers/input/keyboard/mpr121_touchkey.c    | 18 +++++------
 drivers/input/keyboard/nspire-keypad.c      |  2 --
 drivers/input/keyboard/omap4-keypad.c       |  3 --
 drivers/input/keyboard/opencores-kbd.c      |  2 --
 drivers/input/keyboard/samsung-keypad.c     |  2 --
 drivers/input/keyboard/spear-keyboard.c     |  2 --
 drivers/input/keyboard/sun4i-lradc-keys.c   |  1 -
 drivers/input/misc/88pm80x_onkey.c          |  1 -
 drivers/input/misc/arizona-haptics.c        |  2 --
 drivers/input/misc/atmel_captouch.c         |  1 -
 drivers/input/misc/da9063_onkey.c           |  1 -
 drivers/input/misc/drv260x.c                |  2 +-
 drivers/input/misc/e3x0-button.c            |  8 -----
 drivers/input/misc/gp2ap002a00f.c           |  2 --
 drivers/input/misc/gpio_tilt_polled.c       |  2 +-
 drivers/input/misc/hisi_powerkey.c          | 17 +++--------
 drivers/input/misc/pm8941-pwrkey.c          |  1 -
 drivers/input/misc/pmic8xxx-pwrkey.c        |  8 -----
 drivers/input/misc/retu-pwrbutton.c         |  6 ----
 drivers/input/misc/sirfsoc-onkey.c          |  8 -----
 drivers/input/misc/twl4030-pwrbutton.c      |  1 -
 drivers/input/mouse/alps.c                  |  2 +-
 drivers/input/mouse/bcm5974.c               |  2 +-
 drivers/input/mouse/cyapa.c                 |  6 ++--
 drivers/input/mouse/cypress_ps2.c           |  4 +--
 drivers/input/mouse/elan_i2c_core.c         | 46 +++++++++++------------------
 drivers/input/mouse/elantech.c              |  2 +-
 drivers/input/mouse/hgpk.c                  |  5 ++--
 drivers/input/mouse/logips2pp.c             |  2 +-
 drivers/input/mouse/trackpoint.c            |  4 +--
 drivers/input/rmi4/rmi_bus.c                |  4 +--
 drivers/input/rmi4/rmi_driver.c             |  4 +--
 drivers/input/serio/hyperv-keyboard.c       |  1 -
 drivers/input/touchscreen/88pm860x-ts.c     |  3 --
 drivers/input/touchscreen/ads7846.c         |  2 --
 drivers/input/touchscreen/atmel_mxt_ts.c    |  2 +-
 drivers/input/touchscreen/bu21013_ts.c      |  2 --
 drivers/input/touchscreen/colibri-vf50-ts.c |  2 --
 drivers/input/touchscreen/eeti_ts.c         |  1 -
 drivers/input/touchscreen/egalax_ts.c       |  1 -
 drivers/input/touchscreen/fsl-imx25-tcq.c   |  2 +-
 drivers/input/touchscreen/ili210x.c         |  2 +-
 drivers/input/touchscreen/lpc32xx_ts.c      |  1 -
 drivers/input/touchscreen/max11801_ts.c     |  1 -
 drivers/input/touchscreen/pixcir_i2c_ts.c   |  4 +--
 drivers/input/touchscreen/rohm_bu21023.c    |  3 +-
 drivers/input/touchscreen/s3c2410_ts.c      |  2 +-
 drivers/input/touchscreen/st1232.c          |  1 -
 drivers/input/touchscreen/sx8654.c          |  1 -
 57 files changed, 73 insertions(+), 174 deletions(-)
