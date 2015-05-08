From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH 1/2] HID: wacom: Allow wacom_{get,set}_report to retry on -EAGAIN
Date: Fri,  8 May 2015 14:25:01 -0700
Message-ID: <1431120302-13691-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:35325 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbbEHV0A (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2015 17:26:00 -0400
Received: by pabtp1 with SMTP id tp1so59537913pab.2
        for <linux-input@vger.kernel.org>; Fri, 08 May 2015 14:26:00 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, jono <lejono@gmail.com>, Ping Cheng <pinglinux@gmail.com>
Cc: linux-input@vger.kernel.org, Jason Gerecke <killertofu@gmail.com>, Jason Gerecke <jason.gerecke@wacom.com>

If we get an -EAGAIN error within either of the wacom_{get,set}_report
functions, we should use one of our retries if available. Also, log an error
if the functions fail so that we can be aware of what's going on.

Signed-off-by: Jason Gerecke <jason.gerecke@wacom.com>
---
 drivers/hid/wacom_sys.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 7abf52c..3cd74d9 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -35,7 +35,11 @@ static int wacom_get_report(struct hid_device *hdev, u8 type, u8 *buf,
 	do {
 		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
 				HID_REQ_GET_REPORT);
-	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
+	} while ((retval == -ETIMEDOUT || retval == -EPIPE || retval == -EAGAIN) && --retries);
+
+	if (retval < 0)
+		dev_err(&hdev->dev, "wacom_get_report: ran out of retries "
+			"(last error = %d)\n", retval);
 
 	return retval;
 }
@@ -48,7 +52,11 @@ static int wacom_set_report(struct hid_device *hdev, u8 type, u8 *buf,
 	do {
 		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
 				HID_REQ_SET_REPORT);
-	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
+	} while ((retval == -ETIMEDOUT || retval == -EPIPE || retval == -EAGAIN) && --retries);
+
+	if (retval < 0)
+		dev_err(&hdev->dev, "wacom_set_report: ran out of retries "
+			"(last error = %d)\n", retval);
 
 	return retval;
 }
-- 
2.4.0

