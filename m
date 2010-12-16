From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.37-rc5
Date: Wed, 15 Dec 2010 23:52:49 -0800
Message-ID: <20101216075249.GC26567@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35456 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751895Ab0LPIAg (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 16 Dec 2010 03:00:36 -0500
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

The main change it that we define new versions of EVIOC{G|S}KEYCODE_V2
ioctls instead of reusing the old names. This is to avoid surprising
people recompiling programs using old interface on newer kernels (while
we kept ABI intact so existing binaries should continue working fine
recompiled programs would start failing since they'd be using old ioctl
data with new ioctl numbers).

Changelog:
---------

Dmitry Torokhov (1):
      Input: define separate EVIOCGKEYCODE_V2/EVIOCSKEYCODE_V2

Kevin Granade (1):
      Input: wacom - add another Bamboo Pen ID (0xd4)


Diffstat:
--------

 drivers/input/evdev.c            |  113 +++++++++++++++++++------------------
 drivers/input/tablet/wacom_wac.c |    3 +
 include/linux/input.h            |    6 +-
 3 files changed, 65 insertions(+), 57 deletions(-)

-- 
Dmitry

