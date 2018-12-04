From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for v4.20-rc5
Date: Mon, 3 Dec 2018 19:37:46 -0800
Message-ID: <20181204033746.GA235290@dtor-ws>
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

to receive updates for the input subsystem. Mostly new IDs for
Elan/Synaptics touchpads, plus a few small fixups.

Changelog:
---------

Adam Wong (1):
      Input: elan_i2c - add support for ELAN0621 touchpad

Brian Norris (1):
      Input: cros_ec_keyb - fix button/switch capability reports

Cameron Gutman (1):
      Input: xpad - quirk all PDP Xbox One gamepads

Christian Hoff (1):
      Input: matrix_keypad - check for errors from of_get_named_gpio()

Colin Ian King (1):
      Input: atkbd - clean up indentation issue

Ding Tao (1):
      Input: dt-bindings - fix a typo in file input-reset.txt

Kuninori Morimoto (2):
      Input: migor_ts - convert to SPDX identifiers
      Input: st1232 - convert to SPDX identifiers

Lyude Paul (1):
      Input: synaptics - add PNP ID for ThinkPad P50 to SMBus

Noah Westervelt (1):
      Input: elan_i2c - add ACPI ID for Lenovo IdeaPad 330-15ARR

Patrick Gaskin (1):
      Input: elan_i2c - add ELAN0620 to the ACPI table

Teika Kazura (1):
      Input: synaptics - enable SMBus for HP 15-ay000

Tony Lindgren (1):
      Input: omap-keypad - fix keyboard debounce configuration

Vitaly Kuznetsov (1):
      Input: hyper-v - fix wakeup from suspend-to-idle

Diffstat:
--------

 .../devicetree/bindings/input/input-reset.txt      |  2 +-
 drivers/hid/hid-hyperv.c                           |  2 +-
 drivers/input/joystick/xpad.c                      | 16 ++++++---------
 drivers/input/keyboard/atkbd.c                     |  2 +-
 drivers/input/keyboard/cros_ec_keyb.c              |  3 ++-
 drivers/input/keyboard/matrix_keypad.c             | 23 +++++++++++++---------
 drivers/input/keyboard/omap4-keypad.c              | 18 +++++++++++++----
 drivers/input/mouse/elan_i2c_core.c                |  3 +++
 drivers/input/mouse/synaptics.c                    |  2 ++
 drivers/input/serio/hyperv-keyboard.c              |  2 +-
 drivers/input/touchscreen/migor_ts.c               | 15 +-------------
 drivers/input/touchscreen/st1232.c                 | 12 ++---------
 12 files changed, 48 insertions(+), 52 deletions(-)

Thanks.


-- 
Dmitry
