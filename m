From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.34-rc6
Date: Thu, 13 May 2010 00:57:28 -0700
Message-ID: <20100513075728.GF30110@core.coreip.homeip.net>
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

to receive a few last minute changes to the input subsystem.

Changelog:
---------

Bastien Nocera (1):
      Input: i8042 - do not try to probe ports on Intel Apple Macs

Dmitry Torokhov (2):
      Input: elantech - use all 3 bytes when checking version
      Input: psmouse - reset all types of mice before reconnecting

Marek Vasut (2):
      Input: iforce - add Guillemot Jet Leader Force Feedback
      Input: iforce - fix Guillemot Jet Leader 3D entry

Oskar Schirmer (1):
      Input: ad7877 - keep dma rx buffers in seperate cache lines


Diffstat:
--------

 drivers/input/joystick/iforce/iforce-main.c |    6 ++++-
 drivers/input/joystick/iforce/iforce-usb.c  |    1 +
 drivers/input/mouse/elantech.c              |   24 ++++++++++----------
 drivers/input/mouse/elantech.h              |    5 +--
 drivers/input/mouse/psmouse-base.c          |   14 +++++++++---
 drivers/input/serio/i8042-x86ia64io.h       |   30 ++++++++++++++++++++++++++-
 drivers/input/touchscreen/ad7877.c          |   15 ++++++++++--
 7 files changed, 71 insertions(+), 24 deletions(-)

-- 
Dmitry
