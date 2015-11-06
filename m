From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.4-rc0
Date: Fri, 6 Nov 2015 11:24:32 -0800
Message-ID: <20151106192432.GA14196@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Items of note:

- evdev users can now limit or mask the kind of events they will
  receive. This will allow applications such as power manager or networ=
k
  manager to only be woken when user presses special keys such as
  KEY_POWER or KEY_WIFI and not be bothered with ordinary key presses
  coming from keyboard;
- support for FocalTech FT6236 touchscreen controller;
- support for ROHM BU21023/24 touchscreen controller;
- edt-ft5x06 touchscreen driver got a face lift and can now be used wit=
h
  FT5506;
- support for Google Fiber TV Box remote controls;
- improvements in xpad driver (with more to come);
- several parport-based drivers have been switched to the new device
  model;
- other miscellaneous driver improvements.

Changelog:
---------

Aniroop Mathur (1):
      Input: evdev - fix bug in checking duplicate clock change request

Arnd Bergmann (1):
      HID: hid-gfrm: avoid warning for input_configured API change

Ben Gamari (1):
      Input: rotary-encoder - use of_property_read_bool

Bjorn Andersson (1):
      Input: gpio_keys - don't report events on gpio failure

Dan Carpenter (1):
      Input: ff-core - silence an underflow warning

Dario Scarpa (1):
      Input: xpad - fix Razer Atrox Arcade Stick button mapping

David Herrmann (1):
      Input: evdev - add event-mask API

Dmitry Torokhov (7):
      Input: edt-ft5x06 - drop parsing of irq gpio
      Input: edt-ft5x06 - remove support for platform data
      Input: edt-ft5x06 - use generic properties API
      Input: edt-ft5x06 - do not hardcode interrupt trigger type
      ARM: dts: set up trigger type for edt-ft5x06 interrupts
      Input: ft6236 - change module license string to match copyright n=
otice
      HID: hid-input: allow input_configured callback return errors

Elias Vanderstuyft (2):
      Input: fix EVIOCSFF macro inconsistency by using _IOW()
      Input: document and check on implicitly defined FF_MAX_EFFECTS

Erik Lundgren (1):
      Input: xpad - add Covert Forces edition of the Xbox One controlle=
r

Ezequiel Garcia (1):
      Input: rotary-encoder - add support for quarter-period mode

=46engguang Wu (1):
      Input: ft6236 - do not explicitly set driver's owner

=46ranklin S Cooper Jr (6):
      Input: edt-ft5x06 - switch to newer gpio framework
      Input: edt-ft5x06 - do not call desc_to_gpio for invalid gpios
      Input: edt-ft5x06 - use max support points to determine how much =
to read
      Input: edt-ft5x06 - add support for different max support points
      Input: edt-ft5x06 - add support for FT5506
      Input: edt-ft5x06 - work around FT5506 firmware bug

Geliang Tang (1):
      Input: nomadik-ske-keypad - fix a trivial typo

Hans de Goede (3):
      Input: gpio_keys_polled - add support for abs/rel axis
      Input: add input-event-codes header file
      devicetree: bindings: Use linux-event-codes.h for evdev codes

Insu Yun (1):
      Input: xen - check return value of xenbus_printf

Javier Martinez Canillas (10):
      Input: goldfish - allow compile the driver with COMPILE_TEST
      Input: joydev - use memdup_user() to duplicate memory from user-s=
pace
      Input: kxtj9 - remove unneeded retval variable
      Input: zforce - simplify function return logic
      Input: auo-pixcir-ts - simplify function return logic
      Input: tps6507x-ts - simplify function return logic
      Input: ads7846 - use PTR_ERR_OR_ZERO()
      Input: cyttsp - use PTR_ERR_OR_ZERO()
      Input: joydev - fix possible ERR_PTR() dereferencing
      Input: snvs_pwrkey - remove duplicated semicolon

Moritz Fischer (1):
      Input: e3x0-button - update Kconfig description

