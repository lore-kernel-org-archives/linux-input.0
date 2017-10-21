From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.14-rc5
Date: Sat, 21 Oct 2017 15:19:32 -0700
Message-ID: <20171021221932.p4m6slpg5sajvn4k@dtor-ws>
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

to receive updates for the input subsystem. You will get:

- joydev now implements a blacklist to avoid creating joystick nodes for
  accelerometers found in composite devices such as PlaStation
  controllers

- assorted driver fixes.

Changelog:
---------

Andrew Duggan (1):
      Input: synaptics - disable kernel tracking on SMBus devices

Chanwoo Choi (1):
      Input: stmfts - fix setting ABS_MT_POSITION_* maximum size

Damien Riegel (1):
      Input: tca8418 - enable interrupt after it has been requested

Dmitry Torokhov (3):
      Input: factor out and export input_device_id matching code
      Input: allow matching device IDs on property bits
      Input: ims-psu - check if CDC union descriptor is sane

Hans de Goede (1):
      Input: axp20x-pek - fix module not auto-loading for axp221 pek

Jeff Lance (1):
      Input: ti_am335x_tsc - fix incorrect step config for 5 wire touchscreen

Paul Cercueil (1):
      Input: goodix - poll the 'buffer status' bit before reading data

Roderick Colenbrander (1):
      Input: joydev - blacklist ds3/ds4/udraw motion sensors

Diffstat:
--------

 drivers/input/input.c                     | 84 ++++++++++++++-----------------
 drivers/input/joydev.c                    | 70 +++++++++++++++++++++++---
 drivers/input/keyboard/tca8418_keypad.c   | 29 ++++++-----
 drivers/input/misc/axp20x-pek.c           |  2 +-
 drivers/input/misc/ims-pcu.c              | 16 +++++-
 drivers/input/mouse/synaptics.c           |  3 +-
 drivers/input/touchscreen/goodix.c        | 67 +++++++++++++++---------
 drivers/input/touchscreen/stmfts.c        |  6 +--
 drivers/input/touchscreen/ti_am335x_tsc.c |  2 +-
 include/linux/input.h                     |  7 +++
 include/linux/mod_devicetable.h           |  3 ++
 scripts/mod/devicetable-offsets.c         |  1 +
 scripts/mod/file2alias.c                  |  6 ++-
 13 files changed, 199 insertions(+), 97 deletions(-)

Thanks.


-- 
Dmitry
