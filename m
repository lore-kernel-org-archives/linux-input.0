From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.27-rc5
Date: Sat, 6 Sep 2008 23:56:48 -0400
Message-ID: <20080907035647.GA24245@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:43463 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753616AbYIGD4y (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Sep 2008 23:56:54 -0400
Received: by an-out-0708.google.com with SMTP id d40so170859and.103
        for <linux-input@vger.kernel.org>; Sat, 06 Sep 2008 20:56:52 -0700 (PDT)
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

to receive updates for the input subsystem. You will get an update to
the new bcm5974 touchpad driver. While is it bigger than I would like at
this stage the changes are needed for mousedev to bind to the touchpad
and provide basic mouse emulation (until user installs Synaptics X
driver). Another change is refining quirk for Lenovo N3000 to activate
for a specific board version only.

Changelog:
---------

Henrik Rydberg (4):
      Input: bcm5974 - add maintainer entry
      Input: bcm5974 - small formatting cleanup
      Input: bcm5974 - improve finger tracking and counting
      Input: bcm5974 - add BTN_TOUCH event for mousedev benefit

Jiri Kosina (1):
      Input: i8042 - make Lenovo 3000 N100 blacklist entry more specific


Diffstat:
--------

 drivers/input/mouse/bcm5974.c         |   74 +++++++++++++++++++++++++--------
 drivers/input/serio/i8042-x86ia64io.h |    2 +-
 2 files changed, 58 insertions(+), 18 deletions(-)


-- 
Dmitry
