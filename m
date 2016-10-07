From: Roderick Colenbrander <roderick@gaikai.com>
Subject: [PATCH 2/7] HID: sony: Adjust HID report size name definitions
Date: Fri,  7 Oct 2016 12:39:35 -0700
Message-ID: <1475869180-26757-3-git-send-email-roderick@gaikai.com>
References: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-io0-f176.google.com ([209.85.223.176]:36220 "EHLO
        mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755351AbcJGTkO (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Fri, 7 Oct 2016 15:40:14 -0400
Received: by mail-io0-f176.google.com with SMTP id j37so57471869ioo.3
        for <linux-input@vger.kernel.org>; Fri, 07 Oct 2016 12:40:13 -0700 (PDT)
In-Reply-To: <1475869180-26757-1-git-send-email-roderick@gaikai.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Benjamin Tissoires <benjamin.tissoires@redhat.com>, Jiri Kosina <jikos@kernel.org>, Tim Bird <tim.bird@am.sony.com>, Roderick Colenbrander <roderick.colenbrander@sony.com>

From: Roderick Colenbrander <roderick.colenbrander@sony.com>

Put the report type (feature / output) in the report size definitions.
This prevents name collisions later on for other different reports, which use
the same report id, but have a different size.

Signed-off-by: Roderick Colenbrander <roderick.colenbrander@sony.com>
---
 drivers/hid/hid-sony.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index afa8219..43bb24c 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1019,10 +1019,10 @@ struct motion_output_report_02 {
 	u8 rumble;
 };
 
-#define DS4_REPORT_0x02_SIZE 37
-#define DS4_REPORT_0x05_SIZE 32
-#define DS4_REPORT_0x11_SIZE 78
-#define DS4_REPORT_0x81_SIZE 7
+#define DS4_FEATURE_REPORT_0x02_SIZE 37
+#define DS4_FEATURE_REPORT_0x81_SIZE 7
+#define DS4_OUTPUT_REPORT_0x05_SIZE 32
+#define DS4_OUTPUT_REPORT_0x11_SIZE 78
 #define SIXAXIS_REPORT_0xF2_SIZE 17
 #define SIXAXIS_REPORT_0xF5_SIZE 8
 #define MOTION_REPORT_0x02_SIZE 49
@@ -1461,11 +1461,11 @@ static int dualshock4_set_operational_bt(struct hid_device *hdev)
 	u8 *buf;
 	int ret;
 
-	buf = kmalloc(DS4_REPORT_0x02_SIZE, GFP_KERNEL);
+	buf = kmalloc(DS4_FEATURE_REPORT_0x02_SIZE, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(hdev, 0x02, buf, DS4_REPORT_0x02_SIZE,
+	ret = hid_hw_raw_request(hdev, 0x02, buf, DS4_FEATURE_REPORT_0x02_SIZE,
 				HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 	kfree(buf);
@@ -1870,12 +1870,12 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	 * 0xD0 - 66hz
 	 */
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
-		memset(buf, 0, DS4_REPORT_0x05_SIZE);
+		memset(buf, 0, DS4_OUTPUT_REPORT_0x05_SIZE);
 		buf[0] = 0x05;
 		buf[1] = 0xFF;
 		offset = 4;
 	} else {
-		memset(buf, 0, DS4_REPORT_0x11_SIZE);
+		memset(buf, 0, DS4_OUTPUT_REPORT_0x11_SIZE);
 		buf[0] = 0x11;
 		buf[1] = 0x80;
 		buf[3] = 0x0F;
@@ -1903,9 +1903,9 @@ static void dualshock4_send_output_report(struct sony_sc *sc)
 	buf[offset++] = sc->led_delay_off[3];
 
 	if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
-		hid_hw_output_report(hdev, buf, DS4_REPORT_0x05_SIZE);
+		hid_hw_output_report(hdev, buf, DS4_OUTPUT_REPORT_0x05_SIZE);
 	else
-		hid_hw_raw_request(hdev, 0x11, buf, DS4_REPORT_0x11_SIZE,
+		hid_hw_raw_request(hdev, 0x11, buf, DS4_OUTPUT_REPORT_0x11_SIZE,
 				HID_OUTPUT_REPORT, HID_REQ_SET_REPORT);
 }
 
@@ -1950,10 +1950,10 @@ static int sony_allocate_output_report(struct sony_sc *sc)
 			kmalloc(sizeof(union sixaxis_output_report_01),
 				GFP_KERNEL);
 	else if (sc->quirks & DUALSHOCK4_CONTROLLER_BT)
-		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x11_SIZE,
+		sc->output_report_dmabuf = kmalloc(DS4_OUTPUT_REPORT_0x11_SIZE,
 						GFP_KERNEL);
 	else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB)
-		sc->output_report_dmabuf = kmalloc(DS4_REPORT_0x05_SIZE,
+		sc->output_report_dmabuf = kmalloc(DS4_OUTPUT_REPORT_0x05_SIZE,
 						GFP_KERNEL);
 	else if (sc->quirks & MOTION_CONTROLLER)
 		sc->output_report_dmabuf = kmalloc(MOTION_REPORT_0x02_SIZE,
@@ -2198,7 +2198,7 @@ static int sony_check_add(struct sony_sc *sc)
 			return 0;
 		}
 	} else if (sc->quirks & DUALSHOCK4_CONTROLLER_USB) {
-		buf = kmalloc(DS4_REPORT_0x81_SIZE, GFP_KERNEL);
+		buf = kmalloc(DS4_FEATURE_REPORT_0x81_SIZE, GFP_KERNEL);
 		if (!buf)
 			return -ENOMEM;
 
@@ -2208,10 +2208,10 @@ static int sony_check_add(struct sony_sc *sc)
 		 * offset 1.
 		 */
 		ret = hid_hw_raw_request(sc->hdev, 0x81, buf,
-				DS4_REPORT_0x81_SIZE, HID_FEATURE_REPORT,
+				DS4_FEATURE_REPORT_0x81_SIZE, HID_FEATURE_REPORT,
 				HID_REQ_GET_REPORT);
 
-		if (ret != DS4_REPORT_0x81_SIZE) {
+		if (ret != DS4_FEATURE_REPORT_0x81_SIZE) {
 			hid_err(sc->hdev, "failed to retrieve feature report 0x81 with the DualShock 4 MAC address\n");
 			ret = ret < 0 ? ret : -EINVAL;
 			goto out_free;
-- 
2.7.4

