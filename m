From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.3-rc0
Date: Fri, 4 Sep 2015 11:44:47 -0700
Message-ID: <20150904184447.GA5836@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:36414 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755488AbbIDSou (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 4 Sep 2015 14:44:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive first round of updates for the input subsystem. Drivers,
drivers, drivers...  No interesting input core changes this time.

Changelog:
---------

Anshul Garg (3):
      Input: joydev - use for_each_set_bit where appropriate
      Input: ff-core - use for_each_set_bit where appropriate
      Input: uinput - switch to using for_each_set_bit()

Axel Lin (1):
      Input: drv260x/drv2665/drv2667 - constify reg_default tables

Benjamin Tissoires (1):
      Input: elan_i2c - enable ELAN0600 acpi panels

Benson Leung (1):
      Input: elan_i2c - fix typos for validpage_count

Dan Carpenter (1):
      Input: sentelic - silence some underflow warnings

Dirk Behme (3):
      Input: zforce_ts - convert to use the gpiod interface
      Input: zforce - don't invert the interrupt GPIO
      Input: zforce - make the interrupt GPIO optional

Dmitry Torokhov (20):
      Input: of_touchscreen - always issue warning if axis is not set up
      Input: of_touchscreen - fix setting max values on X/Y axis
      Input: of_touchscreen - switch to using device properties
      Input: pixcir_i2c_ts - move platform data
      Input: pixcir_i2c_ts - switch the device over to gpiod
      Input: pixcir_i2c_ts - allow using with GPIO expanders
      Input: pixcir_i2c_ts - simplify input device initialization
      Input: pixcir_i2c_ts - use standard OF touchscreen parsing code
      Input: matrix_keypad - change name of wakeup property to "wakeup-source"
      Input: ads7846 - change name of wakeup property to "wakeup-source"
      Input: pmic8xxx-keypad - change name of wakeup property
      Input: gpio_keys[_polled] - change name of wakeup property
      Input: samsung-keypad - change name of wakeup property
      Input: tc3589x-keypad - change name of wakeup property
      Input: arizona-haptic - convert to use managed input devices
      Input: do not emit unneeded EV_SYN when suspending
      Input: elants_i2c - wire up regulator support
      Input: elants_i2c - enable asynchronous probing
      Input: elan_i2c - enable asynchronous probing
      Input: synaptics - fix handling of disabling gesture mode

Dudley Du (8):
      Input: cyapa - rename 'gen5' to 'pip' for chared code
      Input: cyapa - add gen6 device module support
      Input: cyapa - add proximity support for gen5 and gen6 modules
      Input: cyapa - fully support runtime suspend power management
      Input: cyapa - add ACPI HID CYAP0002 for Gen6 devices
      Input: cyapa - add regulator vcc support
      Input: cyapa - introduce device tree binding
      Input: cyapa - do not try to enable proximity reporting on older devices

Duson Lin (1):
      Input: elan_i2c - use iap_version to get firmware information

Geert Uytterhoeven (1):
      Input: Allow compile test of GPIO consumers if !GPIOLIB

Himangi Saraogi (1):
      Input: tc3589x-keypad - switch to using managed resources

HungNien Chen (2):
      Input: wdt87xx_i2c - populate vendor and product in input device
      Input: wdt87xx_i2c - change the sleep time to 2500ms after the sw reset

James Chen (1):
      Input: elants_i2c - disable idle mode before updating firmware

Javier Martinez Canillas (4):
      Input: export I2C module alias information in missing drivers
      Input: touchscreen - export OF module alias information
      Input: cros_ec_keyb - replace KEYBOARD_CROS_EC dependency
      Input: max8997_haptic - fix module alias

Julia Lawall (1):
      Input: sur40 - fix error return code

Krzysztof Kozlowski (1):
      Input: drop owner assignment from i2c_driver

Martin Kepplinger (1):
      Input: bma150 - use sign_extend32() for sign extending

Matt Ranostay (1):
      Input: cap11xx - add LED support

Michele Curti (1):
      Input: elan_i2c - enable ELAN0100 acpi panels

Nick Dyer (7):
      Input: atmel_mxt_ts - use deep sleep mode when stopped
      Input: atmel_mxt_ts - remove unused defines
      Input: atmel_mxt_ts - improve device tree parsing
      Input: atmel_mxt_ts - disable interrupt for 50ms after reset
      Input: atmel_mxt_ts - initialise input slots with INPUT_MT_DIRECT
      Input: atmel_mxt_ts - remove warning on zero T44 count
      MAINTAINERS: Add maintainer for atmel_mxt_ts

Pan Xinhui (1):
      Input: atmel_mxt_ts - suspend/resume causes panic if input_dev fails to init

Peng Fan (1):
      Input: gpio-keys - report error when disabling unsupported key

Roger Quadros (1):
      Input: pixcir_i2c_ts - add RESET gpio

Sebastian Reichel (5):
      Input: tsc2005 - improve readability of register defines
      Input: tsc2005 - fix Kconfig indentation
      Input: tsc2005 - convert to regmap
      Input: tsc2005 - simplify drvdata acquisition
      Input: tsc2005 - convert to gpiod

Stefan Assmann (1):
      Input: psmouse - add small delay for IBM trackpoint pass-through mode

Stephen Boyd (1):
      Input: pmic8xxx-pwrkey - support shutdown

Stephen Chandler Paul (1):
      Input: i8042 - add unmask_kbd_data option

Stephen Rothwell (1):
      Input: elants_i2c - fix for devm_gpiod_get API change

Ulf Hansson (1):
      Input: ambakmi - fix system PM by converting to modern callbacks

Yalin Wang (1):
      Input: zhenhua - switch to using bitrev8()


Diffstat:
--------

 .../devicetree/bindings/input/ads7846.txt          |    2 +-
 .../devicetree/bindings/input/cap11xx.txt          |   19 +
 .../devicetree/bindings/input/cypress,cyapa.txt    |   44 +
 .../devicetree/bindings/input/elants_i2c.txt       |    3 +
 .../devicetree/bindings/input/gpio-keys-polled.txt |    2 +-
 .../devicetree/bindings/input/gpio-keys.txt        |    2 +-
 .../bindings/input/gpio-matrix-keypad.txt          |    2 +-
 .../bindings/input/qcom,pm8xxx-keypad.txt          |    2 +-
 .../devicetree/bindings/input/samsung-keypad.txt   |    4 +-
 .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |    3 +
 .../bindings/input/touchscreen/zforce_ts.txt       |    8 +-
 Documentation/devicetree/bindings/mfd/tc3589x.txt  |    4 +-
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/kernel-parameters.txt                |    4 +
 MAINTAINERS                                        |    8 +
 drivers/hid/hid-core.c                             |    2 +
 drivers/input/ff-core.c                            |    5 +-
 drivers/input/input.c                              |   10 +-
 drivers/input/joydev.c                             |   11 +-
 drivers/input/joystick/zhenhua.c                   |   13 +-
 drivers/input/keyboard/Kconfig                     |    6 +-
 drivers/input/keyboard/adp5589-keys.c              |    1 -
 drivers/input/keyboard/cap11xx.c                   |  145 ++-
 drivers/input/keyboard/gpio_keys.c                 |    9 +-
 drivers/input/keyboard/gpio_keys_polled.c          |    5 +-
 drivers/input/keyboard/lm8333.c                    |    1 -
 drivers/input/keyboard/matrix_keypad.c             |    6 +-
 drivers/input/keyboard/mcs_touchkey.c              |    1 -
 drivers/input/keyboard/mpr121_touchkey.c           |    1 -
 drivers/input/keyboard/pmic8xxx-keypad.c           |   10 +-
 drivers/input/keyboard/qt1070.c                    |    1 -
 drivers/input/keyboard/qt2160.c                    |    1 -
 drivers/input/keyboard/samsung-keypad.c            |    6 +-
 drivers/input/keyboard/tc3589x-keypad.c            |   63 +-
 drivers/input/keyboard/tca8418_keypad.c            |    1 -
 drivers/input/misc/Kconfig                         |   11 +-
 drivers/input/misc/adxl34x-i2c.c                   |    1 -
 drivers/input/misc/arizona-haptics.c               |   26 +-
 drivers/input/misc/bma150.c                        |    8 +-
 drivers/input/misc/cma3000_d0x_i2c.c               |    1 -
 drivers/input/misc/drv260x.c                       |    3 +-
 drivers/input/misc/drv2665.c                       |    3 +-
 drivers/input/misc/drv2667.c                       |    3 +-
 drivers/input/misc/gp2ap002a00f.c                  |    2 +-
 drivers/input/misc/kxtj9.c                         |    1 -
 drivers/input/misc/max8997_haptic.c                |    3 +-
 drivers/input/misc/mpu3050.c                       |    1 -
 drivers/input/misc/pcf8574_keypad.c                |    1 -
 drivers/input/misc/pmic8xxx-pwrkey.c               |  268 ++++-
 drivers/input/misc/uinput.c                        |    6 +-
 drivers/input/mouse/Kconfig                        |    2 +-
 drivers/input/mouse/Makefile                       |    2 +-
 drivers/input/mouse/cyapa.c                        |  183 ++-
 drivers/input/mouse/cyapa.h                        |  157 ++-
 drivers/input/mouse/cyapa_gen3.c                   |   15 +-
 drivers/input/mouse/cyapa_gen5.c                   | 1255 +++++++++++---------
 drivers/input/mouse/cyapa_gen6.c                   |  749 ++++++++++++
 drivers/input/mouse/elan_i2c_core.c                |   31 +-
 drivers/input/mouse/psmouse-base.c                 |    4 +
 drivers/input/mouse/sentelic.c                     |   14 +-
 drivers/input/mouse/synaptics.c                    |   12 +-
 drivers/input/mouse/synaptics_i2c.c                |    1 -
 drivers/input/serio/ambakmi.c                      |    8 +-
 drivers/input/serio/i8042.c                        |   43 +-
 drivers/input/serio/i8042.h                        |   13 +
 drivers/input/serio/serio.c                        |    5 +-
 drivers/input/touchscreen/Kconfig                  |   21 +-
 drivers/input/touchscreen/Makefile                 |    2 +-
 drivers/input/touchscreen/ad7879-i2c.c             |    1 -
 drivers/input/touchscreen/ads7846.c                |    3 +-
 drivers/input/touchscreen/ar1021_i2c.c             |    1 -
 drivers/input/touchscreen/atmel_mxt_ts.c           |  240 ++--
 drivers/input/touchscreen/auo-pixcir-ts.c          |    1 -
 drivers/input/touchscreen/bu21013_ts.c             |    1 -
 drivers/input/touchscreen/chipone_icn8318.c        |    1 -
 drivers/input/touchscreen/cy8ctmg110_ts.c          |    1 -
 drivers/input/touchscreen/cyttsp4_i2c.c            |    1 -
 drivers/input/touchscreen/cyttsp_i2c.c             |    1 -
 drivers/input/touchscreen/edt-ft5x06.c             |    3 +-
 drivers/input/touchscreen/egalax_ts.c              |    2 +-
 drivers/input/touchscreen/elants_i2c.c             |  186 ++-
 drivers/input/touchscreen/goodix.c                 |    2 +-
 drivers/input/touchscreen/ili210x.c                |    1 -
 drivers/input/touchscreen/max11801_ts.c            |    1 -
 drivers/input/touchscreen/mms114.c                 |    2 +-
 drivers/input/touchscreen/of_touchscreen.c         |   68 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |  147 +--
 drivers/input/touchscreen/st1232.c                 |    1 -
 drivers/input/touchscreen/sur40.c                  |    1 +
 drivers/input/touchscreen/tsc2005.c                |  264 ++--
 drivers/input/touchscreen/tsc2007.c                |    1 -
 drivers/input/touchscreen/wacom_i2c.c              |    1 -
 drivers/input/touchscreen/wdt87xx_i2c.c            |   49 +-
 drivers/input/touchscreen/zforce_ts.c              |   98 +-
 drivers/platform/chrome/chromeos_laptop.c          |    4 +-
 include/linux/input/touchscreen.h                  |   11 +-
 .../linux/{i2c => platform_data}/atmel_mxt_ts.h    |   12 +-
 .../pixcir_ts.h => platform_data/pixcir_i2c_ts.h}  |    1 -
 include/linux/platform_data/zforce_ts.h            |    3 -
 include/linux/serio.h                              |    2 +
 100 files changed, 3075 insertions(+), 1297 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,cyapa.txt
 create mode 100644 drivers/input/mouse/cyapa_gen6.c
 rename include/linux/{i2c => platform_data}/atmel_mxt_ts.h (70%)
 rename include/linux/{input/pixcir_ts.h => platform_data/pixcir_i2c_ts.h} (96%)

-- 
Dmitry

