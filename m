From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] Input: wacom - LED is only suported through digitizer interface
Date: Thu, 29 Aug 2013 16:04:58 -0700
Message-ID: <1377817498-29799-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f175.google.com ([209.85.192.175]:55819 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755316Ab3H2XFF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 29 Aug 2013 19:05:05 -0400
Received: by mail-pd0-f175.google.com with SMTP id q10so1061294pdj.34
        for <linux-input@vger.kernel.org>; Thu, 29 Aug 2013 16:05:04 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_sys.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/input/tablet/wacom_sys.c b/drivers/input/tablet/wacom_sys.c
index 1c70a8d..f1469e4 100644
--- a/drivers/input/tablet/wacom_sys.c
+++ b/drivers/input/tablet/wacom_sys.c
@@ -978,14 +978,17 @@ static int wacom_initialize_leds(struct wacom *wacom)
 	case INTUOS5S:
 	case INTUOS5:
 	case INTUOS5L:
-		wacom->led.select[0] = 0;
-		wacom->led.select[1] = 0;
-		wacom->led.llv = 32;
-		wacom->led.hlv = 0;
-		wacom->led.img_lum = 0;
-
-		error = sysfs_create_group(&wacom->intf->dev.kobj,
-					   &intuos5_led_attr_group);
+		if (wacom->wacom_wac.features.device_type == BTN_TOOL_PEN) {
+			wacom->led.select[0] = 0;
+			wacom->led.select[1] = 0;
+			wacom->led.llv = 32;
+			wacom->led.hlv = 0;
+			wacom->led.img_lum = 0;
+
+			error = sysfs_create_group(&wacom->intf->dev.kobj,
+					 	  &intuos5_led_attr_group);
+		} else
+			return 0;
 		break;
 
 	default:
@@ -1021,8 +1024,9 @@ static void wacom_destroy_leds(struct wacom *wacom)
 	case INTUOS5S:
 	case INTUOS5:
 	case INTUOS5L:
-		sysfs_remove_group(&wacom->intf->dev.kobj,
-				   &intuos5_led_attr_group);
+		if (wacom->wacom_wac.features.device_type == BTN_TOOL_PEN)
+			sysfs_remove_group(&wacom->intf->dev.kobj,
+					   &intuos5_led_attr_group);
 		break;
 	}
 }
-- 
1.8.1.2

