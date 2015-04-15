From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.1-rc0
Date: Tue, 14 Apr 2015 17:12:14 -0700
Message-ID: <20150415001214.GC22757@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:34113 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751768AbbDOAMT (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 14 Apr 2015 20:12:19 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get the following
new drivers: Qualcomm PM8941 power key drver, ChipOne icn8318
touchscreen controller driver, Broadcom iProc touchscreen and keypad
drivers, and Semtech SX8654 I2C touchscreen controller driver. ALPS
driver now supports newer SS4 devices; Elantech got a fix that should
make it work on some ASUS laptops; and a slew of other enhancements and
random fixes.

Changelog:
---------

Aaron Sierra (1):
      Input: tsc2007 - Convert msecs to jiffies only once

Aleksei Mamlin (2):
      Input: goodix - use max touch number from device config
      Input: goodix - add device tree support

Benjamin Tissoires (3):
      Input: MT - make slot assignment work for overcovered solutions
      Input: Revert "Revert "synaptics - use dmax in input_mt_assign_sl=
ots""
      Input: synaptics - allocate 3 slots to keep stability in image se=
nsors

Brian K. Turner (1):
      Input: lifebook - fix tabbing issue

Charlie Mooney (1):
      Input: elants_i2c - append hw_version to FW file

Courtney Cavin (1):
      Input: add Qualcomm PM8941 power key driver

Dan Carpenter (1):
      Input: sx8654 - signedness bug in sx8654_irq()

Dmitry Torokhov (5):
      Input: psmouse - when comparing PNP IDs ignore case
      Input: synaptics - switch ForcePad detection to PNP IDs
      Input: pwm-beeper - remove unneeded PWM_BEEPER_PM_OPS define
      Input: mma8450 - convert to using managed resources
      Input: atkbd - document "no new force-release quirks" policy

Duson Lin (2):
      Input: elan_i2c - return error code when resume fails
      Input: elan_i2c - remove duplicate repeat code

=46abian Frederick (1):
      Input: constify of_device_id arrays

=46engguang Wu (1):
      Input: ALPS - make alps_get_pkt_id_ss4_v2() and others static

Hans de Goede (6):
      Input: sun4i-ts -  A10 (sun4i) has a different temperature curve
      Input: sun4i-ts - really fix A10 temperature reporting
      Input: touchscreen DT binding - add touchscreen-swapped-x-y prope=
rty
      Input: add support for ChipOne icn8318 based touchscreens
      Input: alps - fix touchpad buttons getting stuck when used with t=
rackpoint
      Input: alps - non interleaved V2 dualpoint has separate stick but=
ton bits

Jaewon Kim (1):
      Input: add haptic support for max77843

Jens Thiele (1):
      Input: sun4i-ts - allow controlling filter and sensitivity via DT

Jonathan Richardson (1):
      Input: add Broadcom iProc touchscreen driver

Lars Poeschel (1):
      Input: usbtouchscreen - add new model from IRTOUCHSYSTEMS

Linus Walleij (3):
      Input: driver for microcontroller keys on the iPaq h3xxx
      Input: tc3589x - localize platform data
      mfd: tc3589x: enforce device-tree only mode

Masaki Ota (3):
      Input: ALPS - refactor alps_set_abs_params_mt()
      Input: ALPS - add support for SS4 touchpad devices
      Input: ALPS - V7 devices can report 5-finger taps

Maxime Ripard (4):
      Input: of_touchscreen - rework the DT parsing function
      Input: of_touchscreen - register multitouch axes
      Input: edt-ft5x06 - allow to setting the maximum axes value throu=
gh the DT
      Input: edt-ft5x06 - remove EV_SYN event report

Michael S. Tsirkin (1):
      Input: gscps2 - drop pci_ids dependency

Nick Dyer (1):
      Input: atmel_mxt_ts - implement support for T100 touch object

Nicolas Iooss (1):
      Input: elan_i2c - fix typo in include header guard

Olivier Sobrie (1):
      Input: pwm-beeper - remove useless call to pwm_config()

Rafael J. Wysocki (1):
      Input: i8042 - allow KBD and AUX ports to wake up from suspend-to=
-idle

Scott Branden (1):
      Input: add driver for Broadcom keypad controller

Sjoerd Simons (1):
      Input: atmel_mxt_ts - split out touchpad initialisation logic

Stefan Br=FCns (2):
      Input: rename KEY_DIRECTION to KEY_ROTATE_DISPLAY
      Input: use more descriptive KEY_ROTATE_DISPLAY instead of KEY_DIR=
ECTION

S=E9bastien Szymanski (1):
      Input: add support for Semtech SX8654 I2C touchscreen controller

Tomeu Vizoso (1):
      Input: cros_ec_keyb - fix clearing keyboard state on wakeup

Ulrik De Bie (1):
      Input: elantech - fix absolute mode setting on some ASUS laptops


Diffstat:
--------

 .../devicetree/bindings/input/brcm,bcm-keypad.txt  | 108 +++++
 .../bindings/input/qcom,pm8941-pwrkey.txt          |  43 ++
 .../input/touchscreen/brcm,iproc-touchscreen.txt   |  76 +++
 .../bindings/input/touchscreen/chipone_icn8318.txt |  46 ++
 .../bindings/input/touchscreen/goodix.txt          |  29 ++
 .../bindings/input/touchscreen/sun4i.txt           |  22 +-
 .../bindings/input/touchscreen/sx8654.txt          |  16 +
 .../bindings/input/touchscreen/touchscreen.txt     |   2 +
 .../devicetree/bindings/vendor-prefixes.txt        |   2 +
 MAINTAINERS                                        |   7 +
 drivers/gpio/Kconfig                               |   1 +
 drivers/gpio/gpio-tc3589x.c                        |   3 -
 drivers/hid/hid-debug.c                            |   2 +-
 drivers/input/input-mt.c                           |  26 +-
 drivers/input/keyboard/Kconfig                     |  21 +
 drivers/input/keyboard/Makefile                    |   2 +
 drivers/input/keyboard/atkbd.c                     |   6 +
 drivers/input/keyboard/bcm-keypad.c                | 458 +++++++++++++=
+++++
 drivers/input/keyboard/cros_ec_keyb.c              |   2 +-
 drivers/input/keyboard/ipaq-micro-keys.c           | 168 +++++++
 drivers/input/keyboard/tc3589x-keypad.c            |  42 +-
 drivers/input/misc/Kconfig                         |  24 +
 drivers/input/misc/Makefile                        |   2 +
 drivers/input/misc/max77843-haptic.c               | 358 +++++++++++++=
+
 drivers/input/misc/mma8450.c                       |  35 +-
 drivers/input/misc/palmas-pwrbutton.c              |   2 +-
 drivers/input/misc/pm8941-pwrkey.c                 | 293 ++++++++++++
 drivers/input/misc/pwm-beeper.c                    |   9 +-
 drivers/input/misc/regulator-haptic.c              |   2 +-
 drivers/input/misc/tps65218-pwrbutton.c            |   2 +-
 drivers/input/mouse/alps.c                         | 381 +++++++++++++=
+-
 drivers/input/mouse/alps.h                         |  78 ++-
 drivers/input/mouse/elan_i2c.h                     |   2 +-
 drivers/input/mouse/elan_i2c_core.c                |  15 +-
 drivers/input/mouse/elan_i2c_i2c.c                 |  10 +-
 drivers/input/mouse/elantech.c                     |  22 +
 drivers/input/mouse/elantech.h                     |   1 +
 drivers/input/mouse/lifebook.c                     |   6 +-
 drivers/input/mouse/psmouse-base.c                 |  40 +-
 drivers/input/mouse/synaptics.c                    |  42 +-
 drivers/input/mouse/synaptics.h                    |   1 +
 drivers/input/serio/gscps2.c                       |   1 -
 drivers/input/serio/i8042.c                        |  28 +-
 drivers/input/touchscreen/Kconfig                  |  41 +-
 drivers/input/touchscreen/Makefile                 |   3 +
 drivers/input/touchscreen/ar1021_i2c.c             |   2 +-
 drivers/input/touchscreen/atmel_mxt_ts.c           | 391 +++++++++++++=
--
 drivers/input/touchscreen/bcm_iproc_tsc.c          | 522 +++++++++++++=
++++++++
 drivers/input/touchscreen/chipone_icn8318.c        | 316 +++++++++++++
 drivers/input/touchscreen/edt-ft5x06.c             |   6 +-
 drivers/input/touchscreen/elants_i2c.c             |  14 +-
 drivers/input/touchscreen/goodix.c                 |  36 +-
 drivers/input/touchscreen/of_touchscreen.c         |  62 ++-
 drivers/input/touchscreen/sun4i-ts.c               |  46 +-
 drivers/input/touchscreen/sx8654.c                 | 286 +++++++++++
 drivers/input/touchscreen/tsc2007.c                |  11 +-
 drivers/input/touchscreen/usbtouchscreen.c         |  11 +
 drivers/mfd/Kconfig                                |   1 +
 drivers/mfd/tc3589x.c                              |   9 -
 drivers/platform/x86/fujitsu-tablet.c              |   6 +-
 drivers/platform/x86/hp-wmi.c                      |   2 +-
 include/linux/mfd/tc3589x.h                        |  23 -
 include/uapi/linux/input.h                         |   3 +-
 63 files changed, 3967 insertions(+), 260 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/brcm,bcm-ke=
ypad.txt
 create mode 100644 Documentation/devicetree/bindings/input/qcom,pm8941=
-pwrkey.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/brcm,iproc-touchscreen.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/chipone_icn8318.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/goodix.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/sx8654.txt
 create mode 100644 drivers/input/keyboard/bcm-keypad.c
 create mode 100644 drivers/input/keyboard/ipaq-micro-keys.c
 create mode 100644 drivers/input/misc/max77843-haptic.c
 create mode 100644 drivers/input/misc/pm8941-pwrkey.c
 create mode 100644 drivers/input/touchscreen/bcm_iproc_tsc.c
 create mode 100644 drivers/input/touchscreen/chipone_icn8318.c
 create mode 100644 drivers/input/touchscreen/sx8654.c

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
