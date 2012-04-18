From: Simon Wood <simon@mungewell.org>
Subject: [PATCH 2/2] HID: hid-lg4ff: Updated Comments
Date: Wed, 18 Apr 2012 00:03:08 -0700
Message-ID: <1334732588-9351-2-git-send-email-simon@mungewell.org>
References: <alpine.LNX.2.00.1204131458290.16373@pobox.suse.cz>
 <1334732588-9351-1-git-send-email-simon@mungewell.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from idcmail-mo1so.shaw.ca ([24.71.223.10]:54739 "EHLO
	idcmail-mo1so.shaw.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750891Ab2DRHD2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Apr 2012 03:03:28 -0400
In-Reply-To: <1334732588-9351-1-git-send-email-simon@mungewell.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>, Michael Bauer <michael@m-bauer.org>, Michal Maly <madcatxster@gmail.com>, Simon Wood <simon@mungewell.org>

Updated comments to say that this driver now supports all Logitech
gaming wheels, and not just the WiiWheel

Signed-off-by: Simon Wood <simon@mungewell.org>
---
 drivers/hid/hid-lg4ff.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-lg4ff.c b/drivers/hid/hid-lg4ff.c
index ab5232e..cbafb46 100644
--- a/drivers/hid/hid-lg4ff.c
+++ b/drivers/hid/hid-lg4ff.c
@@ -1,7 +1,8 @@
 /*
- *  Force feedback support for Logitech Speed Force Wireless
+ *  Force feedback support for Logitech Gaming Wheels
  *
- *  http://wiibrew.org/wiki/Logitech_USB_steering_wheel
+ *  Including G27, G25, DFP, DFGT, FFEX, Momo, Momo2 &
+ *  Wireless Speed Force (WiiWheel)
  *
  *  Copyright (c) 2010 Simon Wood <simon@mungewell.org>
  */
@@ -587,7 +588,7 @@ err:
 	}
 #endif
 
-	hid_info(hid, "Force feedback for Logitech Speed Force Wireless by Simon Wood <simon@mungewell.org>\n");
+	hid_info(hid, "Force feedback for Logitech Gaming Wheels\n");
 	return 0;
 }
 
-- 
1.7.4.1

