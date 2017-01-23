From: Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 0/5] Input: Drop unnecessary calls to input_set_drvdata
Date: Sun, 22 Jan 2017 16:48:19 -0800
Message-ID: <1485132505-14562-1-git-send-email-linux@roeck-us.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:53888 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750704AbdAWAse (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Sun, 22 Jan 2017 19:48:34 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>

If there is not call to dev_get_drvdata() or input_get_drvdata(),
the call to input_set_drvdata() is unnecessary and can be dropped.

The series was build tested on kerneltests.org and by the 0day build system.

The patch series is based on v4.10-rc4, with input/next (sha 2de8b4110c82)
merged on top. For convenience, the series is available at:
	git://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git input-base

----------------------------------------------------------------
Guenter Roeck (5):
      Input: keyboard - drop unnecessary calls to input_set_drvdata
      Input: joystick/maplecontrol - drop unnecessary call to input_set_drvdata
      Input: mouse - drop unnecessary calls to input_set_drvdata
      Input: misc/dm355evm_keys - drop unnecessary call to input_set_drvdata
      Input: touchscreen - drop unnecessary calls to input_set_drvdata

 drivers/input/joystick/maplecontrol.c      | 1 -
 drivers/input/keyboard/adp5520-keys.c      | 2 --
 drivers/input/keyboard/bf54x-keys.c        | 2 --
 drivers/input/keyboard/maple_keyb.c        | 1 -
 drivers/input/keyboard/opencores-kbd.c     | 2 --
 drivers/input/keyboard/tca8418_keypad.c    | 2 --
 drivers/input/keyboard/tm2-touchkey.c      | 2 --
 drivers/input/misc/dm355evm_keys.c         | 2 --
 drivers/input/mouse/cypress_ps2.c          | 2 --
 drivers/input/mouse/maplemouse.c           | 1 -
 drivers/input/touchscreen/edt-ft5x06.c     | 1 -
 drivers/input/touchscreen/egalax_ts.c      | 2 --
 drivers/input/touchscreen/elants_i2c.c     | 2 --
 drivers/input/touchscreen/ili210x.c        | 1 -
 drivers/input/touchscreen/mcs5000_ts.c     | 1 -
 drivers/input/touchscreen/raydium_i2c_ts.c | 2 --
 16 files changed, 26 deletions(-)
