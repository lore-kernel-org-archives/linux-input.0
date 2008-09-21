From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.27-rc7
Date: Sun, 21 Sep 2008 18:56:21 -0400
Message-ID: <20080921225621.GA10188@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yx-out-2324.google.com ([74.125.44.28]:62240 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752719AbYIUW41 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sun, 21 Sep 2008 18:56:27 -0400
Received: by yx-out-2324.google.com with SMTP id 8so185100yxm.1
        for <linux-input@vger.kernel.org>; Sun, 21 Sep 2008 15:56:25 -0700 (PDT)
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

Henrik Rydberg (1):
      Input: bcm5974 - switch back to normal mode when closing

Kristoffer Ericson (1):
      Input: jornada720_ts - fix build error ( LONG() usage )


Diffstat:
--------

 drivers/input/mouse/bcm5974.c             |   13 +++++++++----
 drivers/input/touchscreen/jornada720_ts.c |    4 ++--
 2 files changed, 11 insertions(+), 6 deletions(-)

-- 
Dmitry
