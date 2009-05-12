From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.30-rc5
Date: Mon, 11 May 2009 19:14:39 -0700
Message-ID: <20090512021438.GB1965@dtor-d630.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.227]:9217 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757305AbZELCOq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 11 May 2009 22:14:46 -0400
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

Adrian Batzill (1):
      Input: atkbd - add force release keys quirk for Amilo Xi 3650

Jussi Kivilinna (1):
      Input: ff-memless - fix signed to unsigned bit overflow

Thierry Reding (1):
      Input: tsc2007 - fix locking in hrtimer handler

Tim Cole (1):
      Input: joydev - blacklist digitizers


Diffstat:
--------

 drivers/input/ff-memless.c          |    2 +-
 drivers/input/joydev.c              |    8 +++++++-
 drivers/input/keyboard/atkbd.c      |   16 ++++++++++++++++
 drivers/input/touchscreen/tsc2007.c |    5 +++--
 4 files changed, 27 insertions(+), 4 deletions(-)

-- 
Dmitry

