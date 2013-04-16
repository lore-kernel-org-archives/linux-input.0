From: Ping Cheng <pinglinux@gmail.com>
Subject: [PATCH 2/2] input: wacom: Fix "can not retrieve extra class descriptor" for DTH2242
Date: Mon, 15 Apr 2013 19:55:21 -0700
Message-ID: <1366080921-26459-1-git-send-email-pingc@wacom.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:46622 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935212Ab3DPCzW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 15 Apr 2013 22:55:22 -0400
Received: by mail-pa0-f46.google.com with SMTP id lb1so80088pab.5
        for <linux-input@vger.kernel.org>; Mon, 15 Apr 2013 19:55:21 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, Ping Cheng <pingc@wacom.com>

Same as Cintiq 24HDT, DTH2242 has two interfaces sharing one configuration.
This patch ignores the second interface.

Signed-off-by: Ping Cheng <pingc@wacom.com>
---
 drivers/input/tablet/wacom_wac.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/input/tablet/wacom_wac.c b/drivers/input/tablet/wacom_wac.c
index 9ec24df..0bfd8cf 100644
--- a/drivers/input/tablet/wacom_wac.c
+++ b/drivers/input/tablet/wacom_wac.c
@@ -2144,7 +2144,7 @@ const struct usb_device_id wacom_ids[] = {
 	{ USB_DEVICE_WACOM(0x44) },
 	{ USB_DEVICE_WACOM(0x45) },
 	{ USB_DEVICE_WACOM(0x59) },
-	{ USB_DEVICE_WACOM(0x5D) },
+	{ USB_DEVICE_DETAILED(0x5D, USB_CLASS_HID, 0, 0) },
 	{ USB_DEVICE_WACOM(0xB0) },
 	{ USB_DEVICE_WACOM(0xB1) },
 	{ USB_DEVICE_WACOM(0xB2) },
-- 
1.7.10.4

