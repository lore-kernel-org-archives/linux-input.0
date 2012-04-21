From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/2] HID: hid-lg4ff: Updated Comments
Date: Sat, 21 Apr 2012 05:41:16 -0700
Message-ID: <1335012076-26430-2-git-send-email-simon@mungewell.org>
References: <alpine.LNX.2.00.1204201156300.29484@pobox.suse.cz>
 <1335012076-26430-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from host171.canaca.com ([67.55.55.225]:40974 "EHLO
	host171.canaca.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753345Ab2DUCtY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 20 Apr 2012 22:49:24 -0400
In-Reply-To: <1335012076-26430-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

Updated comments to say that this driver now supports all Logitech
gaming wheels, and not just the WiiWheel.

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index 1e942a0..24cf037 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1,7 +1,8 @@
 /*
- *  Force feedback support for Logitech Speed Force Wireless
+ *  Force feedback support for Logitech Gaming Wheels
  *
- *  http://wiibrew.org/wiki/Logitech_USB_steering_wheel
+ *  Including G27, G25, DFP, DFGT, FFEX, Momo, Momo2 &
+ *  Speed Force Wireless (WiiWheel)
  *
  *  Copyright (c) 2010 Simon Wood <simon@mungewell.org>
  */
@@ -590,7 +591,7 @@ err:
 #endif
 
 out:
-	hid_info(hid, "Force feedback for Logitech Speed Force Wireless by Simon Wood <simon@mungewell.org>\n");
+	hid_info(hid, "Force feedback support for Logitech Gaming Wheels\n");
 	return 0;
 }
 
-- 
1.7.4.1

