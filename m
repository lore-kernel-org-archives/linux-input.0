From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.6-rc0
Date: Thu, 17 Mar 2016 14:16:32 -0700
Message-ID: <20160317211632.GB21461@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f177.google.com ([209.85.192.177]:35585 "EHLO
	mail-pf0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756513AbcCQVQf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 17 Mar 2016 17:16:35 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. The most notable item is
addition of support for Synaptics RMI4 protocol which is native protoco=
l
for all current Synaptics devices (touchscreens, touchpads). In later
releases we'll switch devices using HID and PS/2 protocol emulation to
RMI4.

You will also get:
- BYD PS/2 touchpad protocol support for psmouse
- MELFAS MIP4 Touchscreen driver
- rotary encoder was moved away from legacy platform data and to generi=
c
  device properties API, devm_* API, and can now handle encoders using
  more than 2 GPIOs
- Cypress touchpad driver was switched to devm_* API and device
  properties
- other assorted driver fixes

Changelog:
---------

Andreas F=E4rber (1):
      MAINTAINERS: add devicetree bindings to Input Drivers section

Andrew Duggan (9):
      Input: synaptics-rmi4 - add support for Synaptics RMI4 devices
      Input: synaptics-rmi4 - add I2C transport driver
      Input: synaptics-rmi4 - add device tree support for RMI4 I2C devi=
ces
      Input: synaptics-rmi4 - add support for 2D sensors and F11
      Input: synaptics-rmi4 - add device tree support for 2d sensors an=
d F11
      Input: synaptics-rmi4 - add support for F12
      Input: synaptics-rmi4 - add support for F30
      Input: synaptics-rmi4 - add SPI transport driver
      Input: synaptics-rmi4 - add device tree support to the SPI transp=
ort driver

Arnd Bergmann (3):
      Input: spear-keyboard - use __maybe_unused to hide pm functions
      Input: snvs_pwrkey - use __maybe_unused to hide pm functions
      ARM: pxa/raumfeld: use PROPERTY_ENTRY_INTEGER to define props

Chris Diamand (1):
      Input: byd - add BYD PS/2 touchpad driver

Dan Carpenter (1):
      Input: synaptics-rmi4 - using logical instead of bitwise AND

Dmitry Torokhov (4):
      Input: rotary_encoder - mark PM methods as __maybe_unused
      Input: rotary_encoder - convert to use gpiod API
      Input: rotary_encoder - use input_set_capability()
      Input: rotary_encoder - move away from platform data structure

Dudley Du (1):
      Input: cyapa - fix for losing events during device power transiti=
ons

Geert Uytterhoeven (1):
      Input: Allow compile test of Goodix and Colibri VF50 if !GPIOLIB

Greg Hackmann (1):
      Input: goldfish_events - add devicetree bindings

Jason Hu (1):
      Input: goldfish_events - enable ACPI-based enumeration for goldfi=
sh events

Jean Delvare (1):
      Input: ts4800 - add hardware dependency

Josh Boyer (1):
      Input: powermate - fix oops with malicious USB descriptors

Linus Walleij (1):
      Input: stmpe-ts - restore kerneldoc

Oreste Salerno (4):
      Input: cyttsp - use devres managed resource allocations
      Input: cyttsp - check return value of input_mt_init_slots
      Input: cyttsp - switch to using device properties
      Input: cyttsp - perform hard reset of the chip during probe

Sangwon Jee (2):
      Input: add MELFAS MIP4 Touchscreen driver
      Input: melfas_mip4 - add resolution reporting

Simon Horman (1):
      Input: sh_keysc - remove dependency on SUPERH

Stefan Agner (3):
      Input: ad7879 - move header to platform_data directory
      Input: ad7879 - fix default x/y axis assignment
      Input: ad7879 - add device tree support

Timo Ter=E4s (2):
      Input: rotary_encoder - convert to devm-* api
      Input: rotary_encoder - use threaded irqs

Uwe Kleine-K=F6nig (1):
      Input: rotary-encoder - support more than 2 gpios as input

Vladimir Zapolskiy (1):
      Input: snvs_pwrkey - fix returned value check of syscon_regmap_lo=
okup_by_phandle()


Diffstat:
--------

 .../devicetree/bindings/goldfish/events.txt        |   17 +
 .../bindings/input/rmi4/rmi_2d_sensor.txt          |   56 +
 .../devicetree/bindings/input/rmi4/rmi_f01.txt     |   39 +
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |   53 +
 .../devicetree/bindings/input/rmi4/rmi_spi.txt     |   57 +
 .../devicetree/bindings/input/rotary-encoder.txt   |    2 +-
 .../bindings/input/touchscreen/ad7879.txt          |   53 +
 .../bindings/input/touchscreen/cyttsp.txt          |   95 ++
 .../bindings/input/touchscreen/touchscreen.txt     |    2 +
 Documentation/devicetree/bindings/spi/spi-bus.txt  |    2 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 MAINTAINERS                                        |    1 +
 arch/arm/mach-pxa/raumfeld.c                       |   43 +-
 arch/blackfin/mach-bf527/boards/ezbrd.c            |    2 +-
 arch/blackfin/mach-bf527/boards/ezkit.c            |    2 +-
 arch/blackfin/mach-bf527/boards/tll6527m.c         |    2 +-
 arch/blackfin/mach-bf537/boards/stamp.c            |    2 +-
 arch/blackfin/mach-bf538/boards/ezkit.c            |    2 +-
 drivers/input/Kconfig                              |    2 +
 drivers/input/Makefile                             |    2 +
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/goldfish_events.c           |   17 +
 drivers/input/keyboard/snvs_pwrkey.c               |    8 +-
 drivers/input/keyboard/spear-keyboard.c            |    6 +-
 drivers/input/misc/powermate.c                     |    3 +
 drivers/input/misc/rotary_encoder.c                |  403 ++----
 drivers/input/mouse/Kconfig                        |   10 +
 drivers/input/mouse/Makefile                       |    1 +
 drivers/input/mouse/byd.c                          |  337 +++++
 drivers/input/mouse/byd.h                          |   18 +
 drivers/input/mouse/cyapa.c                        |   22 +-
 drivers/input/mouse/cyapa.h                        |   14 +-
 drivers/input/mouse/cyapa_gen3.c                   |  108 +-
 drivers/input/mouse/cyapa_gen5.c                   |   99 +-
 drivers/input/mouse/cyapa_gen6.c                   |    4 +-
 drivers/input/mouse/psmouse-base.c                 |   14 +
 drivers/input/mouse/psmouse.h                      |    1 +
 drivers/input/rmi4/Kconfig                         |   63 +
 drivers/input/rmi4/Makefile                        |   13 +
 drivers/input/rmi4/rmi_2d_sensor.c                 |  329 +++++
 drivers/input/rmi4/rmi_2d_sensor.h                 |   87 ++
 drivers/input/rmi4/rmi_bus.c                       |  419 ++++++
 drivers/input/rmi4/rmi_bus.h                       |  182 +++
 drivers/input/rmi4/rmi_driver.c                    | 1055 ++++++++++++=
++
 drivers/input/rmi4/rmi_driver.h                    |  105 ++
 drivers/input/rmi4/rmi_f01.c                       |  624 ++++++++
 drivers/input/rmi4/rmi_f11.c                       | 1317 ++++++++++++=
+++++
 drivers/input/rmi4/rmi_f12.c                       |  457 ++++++
 drivers/input/rmi4/rmi_f30.c                       |  407 ++++++
 drivers/input/rmi4/rmi_i2c.c                       |  397 +++++
 drivers/input/rmi4/rmi_spi.c                       |  589 ++++++++
 drivers/input/touchscreen/Kconfig                  |   17 +-
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/ad7879-i2c.c             |   10 +
 drivers/input/touchscreen/ad7879-spi.c             |   10 +
 drivers/input/touchscreen/ad7879.c                 |  160 ++-
 drivers/input/touchscreen/cyttsp_core.c            |  194 ++-
 drivers/input/touchscreen/cyttsp_core.h            |   10 +-
 drivers/input/touchscreen/cyttsp_i2c.c             |   10 -
 drivers/input/touchscreen/cyttsp_spi.c             |   10 -
 drivers/input/touchscreen/melfas_mip4.c            | 1517 ++++++++++++=
++++++++
 drivers/input/touchscreen/stmpe-ts.c               |   31 +
 include/linux/input/cyttsp.h                       |   15 -
 include/linux/{spi =3D> platform_data}/ad7879.h      |    2 +-
 include/linux/rmi.h                                |  359 +++++
 include/linux/rotary_encoder.h                     |   17 -
 include/uapi/linux/input.h                         |    1 +
 67 files changed, 9387 insertions(+), 523 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/goldfish/events.t=
xt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_2d=
_sensor.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_f0=
1.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_i2=
c.txt
 create mode 100644 Documentation/devicetree/bindings/input/rmi4/rmi_sp=
i.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/ad7879.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/cyttsp.txt
 create mode 100644 drivers/input/mouse/byd.c
 create mode 100644 drivers/input/mouse/byd.h
 create mode 100644 drivers/input/rmi4/Kconfig
 create mode 100644 drivers/input/rmi4/Makefile
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.c
 create mode 100644 drivers/input/rmi4/rmi_2d_sensor.h
 create mode 100644 drivers/input/rmi4/rmi_bus.c
 create mode 100644 drivers/input/rmi4/rmi_bus.h
 create mode 100644 drivers/input/rmi4/rmi_driver.c
 create mode 100644 drivers/input/rmi4/rmi_driver.h
 create mode 100644 drivers/input/rmi4/rmi_f01.c
 create mode 100644 drivers/input/rmi4/rmi_f11.c
 create mode 100644 drivers/input/rmi4/rmi_f12.c
 create mode 100644 drivers/input/rmi4/rmi_f30.c
 create mode 100644 drivers/input/rmi4/rmi_i2c.c
 create mode 100644 drivers/input/rmi4/rmi_spi.c
 create mode 100644 drivers/input/touchscreen/melfas_mip4.c
 rename include/linux/{spi =3D> platform_data}/ad7879.h (96%)
 create mode 100644 include/linux/rmi.h
 delete mode 100644 include/linux/rotary_encoder.h

--=20
Dmitry

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
