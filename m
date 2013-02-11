From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/3] HID: extend autodetect to handle I2C sensors as well
Date: Mon, 11 Feb 2013 12:31:17 +0200
Message-ID: <1360578679-7029-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:32422 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754732Ab3BKKaA (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 11 Feb 2013 05:30:00 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, linux-input@vger.kernel.org, srinivas.pandruvada@intel.com, Mika Westerberg <mika.westerberg@linux.intel.com>

Since the advent of HID over I2C protocol, it is possible to have sensor
hubs behind I2C bus as well. We can autodetect this in a same way than USB
sensor hubs.

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index eb2ee11..fe3a59e 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -729,7 +729,7 @@ static int hid_scan_report(struct hid_device *hid)
 			item.type == HID_ITEM_TYPE_MAIN &&
 			item.tag == HID_MAIN_ITEM_TAG_BEGIN_COLLECTION &&
 			(item_udata(&item) & 0xff) == HID_COLLECTION_PHYSICAL &&
-			hid->bus == BUS_USB)
+			(hid->bus == BUS_USB || hid->bus == BUS_I2C))
 			hid->group = HID_GROUP_SENSOR_HUB;
 	}
 
-- 
1.7.10.4

