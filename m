From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.39-rc5
Date: Mon, 2 May 2011 18:43:59 -0700
Message-ID: <20110503014359.GA22278@core.coreip.homeip.net>
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

to receive updates for the input subsystem. You will get some final
adjustments for the newly introduced wm831x-ts driver.

Thanks!

Changelog:
---------

Mark Brown (3):
      Input: wm831x-ts - fix races with IRQ management
      Input: wm831x-ts - allow IRQ flags to be specified
      Input: wm831x-ts - move BTN_TOUCH reporting to data transfer


Diffstat:
--------

 drivers/input/touchscreen/wm831x-ts.c |   75 ++++++++++++++++++++++++++++-----
 include/linux/mfd/wm831x/pdata.h      |    2 +
 2 files changed, 66 insertions(+), 11 deletions(-)

-- 
Dmitry
