From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH] HID: multitouch: Add suffix for HID_DG_TOUCHPAD
Date: Mon, 28 Sep 2015 17:22:17 +0300
Message-ID: <1443450137-139724-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:21110 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933866AbbI1OW0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 10:22:26 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org

Instead of printing "UNKNOWN" as device suffix for HID_DG_TOUCHPAD call
the device as "Touchpad".

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-multitouch.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 426b2f1a3450..661b4fce1a5d 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -968,6 +968,9 @@ static void mt_input_configured(struct hid_device *hdev, struct hid_input *hi)
 		case HID_DG_TOUCHSCREEN:
 			/* we do not set suffix = "Touchscreen" */
 			break;
+		case HID_DG_TOUCHPAD:
+			suffix = "Touchpad";
+			break;
 		case HID_GD_SYSTEM_CONTROL:
 			suffix = "System Control";
 			break;
-- 
2.5.1

