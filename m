From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.37-rc0
Date: Sun, 31 Oct 2010 08:28:32 -0700
Message-ID: <20101031152831.GA1101@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:49993 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756031Ab0JaP2i (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 31 Oct 2010 11:28:38 -0400
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

Dan Carpenter (1):
      Input: bu21013_ts - fix null dereference in error handling

Joe Perches (1):
      Input: appletouch - remove extra KERN_DEBUG use from dprintk

Michael Hennerich (1):
      Input: ad7879 - prevent invalid finger data reports


Diffstat:
--------

 drivers/input/mouse/appletouch.c       |    2 +-
 drivers/input/touchscreen/ad7879.c     |   32 +++++++++++++++++++++++++++-----
 drivers/input/touchscreen/bu21013_ts.c |    2 +-
 3 files changed, 29 insertions(+), 7 deletions(-)

-- 
Dmitry

