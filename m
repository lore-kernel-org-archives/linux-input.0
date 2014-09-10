From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/4 v2] HID: wacom - remove report_id from wacom_get_report interface
Date: Wed, 10 Sep 2014 12:41:04 -0700
Message-ID: <1410378064-14545-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:46787 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751624AbaIJTlK (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 10 Sep 2014 15:41:10 -0400
Received: by mail-pd0-f180.google.com with SMTP id ft15so9665306pdb.25
        for <linux-input@vger.kernel.org>; Wed, 10 Sep 2014 12:41:10 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: killertofu@gmail.com, linux-input@vger.kernel.org, Ping Cheng <pingc@wacom.com>

It is assigned in buf[0] anyway.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_sys.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/hid/wacom_sys.c b/drivers/hid/wacom_sys.c
index 4a7b9c8..f911f97 100644
--- a/drivers/hid/wacom_sys.c
+++ b/drivers/hid/wacom_sys.c
@@ -26,13 +26,13 @@
 #define DEV_ATTR_RW_PERM (S_IRUGO | S_IWUSR | S_IWGRP)
 #define DEV_ATTR_WO_PERM (S_IWUSR | S_IWGRP)
 
-static int wacom_get_report(struct hid_device *hdev, u8 type, u8 id,
-			    void *buf, size_t size, unsigned int retries)
+static int wacom_get_report(struct hid_device *hdev, u8 type, u8 *buf,
+			    size_t size, unsigned int retries)
 {
 	int retval;
 
 	do {
-		retval = hid_hw_raw_request(hdev, id, buf, size, type,
+		retval = hid_hw_raw_request(hdev, buf[0], buf, size, type,
 				HID_REQ_GET_REPORT);
 	} while ((retval == -ETIMEDOUT || retval == -EPIPE) && --retries);
 
@@ -258,7 +258,7 @@ static int wacom_set_device_mode(struct hid_device *hdev, int report_id,
 					 length, 1);
 		if (error >= 0)
 			error = wacom_get_report(hdev, HID_FEATURE_REPORT,
-			                         report_id, rep_data, length, 1);
+			                         rep_data, length, 1);
 	} while ((error < 0 || rep_data[1] != mode) && limit++ < WAC_MSG_RETRIES);
 
 	kfree(rep_data);
-- 
1.9.1

