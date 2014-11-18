From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 1/3] HID: wacom - return ENODEV for failed wacom_setup_pad_input_capabilities
Date: Tue, 18 Nov 2014 13:27:48 -0800
Message-ID: <1416346068-11266-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:39284 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932074AbaKRV14 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 18 Nov 2014 16:27:56 -0500
Received: by mail-pa0-f45.google.com with SMTP id lj1so1177052pab.4
        for <linux-input@vger.kernel.org>; Tue, 18 Nov 2014 13:27:56 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: linux-input@vger.kernel.org, benjamin.tissoires@gmail.com, Ping Cheng <pingc@wacom.com>

ENODEV indicates no device is added. Hence, the associated pad input device
is simply freed.

Signed-off-by: Ping Cheng <pingc@wacom.com>
Reviewed-by:  Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/wacom_wac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/wacom_wac.c b/drivers/hid/wacom_wac.c
index 586b240..372d890 100644
--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -2402,7 +2402,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case INTUOSPS:
 		/* touch interface does not have the pad device */
 		if (features->device_type != BTN_TOOL_PEN)
-			return 1;
+			return -ENODEV;
 
 		for (i = 0; i < 7; i++)
 			__set_bit(BTN_0 + i, input_dev->keybit);
@@ -2447,7 +2447,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 	case BAMBOO_PT:
 		/* pad device is on the touch interface */
 		if (features->device_type != BTN_TOOL_FINGER)
-			return 1;
+			return -ENODEV;
 
 		__clear_bit(ABS_MISC, input_dev->absbit);
 
@@ -2460,7 +2460,7 @@ int wacom_setup_pad_input_capabilities(struct input_dev *input_dev,
 
 	default:
 		/* no pad supported */
-		return 1;
+		return -ENODEV;
 	}
 	return 0;
 }
-- 
1.9.1

