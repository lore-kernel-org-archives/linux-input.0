From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.39-rc7
Date: Thu, 12 May 2011 08:34:42 -0700
Message-ID: <20110512153442.GA8293@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:38732 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197Ab1ELPet (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2011 11:34:49 -0400
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

to receive a couple of fixups to ads7846 driver. Only the firs one is
important, the 2nd one is a cleanup but I am including it to avoid
annoying merge conflict.

Thanks!

Changelog:
---------

Alexander Stein (2):
      Input: ads7846 - make transfer buffers DMA safe
      Input: ads7846 - remove unused variable from struct ads7845_ser_req


Diffstat:
--------

 drivers/input/touchscreen/ads7846.c |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

-- 
Dmitry

