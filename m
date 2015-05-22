From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 4.1-rc4
Date: Fri, 22 May 2015 12:07:06 -0700
Message-ID: <20150522190706.GH40101@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35827 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756676AbbEVTHK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 May 2015 15:07:10 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. The main change is that
we tell joydev not to touch "absolute mice", such as VMware virtual
mouse, as that produced bad result (cursor stuck in upper right corner)
with games.

Changelog:
---------

Benjamin Tissoires (1):
      Input: elantech - fix semi-mt protocol for v3 HW

Dmitry Torokhov (1):
      Input: sx8654 - fix memory allocation check

Hans de Goede (1):
      Input: alps - fix finger jumps on lifting 2 fingers on v7 touchpad

Marek Vasut (2):
      Input: smtpe-ts - use msecs_to_jiffies() instead of HZ
      Input: smtpe-ts - wait 50mS until polling for pen-up

Thomas Hellstrom (2):
      Input: vmmouse - do not reference non-existing version of X driver
      Input: joydev - don't classify the vmmouse as a joystick


Diffstat:
--------

 drivers/input/joydev.c               | 61 ++++++++++++++++++++++++++++++++++++
 drivers/input/mouse/Kconfig          |  2 +-
 drivers/input/mouse/alps.c           |  5 +++
 drivers/input/mouse/elantech.c       |  2 +-
 drivers/input/touchscreen/stmpe-ts.c |  2 +-
 drivers/input/touchscreen/sx8654.c   |  2 +-
 6 files changed, 70 insertions(+), 4 deletions(-)

-- 
Dmitry

