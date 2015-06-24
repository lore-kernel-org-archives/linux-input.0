From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.2-rc0
Date: Wed, 24 Jun 2015 15:08:46 -0700
Message-ID: <20150624220846.GC3636@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33924 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752400AbbFXWIu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jun 2015 18:08:50 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Samuel Thibault <samuel.thibault@ens-lyon.org>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Thanks to Samuel Thibault
input device (keyboard) LEDs are no longer hardwired within the input
core but use LED subsystem and so allow use of different triggers; Hans
de Goede did a large update for the ALPS touchpad driver; we have new T=
I
drv2665 haptics driver and DA9063 OnKey driver, and host of other
drivers got various fixes.

Changelog:
---------

Arnd Bergmann (1):
      tty: remove platform_sysrq_reset_seq

Baruch Siach (1):
      MAINTAINERS: remove non existent input mt git tree

Charlie Mooney (1):
      Input: elan_i2c - add product IDs FW names

Dan Murphy (3):
      Input: drv2667 - fix Kconfig error for help screen
      Input: ff-core - fix spelling mistake in ff-core
      Input: add TI drv2665 haptics driver

Dmitry Torokhov (5):
      Input: atmel_mxt_ts - use BIT() macro when reporting button state
      Input: cyapa - do not set otherwise unused variable
      Input: stmpe-ts - fix automatic module loading
      Input: stmpe-ts - enforce device tree only mode
      Input: goodix - do not explicitly set evbits in input device

Dmitry Tunin (1):
      Input: focaltech - report finger width to userspace

Duson Lin (1):
      Input: elan_i2c - add support for multi IC type and iap format

Evgeniy Dushistov (2):
      Input: max7359_keypad - do not set MAX7359_CFG_INTERRUPT flag
      Input: max7359_keypad - switch to using matrix_keypad_build_keyma=
p()

=46abian Frederick (1):
      Input: cyttsp4 - use swap() in cyttsp4_get_touch()

=46abio Estevam (4):
      Input: twl4030-pwrbutton - pass the IRQF_ONESHOT flag
      Input: retu-pwrbutton - pass the IRQF_ONESHOT flag
      Input: twl6040-vibra - pass the IRQF_ONESHOT flag
      Input: wm831x-on - pass the IRQF_ONESHOT flag

=46rodo Lai (1):
      Input: pixcir_i2c_ts - fix receive error

Guido Mart=EDnez (2):
      Input: adp5589-keys - fix pull mask setting
      Input: adp5589-keys - fix event count mask

Hans de Goede (7):
      Input: alps - change alps_decode_rushmore to do all decoding itse=
lf
      Input: alps - only set fields that are actually present
      Input: alps - decode the position packet first
      Input: alps - use more accurate coordinates for first touch in se=
mi-mt mode
      Input: alps - do not use input-mt finger tracking for semi-mt dev=
ices
      Input: alps - rename alps_set_abs_params_mt to alps_set_abs_param=
s_semi_mt
      Input: alps - use the generic process_bitmap function for v5 touc=
hpads

Irina Tirdea (3):
      Input: goodix - fix alignment issues
      Input: goodix - fix variable length array warning
      Input: goodix - export id and version read from device

Khem Raj (1):
      Input: sentelic - use "static inline" instead of "inline"

Krzysztof Kozlowski (2):
      Input: samsung-keypad - constify platform_device_id
      Input: s3c2410_ts - constify platform_device_id

Laurent Pinchart (2):
      DT: i2c: Deprecate adi,adxl34x compatible string
      Input: adxl34x - add OF match support

Marek Vasut (2):
      Input: smtpe-ts - use msecs_to_jiffies() instead of HZ
      Input: smtpe-ts - wait 50mS until polling for pen-up

Paul Cercueil (1):
      Input: goodix - check the 'buffer status' bit before reading data

Pekka Enberg (1):
      Input: evdev - use kvfree() in evdev_release()

Rajeev Kumar (1):
      Input: update email-id of Rajeev Kumar

Samuel Thibault (3):
      Input: export LEDs as class devices in sysfs
      tty/vt/keyboard: define LED triggers for VT LED states
      tty/vt/keyboard: define LED triggers for VT keyboard lock states

