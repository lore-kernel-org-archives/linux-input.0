From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.32-rc7
Date: Thu, 12 Nov 2009 23:36:47 -0800
Message-ID: <20091113073647.GA7783@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:50431 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbZKMHgq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Nov 2009 02:36:46 -0500
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

Dmitry Torokhov (3):
      Input: fix locking in memoryless force-feedback devices
      Input: force LED reset on resume
      Input: atkbd - restore LED state at reconnect

Takashi Iwai (1):
      Input: psmouse - remove unneeded '\n' from psmouse.proto parameter

Diffstat:
--------

 drivers/input/ff-core.c            |   20 +++++++++++---------
 drivers/input/ff-memless.c         |   26 +++++++++++---------------
 drivers/input/input.c              |   29 ++++++++++++++++++-----------
 drivers/input/keyboard/atkbd.c     |   13 +++++++++++++
 drivers/input/mouse/psmouse-base.c |    2 +-
 include/linux/input.h              |    4 ++++
 6 files changed, 58 insertions(+), 36 deletions(-)

-- 
Dmitry

