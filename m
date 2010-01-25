From: Michael Poole <mdpoole@troilus.org>
Subject: [RFC PATCH 0/3] Support Apple Magic Mouse
Date: Mon, 25 Jan 2010 00:04:34 -0500
Message-ID: <1264395877-2582-1-git-send-email-mdpoole@troilus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:54161 "HELO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1750893Ab0AYFEr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Jan 2010 00:04:47 -0500
Received: by qyk40 with SMTP id 40so1718059qyk.22
        for <linux-input@vger.kernel.org>; Sun, 24 Jan 2010 21:04:46 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org

he Magic Mouse uses a vendor-specific code page to turn on its
multi-touch support, and then reports that with an "unlisted"
input report.  The first two patches in this series allow the
driver to (respectively) register for and enable those reports.

The third patch is the driver itself.  The major and minor axis
lengths use what the device sends, and the units for those are
larger than for the touch resolution.  I'm not sure how hard a
rule it is that those be in surface units.

 drivers/hid/Kconfig           |   10 +
 drivers/hid/Makefile          |    1 +
 drivers/hid/hid-core.c        |    4 +-
 drivers/hid/hid-ids.h         |    1 +
 drivers/hid/hid-magicmouse.c  |  395 +++++++++++++++++++++++++++++++++++++++++
 drivers/hid/usbhid/hid-core.c |   23 +++
 include/linux/hid.h           |    5 +
 net/bluetooth/hidp/core.c     |   25 +++
 8 files changed, 463 insertions(+), 1 deletions(-)

