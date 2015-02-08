From: Lauri Kasanen <cand@gmx.com>
Subject: [PATCH] HID: sony: Enable Gasia third-party PS3 controllers, v2
Date: Sun, 8 Feb 2015 11:11:38 +0200
Message-ID: <20150208111138.6f562d6c.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.15.19]:64906 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751956AbbBHJJ0 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sun, 8 Feb 2015 04:09:26 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com
Cc: ao2@ao2.it, AndrewD207@aol.com

Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
any events. Now everything works including the leds.

Based on work by Andrew Haines and Antonio Ospite.

v2:
- edited error messages
- use output_report

cc: Antonio Ospite <ao2@ao2.it>
cc: Andrew Haines <AndrewD207@aol.com>
Signed-off-by: Lauri Kasanen <cand@gmx.com>
---
 drivers/hid/hid-sony.c | 20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Despite Andrew's report, using output_report worked fine.

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d25..2661227 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1131,7 +1131,8 @@ static void sony_input_configured(struct hid_device *hdev,
 static int sixaxis_set_operational_usb(struct hid_device *hdev)
 {
 	int ret;
-	char *buf = kmalloc(18, GFP_KERNEL);
+	char *buf = kmalloc(65, GFP_KERNEL);
+	unsigned char buf2[] = { 0x00 };
 
 	if (!buf)
 		return -ENOMEM;
@@ -1140,7 +1141,22 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 				 HID_REQ_GET_REPORT);
 
 	if (ret < 0)
-		hid_err(hdev, "can't set operational mode\n");
+		hid_err(hdev, "can't set operational mode: step 1\n");
+
+	/*
+	 * Some compatible controllers like the Speedlink Strike FX and
+	 * Gasia need another query plus an USB interrupt to get operational.
+	 */
+	ret = hid_hw_raw_request(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+
+	if (ret < 0)
+		hid_err(hdev, "can't set operational mode: step 2\n");
+
+	ret = hid_hw_output_report(hdev, buf2, sizeof(buf2));
+
+	if (ret < 0)
+		hid_err(hdev, "can't set operational mode: step 3\n");
 
 	kfree(buf);
 
-- 
1.8.3.1