Noralf Tr=F8nnes (1):
      Input: add support for FocalTech FT6236 touchscreen controller

Pavel Rojtberg (7):
      Input: xpad - clarify LED enumeration
      Input: xpad - use ida() for finding the pad_nr
      Input: xpad - remove needless bulk out URB used for LED setup
      Input: xpad - factor out URB submission in xpad_play_effect
      Input: xpad - x360w: report dpad as buttons and axes
      Input: xpad - query wireless controller state at init
      Input: xpad - fix clash of presence handling with LED setting

Petri Gynther (2):
      Input: improve autorepeat initialization
      HID: hid-gfrm: Google Fiber TV Box remote controls

Pierre-Loup A. Griffais (1):
      Input: xpad - move the input device creation to a new function

S Twiss (1):
      Input: add DA9062 OnKey capability to DA9063 OnKey driver

Stephen Chandler Paul (1):
      Input: add userio module

Sudeep Holla (2):
      Input: tegra-kbc - enable support for the standard "wakeup-source=
" property
      Input: tegra-kbc - drop use of IRQF_NO_SUSPEND flag

Sudip Mukherjee (9):
      Input: db9 - use parallel port device model
      Input: omap4-keypad - fix memory leak
      Input: gamecon - use parallel port device model
      Input: turbografx - use parallel port device model
      Input: walkera0701 - use parallel port device model
      Input: db9 - store object at correct index
      Input: gamecon - store object at correct index
      Input: turbografx - store object in correct index
      Input: parkbd - use parallel port device model

Sylvain Rochet (1):
      Input: rotary_encoder - add wake up support

Vaishali Thakkar (1):
      Input: ad714x - convert to using managed resources

Vignesh R (1):
      Input: pixcir_i2c_ts - remove wakeirq related code from pixcir dr=
iver

WEN Pingbo (1):
      Input: hp_sdc_rtc - fix y2038 problem in proc_show

Yoichi Yuasa (1):
      Input: add support for ROHM BU21023/24 touchscreen


