From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 1/2] HID: Show I2C bus type in hid_connect()
Date: Mon, 28 Sep 2015 15:15:07 +0300
Message-ID: <1443442508-94971-1-git-send-email-mika.westerberg@linux.intel.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31823 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756727AbbI1MPl (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 28 Sep 2015 08:15:41 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, linux-input@vger.kernel.org

For I2C HID devices output currently looks like:

  hid-multitouch ... input,hidraw0: <UNKNOWN> HID v1.00 Mouse ...

Add knowledge about I2C bus to hid_connect() so that it shows "I2C"
correctly instead of "<UNKNOWN>".

Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/hid/hid-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 70a11ac38119..7f1baba081a1 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1678,6 +1678,9 @@ int hid_connect(struct hid_device *hdev, unsigned int connect_mask)
 	case BUS_BLUETOOTH:
 		bus = "BLUETOOTH";
 		break;
+	case BUS_I2C:
+		bus = "I2C";
+		break;
 	default:
 		bus = "<UNKNOWN>";
 	}
-- 
2.5.1

