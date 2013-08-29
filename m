From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/2] Input: wacom - testing result shows get_report is unnecessary.
Date: Thu, 29 Aug 2013 16:03:47 -0700
Message-ID: <1377817427-29761-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f182.google.com ([209.85.192.182]:51003 "EHLO
	mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754336Ab3H2XEW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 19:04:22 -0400
Received: by mail-pd0-f182.google.com with SMTP id r10so1063150pdi.27
        for <linux-input@vger.kernel.org>; Thu, 29 Aug 2013 16:04:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 79b69ea..1c70a8d 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -524,9 +524,6 @@ static int wacom_set_device_mode(struct usb_interface *intf, int report_id, int
 
 		error = wacom_set_report(intf, WAC_HID_FEATURE_REPORT,
 		                         report_id, rep_data, length, 1);
-		if (error >= 0)
-			error = wacom_get_report(intf, WAC_HID_FEATURE_REPORT,
-			                         report_id, rep_data, length, 1);
 	} while ((error < 0 || rep_data[1] != mode) && limit++ < WAC_MSG_RETRIES);
 
 	kfree(rep_data);
-- 
1.8.1.2