Diffstat:
--------

 .../devicetree/bindings/input/da9062-onkey.txt     |   32 +
 .../devicetree/bindings/input/gpio-keys-polled.txt |    9 +-
 .../devicetree/bindings/input/rotary-encoder.txt   |   10 +
 .../bindings/input/touchscreen/edt-ft5x06.txt      |    8 +-
 .../input/touchscreen/focaltech-ft6236.txt         |   35 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 Documentation/input/rotary-encoder.txt             |    9 +-
 Documentation/input/userio.txt                     |   70 ++
 MAINTAINERS                                        |    6 +
 arch/arm/boot/dts/am437x-sk-evm.dts                |    2 +-
 arch/arm/boot/dts/imx28-tx28.dts                   |    3 +-
 arch/arm/boot/dts/imx53-tx53-x03x.dts              |    3 +-
 arch/arm/boot/dts/imx6qdl-tx6.dtsi                 |    3 +-
 drivers/hid/Kconfig                                |    6 +
 drivers/hid/Makefile                               |    1 +
 drivers/hid/hid-appleir.c                          |    4 +-
 drivers/hid/hid-elo.c                              |    4 +-
 drivers/hid/hid-gfrm.c                             |  159 +++
 drivers/hid/hid-input.c                            |   10 +-
 drivers/hid/hid-lenovo.c                           |    4 +-
 drivers/hid/hid-logitech-hidpp.c                   |    4 +-
 drivers/hid/hid-magicmouse.c                       |    8 +-
 drivers/hid/hid-multitouch.c                       |   20 +-
 drivers/hid/hid-ntrig.c                            |    6 +-
 drivers/hid/hid-rmi.c                              |   11 +-
 drivers/hid/hid-sony.c                             |   13 +-
 drivers/hid/hid-uclogic.c                          |    6 +-
 drivers/input/evdev.c                              |  270 ++++-
 drivers/input/ff-core.c                            |    9 +-
 drivers/input/input.c                              |   25 +-
 drivers/input/joydev.c                             |   22 +-
 drivers/input/joystick/db9.c                       |  113 +-
 drivers/input/joystick/gamecon.c                   |  103 +-
 drivers/input/joystick/turbografx.c                |  104 +-
 drivers/input/joystick/walkera0701.c               |   64 +-
 drivers/input/joystick/xpad.c                      |  534 +++++----
 drivers/input/keyboard/Kconfig                     |    2 +-
 drivers/input/keyboard/gpio_keys.c                 |    8 +-
 drivers/input/keyboard/gpio_keys_polled.c          |   88 +-
 drivers/input/keyboard/nomadik-ske-keypad.c        |    2 +-
 drivers/input/keyboard/snvs_pwrkey.c               |    3 +-
 drivers/input/keyboard/tegra-kbc.c                 |    5 +-
 drivers/input/misc/Kconfig                         |   12 +-
 drivers/input/misc/ad714x-i2c.c                    |   10 -
 drivers/input/misc/ad714x-spi.c                    |   10 -
 drivers/input/misc/ad714x.c                        |  214 ++--
 drivers/input/misc/ad714x.h                        |    1 -
 drivers/input/misc/da9063_onkey.c                  |  129 ++-
 drivers/input/misc/hp_sdc_rtc.c                    |   52 +-
 drivers/input/misc/kxtj9.c                         |    3 +-
 drivers/input/misc/rotary_encoder.c                |  129 ++-
 drivers/input/misc/xen-kbdfront.c                  |   10 +-
 drivers/input/serio/Kconfig                        |   14 +
 drivers/input/serio/Makefile                       |    1 +
 drivers/input/serio/parkbd.c                       |   55 +-
 drivers/input/serio/userio.c                       |  285 +++++
 drivers/input/touchscreen/Kconfig                  |   24 +
 drivers/input/touchscreen/Makefile                 |    2 +
 drivers/input/touchscreen/ads7846.c                |    4 +-
 drivers/input/touchscreen/auo-pixcir-ts.c          |    7 +-
 drivers/input/touchscreen/cyttsp4_i2c.c            |    5 +-
 drivers/input/touchscreen/edt-ft5x06.c             |  246 ++--
 drivers/input/touchscreen/ft6236.c                 |  326 ++++++
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   12 -
 drivers/input/touchscreen/rohm_bu21023.c           | 1218 ++++++++++++=
++++++++
 drivers/input/touchscreen/tps6507x-ts.c            |    9 +-
 drivers/input/touchscreen/zforce_ts.c              |    7 +-
 include/dt-bindings/input/input.h                  |  510 +-------
 include/dt-bindings/input/linux-event-codes.h      |    1 +
 include/linux/hid.h                                |    4 +-
 include/linux/input.h                              |    2 +
 include/linux/input/edt-ft5x06.h                   |   24 -
 include/linux/miscdevice.h                         |    1 +
 include/linux/rotary_encoder.h                     |    3 +-
 include/uapi/linux/Kbuild                          |    1 +
 include/uapi/linux/input-event-codes.h             |  805 ++++++++++++=
+
 include/uapi/linux/input.h                         |  850 ++----------=
--
 include/uapi/linux/userio.h                        |   44 +
 78 files changed, 4547 insertions(+), 2282 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/da9062-onke=
y.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/focaltech-ft6236.txt
 create mode 100644 Documentation/input/userio.txt
 create mode 100644 drivers/hid/hid-gfrm.c
 create mode 100644 drivers/input/serio/userio.c
 create mode 100644 drivers/input/touchscreen/ft6236.c
 create mode 100644 drivers/input/touchscreen/rohm_bu21023.c
 create mode 120000 include/dt-bindings/input/linux-event-codes.h
 delete mode 100644 include/linux/input/edt-ft5x06.h
 create mode 100644 include/uapi/linux/input-event-codes.h
 create mode 100644 include/uapi/linux/userio.h

--=20
Dmitry
