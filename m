From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 01/17] HID: logitech-dj: allow devices to request full pairing information
Date: Tue, 17 Jan 2017 15:35:31 +0100
Message-ID: <20170117143547.30488-2-benjamin.tissoires@redhat.com>
References: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170117143547.30488-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Bastien Nocera <hadess@hadess.net>, Peter Hutterer <peter.hutterer@who-t.net>, Nestor Lopez Casado <nlopezcasad@logitech.com>, Olivier Gay <ogay@logitech.com>, Simon Wood <simon@mungewell.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

Register 0xB5 should be handled specially no matter what function is
used. This allows to retrieve the serial and the Quad ID from
hid-logitech-hidpp directly.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-dj.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 5bc6d80..71ce4ca 100644
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
@@ -712,8 +716,8 @@ static int logi_dj_ll_raw_request(struct hid_device *hid,
 
 		/* special case where we should not overwrite
 		 * the device_index */
-		if (count == 7 && !memcmp(buf, unifying_name_query,
-					  sizeof(unifying_name_query)))
+		if (count == 7 && !memcmp(buf, unifying_pairing_query,
+					  sizeof(unifying_pairing_query)))
 			buf[4] |= djdev->device_index - 1;
 		else
 			buf[1] = djdev->device_index;
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
