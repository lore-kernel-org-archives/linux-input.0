From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.38-rc4
Date: Tue, 15 Feb 2011 08:41:45 -0800
Message-ID: <20110215164145.GA32308@core.coreip.homeip.net>
References: <20110107065448.GC29038@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20110107065448.GC29038@core.coreip.homeip.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Nothing exciting, just small
fixups to the drivers.

Changelog:
---------

Alexander Stein (1):
      Input: rotary_encoder - use proper irqflags

Alexander Strakh (1):
      Input: wacom - fix error path in wacom_probe()

Dmitry Torokhov (3):
      Input: sysrq - rework re-inject logic
      Revert "Input: do not pass injected events back to the originating handler"
      Input: ads7846 - check proper condition when freeing gpio

Duncan Laurie (1):
      Input: serio - clear pending rescans after sysfs driver rebind

Ping Cheng (1):
      Input: wacom_w8001 - report resolution to userland

Trilok Soni (1):
      Input: matrix_keypad - increase the limit of rows and columns


Diffstat:
--------

 drivers/input/input.c                   |   37 +++++++++---------------------
 drivers/input/misc/rotary_encoder.c     |    4 +-
 drivers/input/serio/serio.c             |   11 +++++---
 drivers/input/tablet/wacom_sys.c        |    2 +-
 drivers/input/touchscreen/ads7846.c     |   38 ++++++++++++++++++-------------
 drivers/input/touchscreen/wacom_w8001.c |   13 +++++++++-
 drivers/tty/sysrq.c                     |   17 +++++++++++++-
 include/linux/input/matrix_keypad.h     |    4 +-
 8 files changed, 72 insertions(+), 54 deletions(-)

-- 
Dmitry
