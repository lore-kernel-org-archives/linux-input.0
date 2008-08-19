From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.27-rc3 (part 2)
Date: Tue, 19 Aug 2008 12:23:37 -0400
Message-ID: <20080819162337.GB21069@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.250]:52367 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752415AbYHSQXl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 19 Aug 2008 12:23:41 -0400
Received: by an-out-0708.google.com with SMTP id d40so4089and.103
        for <linux-input@vger.kernel.org>; Tue, 19 Aug 2008 09:23:40 -0700 (PDT)
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

Geert Uytterhoeven (1):
      Input: evdev - fix printf() format for sizeof

Huang Weiyi (1):
      Input: remove version.h from drivers that don't need it

Martin Michlmayr (1):
      Input: cobalt_btns - add missing MODULE_LICENSE


Diffstat:
--------

 drivers/input/evdev.c                   |    4 ++--
 drivers/input/keyboard/gpio_keys.c      |    1 -
 drivers/input/misc/cobalt_btns.c        |    3 +++
 drivers/input/mouse/gpio_mouse.c        |    1 -
 drivers/input/tablet/gtco.c             |    1 -
 drivers/input/touchscreen/wm9705.c      |    1 -
 drivers/input/touchscreen/wm9712.c      |    1 -
 drivers/input/touchscreen/wm9713.c      |    1 -
 drivers/input/touchscreen/wm97xx-core.c |    1 -
 9 files changed, 5 insertions(+), 9 deletions(-)

-- 
Dmitry
