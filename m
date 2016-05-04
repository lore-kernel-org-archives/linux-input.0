From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.6-rc6
Date: Wed, 4 May 2016 16:03:59 -0700
Message-ID: <20160504230359.GB17403@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f180.google.com ([209.85.192.180]:36551 "EHLO
	mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754704AbcEDXED (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 4 May 2016 19:04:03 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem.

Changelog:
---------

H. Nikolaus Schaller (1):
      Input: twl6040-vibra - fix atomic schedule panic

Knut Wohlrab (1):
      Input: zforce_ts - fix dual touch recognition

Nick Dyer (1):
      Input: atmel_mxt_ts - use mxt_acquire_irq in mxt_soft_reset


Diffstat:
--------

 drivers/input/misc/twl6040-vibra.c       | 16 ++++++++--------
 drivers/input/touchscreen/atmel_mxt_ts.c | 28 ++++++++++++++--------------
 drivers/input/touchscreen/zforce_ts.c    |  4 ++--
 3 files changed, 24 insertions(+), 24 deletions(-)

-- 
Dmitry

