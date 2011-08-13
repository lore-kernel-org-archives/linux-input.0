From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 3/5] input: wacom - define hardcoded limit
Date: Fri, 12 Aug 2011 17:08:57 -0700
Message-ID: <1313194137-5024-1-git-send-email-pinglinux@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:59582 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752343Ab1HMAHS (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 12 Aug 2011 20:07:18 -0400
Received: by yxj19 with SMTP id 19so2303383yxj.19
        for <linux-input@vger.kernel.org>; Fri, 12 Aug 2011 17:07:18 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pinglinux@gmail.com>, Ping Cheng <pingc@wacom.com>

>From 5 to WAC_MSG_RETRIES

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 36001eb..34edaae 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -49,6 +49,7 @@ struct hid_descriptor {
 #define USB_REQ_GET_REPORT	0x01
 #define USB_REQ_SET_REPORT	0x09
 #define WAC_HID_FEATURE_REPORT	0x03
+#define WAC_MSG_RETRIES		5
 
 static int usb_get_report(struct usb_interface *intf, unsigned char type,
 				unsigned char id, void *buf, int size)
@@ -165,7 +166,7 @@ static int wacom_parse_hid(struct usb_interface *intf, struct hid_descriptor *hi
 			report,
 			hid_desc->wDescriptorLength,
 			5000); /* 5 secs */
-	} while (result < 0 && limit++ < 5);
+	} while (result < 0 && limit++ < WAC_MSG_RETRIES);
 
 	/* No need to parse the Descriptor. It isn't an error though */
 	if (result < 0)
@@ -322,7 +323,7 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 				error = usb_get_report(intf,
 					WAC_HID_FEATURE_REPORT, report_id,
 					rep_data, 3);
-		} while ((error < 0 || rep_data[1] != 4) && limit++ < 5);
+		} while ((error < 0 || rep_data[1] != 4) && limit++ < WAC_MSG_RETRIES);
 	} else if (features->type != TABLETPC) {
 		do {
 			rep_data[0] = 2;
@@ -333,7 +334,7 @@ static int wacom_query_tablet_data(struct usb_interface *intf, struct wacom_feat
 				error = usb_get_report(intf,
 					WAC_HID_FEATURE_REPORT, report_id,
 					rep_data, 2);
-		} while ((error < 0 || rep_data[1] != 2) && limit++ < 5);
+		} while ((error < 0 || rep_data[1] != 2) && limit++ < WAC_MSG_RETRIES);
 	}
 
 	kfree(rep_data);
-- 
1.7.6

