From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 3/5] HID: sony: Don't use magic numbers in sixaxis_set_operational_usb()
Date: Mon, 16 Feb 2015 18:12:22 +0100
Message-ID: <1424106744-12872-4-git-send-email-ao2@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
 <1424106744-12872-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:30646 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753463AbbBPRMn (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 12:12:43 -0500
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

Remove the magic numbers used in sixaxis_set_operational_usb():
  - use the already defined SIXAXIS_REPORT_0xF2_SIZE;
  - define and use SIXAXIS_REPORT_0xF5_SIZE;
  - set the dummy buffer size to accommodate any report that is going to
    be requested.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 303335b..a419868 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -803,6 +803,7 @@ union sixaxis_output_report_01 {
 #define DS4_REPORT_0x11_SIZE 78
 #define DS4_REPORT_0x81_SIZE 7
 #define SIXAXIS_REPORT_0xF2_SIZE 17
+#define SIXAXIS_REPORT_0xF5_SIZE 8
 
 static spinlock_t sony_dev_list_lock;
 static LIST_HEAD(sony_device_list);
@@ -1131,13 +1132,15 @@ static void sony_input_configured(struct hid_device *hdev,
 static int sixaxis_set_operational_usb(struct hid_device *hdev)
 {
 	int ret;
-	char *buf = kmalloc(18, GFP_KERNEL);
+	const int buf_size =
+		max(SIXAXIS_REPORT_0xF2_SIZE, SIXAXIS_REPORT_0xF5_SIZE);
+	char *buf = kmalloc(buf_size, GFP_KERNEL);
 
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(hdev, 0xf2, buf, 17, HID_FEATURE_REPORT,
-				 HID_REQ_GET_REPORT);
+	ret = hid_hw_raw_request(hdev, 0xf2, buf, SIXAXIS_REPORT_0xF2_SIZE,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 	if (ret < 0) {
 		hid_err(hdev, "can't set operational mode: step 1\n");
@@ -1148,8 +1151,8 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	 * Some compatible controllers like the Speedlink Strike FX and
 	 * Gasia need another query plus an USB interrupt to get operational.
 	 */
-	ret = hid_hw_raw_request(hdev, 0xf5, buf, 8, HID_FEATURE_REPORT,
-				 HID_REQ_GET_REPORT);
+	ret = hid_hw_raw_request(hdev, 0xf5, buf, SIXAXIS_REPORT_0xF5_SIZE,
+				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
 
 	if (ret < 0) {
 		hid_err(hdev, "can't set operational mode: step 2\n");
-- 
2.1.4

