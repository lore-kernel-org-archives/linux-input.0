From: Lauri Kasanen <cand@gmx.com>
Subject: [PATCHv3] HID: sony: Enable Gasia third-party PS3 controllers
Date: Tue, 10 Feb 2015 14:52:52 +0200
Message-ID: <20150210145252.d5b86e42.cand@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mout.gmx.net ([212.227.17.21]:50833 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752736AbbBJMuf (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 10 Feb 2015 07:50:35 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, benjamin.tissoires@gmail.com
Cc: ao2@ao2.it, AndrewD207@aol.com

Without this, my "Gasia Co.,Ltd PS(R) Gamepad" would not send
any events. Now everything works including the leds.

Based on work by Andrew Haines and Antonio Ospite.

cc: Antonio Ospite <ao2@ao2.it>
cc: Andrew Haines <AndrewD207@aol.com>
Signed-off-by: Lauri Kasanen <cand@gmx.com>
---
 drivers/hid/hid-sony.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

v3:
- reuse the dummy heap buffer
- skip later checks if the earlier ones fail

v2:
- edited error messages
- use output_report

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 31e9d25..b0010d9 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1131,7 +1131,7 @@ static void sony_input_configured(struct hid_device *hdev,
 static int sixaxis_set_operational_usb(struct hid_device *hdev)
 {
 	int ret;
-	char *buf = kmalloc(18, GFP_KERNEL);
+	char *buf = kmalloc(65, GFP_KERNEL);
 
 	if (!buf)
 		return -ENOMEM;
@@ -1139,9 +1139,29 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 	ret = hid_hw_raw_request(hdev, 0xf2, buf, 17, HID_FEATURE_REPORT,
 				 HID_REQ_GET_REPORT);
 
+	if (ret < 0) {
+		hid_err(hdev, "can't set operational mode: step 1\n");
+		goto out;
+	}
+
+	/*
+	 * Some compatible controllers like the Speedlink Strike FX and
+	 * Gasia need another query plus an USB interrupt to get operational.
+	 */
+	ret = hid_hw_raw_request(hdev, 0xf5, buf, 64, HID_FEATURE_REPORT,
+				 HID_REQ_GET_REPORT);
+
+	if (ret < 0) {
+		hid_err(hdev, "can't set operational mode: step 2\n");
+		goto out;
+	}
+
+	ret = hid_hw_output_report(hdev, buf, 1);
+
 	if (ret < 0)
-		hid_err(hdev, "can't set operational mode\n");
+		hid_err(hdev, "can't set operational mode: step 3\n");
 
+out:
 	kfree(buf);
 
 	return ret;
-- 
1.8.3.1

