From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.2-rc0
Date: Mon, 13 May 2019 13:12:35 -0700
Message-ID: <20190513201235.GA87488@dtor-ws>
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

to receive updates for the input subsystem. You will get a few new
drivers:

- driver for Azoteq IQS550/572/525 touch controllers
- driver for Microchip AT42QT1050 keys
- driver for GPIO controllable vibrators
- support for GT5663 in Goodix driver

along with miscellaneous driver fixes.


Changelog:
---------

Andy Shevchenko (2):
      Input: edt-ft5x06 - enable ACPI enumeration
      Input: edt-ft5x06 - convert to use SPDX identifier

Anson Huang (1):
      Input: snvs_pwrkey - use dev_pm_set_wake_irq() to simplify code

Dmitry Torokhov (3):
      Input: i8042 - signal wakeup from atkbd/psmouse
      Input: add KEY_KBD_LAYOUT_NEXT
      HID: input: add mapping for KEY_KBD_LAYOUT_NEXT

Gustavo A. R. Silva (2):
      Input: evdev - use struct_size() in kzalloc() and vzalloc()
      Input: libps2 - mark expected switch fall-through

Jagan Teki (2):
      Input: goodix - add regulators suppot
      Input: goodix - add GT5663 CTP support

Jean Delvare (1):
      Input: olpc_apsp - depend on ARCH_MMP

Jeff LaBundy (1):
      Input: add support for Azoteq IQS550/572/525

Joseph Salisbury (1):
      Input: hyperv-keyboard - add module description

Luca Weiss (1):
      Input: add a driver for GPIO controllable vibrators

Marco Felsch (1):
      Input: qt1050 - add Microchip AT42QT1050 support

Philipp Zabel (2):
      Input: synaptics-rmi4 - fill initial format
      Input: synaptics-rmi4 - fix enum_fmt

Vladimir Zapolskiy (1):
      Input: lpc32xx-key - add clocks property and fix DT binding example

Ziping Chen (1):
      Input: sun4i-a10-lradc-keys - add support for A83T

Diffstat:
--------

 .../devicetree/bindings/input/gpio-vibrator.yaml   |   37 +
 .../devicetree/bindings/input/lpc32xx-key.txt      |    5 +-
 .../devicetree/bindings/input/microchip,qt1050.txt |   78 ++
 .../devicetree/bindings/input/sun4i-lradc-keys.txt |    6 +-
 .../bindings/input/touchscreen/goodix.txt          |    3 +
 .../bindings/input/touchscreen/iqs5xx.txt          |   80 ++
 .../devicetree/bindings/vendor-prefixes.txt        |    1 +
 drivers/hid/hid-input.c                            |    2 +
 drivers/input/evdev.c                              |    7 +-
 drivers/input/keyboard/Kconfig                     |   11 +
 drivers/input/keyboard/Makefile                    |    1 +
 drivers/input/keyboard/atkbd.c                     |    2 +
 drivers/input/keyboard/qt1050.c                    |  598 +++++++++++
 drivers/input/keyboard/snvs_pwrkey.c               |   30 +-
 drivers/input/keyboard/sun4i-lradc-keys.c          |   38 +-
 drivers/input/misc/Kconfig                         |   12 +
 drivers/input/misc/Makefile                        |    1 +
 drivers/input/misc/gpio-vibra.c                    |  207 ++++
 drivers/input/mouse/psmouse-base.c                 |    2 +
 drivers/input/rmi4/rmi_f54.c                       |   21 +-
 drivers/input/serio/Kconfig                        |    1 +
 drivers/input/serio/hyperv-keyboard.c              |    2 +
 drivers/input/serio/i8042.c                        |    3 -
 drivers/input/serio/libps2.c                       |    1 +
 drivers/input/touchscreen/Kconfig                  |   10 +
 drivers/input/touchscreen/Makefile                 |    1 +
 drivers/input/touchscreen/edt-ft5x06.c             |   23 +-
 drivers/input/touchscreen/goodix.c                 |   54 +
 drivers/input/touchscreen/iqs5xx.c                 | 1133 ++++++++++++++++++++
 include/uapi/linux/input-event-codes.h             |    1 +
 30 files changed, 2297 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/gpio-vibrator.yaml
 create mode 100644 Documentation/devicetree/bindings/input/microchip,qt1050.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen/iqs5xx.txt
 create mode 100644 drivers/input/keyboard/qt1050.c
 create mode 100644 drivers/input/misc/gpio-vibra.c
 create mode 100644 drivers/input/touchscreen/iqs5xx.c

Thanks.


-- 
Dmitry
