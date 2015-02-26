From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH] HID: remove 2 unused usbh.h includes
Date: Thu, 26 Feb 2015 13:39:48 -0500
Message-ID: <1424975988-18094-1-git-send-email-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48087 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753684AbbBZSjw (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 26 Feb 2015 13:39:52 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

These 2 are left over from the USB dependency cleaning, so there is
no need to keep them.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-multitouch.c  | 1 -
 drivers/hid/hid-steelseries.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index f65e78b..b61715f 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -42,7 +42,6 @@
 #include <linux/hid.h>
 #include <linux/module.h>
 #include <linux/slab.h>
-#include <linux/usb.h>
 #include <linux/input/mt.h>
 #include <linux/string.h>
 
diff --git a/drivers/hid/hid-steelseries.c b/drivers/hid/hid-steelseries.c
index 29f328f..3edd4ac 100644
--- a/drivers/hid/hid-steelseries.c
+++ b/drivers/hid/hid-steelseries.c
@@ -12,7 +12,6 @@
  */
 
 #include <linux/device.h>
-#include <linux/usb.h>
 #include <linux/hid.h>
 #include <linux/module.h>
 
-- 
2.1.0

