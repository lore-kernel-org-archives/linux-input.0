From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.3-rc0 (round 2)
Date: Fri, 11 Sep 2015 16:00:56 -0700
Message-ID: <20150911230056.GA867@dtor-ws>
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

to receive second round of updates for the input subsystem. You will ge=
t
2 brand new touchscreen drivers (Colibri and imx6ul_tsc), some small
driver fixes, and we are no longer report errors from evdev_flush() as
users do not really have a way of handling errors, error codes that we
were returning were not on the list of errors supposed to be returned b=
y
close(), and errors were causing issues with one of older versions of
systemd.

Changelog:
---------

=46abio Estevam (1):
      Input: imx_keypad - remove obsolete comment

Haibo Chen (1):
      Input: touchscreen - add imx6ul_tsc driver support

James Chen (1):
      Input: elants_i2c - extend the calibration timeout to 12 seconds

Javier Martinez Canillas (1):
      Input: cyttsp - remove unnecessary MODULE_ALIAS()

Jo=E3o Paulo Rechi Vita (1):
      Input: elan_i2c - add ACPI ID "ELAN1000"

Luis de Bethencourt (4):
      Input: ab8500-ponkey - Fix module autoload for OF platform driver
      Input: pwm-beeper - fix module autoload for OF platform driver
      Input: regulator-haptic - fix module autoload for OF platform dri=
ver
      Input: sparcspkr - fix module autoload for OF platform drivers

Sanchayan Maity (1):
      Input: Add touchscreen support for Colibri VF50

Takashi Iwai (2):
      Input: evdev - do not report errors form flush()
      Input: i8042 - lower log level for "no controller" message


Diffstat:
--------

 .../bindings/input/touchscreen/colibri-vf50-ts.txt |  36 ++
 .../bindings/input/touchscreen/imx6ul_tsc.txt      |  36 ++
 drivers/input/evdev.c                              |  13 +-
 drivers/input/keyboard/imx_keypad.c                |   2 -
 drivers/input/misc/ab8500-ponkey.c                 |   1 +
 drivers/input/misc/pwm-beeper.c                    |   1 +
 drivers/input/misc/regulator-haptic.c              |   1 +
 drivers/input/misc/sparcspkr.c                     |   2 +
 drivers/input/mouse/elan_i2c_core.c                |   1 +
 drivers/input/serio/i8042.c                        |   2 +-
 drivers/input/touchscreen/Kconfig                  |  24 +
 drivers/input/touchscreen/Makefile                 |   2 +
 drivers/input/touchscreen/colibri-vf50-ts.c        | 386 +++++++++++++=
++
 drivers/input/touchscreen/cyttsp4_i2c.c            |   1 -
 drivers/input/touchscreen/cyttsp_i2c.c             |   1 -
 drivers/input/touchscreen/elants_i2c.c             |   2 +-
 drivers/input/touchscreen/imx6ul_tsc.c             | 523 +++++++++++++=
++++++++
 17 files changed, 1019 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/colibri-vf50-ts.txt
 create mode 100644 Documentation/devicetree/bindings/input/touchscreen=
/imx6ul_tsc.txt
 create mode 100644 drivers/input/touchscreen/colibri-vf50-ts.c
 create mode 100644 drivers/input/touchscreen/imx6ul_tsc.c


--=20
Dmitry
