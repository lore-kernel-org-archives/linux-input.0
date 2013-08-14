From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 4/4] hid-sensor-hub: change kmalloc + memcpy by kmemdup
Date: Wed, 14 Aug 2013 11:07:11 +0300
Message-ID: <1376467631-20857-4-git-send-email-andriy.shevchenko@linux.intel.com>
References: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60005 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755153Ab3HNIHv (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 04:07:51 -0400
In-Reply-To: <1376467631-20857-1-git-send-email-andriy.shevchenko@linux.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

The patch substitutes kmemdup for kmalloc followed by memcpy.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/hid/hid-sensor-hub.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sensor-hub.c b/drivers/hid/hid-sensor-hub.c
index 4cb19df..0794e9f 100644
--- a/drivers/hid/hid-sensor-hub.c
+++ b/drivers/hid/hid-sensor-hub.c
@@ -430,11 +430,10 @@ static int sensor_hub_raw_event(struct hid_device *hdev,
 		if (pdata->pending.status && pdata->pending.attr_usage_id ==
 				report->field[i]->usage->hid) {
 			hid_dbg(hdev, "data was pending ...\n");
-			pdata->pending.raw_data = kmalloc(sz, GFP_ATOMIC);
-			if (pdata->pending.raw_data) {
-				memcpy(pdata->pending.raw_data, ptr, sz);
+			pdata->pending.raw_data = kmemdup(ptr, sz, GFP_ATOMIC);
+			if (pdata->pending.raw_data)
 				pdata->pending.raw_size = sz;
-			} else
+			else
 				pdata->pending.raw_size = 0;
 			complete(&pdata->pending.ready);
 		}
-- 
1.8.4.rc2

