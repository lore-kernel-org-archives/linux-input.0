From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] HID: sony: Fix SHANWAN pad rumbling on USB
Date: Tue,  7 Nov 2017 15:24:47 +0100
Message-ID: <20171107142447.11810-1-hadess@hadess.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from slow1-d.mail.gandi.net ([217.70.178.86]:37345 "EHLO
        slow1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751875AbdKGOZL (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 7 Nov 2017 09:25:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>, Szymon Janc <szymon.janc@codecoup.pl>, Bastien Nocera <hadess@hadess.net>

The SHANWAN PS3 clone joypad will start its rumble motors as soon as
it is plugged in via USB. As the additional USB interrupt does nothing on
the original PS3 Sixaxis joypads, and makes a number of other
clone joypads actually start sending data, disable that call for
the SHANWAN so the rumble motors aren't started on plug.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-sony.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index d03203a82e8f..b9dc3ac4d4aa 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -1439,10 +1439,16 @@ static int sixaxis_set_operational_usb(struct hid_device *hdev)
 		goto out;
 	}
 
-	ret = hid_hw_output_report(hdev, buf, 1);
-	if (ret < 0) {
-		hid_info(hdev, "can't set operational mode: step 3, ignoring\n");
-		ret = 0;
+	/*
+	 * But the USB interrupt would cause SHANWAN controllers to
+	 * start rumbling non-stop.
+	 */
+	if (strcmp(hdev->name, "SHANWAN PS3 GamePad")) {
+		ret = hid_hw_output_report(hdev, buf, 1);
+		if (ret < 0) {
+			hid_info(hdev, "can't set operational mode: step 3, ignoring\n");
+			ret = 0;
+		}
 	}
 
 out:
-- 
2.14.3

