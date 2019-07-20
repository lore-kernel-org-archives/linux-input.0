From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v5.3-rc0
Date: Sat, 20 Jul 2019 22:10:36 +0300
Message-ID: <20190720191036.GA873@penguin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
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

- Apple SPI keyboard and trackpad driver for newer Macs
- ALPS driver will ignore trackpoint-only devices to give chance
  trackpoint driver handle them properly
- another Lenovo is switched over to SMbus from PS/2
- assorted driver fixups.

Changelog:
---------

Fuqian Huang (1):
      Input: auo-pixcir-ts - switch to using  devm_add_action_or_reset()

Grant Hernandez (1):
      Input: gtco - bounds check collection indent level

Hui Wang (2):
      Input: alps - don't handle ALPS cs19 trackpoint-only device
      Input: alps - fix a mismatch between a condition check and its comment

Joe Perches (1):
      Input: synaptics - fix misuse of strlcpy

Lars-Peter Clausen (1):
      Input: adp5589 - initialize GPIO controller parent device

Mao Wenan (1):
      Input: applespi - remove set but not used variables 'sts'

Maya Nakamura (1):
      Input: hyperv-keyboard - remove dependencies on PAGE_SIZE for ring buffer

Nick Black (1):
      Input: synaptics - whitelist Lenovo T580 SMBus intertouch

Nishka Dasgupta (2):
      Input: sun4i-lradc-keys - add of_node_put() before return
      Input: mtk-pmic-keys - add of_node_put() before return

Ronald Tschalär (1):
      Input: add Apple SPI keyboard and trackpad driver

Tim Schumacher (1):
      Input: iforce - remove empty multiline comments

YueHaibing (1):
      Input: psmouse - fix build error of multiple definition

Diffstat:
--------

 drivers/input/joystick/iforce/iforce-ff.c      |    3 -
 drivers/input/joystick/iforce/iforce-main.c    |    3 -
 drivers/input/joystick/iforce/iforce-packets.c |    3 -
 drivers/input/joystick/iforce/iforce-serio.c   |    3 -
 drivers/input/joystick/iforce/iforce-usb.c     |    3 -
 drivers/input/joystick/iforce/iforce.h         |    3 -
 drivers/input/keyboard/Kconfig                 |   16 +
 drivers/input/keyboard/Makefile                |    1 +
 drivers/input/keyboard/adp5589-keys.c          |    1 +
 drivers/input/keyboard/applespi.c              | 1977 ++++++++++++++++++++++++
 drivers/input/keyboard/applespi.h              |   29 +
 drivers/input/keyboard/applespi_trace.h        |   93 ++
 drivers/input/keyboard/mtk-pmic-keys.c         |    9 +-
 drivers/input/keyboard/sun4i-lradc-keys.c      |    3 +
 drivers/input/mouse/alps.c                     |   32 +
 drivers/input/mouse/synaptics.c                |    3 +-
 drivers/input/mouse/trackpoint.h               |    3 +-
 drivers/input/serio/hyperv-keyboard.c          |    4 +-
 drivers/input/tablet/gtco.c                    |   20 +-
 drivers/input/touchscreen/auo-pixcir-ts.c      |    3 +-
 20 files changed, 2183 insertions(+), 29 deletions(-)
 create mode 100644 drivers/input/keyboard/applespi.c
 create mode 100644 drivers/input/keyboard/applespi.h
 create mode 100644 drivers/input/keyboard/applespi_trace.h

Thanks.

-- 
Dmitry
