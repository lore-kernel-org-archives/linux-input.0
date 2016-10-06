From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.9-rc0
Date: Wed, 5 Oct 2016 22:42:24 -0700
Message-ID: <20161006054224.GA36340@dtor-ws>
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

to receive updates for the input subsystem. You will get new driver for
Elan eKTF2127 touchscreen controllers; a new "gpio-decoder" driver to
read and report state of several GPIO lines; an ADC resistor ladder
driver; the ft6326 driver is removed because edt-ft5x06 handles the same
devices just fine. Plus regular slew of driver fixes/enhancements. 

Changelog:
---------

Alexandre Belloni (1):
      Input: add ADC resistor ladder driver

Arnd Bergmann (1):
      Input: ektf2127 - mark PM functions as __maybe_unused

Axel Lin (1):
      Input: snvs_pwrkey - drop input_free_device call if input_register_device fails

Baoyou Xie (1):
      Input: focaltech - mark focaltech_set_resolution() static

Benjamin Tissoires (1):
      Input: elan_i2c - fix return tests of i2c_smbus_read_block_data()

Bhaktipriya Shridhar (3):
      Input: psmouse - remove deprecated create_singletheread_workqueue
      Input: mc13783_ts - remove deprecated create_singletheread_workqueue
      Input: wm97xx - remove deprecated create_singletheread_workqueue

Dmitry Torokhov (1):
      Input: jornada720_kbd - switch to using dev_dbg

Hans Verkuil (1):
      Input: serio - add hangup support

Hans de Goede (1):
      Input: remove duplicate ft6236 driver

HungNien Chen (1):
      Input: wdt87xx_i2c - fix the flash erase issue

Johnny Chuang (1):
      Input: elants_i2c - get product id on recovery mode for FW update

Krzysztof Kozlowski (1):
      Input: max77693-haptic - change Krzysztof Kozlowski's email to kernel.org

LABBE Corentin (3):
      Input: pixcir_i2c_ts - simplify code with of_device_get_match_data
      Input: pixcir_i2c_ts - remove text about writing to Free Software Foundation
      Input: pixcir_i2c_ts - remove a useless blank line

Marcin Niestroj (1):
      Input: tps65218-pwrbutton - add support for tps65217 variant

Martin Kepplinger (1):
      Input: pegasus_notetaker - directly include workqueue header

Russell King (4):
      Input: jornada720_kbd - switch to devm_* APIs
      Input: jornada720_kbd - get rid of mach/irqs.h include
      Input: jornada720_kbd - remove unneeded mach/hardware.h include
      Input: jornada720_ts - get rid of mach/irqs.h and mach/hardware.h includes

Siebren Vroegindeweij (1):
      Input: add support for Elan eKTF2127 touchscreen controller

Vignesh R (1):
      Input: add generic input driver to read encoded GPIO lines

Vladimir Zapolskiy (1):
      Input: gpio-keys-polled - don't use unit-address with button nodes


Diffstat:
--------

 .../devicetree/bindings/input/adc-keys.txt         |  49 +++
 .../devicetree/bindings/input/gpio-decoder.txt     |  23 ++
 .../devicetree/bindings/input/gpio-keys-polled.txt |   5 +-
 .../bindings/input/touchscreen/edt-ft5x06.txt      |   8 +
 .../bindings/input/touchscreen/ektf2127.txt        |  27 ++
 .../input/touchscreen/focaltech-ft6236.txt         |  35 ---
 .../bindings/input/tps65218-pwrbutton.txt          |  17 +-
 arch/arm/mach-sa1100/jornada720.c                  |  16 +
 drivers/input/keyboard/Kconfig                     |  15 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/adc-keys.c                  | 210 +++++++++++++
 drivers/input/keyboard/jornada720_kbd.c            |  59 +---
 drivers/input/keyboard/snvs_pwrkey.c               |   1 -
 drivers/input/misc/Kconfig                         |  16 +-
 drivers/input/misc/Makefile                        |   1 +
 drivers/input/misc/gpio_decoder.c                  | 137 +++++++++
 drivers/input/misc/max77693-haptic.c               |   4 +-
 drivers/input/misc/tps65218-pwrbutton.c            |  92 ++++--
 drivers/input/mouse/elan_i2c_smbus.c               |  20 +-
 drivers/input/mouse/focaltech.c                    |   3 +-
 drivers/input/mouse/psmouse-base.c                 |   2 +-
 drivers/input/serio/serport.c                      |  17 +-
 drivers/input/tablet/pegasus_notetaker.c           |   1 +
 drivers/input/touchscreen/Kconfig                  |  25 +-
 drivers/input/touchscreen/Makefile                 |   2 +-
 drivers/input/touchscreen/edt-ft5x06.c             |   8 +
 drivers/input/touchscreen/ektf2127.c               | 336 +++++++++++++++++++++
 drivers/input/touchscreen/elants_i2c.c             |  31 +-
 drivers/input/touchscreen/ft6236.c                 | 326 --------------------
 drivers/input/touchscreen/jornada720_ts.c          |  21 +-
 drivers/input/touchscreen/mc13783_ts.c             |  24 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |  13 +-
 drivers/input/touchscreen/wdt87xx_i2c.c            |   5 +-
 drivers/input/touchscreen/wm97xx-core.c            |   2 +-
 34 files changed, 1033 insertions(+), 519 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/adc-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/gpio-decoder.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ektf2127.txt
 delete mode 100644 Documentation/devicetree/bindings/input/touchscreen/focaltech-ft6236.txt
 create mode 100644 drivers/input/keyboard/adc-keys.c
 create mode 100644 drivers/input/misc/gpio_decoder.c
 create mode 100644 drivers/input/touchscreen/ektf2127.c
 delete mode 100644 drivers/input/touchscreen/ft6236.c

-- 
Dmitry
