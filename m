From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.21-rc0
Date: Wed, 2 Jan 2019 17:06:36 -0800
Message-ID: <20190103010636.GA189500@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. A tiny pull request this
merge window unfortunately, should get more material in for the next
release.

- new driver for Raspberry Pi's touchscreen (firmware interface)
- miscellaneous input driver fixes

Changelog:
---------

Colin Ian King (1):
      Input: drv2667 - fix indentation issues

Dan Carpenter (1):
      Input: nomadik-ske-keypad - fix a loop timeout test

Hardik Singh Rathore (1):
      Input: touchscreen - fix coding style issue

Linus Walleij (1):
      Input: ad7879 - drop platform data support

Lubomir Rintel (5):
      dt-bindings: marvell,mmp2: Add clock id for the SP clock
      clk: mmp2: add SP clock
      Input: olpc_apsp - drop CONFIG_OLPC dependency
      Input: olpc_apsp - check FIFO status on open(), not probe()
      Input: olpc_apsp - enable the SP clock

Nicolas Saenz Julienne (1):
      Input: add official Raspberry Pi's touchscreen driver

Patrick Dreyer (1):
      Input: elan_i2c - add ACPI ID for touchpad in ASUS Aspire F5-573G

Sanjeev Chugh (1):
      Input: atmel_mxt_ts - don't try to free unallocated kernel memory

Uwe Kleine-König (1):
      Input: rotary-encoder - don't log EPROBE_DEFER to kernel log

YueHaibing (1):
      Input: olpc_apsp - remove set but not used variable 'np'

Diffstat:
--------

 .../input/touchscreen/raspberrypi,firmware-ts.txt  |  26 +++
 .../devicetree/bindings/serio/olpc,ap-sp.txt       |   4 +
 drivers/clk/mmp/clk-of-mmp2.c                      |   4 +
 drivers/input/keyboard/nomadik-ske-keypad.c        |   2 +-
 drivers/input/misc/drv2667.c                       |   6 +-
 drivers/input/misc/rotary_encoder.c                |   6 +-
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/serio/Kconfig                        |   1 -
 drivers/input/serio/olpc_apsp.c                    |  28 ++-
 drivers/input/touchscreen/Kconfig                  |  12 ++
 drivers/input/touchscreen/Makefile                 |   1 +
 drivers/input/touchscreen/ad7879.c                 | 109 +++-------
 drivers/input/touchscreen/atmel_mxt_ts.c           |   4 +-
 drivers/input/touchscreen/ektf2127.c               |   2 +-
 drivers/input/touchscreen/gunze.c                  |   4 +-
 drivers/input/touchscreen/inexio.c                 |   4 +-
 drivers/input/touchscreen/mtouch.c                 |   4 +-
 drivers/input/touchscreen/raspberrypi-ts.c         | 227 +++++++++++++++++++++
 include/dt-bindings/clock/marvell,mmp2.h           |   1 +
 include/linux/platform_data/ad7879.h               |  42 ----
 20 files changed, 347 insertions(+), 141 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
 create mode 100644 drivers/input/touchscreen/raspberrypi-ts.c
 delete mode 100644 include/linux/platform_data/ad7879.h

Thanks.


-- 
Dmitry
