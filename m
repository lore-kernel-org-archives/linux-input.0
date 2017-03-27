From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 07/19] HID: logitech-hidpp: retrieve the HID++ device name when available
Date: Mon, 27 Mar 2017 16:59:27 +0200
Message-ID: <20170327145939.29824-8-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39714 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753463AbdC0PAE (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 11:00:04 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

hidpp->name can't be null.
Only HID++ 2.0 and above device supports the query.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- moved up in the series

new in v2
---
 drivers/hid/hid-logitech-hidpp.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index db15cfc..b0d2fea 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -2443,13 +2443,7 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 			 hidpp->protocol_major, hidpp->protocol_minor);
 	}
 
-	hidpp_initialize_battery(hidpp);
-
-	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
-		/* if HID created the input nodes for us, we can stop now */
-		return;
-
-	if (!hidpp->name || hidpp->name == hdev->name) {
+	if (hidpp->name == hdev->name && hidpp->protocol_major >= 2) {
 		name = hidpp_get_device_name(hidpp);
 		if (!name) {
 			hid_err(hdev,
@@ -2465,6 +2459,12 @@ static void hidpp_connect_event(struct hidpp_device *hidpp)
 		hidpp->name = devm_name;
 	}
 
+	hidpp_initialize_battery(hidpp);
+
+	if (!(hidpp->quirks & HIDPP_QUIRK_NO_HIDINPUT))
+		/* if HID created the input nodes for us, we can stop now */
+		return;
+
 	input = hidpp_allocate_input(hdev);
 	if (!input) {
 		hid_err(hdev, "cannot allocate new input device: %d\n", ret);
-- 
2.9.3

