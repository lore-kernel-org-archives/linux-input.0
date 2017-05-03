From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.11-rc0
Date: Wed, 3 May 2017 11:50:39 -0700
Message-ID: <20170503185039.GA36469@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35464 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753829AbdECSum (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 3 May 2017 14:50:42 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get:

- a big update from Mauro converting input documentation to ReST format

- Synaptics PS/2 is now aware of SMBus companion devices, which means that
  we can now use native RMI4 protocol to handle touchpads, instead of
  relying on legacy PS/2 mode.

- we removed support from BMA180 accelerometer from input devices as it is
  now handled properly by IIO

- update to TSC2007 to corretcly report pressure

- other miscellaneous driver fixes.

Note that you will get a merge conflict in Documentation/input/ff.rst.
Please resolve it as follows:

"
See <uapi/linux/input.h> for a description of the ff_effect struct. You should
also find help in a few sketches, contained in files shape.svg and
interactive.svg:
"


Changelog:
---------

Benjamin Tissoires (2):
      Input: psmouse - add support for SMBus companions
      Input: synaptics - add support for Intertouch devices

Cameron Gutman (1):
      Input: xpad - support some quirky Xbox One pads

Christophe JAILLET (1):
      Input: omap-keypad - fix error handling code

Damien Riegel (4):
      Input: pm8xxx-vib - reorder header alphabetically
      Input: pm8xxx-vib - parametrize the driver
      Input: pm8xxx-vib - handle separate enable register
      Input: pm8xxx-vib - add support for pm8916's vibrator

David Jander (1):
      Input: ads7846 - avoid pen up/down when reading hwmon

David Rivshin (1):
      Input: matrix_keypad - add option to drive inactive columns

Dmitry Torokhov (54):
      Input: tsc2007 - switch to using input_set_capability()
      Input: ad7879 - convert to use regmap
      Input: ad7879 - use more devm interfaces
      Input: ad7879 - allow exporting AUX/VBAT/GPIO pin via device property
      Input: tca8418_keypad - remove double read of key event register
      Input: ad7879 - make sure we set up drvdata
      Input: ad7879 - return plain error code from ad7879_probe()
      Input: ad7879 - try parsing properties on non-DT systems
      Input: ad7879 - do not manipulate capability bits directly
      Input: dm355evm_keys - remove use of sparse_keymap_free
      Input: wistron_btns - remove use of sparse_keymap_free
      Input: dm355evm_keys - switch to using managed resources
      Input: synaptics - do not mix logical and bitwise operations
      Input: serio - add fast reconnect option
      Input: psmouse - implement fast reconnect option
      Input: psmouse - store pointer to current protocol
      Input: psmouse - introduce notion of SMBus companions
      Input: synaptics - split device info into a separate structure
      Input: melfas_mip4 - ensure that device is present
      i2c: export i2c_client_type structure
      i2c: copy device properties when using i2c_register_board_info()
      i2c: allow attaching IRQ resources to i2c_board_info
      Input: psmouse - fix cleaning up SMBus companions
      Input: psmouse - use i2c_client_type to locate i2c clients
      Input: synaptics - add synaptics_query_int()
      Input: synaptics - use BIT() and GENMASK() macros
      Input: synaptics - do not abuse -1 as return value
      Input: synaptics - use u8 instead of unsigned char
      Input: synaptics-rmi4 - fix handling failures from rmi_enable_sensor
      Input: synaptics-rmi4 - fix endianness issue in SMBus transport
      Input: synaptics-rmi4 - cleanup SMbus mapping handling
      Input: synaptics-rmi4 - when registering sensors do not call them "drivers"
      Input: eeti_ts - rename eeti_ts_priv to eeti_ts
      Input: eeti_ts - use BIT(n)
      Input: eeti_ts - use get_unaligned_be16() to retrieve data
      Input: eeti_ts - use input_set_capability()
      Input: eeti_ts - switch to using managed resources
      Input: eeti_ts - respect interrupt set in client structure
      Input: eeti_ts - use gpio_get_value_cansleep
      Input: eeti_ts - switch to using threaded interrupt
      Input: eeti_ts - expect platform code to set interrupt trigger
      Input: eeti_ts - switch to gpiod API
      Input: ar1021_i2c - fix too long name in driver's device table
      Input: ar1021_i2c - do not force raising edge IRQ trigger
      Input: move documentation for Amiga CD32
      Input: rotary-encoder - remove references to platform data from docs
      Input: fix "Game console" heading level in joystick documentation
      Input: docs - remove disclaimer/GPL notice
      Input: docs - update joystick documentation a bit
      Input: docs - note that MT-A protocol is obsolete
      Input: docs - split input docs into kernel- and user-facing
      Input: docs - freshen up introduction
      Input: xpad - do not suggest writing to Dominic
      ARM: pxa/raumfeld: fix compile error in rotary controller resources

Fabio Estevam (2):
      Input: imx6ul_tsc - fix error handling
      Input: lpc32xx_ts - check for clk_prepare_enable() error

Geliang Tang (4):
      Input: db9 - use setup_timer
      Input: gameport - use setup_timer
      Input: locomokbd - use setup_timer
      Input: turbografx - use setup_timer

Guan Ben (1):
      Input: pwm-beeper - support customized freq for SND_BELL

H. Nikolaus Schaller (6):
      Input: tsc2007 - check for presence and power down tsc2007 during probe
      Input: tsc2007 - add iio interface to read external ADC input and temperature
      Input: tsc2007 - rename function tsc2007_calculate_pressure
      Input: tsc2007 - correctly report pressure and not resistance to user space
      Input: ad7846 - move bindings to touchscreen subdirectory
      Input: bma150 - remove support for bma150

Hans de Goede (7):
      Input: axp20x-pek - use our own device for errors
      Input: axp20x_pek - add axp20x_pek_probe_input_device helper
      Input: axp20x-pek - do not register input device on some systems
      Input: soc_button_array - use NULL for GPIO connection ID
      Input: soc_button_array - get rid of MAX_NBUTTONS
      Input: soc_button_array - add support for ACPI 6.0 Generic Button Device
      Input: soc_button_array - properly map usage 0x07/0xe3 to KEY_LEFTMETA

Jagan Teki (2):
      Input: max11801_ts - add missing of_match_table
      dt-bindings: input: touchscreen: add max11801-ts binding

Javier Martinez Canillas (4):
      Input: silead - add OF device ID table
      Input: synaptics_i2c - add OF device ID table
      Input: qt1070 - add OF device ID table
      Input: silead - list all supported compatible strings in binding document

Jingkui Wang (1):
      Input: drv260x - remove OF dependency

Joe Perches (1):
      Input: convert remaining uses of pr_warning to pr_warn

Juergen Gross (1):
      Input: xen-kbdfront - add module parameter for setting resolution

Marcos Paulo de Souza (1):
      Input: add uinput documentation

Martin Kepplinger (7):
      Input: sur40 - fix bad endianness handling in sur40_poll
      Input: yealink - define packet offset __be16 instead of u16
      Input: ar1021_i2c - coding style fixes
      Input: ar1021_i2c - highlight support for AR1020
      dt-bindings: input: add bindings document for ar1021_i2c driver
      Input: ar1021_i2c - enable touch mode during open
      Input: ar1021_i2c - use BIT to check for a bit

Mauro Carvalho Chehab (35):
      Input: docs - convert input.txt into ReST format
      Input: ALPS - convert documentation into ReST format
      Input: amijoy - convert documentation into ReST format
      Input: appletouch - convert documentation into ReST format
      Input: atarikbd - convert documentation into ReST format
      Input: bcm5974 - convert documentation into ReST format
      Input: db9/CD32 - convert documentation into ReST format
      Input: cma3000_d0x - convert documentation into ReST format
      Input: cs461x - convert documentation into ReST format
      Input: elantech - convert documentation into ReST format
      Input: convert event codes documentation into ReST format
      Input: convert force feedback documentation into ReST format
      Input: convert gamepad specification into ReST format
      Input: convert gameport programming documentation into ReST format
      Input: gpio-tilt - convert documentation into ReST format
      Input: iforce - convert documentation into ReST format
      Input: convert input-programming doc into ReST format
      Input: convert joystick-api doc into ReST format
      Input: joystick - convert documentation into ReST format
      Input: joystick-parport - convert documentation into ReST format
      Input: convert multi-touch protocol spec into ReST format
      Input: convert keyboard notifier docs into ReST format
      Input: ntrig - convert documentation into ReST format
      Input: rotary-encoder - convert documentation into to ReST format
      Input: sentelic - convert documentation into ReST format
      Input: userio - convert documentation into ReST format
      Input: walkera0701 - convert documentation into ReST format
      Input: xpad - convert documentation into ReST format
      Input: yealink - convert documentation into ReST format
      Input: create a book with Linux Input documentation
      Input: docs - convert shape.fig from xfig to svg
      Input: docs - convert interactive.fig from xfig to svg
      Input: use svg files instead of xfig in force feedback documentation
      Input: xpad - note that usb/devices is now at /sys/kernel/debug/
      Input: xpad - don't use literal blocks inside footnotes

Michael Hennerich (3):
      Input: ad7879-spi - remove bits_per_word = 16 enforcement
      Input: ad7879 - update MODULE_AUTHOR email address
      Input: ad7879 - add SPI device tree binding example

Michał Kępień (1):
      Input: sparse-keymap - use a managed allocation for keymap copy

Nick Dyer (3):
      Input: synaptics-rmi4 - use dev_driver_string when registering interrupt
      Input: synaptics-rmi4 - change F12 clip to inactive border debug
      Input: synaptics-rmi4 - enable IRQ operation in F34 V7

Pali Rohár (3):
      Input: alps - move ALPS_PROTO_V4 out of alps_model_data table
      Input: alps - warn about unsupported ALPS V9 touchpad
      Input: alps - cleanup alps_model_data

Rahul Bedarkar (1):
      dt-bindings: input: rotary-encoder: fix typo

Rajat Jain (1):
      Input: cros_ec_keyb - add an EC event for sysrq

Randy Dunlap (1):
      Input: ad7879 - add header file to fix ad7879.c build errors

Sebastian Reichel (2):
      Input: twl4030-pwrbutton - use correct device for irq request
      Input: twl4030-pwrbutton - use input_set_capability() helper

Yegor Yefremov (1):
      Input: tps6507x-ts - update to devm_* API

Diffstat:
--------

 Documentation/conf.py                              |   2 +
 .../bindings/input/gpio-matrix-keypad.txt          |   2 +
 .../devicetree/bindings/input/pwm-beeper.txt       |   1 +
 .../devicetree/bindings/input/qcom,pm8xxx-vib.txt  |   1 +
 .../devicetree/bindings/input/rotary-encoder.txt   |   2 +-
 .../bindings/input/touchscreen/ad7879.txt          |  19 +
 .../bindings/input/{ => touchscreen}/ads7846.txt   |   0
 .../bindings/input/touchscreen/ar1021.txt          |  16 +
 .../bindings/input/touchscreen/max11801-ts.txt     |  18 +
 .../bindings/input/touchscreen/silead_gsl1680.txt  |   7 +-
 Documentation/input/cd32.txt                       |  19 -
 Documentation/input/conf.py                        |  10 +
 Documentation/input/{alps.txt => devices/alps.rst} |  45 +-
 .../input/{amijoy.txt => devices/amijoy.rst}       | 179 ++--
 .../{appletouch.txt => devices/appletouch.rst}     |  45 +-
 .../input/{atarikbd.txt => devices/atarikbd.rst}   | 225 +++--
 .../input/{bcm5974.txt => devices/bcm5974.rst}     |  43 +-
 .../{cma3000_d0x.txt => devices/cma3000_d0x.rst}   |  74 +-
 .../input/{cs461x.txt => devices/cs461x.rst}       |  28 +-
 .../{edt-ft5x06.txt => devices/edt-ft5x06.rst}     |   0
 .../input/{elantech.txt => devices/elantech.rst}   | 306 ++++---
 Documentation/input/devices/gpio-tilt.rst          | 103 +++
 Documentation/input/devices/iforce-protocol.rst    | 381 ++++++++
 Documentation/input/devices/index.rst              |  19 +
 Documentation/input/devices/joystick-parport.rst   | 611 +++++++++++++
 .../input/{ntrig.txt => devices/ntrig.rst}         |  49 +-
 .../rotary-encoder.rst}                            | 117 +--
 Documentation/input/devices/sentelic.rst           | 901 +++++++++++++++++++
 .../{walkera0701.txt => devices/walkera0701.rst}   |  51 +-
 Documentation/input/{xpad.txt => devices/xpad.rst} | 143 +--
 .../input/{yealink.txt => devices/yealink.rst}     | 173 ++--
 .../input/{event-codes.txt => event-codes.rst}     | 134 ++-
 Documentation/input/{ff.txt => ff.rst}             | 206 +++--
 Documentation/input/{gamepad.txt => gamepad.rst}   |  94 +-
 ...rt-programming.txt => gameport-programming.rst} |  83 +-
 Documentation/input/gpio-tilt.txt                  | 103 ---
 Documentation/input/iforce-protocol.txt            | 258 ------
 Documentation/input/index.rst                      |  20 +
 ...input-programming.txt => input-programming.rst} | 268 +++---
 Documentation/input/input.rst                      | 281 ++++++
 Documentation/input/input.txt                      | 290 ------
 Documentation/input/input_kapi.rst                 |  17 +
 Documentation/input/input_uapi.rst                 |  22 +
 Documentation/input/interactive.fig                |  42 -
 Documentation/input/interactive.svg                |  24 +
 Documentation/input/joydev/index.rst               |  18 +
 .../{joystick-api.txt => joydev/joystick-api.rst}  | 160 ++--
 Documentation/input/joydev/joystick.rst            | 585 ++++++++++++
 Documentation/input/joystick-parport.txt           | 542 ------------
 Documentation/input/joystick.txt                   | 586 ------------
 ...touch-protocol.txt => multi-touch-protocol.rst} | 206 +++--
 Documentation/input/{notifier.txt => notifier.rst} |  10 +-
 Documentation/input/sentelic.txt                   | 873 ------------------
 Documentation/input/shape.fig                      |  65 --
 Documentation/input/shape.svg                      |  39 +
 Documentation/input/uinput.rst                     | 245 ++++++
 Documentation/input/{userio.txt => userio.rst}     |  79 +-
 MAINTAINERS                                        |   4 +-
 arch/arm/mach-pxa/raumfeld.c                       |  24 +-
 drivers/i2c/i2c-boardinfo.c                        |  24 +
 drivers/i2c/i2c-core.c                             |  34 +-
 drivers/input/gameport/gameport.c                  |   9 +-
 drivers/input/joystick/db9.c                       |   4 +-
 drivers/input/joystick/gamecon.c                   |   3 +-
 drivers/input/joystick/turbografx.c                |   4 +-
 drivers/input/joystick/xpad.c                      | 114 ++-
 drivers/input/keyboard/cros_ec_keyb.c              |   7 +
 drivers/input/keyboard/locomokbd.c                 |   5 +-
 drivers/input/keyboard/matrix_keypad.c             |  13 +-
 drivers/input/keyboard/omap4-keypad.c              |   2 +-
 drivers/input/keyboard/qt1070.c                    |   9 +
 drivers/input/keyboard/tca8418_keypad.c            |   2 -
 drivers/input/misc/Kconfig                         |   2 +-
 drivers/input/misc/apanel.c                        |   3 +-
 drivers/input/misc/axp20x-pek.c                    |  62 +-
 drivers/input/misc/bma150.c                        |  11 +-
 drivers/input/misc/dm355evm_keys.c                 |  79 +-
 drivers/input/misc/drv260x.c                       |   4 +-
 drivers/input/misc/pm8xxx-vibrator.c               |  78 +-
 drivers/input/misc/pwm-beeper.c                    |  15 +-
 drivers/input/misc/soc_button_array.c              | 182 +++-
 drivers/input/misc/twl4030-pwrbutton.c             |   5 +-
 drivers/input/misc/wistron_btns.c                  |   5 +-
 drivers/input/misc/xen-kbdfront.c                  |  45 +-
 drivers/input/misc/yealink.h                       |   2 +-
 drivers/input/mouse/Kconfig                        |  16 +
 drivers/input/mouse/Makefile                       |   2 +
 drivers/input/mouse/alps.c                         |  76 +-
 drivers/input/mouse/alps.h                         |   6 +-
 drivers/input/mouse/psmouse-base.c                 | 216 +++--
 drivers/input/mouse/psmouse-smbus.c                | 302 +++++++
 drivers/input/mouse/psmouse.h                      | 102 ++-
 drivers/input/mouse/synaptics.c                    | 980 +++++++++++++--------
 drivers/input/mouse/synaptics.h                    | 154 ++--
 drivers/input/mouse/synaptics_i2c.c                |   9 +
 drivers/input/rmi4/rmi_driver.c                    |  13 +-
 drivers/input/rmi4/rmi_f12.c                       |  18 +-
 drivers/input/rmi4/rmi_f34.c                       |  27 +-
 drivers/input/rmi4/rmi_f34.h                       |   7 +-
 drivers/input/rmi4/rmi_f34v7.c                     | 117 +--
 drivers/input/rmi4/rmi_i2c.c                       |  51 +-
 drivers/input/rmi4/rmi_smbus.c                     |  94 +-
 drivers/input/rmi4/rmi_spi.c                       |  44 +-
 drivers/input/serio/serio.c                        |  30 +-
 drivers/input/sparse-keymap.c                      |  39 +-
 drivers/input/touchscreen/Kconfig                  |  18 +-
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/ad7879-i2c.c             |  67 +-
 drivers/input/touchscreen/ad7879-spi.c             | 131 +--
 drivers/input/touchscreen/ad7879.c                 | 152 ++--
 drivers/input/touchscreen/ad7879.h                 |  14 +-
 drivers/input/touchscreen/ads7846.c                |   2 +-
 drivers/input/touchscreen/ar1021_i2c.c             |  30 +-
 drivers/input/touchscreen/eeti_ts.c                | 226 ++---
 drivers/input/touchscreen/imx6ul_tsc.c             |  15 +-
 drivers/input/touchscreen/lpc32xx_ts.c             |  13 +-
 drivers/input/touchscreen/max11801_ts.c            |   7 +
 drivers/input/touchscreen/melfas_mip4.c            |  11 +
 drivers/input/touchscreen/silead.c                 |  13 +
 drivers/input/touchscreen/sur40.c                  |   2 +-
 drivers/input/touchscreen/tps6507x-ts.c            |  33 +-
 drivers/input/touchscreen/tsc2007.h                | 101 +++
 .../touchscreen/{tsc2007.c => tsc2007_core.c}      | 102 +--
 drivers/input/touchscreen/tsc2007_iio.c            | 140 +++
 include/linux/i2c.h                                |   5 +
 include/linux/input/eeti_ts.h                      |  10 -
 include/linux/input/matrix_keypad.h                |   3 +
 include/linux/mfd/cros_ec_commands.h               |   4 +
 include/linux/serio.h                              |   1 +
 129 files changed, 7607 insertions(+), 5389 deletions(-)
 rename Documentation/devicetree/bindings/input/{ => touchscreen}/ads7846.txt (100%)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/ar1021.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/max11801-ts.txt
 delete mode 100644 Documentation/input/cd32.txt
 create mode 100644 Documentation/input/conf.py
 rename Documentation/input/{alps.txt => devices/alps.rst} (94%)
 rename Documentation/input/{amijoy.txt => devices/amijoy.rst} (60%)
 rename Documentation/input/{appletouch.txt => devices/appletouch.rst} (79%)
 rename Documentation/input/{atarikbd.txt => devices/atarikbd.rst} (90%)
 rename Documentation/input/{bcm5974.txt => devices/bcm5974.rst} (55%)
 rename Documentation/input/{cma3000_d0x.txt => devices/cma3000_d0x.rst} (66%)
 rename Documentation/input/{cs461x.txt => devices/cs461x.rst} (80%)
 rename Documentation/input/{edt-ft5x06.txt => devices/edt-ft5x06.rst} (100%)
 rename Documentation/input/{elantech.txt => devices/elantech.rst} (88%)
 create mode 100644 Documentation/input/devices/gpio-tilt.rst
 create mode 100644 Documentation/input/devices/iforce-protocol.rst
 create mode 100644 Documentation/input/devices/index.rst
 create mode 100644 Documentation/input/devices/joystick-parport.rst
 rename Documentation/input/{ntrig.txt => devices/ntrig.rst} (75%)
 rename Documentation/input/{rotary-encoder.txt => devices/rotary-encoder.rst} (59%)
 create mode 100644 Documentation/input/devices/sentelic.rst
 rename Documentation/input/{walkera0701.txt => devices/walkera0701.rst} (86%)
 rename Documentation/input/{xpad.txt => devices/xpad.rst} (73%)
 rename Documentation/input/{yealink.txt => devices/yealink.rst} (60%)
 rename Documentation/input/{event-codes.txt => event-codes.rst} (96%)
 rename Documentation/input/{ff.txt => ff.rst} (62%)
 rename Documentation/input/{gamepad.txt => gamepad.rst} (87%)
 rename Documentation/input/{gameport-programming.txt => gameport-programming.rst} (85%)
 delete mode 100644 Documentation/input/gpio-tilt.txt
 delete mode 100644 Documentation/input/iforce-protocol.txt
 create mode 100644 Documentation/input/index.rst
 rename Documentation/input/{input-programming.txt => input-programming.rst} (69%)
 create mode 100644 Documentation/input/input.rst
 delete mode 100644 Documentation/input/input.txt
 create mode 100644 Documentation/input/input_kapi.rst
 create mode 100644 Documentation/input/input_uapi.rst
 delete mode 100644 Documentation/input/interactive.fig
 create mode 100644 Documentation/input/interactive.svg
 create mode 100644 Documentation/input/joydev/index.rst
 rename Documentation/input/{joystick-api.txt => joydev/joystick-api.rst} (72%)
 create mode 100644 Documentation/input/joydev/joystick.rst
 delete mode 100644 Documentation/input/joystick-parport.txt
 delete mode 100644 Documentation/input/joystick.txt
 rename Documentation/input/{multi-touch-protocol.txt => multi-touch-protocol.rst} (68%)
 rename Documentation/input/{notifier.txt => notifier.rst} (90%)
 delete mode 100644 Documentation/input/sentelic.txt
 delete mode 100644 Documentation/input/shape.fig
 create mode 100644 Documentation/input/shape.svg
 create mode 100644 Documentation/input/uinput.rst
 rename Documentation/input/{userio.txt => userio.rst} (56%)
 create mode 100644 drivers/input/mouse/psmouse-smbus.c
 create mode 100644 drivers/input/touchscreen/tsc2007.h
 rename drivers/input/touchscreen/{tsc2007.c => tsc2007_core.c} (83%)
 create mode 100644 drivers/input/touchscreen/tsc2007_iio.c
 delete mode 100644 include/linux/input/eeti_ts.h

Thanks.

-- 
Dmitry

-- 
Dmitry
