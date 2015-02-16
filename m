From: Antonio Ospite <ao2@ao2.it>
Subject: [PATCH 5/5] HID: sony: Coding style cleanups in sixaxis_set_operational_usb()
Date: Mon, 16 Feb 2015 18:12:24 +0100
Message-ID: <1424106744-12872-6-git-send-email-ao2@ao2.it>
References: <20150216150659.db522f3d.cand@gmx.com>
 <1424106744-12872-1-git-send-email-ao2@ao2.it>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp205.alice.it ([82.57.200.101]:46249 "EHLO smtp205.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753426AbbBPRMk (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 16 Feb 2015 12:12:40 -0500
In-Reply-To: <1424106744-12872-1-git-send-email-ao2@ao2.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Antonio Ospite <ao2@ao2.it>, Jiri Kosina <jkosina@suse.cz>, Lauri Kasanen <cand@gmx.com>, Frank Praznik <frank.praznik@oh.rr.com>

Don't mix declaration and allocation, remove some useless newlines
between calling a function and checking its return value.

Signed-off-by: Antonio Ospite <ao2@ao2.it>
---
 drivers/hid/hid-sony.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 4a50e65..9e0987d 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1131,17 +1131,17 @@ static void sony_input_configured(struct hid_device *hdev,
  */
 static int sixaxis_set_operational_usb(struct hid_device *hdev)
 {
-	int ret;
 	const int buf_size =
 		max(SIXAXIS_REPORT_0xF2_SIZE, SIXAXIS_REPORT_0xF5_SIZE);
-	__u8 *buf = kmalloc(buf_size, GFP_KERNEL);
+	__u8 *buf;
+	int ret;
 
+	buf = kmalloc(buf_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
 	ret = hid_hw_raw_request(hdev, 0xf2, buf, SIXAXIS_REPORT_0xF2_SIZE,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
-
 	if (ret < 0) {
 		hid_err(hdev, "can't set operational mode: step 1\n");
 		goto out;
@@ -1153,14 +1153,12 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	 */
 	ret = hid_hw_raw_request(hdev, 0xf5, buf, SIXAXIS_REPORT_0xF5_SIZE,
 				 HID_FEATURE_REPORT, HID_REQ_GET_REPORT);
-
 	if (ret < 0) {
 		hid_err(hdev, "can't set operational mode: step 2\n");
 		goto out;
 	}
 
 	ret = hid_hw_output_report(hdev, buf, 1);
-
 	if (ret < 0)
 		hid_err(hdev, "can't set operational mode: step 3\n");
 
-- 
2.1.4

