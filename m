From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.33-rc8
Date: Sun, 21 Feb 2010 23:03:51 -0800
Message-ID: <20100222070351.GC2095@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Hi Linus,

Please pull from:

	git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git for-linus
or
	master.kernel.org:/pub/scm/linux/kernel/git/dtor/input.git for-linus

to receive updates for the input subsystem. Hopefully this is it for .33.

Changelog:
---------

Roy Yin (1):
      Input: usbtouchscreen - extend coordinate range for Generaltouch devices

Samu Onkalo (1):
      Input: polldev can cause crash in case when polling disabled


Diffstat:
--------

 drivers/input/input-polldev.c              |    6 ++++++
 drivers/input/touchscreen/usbtouchscreen.c |    8 ++++----
 2 files changed, 10 insertions(+), 4 deletions(-)

-- 
Dmitry
