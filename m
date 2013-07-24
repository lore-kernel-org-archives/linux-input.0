From: Yann Cantin <yann.cantin@laposte.net>
Subject: [RFC ebeam PATCH 1/2] hid: Blacklist eBeam devices
Date: Thu, 25 Jul 2013 01:52:19 +0200
Message-ID: <1374709940-607-2-git-send-email-yann.cantin@laposte.net>
References: <1374709940-607-1-git-send-email-yann.cantin@laposte.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp07.smtpout.orange.fr ([80.12.242.129]:38449 "EHLO
	smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753983Ab3GYABF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 24 Jul 2013 20:01:05 -0400
In-Reply-To: <1374709940-607-1-git-send-email-yann.cantin@laposte.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, linux-usb@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, dmitry.torokhov@gmail.com, jkosina@suse.cz, rob@landley.net, gregkh@linuxfoundation.org, Yann Cantin <yann.cantin@laposte.net>


Signed-off-by: Yann Cantin <yann.cantin@laposte.net>
---
 drivers/hid/hid-core.c | 3 +++
 drivers/hid/hid-ids.h  | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 36668d1..da5dfa0 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1985,6 +1985,9 @@ static const struct hid_device_id hid_ignore_list[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DELORME, USB_DEVICE_ID_DELORME_EM_LT20) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x0004) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_DREAM_CHEEKY, 0x000a) },
+#if defined(CONFIG_INPUT_EBEAM_USB)
+	{ HID_USB_DEVICE(USB_VENDOR_ID_EFI, USB_DEVICE_ID_EFI_EBEAM) },
+#endif
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ESSENTIAL_REALITY, USB_DEVICE_ID_ESSENTIAL_REALITY_P5) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC5UH) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_ETT, USB_DEVICE_ID_TC4UM) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index ffe4c7a..abd1c53 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -288,6 +288,9 @@
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_73F7	0x73f7
 #define USB_DEVICE_ID_DWAV_EGALAX_MULTITOUCH_A001	0xa001
 
+#define USB_VENDOR_ID_EFI		0x2650
+#define USB_DEVICE_ID_EFI_EBEAM		0x1311
+
 #define USB_VENDOR_ID_ELECOM		0x056e
 #define USB_DEVICE_ID_ELECOM_BM084	0x0061
 
-- 
1.8.1.5

