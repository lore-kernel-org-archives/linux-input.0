From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.8-rc0 (round 2)
Date: Fri, 5 Aug 2016 19:21:04 -0700
Message-ID: <20160806022104.GA20562@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f67.google.com ([209.85.220.67]:35196 "EHLO
	mail-pa0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750933AbcHFWsj (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Aug 2016 18:48:39 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates more for the input subsystem. You will get 2 more
new drivers for touchscreen controllers:

- Silead touchscreen controllers
- SiS 9200 family touchscreen controllers

and a few driver fixes.

Changelog:
---------

Arnd Bergmann (1):
      Input: sis-i2c - select CONFIG_CRC_ITU_T

Benjamin Tissoires (1):
      Input: elantech - fix debug dump of the current packet

Cameron Gutman (1):
      Input: xpad - power off wireless 360 controllers on suspend

Dan Carpenter (1):
      Input: silead - remove some dead code

Dmitry Torokhov (2):
      Input: i8042 - break load dependency between atkbd/psmouse and i8042
      Input: ili210x - fix permissions on "calibrate" attribute

Douglas Anderson (1):
      Input: cros_ec_keyb - cleanup use of dev

KT Liao (1):
      Input: elan_i2c - properly wake up touchpad on ASUS laptops

Markus Elfring (1):
      Input: synaptics-rmi4 - do not check for NULL when calling of_node_put()

Mika Penttilä (1):
      Input: add driver for SiS 9200 family I2C touchscreen controllers

Robert Dolca (1):
      Input: add driver for Silead touchscreens

Uwe Kleine-König (1):
      Input: rotary_encoder - support binary encoding of states


Diffstat:
--------

 .../devicetree/bindings/input/rotary-encoder.txt   |   4 +
 .../bindings/input/touchscreen/silead_gsl1680.txt  |  36 ++
 .../bindings/input/touchscreen/sis_i2c.txt         |  33 ++
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/joystick/xpad.c                      |  43 ++
 drivers/input/keyboard/cros_ec_keyb.c              |  19 +-
 drivers/input/misc/rotary_encoder.c                |  23 +-
 drivers/input/mouse/elan_i2c_core.c                |  79 ++-
 drivers/input/mouse/elantech.c                     |   8 +-
 drivers/input/rmi4/rmi_bus.c                       |   5 +-
 drivers/input/serio/i8042.c                        |  16 +-
 drivers/input/serio/libps2.c                       |  10 +-
 drivers/input/touchscreen/Kconfig                  |  25 +
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/ili210x.c                |   2 +-
 drivers/input/touchscreen/silead.c                 | 565 +++++++++++++++++++++
 drivers/input/touchscreen/sis_i2c.c                | 413 +++++++++++++++
 include/linux/i8042.h                              |   6 -
 include/linux/serio.h                              |  24 +-
 19 files changed, 1244 insertions(+), 70 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/silead_gsl1680.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/sis_i2c.txt
 create mode 100644 drivers/input/touchscreen/silead.c
 create mode 100644 drivers/input/touchscreen/sis_i2c.c

-- 
Dmitry

