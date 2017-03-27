From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH v3 01/19] HID: logitech-dj: allow devices to request full pairing information
Date: Mon, 27 Mar 2017 16:59:21 +0200
Message-ID: <20170327145939.29824-2-benjamin.tissoires@redhat.com>
References: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751124AbdC0O7y (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 27 Mar 2017 10:59:54 -0400
In-Reply-To: <20170327145939.29824-1-benjamin.tissoires@redhat.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

Register 0xB5 should be handled specially no matter what function is
used. This allows to retrieve the serial and the Quad ID from
hid-logitech-hidpp directly.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

---

changes in v3:
- fixed 0xb5 to handle any incoming parameters

no changes in v2
---
 drivers/hid/hid-logitech-dj.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 5bc6d80..826fa1e 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -692,8 +692,12 @@ static void logi_dj_ll_close(struct hid_device *hid)
 	dbg_hid("%s:%s\n", __func__, hid->phys);
 }
 
-static u8 unifying_name_query[]  = {0x10, 0xff, 0x83, 0xb5, 0x40, 0x00, 0x00};
-static u8 unifying_name_answer[] = {0x11, 0xff, 0x83, 0xb5};
+/*
+ * Register 0xB5 is "pairing information". It is solely intended for the
+ * receiver, so do not overwrite the device index.
+ */
+static u8 unifying_pairing_query[]  = {0x10, 0xff, 0x83, 0xb5};
+static u8 unifying_pairing_answer[] = {0x11, 0xff, 0x83, 0xb5};
 
 static int logi_dj_ll_raw_request(struct hid_device *hid,
 				  unsigned char reportnum, __u8 *buf,
@@ -712,9 +716,9 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
 
 		/* special case where we should not overwrite
 		 * the device_index */
-		if (count == 7 && !memcmp(buf, unifying_name_query,
-					  sizeof(unifying_name_query)))
-			buf[4] |= djdev->device_index - 1;
+		if (count == 7 && !memcmp(buf, unifying_pairing_query,
+					  sizeof(unifying_pairing_query)))
+			buf[4] = (buf[4] & 0xf0) | (djdev->device_index - 1);
 		else
 			buf[1] = djdev->device_index;
 		return hid_hw_raw_request(djrcv_dev->hdev, reportnum, buf,
@@ -911,9 +915,8 @@ static int logi_dj_hidpp_event(struct hid_device *hdev,
 		/* special case were the device wants to know its unifying
 		 * name */
 		if (size == HIDPP_REPORT_LONG_LENGTH &&
-		    !memcmp(data, unifying_name_answer,
-			    sizeof(unifying_name_answer)) &&
-		    ((data[4] & 0xF0) == 0x40))
+		    !memcmp(data, unifying_pairing_answer,
+			    sizeof(unifying_pairing_answer)))
 			device_index = (data[4] & 0x0F) + 1;
 		else
 			return false;
-- 
2.9.3

