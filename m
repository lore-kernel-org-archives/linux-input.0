From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] hid: holtekff: use %*ph to dump small buffers
Date: Wed,  5 Sep 2012 15:00:43 +0300
Message-ID: <1346846443-27263-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:45861 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752197Ab2IEMAS (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 5 Sep 2012 08:00:18 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-holtekff.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
index 4e75421..ff295e6 100644
--- a/drivers/hid/hid-holtekff.c
+++ b/drivers/hid/hid-holtekff.c
@@ -100,8 +100,7 @@ static void holtekff_send(struct holtekff_device *holtekff,
 		holtekff->field->value[i] = data[i];
 	}
 
-	dbg_hid("sending %02x %02x %02x %02x %02x %02x %02x\n", data[0],
-		data[1], data[2], data[3], data[4], data[5], data[6]);
+	dbg_hid("sending %*ph\n", 7, data);
 
 	usbhid_submit_report(hid, holtekff->field->report, USB_DIR_OUT);
 }
-- 
1.7.10.4

