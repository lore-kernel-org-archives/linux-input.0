From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 3.19-rc2
Date: Mon, 29 Dec 2014 14:13:56 -0800
Message-ID: <20141229221356.GF9565@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get fixes for v7
protocol for ALPS devices and few other driver fixes. Also users can
request input events to be stamped with boot time timestamps, in
addition to real and monotonic timestamps.

Changelog:
---------

Aniroop Mathur (1):
      Input: evdev - add CLOCK_BOOTTIME support

Anshul Garg (1):
      Input: optimize events_per_packet count calculation

Asaf Vertz (1):
      Input: edt-ft5x06 - fixed a macro coding style issue

Dmitry Torokhov (2):
      Input: gpio_keys - allow separating gpio and irq in device tree
      Input: gpio_keys - replace timer and workqueue with delayed workqueue

Hans de Goede (4):
      Input: alps - v7: ignore new packets
      Input: alps - v7: sometimes a single touch is reported in mt[1]
      Input: alps - v7: fix finger counting for > 2 fingers on clickpads
      Input: alps - v7: document the v7 touchpad packet protocol

Linus Walleij (3):
      mfd: stmpe: add pull up/down register offsets for STMPE
      Input: stmpe - enforce device tree only mode
      Input: stmpe - bias keypad columns properly

Nicholas Mc Guire (1):
      Input: hil_kbd - fix incorrect use of init_completion

haarp (1):
      Input: psmouse - expose drift duration for IBM trackpoints


Diffstat:
--------

 .../devicetree/bindings/input/gpio-keys.txt        |  10 +-
 .../devicetree/bindings/input/stmpe-keypad.txt     |   2 +
 drivers/input/evdev.c                              |  60 ++++++---
 drivers/input/input.c                              |  22 ++--
 drivers/input/keyboard/Kconfig                     |   1 +
 drivers/input/keyboard/gpio_keys.c                 | 114 ++++++++---------
 drivers/input/keyboard/hil_kbd.c                   |   6 +-
 drivers/input/keyboard/stmpe-keypad.c              | 141 ++++++++++++---------
 drivers/input/mouse/alps.c                         |  84 ++++++++++--
 drivers/input/mouse/trackpoint.c                   |   4 +
 drivers/input/mouse/trackpoint.h                   |   5 +
 drivers/input/touchscreen/edt-ft5x06.c             |   4 +-
 drivers/mfd/stmpe.c                                |   4 +
 drivers/mfd/stmpe.h                                |   3 +
 include/linux/mfd/stmpe.h                          |  22 +---
 15 files changed, 302 insertions(+), 180 deletions(-)

-- 
Dmitry
