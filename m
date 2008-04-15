From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: WM97xx touchscreen updates
Date: Tue, 15 Apr 2008 15:45:35 +0100
Message-ID: <20080415144535.GA20619@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765136AbYDOOps@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, David Brownell <david-b@pacbell.net>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

This patch series updates the WM97xx touchscreen drivers with a couple
of small cleanups and the addition of support for use of the WM97xx
touchpanels to wake up from suspend.  Since the last submission I have:

 - Updated the commit message for scheduling of the interrupt handler. 
 - Hooked the touchscreen into the driver model wakeup infrastructure.

It is also available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-touch upstream

Mark Brown (3):
      wm97xx-core: Only schedule interrupt handler if not already scheduled
      wm97xx-core: Use IRQF_SAMPLE_RANDOM
      wm97xx-core: Support use as a wakeup source

 drivers/input/touchscreen/wm97xx-core.c |   56 ++++++++++++++++++++++++++----
 include/linux/wm97xx.h                  |    3 ++
 2 files changed, 51 insertions(+), 8 deletions(-)
