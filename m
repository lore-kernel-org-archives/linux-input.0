From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.8-rc0
Date: Wed, 27 Jul 2016 14:19:28 -0700
Message-ID: <20160727211928.GA24351@dtor-ws>
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

to receive updates for the input subsystem. You will get the following
new drivers promised in the last merge window:

- driver for touchscreen controller found in Surface 3
- driver for Pegasus Notetaker tablet
- driver for Atmel Captouch Buttons
- driver for Raydium I2C touchscreen controllers
- powerkey driver for HISI 65xx SoC

plus a few fixes.

Changelog:
---------

Andrew Duggan (3):
      Input: synaptics-rmi4 - remove pointer to rmi_function in f12_dat=
a
      Input: synaptics-rmi4 - remove unneeded variable
      Input: synaptics-rmi4 - use the RMI_F11_REL_BYTES define in rmi_f=
11_rel_pos_report

Andrew F. Davis (1):
      Input: ti_am335x_tsc - use variable name for sizeof() operator

Arnd Bergmann (2):
      Input: atmel_captouch - add dependence on i2c
      Input: migor-ts - mark PM functions as __maybe_unused

Benjamin Tissoires (1):
      Input: add new driver for the Surface 3

Bjorn Andersson (1):
      Input: synaptics-rmi4 - support regulator supplies

Clifton Barnes (1):
      Input: tc3589x-keypad - remove stray ')'

Colin Ian King (4):
      Input: regulator-haptic - fix spelling mistake: "dveice" -> "devi=
ce"
      Input: tegra-kbc - fix spelling mistake: "porperly" -> "properly"
      Input: ams_delta_serio - fix spelling mistake: "paritiy" -> "pari=
ty"
      Input: apanel - spelling mistake - "skiping" -> "skipping"

Daniel Hung-yu Wu (1):
      Input: add Atmel Captouch Button driver

Dmitry Torokhov (2):
      Input: feed more data into entropy pool
      Input: raydium_i2c_ts - do not ignore EPROBE_DEFER from gpiod_get=
_optional

Hans de Goede (4):
      Input: of_touchscreen - add support for inverted / swapped axes
      Input: edt-ft5x06 - add support for inverting / swapping axes
      Input: icn8318 - use of_touchscreen helpers for inverting / swapp=
ing axes
      Input: pixcir_ts - add support for axis inversion / swapping

Jan Beulich (1):
      Input: xen-kbdfront - prefer xenbus_write() over xenbus_printf() =
where possible

Javier Martinez Canillas (2):
      Input: migor-ts - fix error for modular build
      Input: migor-ts - allow driver to build if COMPILE_TEST is enable=
d

Jeffrey Lin (2):
      Input: add Raydium I2C touchscreen driver
      Input: raydium_i2c_ts - check CRC of incoming packets

Jorge Ramirez-Ortiz (1):
      Input: add powerkey driver for HISI 65xx SoC

KT Liao (1):
      Input: update input_mt_report_pointer_emulation to support hoveri=
ng

Martin Kepplinger (5):
      Input: add Pegasus Notetaker tablet driver
      Input: pegasus_notetaker - handle usb control msg errors
      Input: pegasus_notetaker - fix usb_autopm calls to be balanced
      Input: pegasus_notetaker - cancel workqueue's work in suspend()
      Input: pegasus_notetaker - set device mode in reset_resume() if i=
n use

Masanari Iida (1):
      Input: fix a double word "is is" in include/linux/input.h

Muhammad Falak R Wani (1):
      Input: tty/vt/keyboard - use memdup_user()

Nick Dyer (1):
      Input: synaptics-rmi4 - fix spelling in defines

Pali Roh=E1r (1):
      Input: psmouse - use same format for secondary devices as for pri=
mary

Ping Cheng (2):
      Input: wacom_w8001 - resolution wasn't set for ABS_MT_POSITION_X/=
Y
      Input: wacom_w8001 - handle errors from input_mt_init_slots()

Stephen Just (2):
      Input: surface3_spi - Prepare to add support for Surface Pen
      Input: surface3_spi - add surface pen support for Surface 3


Diffstat:
--------

 .../devicetree/bindings/input/atmel,captouch.txt   |   36 +
 .../devicetree/bindings/input/raydium_i2c_ts.txt   |   20 +
 .../devicetree/bindings/input/rmi4/rmi_i2c.txt     |    9 +
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/input/input-mt.c                           |   17 +-
 drivers/input/input.c                              |    7 +-
 drivers/input/keyboard/tc3589x-keypad.c            |    2 +-
 drivers/input/keyboard/tegra-kbc.c                 |    2 +-
 drivers/input/misc/Kconfig                         |   23 +
 drivers/input/misc/Makefile                        |    2 +
 drivers/input/misc/apanel.c                        |    2 +-
 drivers/input/misc/atmel_captouch.c                |  290 +++++
 drivers/input/misc/hisi_powerkey.c                 |  142 +++
 drivers/input/misc/regulator-haptic.c              |    2 +-
 drivers/input/misc/xen-kbdfront.c                  |    8 +-
 drivers/input/mouse/elantech.c                     |    2 +-
 drivers/input/mouse/lifebook.c                     |    2 +-
 drivers/input/rmi4/rmi_f01.c                       |   22 +-
 drivers/input/rmi4/rmi_f11.c                       |    9 +-
 drivers/input/rmi4/rmi_f12.c                       |    1 -
 drivers/input/rmi4/rmi_i2c.c                       |   46 +
 drivers/input/serio/ams_delta_serio.c              |    2 +-
 drivers/input/tablet/Kconfig                       |   15 +
 drivers/input/tablet/Makefile                      |    1 +
 drivers/input/tablet/pegasus_notetaker.c           |  450 +++++++
 drivers/input/touchscreen/Kconfig                  |   28 +-
 drivers/input/touchscreen/Makefile                 |    2 +
 drivers/input/touchscreen/ad7879.c                 |    2 +-
 drivers/input/touchscreen/chipone_icn8318.c        |   61 +-
 drivers/input/touchscreen/cyttsp_core.c            |    2 +-
 drivers/input/touchscreen/edt-ft5x06.c             |    7 +-
 drivers/input/touchscreen/migor_ts.c               |    6 +-
 drivers/input/touchscreen/of_touchscreen.c         |   81 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |   53 +-
 drivers/input/touchscreen/raydium_i2c_ts.c         | 1238 ++++++++++++=
++++++++
 drivers/input/touchscreen/surface3_spi.c           |  427 +++++++
 drivers/input/touchscreen/ti_am335x_tsc.c          |    2 +-
 drivers/input/touchscreen/tsc200x-core.c           |    2 +-
 drivers/input/touchscreen/wacom_w8001.c            |   10 +-
 include/linux/input.h                              |    2 +-
 include/linux/input/touchscreen.h                  |   21 +-
 41 files changed, 2928 insertions(+), 129 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/atmel,capto=
uch.txt
 create mode 100644 Documentation/devicetree/bindings/input/raydium_i2c=
_ts.txt
 create mode 100644 drivers/input/misc/atmel_captouch.c
 create mode 100644 drivers/input/misc/hisi_powerkey.c
 create mode 100644 drivers/input/tablet/pegasus_notetaker.c
 create mode 100644 drivers/input/touchscreen/raydium_i2c_ts.c
 create mode 100644 drivers/input/touchscreen/surface3_spi.c

--=20
Dmitry
