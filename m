From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH] hid-holtekff: don't push static constants on stack for %*ph
Date: Fri,  2 Aug 2013 14:08:00 +0300
Message-ID: <1375441680-13593-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:16657 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751071Ab3HBLIN (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 2 Aug 2013 07:08:13 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Jiri Kosina <jkosina@suse.cz>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

There is no need to pass constants via stack. The width may be explicitly
specified in the format.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-holtekff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-holtekff.c b/drivers/hid/hid-holtekff.c
index 9a8f051..9325545 100644
--- a/drivers/hid/hid-holtekff.c
+++ b/drivers/hid/hid-holtekff.c
@@ -98,7 +98,7 @@ static void holtekff_send(struct holtekff_device *holtekff,
 		holtekff->field->value[i] = data[i];
 	}
 
-	dbg_hid("sending %*ph\n", 7, data);
+	dbg_hid("sending %7ph\n", data);
 
 	hid_hw_request(hid, holtekff->field->report, HID_REQ_SET_REPORT);
 }
-- 
1.8.4.rc0

