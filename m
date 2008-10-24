From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [git pull] Input updates for 2.6.28-rc1
Date: Thu, 23 Oct 2008 23:33:40 -0400
Message-ID: <20081024033339.GA14393@anvil.corenet.prv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.28]:2583 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685AbYJXDdq (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 23 Oct 2008 23:33:46 -0400
Received: by yw-out-2324.google.com with SMTP id 9so234456ywe.1
        for <linux-input@vger.kernel.org>; Thu, 23 Oct 2008 20:33:45 -0700 (PDT)
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

to receive updates for the input subsystem. It contains completely new
Elantech driver for touchpads found in EeePCs and other notebooks and a
small update to i8042. Elantech driver has been cooking in -mm for a
long time and also was present in -next for a week or so.

Thanks!

Changelog:
---------

Arjan Opmeer (1):
      Input: psmouse - add support for Elantech touchpads

Stefan Bader (1):
      Input: i8042 - add Blue FB5601 to noloop exception table


Diffstat:
--------

 Documentation/input/elantech.txt      |  405 ++++++++++++++++++++
 drivers/input/mouse/Kconfig           |   25 ++-
 drivers/input/mouse/Makefile          |    1 +
 drivers/input/mouse/elantech.c        |  674 +++++++++++++++++++++++++++++++++
 drivers/input/mouse/elantech.h        |  124 ++++++
 drivers/input/mouse/psmouse-base.c    |   23 ++
 drivers/input/mouse/psmouse.h         |    1 +
 drivers/input/serio/i8042-x86ia64io.h |    8 +
 8 files changed, 1259 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/input/elantech.txt
 create mode 100644 drivers/input/mouse/elantech.c
 create mode 100644 drivers/input/mouse/elantech.h

-- 
Dmitry
