From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.39-rc0
Date: Fri, 25 Mar 2011 00:27:59 -0700
Message-ID: <20110325072759.GA2590@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pw0-f46.google.com ([209.85.160.46]:64284 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750883Ab1CYH2F (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 25 Mar 2011 03:28:05 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive a few updates to recently merged tsc2005 driver.

Changelog:
---------

Aaro Koskinen (2):
      Input: tsc2005 - use relative jiffies to schedule the watchdog
      Input: tsc2005 - fix locking issue

Geert Uytterhoeven (1):
      Input: tsc2005 - driver should depend on GENERIC_HARDIRQS


Diffstat:
--------

 drivers/input/touchscreen/Kconfig   |    2 +-
 drivers/input/touchscreen/tsc2005.c |   18 +++++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

-- 
Dmitry

