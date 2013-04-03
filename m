From: Jason Gerecke <killertofu@gmail.com>
Subject: [PATCH] Input: wacom: Fix "can not retrieve extra class descriptor" for 24HDT
Date: Wed,  3 Apr 2013 15:52:52 -0700
Message-ID: <1365029572-1527-1-git-send-email-killertofu@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-da0-f49.google.com ([209.85.210.49]:36347 "EHLO
	mail-da0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758489Ab3DCWx6 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 3 Apr 2013 18:53:58 -0400
Received: by mail-da0-f49.google.com with SMTP id t11so849527daj.8
        for <linux-input@vger.kernel.org>; Wed, 03 Apr 2013 15:53:58 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, pinglinux@gmail.com, Jason Gerecke <killertofu@gmail.com>

The MFT device in the Cintiq 24HDT has two interfaces sharing the
same configuration. Without this patch, the driver attempts to
make use of both interfaces, even though the second interface is
not compatible with this driver.

Signed-off-by: Jason Gerecke <killertofu@gmail.com>
---
 drivers/input/tablet/wacom_wac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 1daa979..ed78be9 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2209,7 +2209,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x47) },
 	{ USB_DEVICE_WACOM(0xF4) },
 	{ USB_DEVICE_WACOM(0xF8) },
-	{ USB_DEVICE_WACOM(0xF6) },
+	{ USB_DEVICE_DETAILED(0xF6, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0xFA) },
 	{ USB_DEVICE_LENOVO(0x6004) },
 	{ }
-- 
1.8.2

