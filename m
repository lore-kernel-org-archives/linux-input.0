From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.11-rc0
Date: Thu, 23 Feb 2017 00:05:37 -0800
Message-ID: <20170223080537.GA18639@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33617 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750951AbdBWIHf (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 03:07:35 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a new driver for Zeitech touchscreen controller
- a new driver for Samsung "touchkeys"
- touchscreen driver for Moorestown platform has been removed because
  platform support is gone
- MPU3050 accelerometer driver was removed in favor of IIO driver
- miscellaneous driver cleanup and fixes

Changelog:
---------

Akinobu Mita (5):
      Input: mpr121 - annotate PM methods as __maybe_unused
      Input: mpr121 - remove unused field in struct mpr121_touchkey
      Input: mpr121 - set missing event capability
      Input: mpr121 - handle multiple bits change of status register
      Input: mpr121 - switch to device tree probe

Andy Shevchenko (1):
      Input: intel-mid-touch - remove driver

Aniroop Mathur (2):
      Input: bma150 - switch to using usleep_range instead of msleep
      Input: edt_ft5x06 - change msleep to usleep_range for small msecs

Benjamin Tissoires (3):
      Input: synaptics-rmi4 - add rmi_find_function()
      Input: psmouse - add a custom serio protocol to send extra information
      Input: synaptics-rmi4 - forward upper mechanical buttons to PS/2 guest

Bhumika Goyal (1):
      Input: constify device_type structures

Cameron Gutman (3):
      Input: xpad - don't depend on endpoint order
      Input: xpad - fix stuck mode button on Xbox One S pad
      Input: xpad - restore LED state after device resume

Colin Ian King (2):
      Input: synaptics-rmi4 - check for non zero version logically dead code
      Input: synaptics-rmi4 - remove redundant null check on rmi_dev

Daniel Tobias (2):
      Input: xpad - correctly sort vendor id's
      Input: xpad - move reporting xbox one home button to common function

David Lechner (2):
      Input: pwm-beeper - suppress error message on probe defer
      Input: pwm-beeper - add optional amplifier regulator

Dmitry Torokhov (18):
      Input: i8042 - force synchronous probing of PNP drivers
      Input: synaptics-rmi4 - use Kconfig "if" to express dependency
      Input: pwm-beeper - remove calls to legacy pwm_request API
      Input: pwm-beeper - switch to using managed resources
      Input: pwm-beeper - use input_set_capability()
      Input: pwm-beeper - fix race when suspending
      Input: pwm-beeper - switch to using "atomic" PWM API
      Input: max11801_ts - drop call to input_set_drvdata()
      Input: matrix-keypad - switch to using generic device properties
      Input: tca8418 - switch to using generic device properties
      Input: mousedev - stop offering PS/2 to userspace by default
      Input: refuse to register absolute devices without absinfo
      Input: joydev - use clamp() macro
      Input: synaptics - use SERIO_OOB_DATA to handle trackstick buttons
      Input: synaptics-rmi4 - clean up F30 implementation
      Input: tsc2005 - add OF device table
      Input: tsc2004/5 - fix regulator handling
      Input: tsc2004/5 - switch to using generic device properties

Douglas Anderson (2):
      mfd: cros-ec: Update cros_ec_commands.h for buttons and switches
      input: cros_ec_keyb: Add non-matrix buttons and switches

Guenter Roeck (33):
      Input: cros_ec_keyb - drop unnecessary call to dev_set_drvdata and other changes
      Input: at32psif - drop unnecessary error messages and other changes
      Input: xilinx_ps2 - use 'dev' instead of dereferencing it
      Input: ar1021_i2c - drop unnecessary call to i2c_set_clientdata
      Input: atmel-wm97xx - drop unnecessary error messages
      Input: eeti_ts - drop goto to return statement
      Input: bfin_rotary - switch to using devm_add_action_or_reset()
      Input: gpio_decoder - drop unnecessary call to platform_set_drvdata
      Input: mma8450 - drop unnecessary call to i2c_set_clientdata
      Input: soc_button_array - use 'dev' instead of dereferencing it
      Input: tps65218-pwrbutton - drop unnecessary call to platform_set_drvdata
      Input: ab8500-ponkey - drop unnecessary call to platform_set_drvdata
      Input: twl4030_keypad - drop unnecessary call to platform_set_drvdata
      Input: bcm-keypad - drop unnecessary call to platform_set_drvdata
      Input: sis_i2c - drop unnecessary call to i2c_set_clientdata
      Input: keyboard - drop calls to platform_set_drvdata and i2c_set_clientdata
      Input: misc - drop calls to platform_set_drvdata and i2c_set_clientdata
      Input: touchscreen - drop calls to platform_set_drvdata and i2c_set_clientdata
      Input: keyboard - use local variables consistently
      Input: misc - use local variables consistently
      Input: mouse - use local variables consistently
      Input: touchscreen - use local variables consistently
      Input: keyboard - drop unnecessary calls to device_init_wakeup
      Input: misc - drop unnecessary calls to device_init_wakeup
      Input: touchscreen - drop unnecessary calls to device_init_wakeup
      Input: serio - drop unnecessary calls to device_init_wakeup
      Input: misc - drop empty remove functions
      Input: synaptics-rmi4 - use local variables consistently
      Input: keyboard - drop unnecessary calls to input_set_drvdata
      Input: maplecontrol - drop unnecessary call to input_set_drvdata
      Input: mouse - drop unnecessary calls to input_set_drvdata
      Input: dm355evm_keys - drop unnecessary call to input_set_drvdata
      Input: touchscreen - drop unnecessary calls to input_set_drvdata

Gwendal Grignou (1):
      input: cros_ec_keyb: Add Tablet Mode switch

Hans de Goede (2):
      Input: soc_button_array - debounce the buttons
      Input: gpio-keys - add support for setkeycode

Jaechul Lee (1):
      Input: tm2-touchkey - add touchkey driver support for TM2

Javier Martinez Canillas (1):
      Input: zet6223 - export OF device ID as module aliases

Jelle van der Waa (1):
      Input: add driver for Zeitec ZET6223

Linus Walleij (1):
      Input: delete MPU3050 driver

Lucas Stach (1):
      Input: synaptics-rmi4 - correctly swap clip values if axes are swapped

Marcos Paulo de Souza (1):
      Input: i8042 - add dbg msg when a command can't write its parameter

Maxime Ripard (1):
      Input: tca8418 - use the interrupt trigger from the device tree

Nicholas Mc Guire (2):
      Input: cyapa - use time based retry loop
      Input: cyapa - use msleep() for long delay

Nick Dyer (2):
      Input: synaptics-rmi4 - add sysfs attribute update_fw_status
      Input: synaptics-rmi4 - add sysfs interfaces for hardware IDs

Pavel Rojtberg (1):
      Input: xpad - simplify error condition in init_output

Raphael Assenat (1):
      Input: joydev - do not report stale values on first open

Wei Yongjun (1):
      Input: synaptics-rmi4 - fix error return code in rmi_probe_interrupts()


Diffstat:
--------

 .../bindings/input/cypress,tm2-touchkey.txt        |  27 +
 .../devicetree/bindings/input/mpr121-touchkey.txt  |  30 +
 .../devicetree/bindings/input/pwm-beeper.txt       |  16 +
 .../bindings/input/touchscreen/zet6223.txt         |  32 +
 .../devicetree/bindings/vendor-prefixes.txt        |   1 +
 drivers/input/Kconfig                              |   3 -
 drivers/input/input.c                              |   8 +-
 drivers/input/joydev.c                             |  20 +-
 drivers/input/joystick/maplecontrol.c              |   1 -
 drivers/input/joystick/xpad.c                      | 156 +++--
 drivers/input/keyboard/Kconfig                     |  11 +
 drivers/input/keyboard/Makefile                    |   1 +
 drivers/input/keyboard/adc-keys.c                  |   2 -
 drivers/input/keyboard/adp5520-keys.c              |   2 -
 drivers/input/keyboard/bcm-keypad.c                |   4 +-
 drivers/input/keyboard/bf54x-keys.c                |   2 -
 drivers/input/keyboard/cap11xx.c                   |   1 -
 drivers/input/keyboard/cros_ec_keyb.c              | 454 ++++++++++++--
 drivers/input/keyboard/davinci_keyscan.c           |   4 +-
 drivers/input/keyboard/gpio_keys.c                 |  66 ++-
 drivers/input/keyboard/gpio_keys_polled.c          |   7 +-
 drivers/input/keyboard/jornada680_kbd.c            |   2 -
 drivers/input/keyboard/lpc32xx-keys.c              |   2 +-
 drivers/input/keyboard/maple_keyb.c                |   1 -
 drivers/input/keyboard/matrix_keypad.c             |   2 -
 drivers/input/keyboard/max7359_keypad.c            |   1 -
 drivers/input/keyboard/mpr121_touchkey.c           | 176 ++++--
 drivers/input/keyboard/nspire-keypad.c             |   2 -
 drivers/input/keyboard/omap4-keypad.c              |   7 +-
 drivers/input/keyboard/opencores-kbd.c             |   4 -
 drivers/input/keyboard/pmic8xxx-keypad.c           |   2 +-
 drivers/input/keyboard/pxa27x_keypad.c             |   2 +-
 drivers/input/keyboard/samsung-keypad.c            |   2 -
 drivers/input/keyboard/spear-keyboard.c            |   2 -
 drivers/input/keyboard/st-keyscan.c                |   4 +-
 drivers/input/keyboard/stmpe-keypad.c              |   2 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |   1 -
 drivers/input/keyboard/tca8418_keypad.c            |  92 +--
 drivers/input/keyboard/tm2-touchkey.c              | 284 +++++++++
 drivers/input/keyboard/twl4030_keypad.c            |   5 +-
 drivers/input/matrix-keymap.c                      | 109 ++--
 drivers/input/misc/88pm80x_onkey.c                 |   1 -
 drivers/input/misc/Kconfig                         |  10 -
 drivers/input/misc/Makefile                        |   1 -
 drivers/input/misc/ab8500-ponkey.c                 |   1 -
 drivers/input/misc/arizona-haptics.c               |   2 -
 drivers/input/misc/atmel_captouch.c                |   1 -
 drivers/input/misc/bfin_rotary.c                   |  11 +-
 drivers/input/misc/bma150.c                        |   4 +-
 drivers/input/misc/da9063_onkey.c                  |   1 -
 drivers/input/misc/dm355evm_keys.c                 |   2 -
 drivers/input/misc/drv260x.c                       |   2 +-
 drivers/input/misc/e3x0-button.c                   |   8 -
 drivers/input/misc/gp2ap002a00f.c                  |   2 -
 drivers/input/misc/gpio_decoder.c                  |   1 -
 drivers/input/misc/gpio_tilt_polled.c              |   2 +-
 drivers/input/misc/hisi_powerkey.c                 |  17 +-
 drivers/input/misc/mma8450.c                       |   2 -
 drivers/input/misc/mpu3050.c                       | 481 ---------------
 drivers/input/misc/pm8941-pwrkey.c                 |   1 -
 drivers/input/misc/pmic8xxx-pwrkey.c               |   8 -
 drivers/input/misc/pwm-beeper.c                    | 156 +++--
 drivers/input/misc/retu-pwrbutton.c                |   6 -
 drivers/input/misc/sirfsoc-onkey.c                 |   8 -
 drivers/input/misc/soc_button_array.c              |   8 +-
 drivers/input/misc/tps65218-pwrbutton.c            |   8 +-
 drivers/input/misc/twl4030-pwrbutton.c             |   1 -
 drivers/input/mouse/alps.c                         |   2 +-
 drivers/input/mouse/bcm5974.c                      |   2 +-
 drivers/input/mouse/cyapa.c                        |   6 +-
 drivers/input/mouse/cyapa_gen3.c                   |  29 +-
 drivers/input/mouse/cypress_ps2.c                  |   6 +-
 drivers/input/mouse/elan_i2c_core.c                |  46 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/hgpk.c                         |   5 +-
 drivers/input/mouse/logips2pp.c                    |   2 +-
 drivers/input/mouse/maplemouse.c                   |   1 -
 drivers/input/mouse/psmouse-base.c                 |  41 +-
 drivers/input/mouse/psmouse.h                      |   5 +
 drivers/input/mouse/synaptics.c                    |  26 +-
 drivers/input/mouse/synaptics.h                    |   1 -
 drivers/input/mouse/trackpoint.c                   |   4 +-
 drivers/input/rmi4/Kconfig                         |  27 +-
 drivers/input/rmi4/rmi_2d_sensor.c                 |   7 +-
 drivers/input/rmi4/rmi_bus.c                       |   8 +-
 drivers/input/rmi4/rmi_driver.c                    |  21 +-
 drivers/input/rmi4/rmi_driver.h                    |  16 +-
 drivers/input/rmi4/rmi_f01.c                       | 104 +++-
 drivers/input/rmi4/rmi_f03.c                       |  41 +-
 drivers/input/rmi4/rmi_f30.c                       | 352 ++++++-----
 drivers/input/rmi4/rmi_f34.c                       | 142 ++++-
 drivers/input/rmi4/rmi_f34.h                       |   4 +
 drivers/input/rmi4/rmi_f34v7.c                     |  11 +
 drivers/input/serio/at32psif.c                     |  12 +-
 drivers/input/serio/hyperv-keyboard.c              |   1 -
 drivers/input/serio/i8042-x86ia64io.h              |   8 +
 drivers/input/serio/i8042.c                        |   6 +-
 drivers/input/serio/xilinx_ps2.c                   |   7 +-
 drivers/input/touchscreen/88pm860x-ts.c            |   3 -
 drivers/input/touchscreen/Kconfig                  |  23 +-
 drivers/input/touchscreen/Makefile                 |   2 +-
 drivers/input/touchscreen/ads7846.c                |   2 -
 drivers/input/touchscreen/ar1021_i2c.c             |   1 -
 drivers/input/touchscreen/atmel-wm97xx.c           |   4 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           |   2 +-
 drivers/input/touchscreen/bu21013_ts.c             |   2 -
 drivers/input/touchscreen/colibri-vf50-ts.c        |   2 -
 drivers/input/touchscreen/edt-ft5x06.c             |   5 +-
 drivers/input/touchscreen/eeti_ts.c                |   5 +-
 drivers/input/touchscreen/egalax_ts.c              |   3 -
 drivers/input/touchscreen/elants_i2c.c             |   2 -
 drivers/input/touchscreen/fsl-imx25-tcq.c          |   2 +-
 drivers/input/touchscreen/ili210x.c                |   3 +-
 drivers/input/touchscreen/intel-mid-touch.c        | 654 ---------------------
 drivers/input/touchscreen/lpc32xx_ts.c             |   1 -
 drivers/input/touchscreen/max11801_ts.c            |   2 -
 drivers/input/touchscreen/mcs5000_ts.c             |   1 -
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   4 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         |   2 -
 drivers/input/touchscreen/rohm_bu21023.c           |   3 +-
 drivers/input/touchscreen/s3c2410_ts.c             |   2 +-
 drivers/input/touchscreen/sis_i2c.c                |   1 -
 drivers/input/touchscreen/st1232.c                 |   1 -
 drivers/input/touchscreen/sx8654.c                 |   1 -
 drivers/input/touchscreen/tsc2005.c                |  12 +-
 drivers/input/touchscreen/tsc200x-core.c           | 112 ++--
 drivers/input/touchscreen/zet6223.c                | 268 +++++++++
 include/linux/i2c/mpr121_touchkey.h                |  20 -
 include/linux/input/matrix_keypad.h                |  21 +-
 include/linux/input/tca8418_keypad.h               |  44 --
 include/linux/mfd/cros_ec_commands.h               |  74 ++-
 include/linux/spi/tsc2005.h                        |  34 --
 include/uapi/linux/serio.h                         |   7 +-
 133 files changed, 2322 insertions(+), 2243 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/cypress,tm2-touchkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/mpr121-touchkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/zet6223.txt
 create mode 100644 drivers/input/keyboard/tm2-touchkey.c
 delete mode 100644 drivers/input/misc/mpu3050.c
 delete mode 100644 drivers/input/touchscreen/intel-mid-touch.c
 create mode 100644 drivers/input/touchscreen/zet6223.c
 delete mode 100644 include/linux/i2c/mpr121_touchkey.h
 delete mode 100644 include/linux/input/tca8418_keypad.h
 delete mode 100644 include/linux/spi/tsc2005.h

-- 
Dmitry

