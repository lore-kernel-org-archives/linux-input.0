From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.5-rc0
Date: Tue, 12 Jan 2016 10:11:32 -0800
Message-ID: <20160112181132.GB32064@dtor-ws>
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

to receive updates for the input subsystem. You will get:

- driver for eGalaxTouch serial touchscreen
- driver for TS-4800 touchscreen
- an update for Goodix touchscreen driver
- PS/2 mouse module was reworked to limit number of protocols we try on
  pass-through ports to speed up their detection time
- wacom_w8001 touchscreen driver now reports pen and touch via separate
  instances of input devices
- other driver changes.

Changelog:
---------

Aur=E9lien Francillon (1):
      Input: i8042 - add Fujitsu Lifebook U745 to the nomux list

Benjamin Tissoires (2):
      Input: uinput - add new UINPUT_DEV_SETUP and UI_ABS_SETUP ioctl
      Input: elantech - mark protocols v2 and v3 as semi-mt

B=F6sz=F6rm=E9nyi Zolt=E1n (1):
      Input: add eGalaxTouch serial touchscreen driver

Damien Riegel (1):
      Input: add touchscreen support for TS-4800

Dan Carpenter (2):
      Input: egalax_ts_serial - fix potential NULL dereference on error
      Input: omap-keypad - set tasklet data earlier

Dave Gerlach (1):
      Input: ti_am335x_tsc - fix HWPEN interrupt handling

David Herrmann (1):
      Input: uinput - rework ABS validation

Dmitry Torokhov (12):
      gpiolib: tighten up ACPI legacy gpio lookups
      Input: psmouse - use switch statement in psmouse_process_byte()
      Input: psmouse - fix comment style
      Input: psmouse - rearrange Focaltech init code
      Input: psmouse - clean up Cypress probe
      Input: psmouse - move protocol descriptions around
      Input: psmouse - factor out common protocol probing code
      Input: psmouse - limit protocols that we try on passthrough ports
      Input: psmouse - rename ps2pp_init() to ps2pp_detect()
      Input: rohm_bu21023 - fix handling of retrying firmware update
      Input: omap-keypad - remove dead check
      Input: gpio-keys - fix check for disabling unsupported keys

Elias Vanderstuyft (1):
      Input: uinput - sanity check on ff_effects_max and EV_FF

Geliang Tang (1):
      Input: pcap_ts - use to_delayed_work

Irina Tirdea (5):
      Input: goodix - use actual config length for each device type
      Input: goodix - reset device at init
      Input: goodix - write configuration data to device
      Input: goodix - add power management support
      Input: goodix - use goodix_i2c_write_u8 instead of i2c_master_sen=
d

Julia Lawall (1):
      Input: bma150 - constify bma150_cfg structure

Karsten Merker (2):
      Input: goodix - add axis swapping and axis inversion support
      Input: goodix - use "inverted_[xy]" flags instead of "rotated_scr=
een"

Pali Roh=E1r (2):
      Input: ALPS - detect trackstick presence for v7 protocol
      Input: ALPS - report v3 pinnacle trackstick device only if is pre=
sent

Peter Hutterer (6):
      Input: wacom_w8001 - use __set_bit for evbits
      Input: wacom_w8001 - set BTN_TOOL_DOUBLETAP if we have 2fg suppor=
t
      Input: wacom_w8001 - handle touch error case correctly
      Input: wacom_w8001 - split pen and touch initialization up
      Input: wacom_w8001 - split the touch and pen devices into two dev=
ices
      Input: wacom_w8001 - drop use of ABS_MT_TOOL_TYPE

Sander Vermin (1):
      Input: pixcir_i2c - add support for wake and enable gpios

Steve Twiss (1):
      Input: da9063 - report KEY_POWER instead of KEY_SLEEP during powe=
r key-press

Thierry Reding (1):
      Input: sparcspkr - use platform_register/unregister_drivers()


Diffstat:
--------

 .../bindings/input/touchscreen/goodix.txt          |  14 +
 .../bindings/input/touchscreen/pixcir_i2c_ts.txt   |   4 +-
 .../bindings/input/touchscreen/ts4800-ts.txt       |  11 +
 drivers/gpio/gpiolib-acpi.c                        |  43 ++
 drivers/gpio/gpiolib.c                             |   3 +
 drivers/gpio/gpiolib.h                             |   8 +
 drivers/input/keyboard/gpio_keys.c                 |  29 +-
 drivers/input/keyboard/omap-keypad.c               |  10 +-
 drivers/input/misc/bma150.c                        |   2 +-
 drivers/input/misc/da9063_onkey.c                  |   8 +-
 drivers/input/misc/sparcspkr.c                     |  18 +-
 drivers/input/misc/uinput.c                        | 158 ++++-
 drivers/input/mouse/alps.c                         |  22 +-
 drivers/input/mouse/elantech.c                     |   2 +-
 drivers/input/mouse/focaltech.c                    |  22 +-
 drivers/input/mouse/focaltech.h                    |   8 +
 drivers/input/mouse/logips2pp.c                    |   2 +-
 drivers/input/mouse/logips2pp.h                    |   4 +-
 drivers/input/mouse/psmouse-base.c                 | 770 ++++++++++---=
--------
 drivers/input/serio/i8042-x86ia64io.h              |   7 +
 drivers/input/touchscreen/Kconfig                  |  27 +
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/egalax_ts_serial.c       | 194 ++++++
 drivers/input/touchscreen/goodix.c                 | 513 ++++++++++++-=
-
 drivers/input/touchscreen/pcap_ts.c                |   2 +-
 drivers/input/touchscreen/pixcir_i2c_ts.c          |  41 ++
 drivers/input/touchscreen/rohm_bu21023.c           |   2 +-
 drivers/input/touchscreen/ti_am335x_tsc.c          |   2 -
 drivers/input/touchscreen/ts4800-ts.c              | 216 ++++++
 drivers/input/touchscreen/wacom_w8001.c            | 325 +++++----
 include/linux/uinput.h                             |   5 +
 include/uapi/linux/serio.h                         |   1 +
 include/uapi/linux/uinput.h                        |  80 ++-
 33 files changed, 1900 insertions(+), 655 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/ts4800-ts.txt
 create mode 100644 drivers/input/touchscreen/egalax_ts_serial.c
 create mode 100644 drivers/input/touchscreen/ts4800-ts.c

--=20
Dmitry
