From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.20-rc0
Date: Tue, 10 Feb 2015 15:23:26 -0800
Message-ID: <20150210232326.GD26472@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f174.google.com ([209.85.223.174]:38235 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751665AbbBJXXb (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 18:23:31 -0500
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive first round of updates for the input subsystem. You will get
a few new drivers (power button handler for AXP20x PMIC, tps65218 power
button driver, sun4i keys driver, regulator haptic driver, NI Ettus
Research USRP E3x0 button, Alwinner A10/A20 PS/2 controller), updates t=
o
Synaptics and ALPS touchpad drivers (with more to come later), brand
new Focaltech PS/2 support, update to Cypress driver to handle Gen5 (in
addition to Gen3) devices, and number of other fixups to various driver=
s
as well as input core.

Changelog:
---------

Anshul Garg (3):
      Input: small tweak to autorepeat handling
      Input: do not try to filter out events if handler is not a filter
      Input: evdev - flush pending events on clock type change

Axel Lin (4):
      Input: regulator-haptic - simplify code
      Input: cap11xx - remove wrong and unneeded cap11xx modalias
      Input: drv260x - remove wrong and unneeded drv260x-haptics modali=
as
      Input: drv2667 - remove wrong and unneeded drv2667-haptics modali=
as

Benjamin Tissoires (3):
      Input: synaptics - use in-kernel tracking for reporting mt data
      Input: synaptics - remove duplicated code
      Input: synaptics - use dmax in input_mt_assign_slots

Brad Griffis (2):
      Input: ti_am335x_tsc - interchange touchscreen and ADC steps
      Input: ti_am335x_tsc - remove udelay in interrupt handler

Carlo Caione (1):
      Input: add driver for AXP20x Power Enable Key

Chen-Yu Tsai (2):
      Input: sun4i-ts - add thermal zone sensor support
      Input: sun4i-ts - add support for touchpanel controller on A31

Dan Carpenter (1):
      Input: cyapa - off by one in cyapa_update_fw_store()

Dmitry Torokhov (4):
      Input: axp20x-pek - switch over to using attribute group
      Input: cyapa - fix endianness issues in gen5 firmware update supp=
ort
      Input: elantech - remove stale comment from Kconfig
      Input: evdev - do not queue SYN_DROPPED if queue is empty

Dudley Du (13):
      Input: cyapa - re-design driver to support multi-trackpad in one =
driver
      Input: cyapa - add gen5 trackpad device basic functions support
      Input: cyapa - add power management interfaces support for the de=
vice
      Input: cyapa - add runtime power management support
      Input: cyapa - add sysfs interfaces support in the cyapa driver
      Input: cyapa - add gen3 trackpad device firmware update support
      Input: cyapa - add gen3 trackpad read baseline support
      Input: cyapa - add gen3 trackpad force re-calibrate support
      Input: cyapa - add gen5 trackpad firmware update support
      Input: cyapa - add gen5 trackpad read baseline support
      Input: cyapa - add gen5 trackpad force re-calibrate function supp=
ort
      Input: cyapa - add acpi device id support
      Input: cyapa - fix variable being dereferenced before check

Duson Lin (1):
      Input: elan_i2c - verify firmware signature applying it

=46abian Frederick (1):
      Input: elants_i2c - remove unnecessary version.h inclusion

=46abio Estevam (1):
      Input: imx_keypad - use the preferred form for passing a size of =
a struct

=46elipe Balbi (1):
      Input: add tps65218 power button driver

Geert Uytterhoeven (1):
      Input: gscps2 - fix MODULE_DEVICE_TABLE invocation

Hans de Goede (1):
      Input: add new sun4i-lradc-keys driver

Henrik Rydberg (1):
      Input: MT - add support for balanced slot assignment

Jaewon Kim (1):
      Input: add regulator haptic driver

Martin Kepplinger (1):
      Input: gtco - use sign_extend32() for sign extension

Mathias Gottschlag (1):
      Input: psmouse - support for the FocalTech PS/2 protocol extensio=
ns

Michael Karcher (1):
      Input: atari - enable the 102nd key for German keyboards

Moritz Fischer (2):
      Input: add support for NI Ettus Research USRP E3x0 button
      MAINTAINERS: add info for e3x0-button driver

Pali Roh=E1r (2):
      Input: alps - fix name, product and version of dev2 input device
      Input: alps - add sanity checks for non DualPoint devices

Rasmus Villemoes (1):
      Input: elan_i2c - fix wrong %p extension

Rob Herring (1):
      Input: pxa27x_keypad - remove unnecessary ARM includes

Vignesh R (3):
      Input: ti_am335x_tsc - read charge delay from DT
      ARM: dts: AM335x: Make charge delay a DT parameter for TSC
      Input: ti_am335x_tsc - replace delta filtering with median filter=
ing

Vishnu Patekar (1):
      Input: serio - add support for Alwinner A10/A20 PS/2 controller


Diffstat:
--------

 .../ABI/testing/sysfs-driver-input-axp-pek         |   11 +
 .../devicetree/bindings/input/e3x0-button.txt      |   25 +
 .../devicetree/bindings/input/regulator-haptic.txt |   21 +
 .../devicetree/bindings/input/sun4i-lradc-keys.txt |   62 +
 .../bindings/input/touchscreen/sun4i.txt           |    4 +-
 .../bindings/input/touchscreen/ti-tsc-adc.txt      |   15 +
 .../bindings/input/tps65218-pwrbutton.txt          |   17 +
 .../bindings/serio/allwinner,sun4i-ps2.txt         |   23 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |   15 +
 arch/arm/boot/dts/am335x-evm.dts                   |    1 +
 drivers/iio/adc/ti_am335x_adc.c                    |    5 +-
 drivers/input/evdev.c                              |   71 +-
 drivers/input/input-mt.c                           |   31 +-
 drivers/input/input.c                              |   38 +-
 drivers/input/keyboard/Kconfig                     |   10 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/atakbd.c                    |    2 +-
 drivers/input/keyboard/cap11xx.c                   |    1 -
 drivers/input/keyboard/imx_keypad.c                |    3 +-
 drivers/input/keyboard/pxa27x_keypad.c             |    5 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |  286 ++
 drivers/input/misc/Kconfig                         |   43 +
 drivers/input/misc/Makefile                        |    4 +
 drivers/input/misc/axp20x-pek.c                    |  290 ++
 drivers/input/misc/drv260x.c                       |    1 -
 drivers/input/misc/drv2667.c                       |    1 -
 drivers/input/misc/e3x0-button.c                   |  157 ++
 drivers/input/misc/regulator-haptic.c              |  266 ++
 drivers/input/misc/tps65218-pwrbutton.c            |  126 +
 drivers/input/mouse/Kconfig                        |   22 +-
 drivers/input/mouse/Makefile                       |    3 +-
 drivers/input/mouse/alps.c                         |   42 +-
 drivers/input/mouse/bcm5974.c                      |    2 +-
 drivers/input/mouse/cyapa.c                        | 1722 +++++++-----
 drivers/input/mouse/cyapa.h                        |  301 +++
 drivers/input/mouse/cyapa_gen3.c                   | 1247 +++++++++
 drivers/input/mouse/cyapa_gen5.c                   | 2777 ++++++++++++=
++++++++
 drivers/input/mouse/cypress_ps2.c                  |    2 +-
 drivers/input/mouse/elan_i2c.h                     |    6 +-
 drivers/input/mouse/elan_i2c_core.c                |   21 +-
 drivers/input/mouse/elan_i2c_i2c.c                 |    1 -
 drivers/input/mouse/elan_i2c_smbus.c               |    3 +-
 drivers/input/mouse/focaltech.c                    |  408 ++-
 drivers/input/mouse/focaltech.h                    |    2 +
 drivers/input/mouse/psmouse-base.c                 |   32 +-
 drivers/input/mouse/psmouse.h                      |    1 +
 drivers/input/mouse/synaptics.c                    |  438 +--
 drivers/input/mouse/synaptics.h                    |   18 +-
 drivers/input/serio/Kconfig                        |   10 +
 drivers/input/serio/Makefile                       |    1 +
 drivers/input/serio/gscps2.c                       |    2 +-
 drivers/input/serio/sun4i-ps2.c                    |  340 +++
 drivers/input/tablet/gtco.c                        |   20 +-
 drivers/input/touchscreen/elants_i2c.c             |    2 -
 drivers/input/touchscreen/pixcir_i2c_ts.c          |    2 +-
 drivers/input/touchscreen/sun4i-ts.c               |   78 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |  197 +-
 include/linux/input/mt.h                           |    3 +-
 include/linux/mfd/ti_am335x_tscadc.h               |    3 +-
 include/linux/platform_data/regulator-haptic.h     |   29 +
 61 files changed, 7963 insertions(+), 1308 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-driver-input-axp-pe=
k
 create mode 100644 Documentation/devicetree/bindings/input/e3x0-button=
=2Etxt
 create mode 100644 Documentation/devicetree/bindings/input/regulator-h=
aptic.txt
 create mode 100644 Documentation/devicetree/bindings/input/sun4i-lradc=
-keys.txt
 create mode 100644 Documentation/devicetree/bindings/input/tps65218-pw=
rbutton.txt
 create mode 100644 Documentation/devicetree/bindings/serio/allwinner,s=
un4i-ps2.txt
 create mode 100644 drivers/input/keyboard/sun4i-lradc-keys.c
 create mode 100644 drivers/input/misc/axp20x-pek.c
 create mode 100644 drivers/input/misc/e3x0-button.c
 create mode 100644 drivers/input/misc/regulator-haptic.c
 create mode 100644 drivers/input/misc/tps65218-pwrbutton.c
 create mode 100644 drivers/input/mouse/cyapa.h
 create mode 100644 drivers/input/mouse/cyapa_gen3.c
 create mode 100644 drivers/input/mouse/cyapa_gen5.c
 create mode 100644 drivers/input/serio/sun4i-ps2.c
 create mode 100644 include/linux/platform_data/regulator-haptic.h

Thanks.

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
