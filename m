From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2] hid-wiimote: print small buffers via %*phC
Date: Tue,  3 Sep 2013 17:48:26 +0300
Message-ID: <1378219706-20252-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:14331 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754119Ab3ICOsn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 3 Sep 2013 10:48:43 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: David Herrmann <dh.herrmann@googlemail.com>, Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Instead of passing each byte through stack let's use %*phC specifier to dump
buffer as a hex string.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: David Herrmann <dh.herrmann@gmail.com>
---
 drivers/hid/hid-wiimote-core.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/hid/hid-wiimote-core.c b/drivers/hid/hid-wiimote-core.c
index 6602098..abb20db 100644
--- a/drivers/hid/hid-wiimote-core.c
+++ b/drivers/hid/hid-wiimote-core.c
@@ -441,8 +441,7 @@ static __u8 wiimote_cmd_read_ext(struct wiimote_data *wdata, __u8 *rmem)
 	if (ret != 6)
 		return WIIMOTE_EXT_NONE;
 
-	hid_dbg(wdata->hdev, "extension ID: %02x:%02x %02x:%02x %02x:%02x\n",
-		rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
+	hid_dbg(wdata->hdev, "extension ID: %6phC\n", rmem);
 
 	if (rmem[0] == 0xff && rmem[1] == 0xff && rmem[2] == 0xff &&
 	    rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
@@ -512,14 +511,12 @@ static bool wiimote_cmd_read_mp(struct wiimote_data *wdata, __u8 *rmem)
 	if (ret != 6)
 		return false;
 
-	hid_dbg(wdata->hdev, "motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
-		rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
+	hid_dbg(wdata->hdev, "motion plus ID: %6phC\n", rmem);
 
 	if (rmem[5] == 0x05)
 		return true;
 
-	hid_info(wdata->hdev, "unknown motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
-		 rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
+	hid_info(wdata->hdev, "unknown motion plus ID: %6phC\n", rmem);
 
 	return false;
 }
@@ -535,8 +532,7 @@ static __u8 wiimote_cmd_read_mp_mapped(struct wiimote_data *wdata)
 	if (ret != 6)
 		return WIIMOTE_MP_NONE;
 
-	hid_dbg(wdata->hdev, "mapped motion plus ID: %02x:%02x %02x:%02x %02x:%02x\n",
-		rmem[0], rmem[1], rmem[2], rmem[3], rmem[4], rmem[5]);
+	hid_dbg(wdata->hdev, "mapped motion plus ID: %6phC\n", rmem);
 
 	if (rmem[0] == 0xff && rmem[1] == 0xff && rmem[2] == 0xff &&
 	    rmem[3] == 0xff && rmem[4] == 0xff && rmem[5] == 0xff)
@@ -1128,9 +1124,8 @@ static void wiimote_init_hotplug(struct wiimote_data *wdata)
 		wiimote_ext_unload(wdata);
 
 		if (exttype == WIIMOTE_EXT_UNKNOWN) {
-			hid_info(wdata->hdev, "cannot detect extension; %02x:%02x %02x:%02x %02x:%02x\n",
-				 extdata[0], extdata[1], extdata[2],
-				 extdata[3], extdata[4], extdata[5]);
+			hid_info(wdata->hdev, "cannot detect extension; %6phC\n",
+				 extdata);
 		} else if (exttype == WIIMOTE_EXT_NONE) {
 			spin_lock_irq(&wdata->state.lock);
 			wdata->state.exttype = WIIMOTE_EXT_NONE;
-- 
1.8.4.rc3

