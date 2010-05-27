From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.35-rc0
Date: Thu, 27 May 2010 09:14:56 -0700
Message-ID: <20100527161455.GA558@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive some more updates for the input subsystem.

Changelog:
---------

Daniel Mack (1):
      Input: use ABS_CNT rather than (ABS_MAX + 1)

Haojian Zhuang (1):
      Input: enable onkey driver of max8925

Kevin Hilman (1):
      Input: ads7846 - return error on regulator_get() failure

Ondrej Zary (1):
      Input: usbtouchscreen - support bigger iNexio touchscreens

Peter Ujfalusi (1):
      Input: twl4030-vibra - correct the power down sequence


Diffstat:
--------

 drivers/hid/hid-debug.c                    |    2 +-
 drivers/input/joydev.c                     |   10 +-
 drivers/input/misc/Kconfig                 |   10 ++
 drivers/input/misc/Makefile                |    1 +
 drivers/input/misc/max8925_onkey.c         |  148 ++++++++++++++++++++++++++++
 drivers/input/misc/twl4030-vibra.c         |    2 +-
 drivers/input/misc/uinput.c                |    4 +-
 drivers/input/touchscreen/ads7846.c        |    4 +-
 drivers/input/touchscreen/usbtouchscreen.c |    7 +-
 include/linux/input.h                      |   12 +-
 include/linux/joystick.h                   |    4 +-
 include/linux/uinput.h                     |   10 +-
 12 files changed, 189 insertions(+), 25 deletions(-)
 create mode 100644 drivers/input/misc/max8925_onkey.c

-- 
Dmitry
