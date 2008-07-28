From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.27-rc0 (round 2)
Date: Mon, 28 Jul 2008 12:59:26 -0400
Message-ID: <20080728165926.GA21561@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.241]:44777 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756771AbYG1Q7b (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Jul 2008 12:59:31 -0400
Received: by an-out-0708.google.com with SMTP id d40so922127and.103
        for <linux-input@vger.kernel.org>; Mon, 28 Jul 2008 09:59:29 -0700 (PDT)
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

to receive updates for the input subsystem.

Changelog:
---------

Dan Liang (1):
      Input: add driver for Atmel integrated touchscreen controller

Dmitry Torokhov (1):
      Input: serio - mark serio_register_driver() __must_check

Hans-Christian Egtvedt (1):
      Input: ads7846 - optimize order of calculating Rt in ads7846_rx()

Harvey Harrison (1):
      Input: ads7846 - fix sparse endian warnings

Huang Weiyi (1):
      Input: uinput - remove duplicate include

Shaohua Li (1):
      Input: serio - offload resume to kseriod


Diffstat:
--------

 drivers/input/misc/uinput.c              |    1 -
 drivers/input/serio/serio.c              |   55 ++++--
 drivers/input/touchscreen/Kconfig        |   12 +
 drivers/input/touchscreen/Makefile       |    1 +
 drivers/input/touchscreen/ads7846.c      |   16 +-
 drivers/input/touchscreen/atmel_tsadcc.c |  332 ++++++++++++++++++++++++++++++
 include/linux/serio.h                    |    3 +-
 7 files changed, 390 insertions(+), 30 deletions(-)
 create mode 100644 drivers/input/touchscreen/atmel_tsadcc.c

-- 
Dmitry
