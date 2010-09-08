From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.36-rc3
Date: Tue, 7 Sep 2010 23:22:14 -0700
Message-ID: <20100908062214.GB10400@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:41596 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab0IHGWU (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Sep 2010 02:22:20 -0400
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

to receive updates for the input subsystem; just small fixups this
time.

Changelog:
---------

Arnd Bergmann (1):
      Input: use PIT_TICK_RATE in vt beep ioctl

Dmitry Torokhov (1):
      Input: i8042 - fix device removal on unload

Henrik Rydberg (2):
      Input: MT - initialize slots to unused
      Input: bcm5974 - adjust major/minor to scale

Mike Auty (1):
      Input: wacom - fix mousewheel handling for old wacom tablets


Diffstat:
--------

 drivers/char/vt_ioctl.c          |   16 ++++++++--------
 drivers/input/input.c            |   11 +++++++++--
 drivers/input/mouse/bcm5974.c    |   12 ++++++++----
 drivers/input/serio/i8042.c      |    2 +-
 drivers/input/tablet/wacom_wac.c |    4 ++--
 5 files changed, 28 insertions(+), 17 deletions(-)

