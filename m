From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.3-rc0
Date: Thu, 11 Jul 2019 22:41:58 -0700
Message-ID: <20190712052744.GA138448@dtor-ws>
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

- an update to Elan touchpad SMBus driver to fetch device parameters
  (size, resolution) while it is still in PS/2 mode, before switching
  over to SMBus, as in that mode some devices return garbage dimensions
- update to iforce joystick driver
- miscellaneous driver fixes

Note that there will be a conflict in drivers/input/misc/da9063_onkey.c
regarding SPDX header, please keep SPDX annotation that is already in
your tree.

Also, I am still hoping to merge applespi keyboard and trackpad driver
in the 2nd pass for this merge window.

Changelog:
---------

Alexander Tsoy (1):
      Input: joydev - extend absolute mouse detection

Anson Huang (2):
      Input: imx_keypad - use devm_platform_ioremap_resource() to simplify code
      Input: imx6ul_tsc - use devm_platform_ioremap_resource() to simplify code

Axel Lin (1):
      Input: iqs5xx - remove redundant dev_set_drvdata call

Bartosz Golaszewski (1):
      Input: max77650-onkey - add MODULE_ALIAS()

Benjamin Tissoires (8):
      Input: elantech - query the min/max information beforehand too
      Input: elantech - add helper function elantech_is_buttonpad()
      Input: elantech - detect middle button based on firmware version
      dt-bindings: add more optional properties for elan_i2c touchpads
      Input: elan_i2c - do not query the info if they are provided
      Input: elantech/SMBus - export all capabilities from the PS/2 node
      Input: elan_i2c - handle physical middle button
      Input: elantech - remove P52 and P72 from SMBus blacklist

Cole Rogers (1):
      Input: synaptics - enable SMBUS on T480 thinkpad trackpad

Daniel Mack (1):
      Input: eeti_ts -  read hardware state once after wakeup

Dmitry Torokhov (21):
      Input: iforce - remove "being used" silliness
      Input: iforce - introduce transport ops
      Input: iforce - move get_id to the transport operations
      Input: iforce - move command completion handling to serio code
      Input: iforce - introduce start and stop io transport ops
      Input: iforce - add bus type and parent arguments to iforce_init_device()
      Input: iforce - move transport data into transport modules
      Input: iforce - split into core and transport modules
      Input: iforce - use DMA-safe buffer when getting IDs from USB
      Input: iforce - update formatting of switch statements
      Input: iforce - factor out hat handling when parsing packets
      Input: iforce - do not combine arguments for iforce_process_packet()
      Input: iforce - signal command completion from transport code
      Input: iforce - only call iforce_process_packet() if initialized
      Input: iforce - allow callers supply data buffer when fetching device IDs
      Input: iforce - use DMA-safe buffores for USB transfers
      Input: iforce - drop bus type from iforce structure
      Input: iforce - drop couple of temps from transport code
      Input: iforce - use unaligned accessors, where appropriate
      Input: edt-ft5x06 - use get_unaligned_be16()
      Input: edt-ft5x06 - simplify event reporting code

Enrico Weigelt, metux IT consult (1):
      Input: gpio_keys_polled - allow specifying name of input device

Gustavo A. R. Silva (2):
      Input: gpio_keys_polled - use struct_size() in devm_kzalloc()
      Input: gpio_keys - use struct_size() in devm_kzalloc()

Ian Ray (1):
      Input: atmel_mxt_ts - fix leak in mxt_update_cfg()

Jeffrey Hugo (2):
      Input: elan_i2c - export the device id whitelist
      HID: quirks: Refactor ELAN 400 and 401 handling

Nathan Huckleberry (1):
      Input: atmel_mxt_ts - fix -Wunused-const-variable

Tim Schumacher (1):
      Input: iforce - add the Saitek R440 Force Wheel

Wolfram Sang (2):
      Input: da9063_onkey - remove platform_data support
      Input: da9063_onkey - convert header to SPDX

YueHaibing (2):
      Input: synaptics-rmi4 - remove set but not used variable 'sensor_flags'
      Input: tca8418 - remove set but not used variable 'max_keys'

Diffstat:
--------

 .../devicetree/bindings/input/elan_i2c.txt         |  11 +
 drivers/hid/hid-quirks.c                           |  22 +-
 drivers/input/joydev.c                             |  24 +-
 drivers/input/joystick/iforce/Kconfig              |   8 +-
 drivers/input/joystick/iforce/Makefile             |   7 +-
 drivers/input/joystick/iforce/iforce-ff.c          |  18 +-
 drivers/input/joystick/iforce/iforce-main.c        | 178 ++++--------
 drivers/input/joystick/iforce/iforce-packets.c     | 215 +++++---------
 drivers/input/joystick/iforce/iforce-serio.c       | 161 ++++++++---
 drivers/input/joystick/iforce/iforce-usb.c         | 192 ++++++++----
 drivers/input/joystick/iforce/iforce.h             |  55 ++--
 drivers/input/keyboard/gpio_keys.c                 |   6 +-
 drivers/input/keyboard/gpio_keys_polled.c          |  10 +-
 drivers/input/keyboard/imx_keypad.c                |   4 +-
 drivers/input/keyboard/tca8418_keypad.c            |   3 +-
 drivers/input/misc/da9063_onkey.c                  |  11 +-
 drivers/input/misc/max77650-onkey.c                |   1 +
 drivers/input/mouse/elan_i2c_core.c                | 122 ++++----
 drivers/input/mouse/elantech.c                     | 322 +++++++++++----------
 drivers/input/mouse/elantech.h                     |   8 +
 drivers/input/mouse/synaptics.c                    |   1 +
 drivers/input/rmi4/rmi_f12.c                       |   6 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |  23 +-
 drivers/input/touchscreen/edt-ft5x06.c             |  18 +-
 drivers/input/touchscreen/eeti_ts.c                |  71 ++++-
 drivers/input/touchscreen/imx6ul_tsc.c             |   8 +-
 drivers/input/touchscreen/iqs5xx.c                 |   2 -
 include/linux/input/elan-i2c-ids.h                 |  76 +++++
 28 files changed, 872 insertions(+), 711 deletions(-)
 create mode 100644 include/linux/input/elan-i2c-ids.h

Thanks.


-- 
Dmitry
