From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.1-rc0
Date: Sat, 9 Mar 2019 18:34:27 -0800
Message-ID: <20190310023427.GA68528@dtor-ws>
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

to receive updates for the input subsystem. You will get:

- update to ili210x touchscreen driver, refreshing the code and adding
  support for ILI251X line
- update to st1232 touchscreen driver adding support for st1633 model
- sx8654 touchscreen driver gained support for sx8650 model
- edt-ft5x06 touchscreen driver gained support for Evervision FT5726
- Goodix touchscreen driver can now support gt5688
- new vibrator driver for MSM SOCs
- miscellaneous fixes for the rest of input drivers

Thanks!

Changelog:
---------

Aditya Pakki (1):
      Input: ad7879 - add check for read errors in interrupt

Arnd Bergmann (2):
      Input: msm-vibrator - use correct gpio header
      Input: raspberrypi-ts - select CONFIG_INPUT_POLLDEV

Brian Masney (1):
      Input: add new vibrator driver for various MSM SOCs

Dan Carpenter (1):
      Input: msm-vibrator - tweak an error message

Dmitry Torokhov (5):
      Input: sx8654 - do not override interrupt trigger
      Input: ili210x - switch to using devm_device_add_group()
      Input: stmfts - acknowledge that setting brightness is a blocking call
      Input: tm2-touchkey - acknowledge that setting brightness is a blocking call
      Input: ims-pcu - switch to using brightness_set_blocking()

Florian Fainelli (1):
      Input: gpio-keys - add shutdown callback

Guido Günther (3):
      Input: goodix - support Goodix gt5688
      Input: goodix - refer to touchscreen.txt in device tree bindings
      Input: goodix - print values in case of inconsistencies

Gustavo A. R. Silva (3):
      Input: tca6416-keypad - use struct_size() in kzalloc()
      Input: mcs_touchkey - use struct_size() in kzalloc()
      Input: db9 - mark expected switch fall-through

Hans de Goede (2):
      Input: soc_button_array - add usage-page 0x01 usage-id 0xca mapping
      Input: soc_button_array - fix mapping of the 5th GPIO in a PNP0C40 device

Jason Gerecke (1):
      Input: wacom_serial4 - add support for Wacom ArtPad II tablet

Jonathan Bakker (3):
      Input: tm2-touchkey - correct initial brightness
      Input: tm2-touchkey - allow specifying custom keycodes
      Input: tm2-touchkey - add support for aries touchkey variant

Marco Felsch (3):
      Input: edt-ft5x06 - add support for Evervision FT5726
      Input: edt-ft5x06 - add support to update ev-ft5726 registers
      Input: edt-ft5x06 - add offset support for ev-ft5726

Marek Vasut (11):
      Input: ili210x - add DT binding document
      Input: ili210x - drop platform data support
      Input: ili210x - drop get_pendown_state
      Input: ili210x - convert to devm_ functions
      Input: ili210x - add reset GPIO support
      Input: ili210x - convert to devm IRQ
      Input: ili210x - rework the touchscreen sample processing
      Input: ili210x - reorder probe
      Input: ili210x - add OF match table
      Input: ili210x - add ILI251X support
      Input: ili210x - fetch touchscreen geometry from DT

Martin Kepplinger (3):
      Input: st1232 - add support for st1633
      Input: st1232 - add Martin as module author
      Input: st1232 - switch to gpiod API

Matthias Fend (1):
      Input: st1232 - handle common DT bindings

Richard Leitner (5):
      Input: sx8654 - add reset-gpio support
      Input: sx8654 - add sx8655 and sx8656 to compatibles
      Input: sx8654 - add sx8650 support
      Input: sx8654 - use common of_touchscreen functions
      Input: sx8654 - convert #defined flags to BIT(x)

Rob Herring (1):
      Input: i8042 - rework DT node name comparisons

Simon Shields (1):
      Input: tm2-touchkey - add support for midas touchkey

Sven Van Asbroeck (2):
      Input: qt2160 - remove redundant spinlock
      Input: synaptics_i2c - remove redundant spinlock

Vincent Batts (1):
      Input: elan_i2c - add id for touchpad found in Lenovo s21e-20

YueHaibing (2):
      Input: mtk-pmic-keys - remove duplicated include from mtk-pmic-keys.c
      Input: ti_am335x_tsc - remove set but not used variable 'tscadc_dev'

Diffstat:
--------

 .../bindings/input/cypress,tm2-touchkey.txt        |   9 +-
 .../devicetree/bindings/input/ilitek,ili2xxx.txt   |  25 ++
 .../devicetree/bindings/input/msm-vibrator.txt     |  36 +++
 .../bindings/input/touchscreen/edt-ft5x06.txt      |  13 +-
 .../bindings/input/touchscreen/goodix.txt          |  14 +-
 .../bindings/input/touchscreen/sitronix-st1232.txt |   8 +-
 .../bindings/input/touchscreen/sx8654.txt          |  10 +-
 drivers/input/joystick/db9.c                       |   2 +-
 drivers/input/keyboard/gpio_keys.c                 |  10 +
 drivers/input/keyboard/mcs_touchkey.c              |   5 +-
 drivers/input/keyboard/mtk-pmic-keys.c             |  13 +-
 drivers/input/keyboard/qt2160.c                    |   9 -
 drivers/input/keyboard/tca6416-keypad.c            |   4 +-
 drivers/input/keyboard/tm2-touchkey.c              | 136 ++++++---
 drivers/input/misc/Kconfig                         |  10 +
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/ims-pcu.c                       |  27 +-
 drivers/input/misc/msm-vibrator.c                  | 281 ++++++++++++++++++
 drivers/input/misc/soc_button_array.c              |   6 +-
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/mouse/synaptics_i2c.c                |  22 +-
 drivers/input/serio/i8042-sparcio.h                |  21 +-
 drivers/input/tablet/wacom_serial4.c               |   2 +
 drivers/input/touchscreen/Kconfig                  |   7 +-
 drivers/input/touchscreen/ad7879.c                 |  11 +-
 drivers/input/touchscreen/edt-ft5x06.c             | 110 ++++++-
 drivers/input/touchscreen/goodix.c                 |   6 +-
 drivers/input/touchscreen/ili210x.c                | 321 +++++++++++++--------
 drivers/input/touchscreen/st1232.c                 | 154 ++++++----
 drivers/input/touchscreen/stmfts.c                 |  30 +-
 drivers/input/touchscreen/sx8654.c                 | 255 ++++++++++++++--
 drivers/input/touchscreen/ti_am335x_tsc.c          |   4 -
 include/linux/input/ili210x.h                      |  11 -
 33 files changed, 1207 insertions(+), 367 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ilitek,ili2xxx.txt
 create mode 100644 Documentation/devicetree/bindings/input/msm-vibrator.txt
 create mode 100644 drivers/input/misc/msm-vibrator.c
 delete mode 100644 include/linux/input/ili210x.h

Thanks.


-- 
Dmitry