Shailendra Verma (5):
      Input: fix typo in comment to input_handler_for_each_handle()
      Input: ff-core - fix typo in comment to input_ff_erase()
      Input: cyapa - fix a few typos in comments
      Input: psmouse - use true instead of 1 for boolean values
      Input: synaptics_i2c - use proper boolean values

Steve Twiss (1):
      Input: add OnKey driver for DA9063 MFD part

Uwe Kleine-K=F6nig (1):
      Input: improve usage of gpiod API

Wei Yongjun (2):
      Input: zforce - remove duplicated include
      Input: soc_button_array - remove duplicated include


Diffstat:
--------

 .../devicetree/bindings/i2c/trivial-devices.txt    |   3 +-
 .../devicetree/bindings/input/ti,drv2665.txt       |  17 ++
 Documentation/leds/leds-class.txt                  |   3 -
 MAINTAINERS                                        |   1 -
 drivers/input/Kconfig                              |  13 +
 drivers/input/Makefile                             |   1 +
 drivers/input/evdev.c                              |   5 +-
 drivers/input/ff-core.c                            |   4 +-
 drivers/input/input-leds.c                         | 212 +++++++++++++=
+
 drivers/input/input.c                              |   2 +-
 drivers/input/keyboard/Kconfig                     |   1 +
 drivers/input/keyboard/adp5589-keys.c              |   6 +-
 drivers/input/keyboard/clps711x-keypad.c           |   7 +-
 drivers/input/keyboard/max7359_keypad.c            |  31 +-
 drivers/input/keyboard/samsung-keypad.c            |   2 +-
 drivers/input/keyboard/spear-keyboard.c            |   2 +-
 drivers/input/misc/Kconfig                         |  23 +-
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/adxl34x-i2c.c                   |  21 ++
 drivers/input/misc/da9063_onkey.c                  | 226 +++++++++++++=
++
 drivers/input/misc/drv260x.c                       |  13 +-
 drivers/input/misc/drv2665.c                       | 322 +++++++++++++=
++++++++
 drivers/input/misc/gpio-beeper.c                   |   7 +-
 drivers/input/misc/retu-pwrbutton.c                |   3 +-
 drivers/input/misc/soc_button_array.c              |   1 -
 drivers/input/misc/twl4030-pwrbutton.c             |   3 +-
 drivers/input/misc/twl6040-vibra.c                 |   3 +-
 drivers/input/misc/wm831x-on.c                     |   3 +-
 drivers/input/mouse/alps.c                         | 244 ++++++++-----=
---
 drivers/input/mouse/alps.h                         |   1 +
 drivers/input/mouse/cyapa_gen3.c                   |   3 +-
 drivers/input/mouse/cyapa_gen5.c                   |  23 +-
 drivers/input/mouse/elan_i2c.h                     |   8 +-
 drivers/input/mouse/elan_i2c_core.c                |  63 +++-
 drivers/input/mouse/elan_i2c_i2c.c                 |   4 +-
 drivers/input/mouse/elan_i2c_smbus.c               |   6 +-
 drivers/input/mouse/focaltech.c                    |  13 +
 drivers/input/mouse/psmouse-base.c                 |   2 +-
 drivers/input/mouse/sentelic.h                     |   4 +-
 drivers/input/mouse/synaptics_i2c.c                |   6 +-
 drivers/input/touchscreen/Kconfig                  |   1 +
 drivers/input/touchscreen/atmel_mxt_ts.c           |   8 +-
 drivers/input/touchscreen/cyttsp4_core.c           |   5 +-
 drivers/input/touchscreen/goodix.c                 |  58 ++--
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   2 +-
 drivers/input/touchscreen/s3c2410_ts.c             |   2 +-
 drivers/input/touchscreen/stmpe-ts.c               |  37 +--
 drivers/input/touchscreen/zforce_ts.c              |   1 -
 drivers/leds/Kconfig                               |   3 -
 drivers/tty/sysrq.c                                |  19 +-
 drivers/tty/vt/keyboard.c                          | 156 ++++++++--
 include/linux/mfd/da9063/pdata.h                   |   1 +
 include/linux/mfd/stmpe.h                          |  44 ---
 include/linux/platform_data/keyboard-spear.h       |   2 +-
 54 files changed, 1278 insertions(+), 375 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,drv2665.=
txt
 create mode 100644 drivers/input/input-leds.c
 create mode 100644 drivers/input/misc/da9063_onkey.c
 create mode 100644 drivers/input/misc/drv2665.c

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
