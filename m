From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 4/5] input: wacom - report id 3 returns 4 bytes data
Date: Fri, 12 Aug 2011 17:09:44 -0700
Message-ID: <1313194184-5061-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:48570 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab1HMAIG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 20:08:06 -0400
Received: by gya6 with SMTP id 6so2310671gya.19
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 17:08:06 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 34edaae..958b4eb 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -306,23 +306,25 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 	int limit = 0, report_id = 2;
 	int error = -ENOMEM;
 
-	rep_data = kmalloc(2, GFP_KERNEL);
+	rep_data = kmalloc(4, GFP_KERNEL);
 	if (!rep_data)
 		return error;
 
-	/* ask to report tablet data if it is 2FGT Tablet PC or
+	/* ask to report tablet data if it is MT Tablet PC or
 	 * not a Tablet PC */
 	if (features->type == TABLETPC2FG) {
 		do {
 			rep_data[0] = 3;
 			rep_data[1] = 4;
+			rep_data[2] = 0;
+			rep_data[3] = 0;
 			report_id = 3;
 			error = usb_set_report(intf, WAC_HID_FEATURE_REPORT,
-				report_id, rep_data, 2);
+				report_id, rep_data, 4);
 			if (error >= 0)
 				error = usb_get_report(intf,
 					WAC_HID_FEATURE_REPORT, report_id,
-					rep_data, 3);
+					rep_data, 4);
 		} while ((error < 0 || rep_data[1] != 4) && limit++ < WAC_MSG_RETRIES);
 	} else if (features->type != TABLETPC) {
 		do {
-- 
1.7.6

