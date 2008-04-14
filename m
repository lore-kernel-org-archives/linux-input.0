From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: WM97xx touchscreen updates
Date: Mon, 14 Apr 2008 18:38:41 +0100
Message-ID: <20080414173841.GA2213@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:34937 "EHLO
	opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753361AbYDNRin (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Apr 2008 13:38:43 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>, Dmitry Torokhov <dtor@mail.ru>, Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

This patch series updates the WM97xx touchscreen drivers with a couple
of small cleanups and the addition of support for use of the WM97xx
touchpanels to wake up from suspend.

It is also available in the git repository at:

  git://opensource.wolfsonmicro.com/linux-2.6-touch upstream

Mark Brown (3):
      wm97xx-core: Only schedule interrupt handler if not already scheduled
      wm97xx-core: Use IRQF_SAMPLE_RANDOM
      wm97xx-core: Support use as a wakeup source

 drivers/input/touchscreen/wm97xx-core.c |   39 ++++++++++++++++++++++++------
 include/linux/wm97xx.h                  |    3 ++
 2 files changed, 34 insertions(+), 8 deletions(-)
