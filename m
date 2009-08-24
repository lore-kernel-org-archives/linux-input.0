From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.31-rc7
Date: Sun, 23 Aug 2009 23:40:09 -0700
Message-ID: <20090824071200.31D67526EC9@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:53180 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751495AbZHXGkM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 24 Aug 2009 02:40:12 -0400
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

to receive updates for the input subsystem. The joydev change fixes
userspace ABI breakage caused by recent KEY_MAX change; there are also
couple of fixes for the ucb1400_ts driver and a fix for wacom to not
use on-stack buffers for transfers during initialization.

Changelog:
---------

Dmitry Torokhov (1):
      Input: wacom - don't use on-stack memory for report buffers

Jiri Kosina (1):
      Input: iforce - support new revision of ACT LABS Force RS

Marek Vasut (1):
      Input: ucb1400_ts - enable ADC Filter

Pavel Revak (1):
      Input: ucb1400_ts - enable interrupt unconditionally

Stephen Kitt (1):
      Input: joydev - decouple axis and button map ioctls from input constants


Diffstat:
--------

 drivers/input/joydev.c                      |   68 ++++++++++++++++-----------
 drivers/input/joystick/iforce/iforce-main.c |    1 +
 drivers/input/joystick/iforce/iforce-usb.c  |    1 +
 drivers/input/tablet/wacom_sys.c            |   43 +++++++++++------
 drivers/input/touchscreen/ucb1400_ts.c      |   17 +++++--
 include/linux/ucb1400.h                     |    4 ++
 6 files changed, 89 insertions(+), 45 deletions(-)

-- 
Dmitry

