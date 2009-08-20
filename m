From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.31-rc5
Date: Wed, 19 Aug 2009 22:34:16 -0700
Message-ID: <20090820060542.8B7A5526EA5@mailhub.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.233]:17972 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751300AbZHTFeV (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2009 01:34:21 -0400
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

to receive updates for the input subsystem. The joydev change fixes userspace
ABI breakage caused by recent KEY_MAX change.

Changelog:
---------

Jiri Kosina (1):
      Input: iforce - support new revision of ACT LABS Force RS

Stephen Kitt (1):
      Input: joydev - decouple axis and button map ioctls from input constants


Diffstat:
--------

 drivers/input/joydev.c                      |   68 ++++++++++++++++-----------
 drivers/input/joystick/iforce/iforce-main.c |    1 +
 drivers/input/joystick/iforce/iforce-usb.c  |    1 +
 3 files changed, 43 insertions(+), 27 deletions(-)

-- 
Dmitry

