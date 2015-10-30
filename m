From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.3-rc7
Date: Fri, 30 Oct 2015 08:23:58 -0700
Message-ID: <20151030152358.GA21265@dtor-pixel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qk0-f169.google.com ([209.85.220.169]:33385 "EHLO
	mail-qk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbbJ3PYO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Oct 2015 11:24:14 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. You will get a change to
ALPS driver where we had limit the quirk for trackstick handling from
being active on all Dells to just a few models; and also fix for build
dependency issue in sur40 driver and a small clock handling fixup in
LPC32xx touchscreen driver.

Changelog:
---------

Hans de Goede (1):
      Input: alps - only the Dell Latitude D420/430/620/630 have separate stick button bits

Randy Dunlap (1):
      Input: sur40 - add dependency on VIDEO_V4L2

Vladimir Zapolskiy (1):
      Input: lpc32xx_ts - fix warnings caused by enabling unprepared clock


Diffstat:
--------

 drivers/input/mouse/alps.c             | 48 +++++++++++++++++++++++++++++-----
 drivers/input/touchscreen/Kconfig      |  1 +
 drivers/input/touchscreen/lpc32xx_ts.c |  4 +--
 3 files changed, 45 insertions(+), 8 deletions(-)

-- 
Dmitry
