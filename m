From: Forest Wilkinson <web11.forest@tibit.com>
Subject: [PATCH] HID: enable all buttons on the TiVo Slide Pro remote
Date: Thu, 12 Mar 2015 23:58:16 -0700
Message-ID: <i825gaplvjcd1oha4ethkjj325m51ujano@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from c.mail.sonic.net ([64.142.111.80]:47034 "EHLO c.mail.sonic.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750874AbbCMHId (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 13 Mar 2015 03:08:33 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org

The linux kernel has supported the TiVo Slide remote control for some time,
but does not recognize the USB ID of the newer Slide Pro. This patch adds
the missing data structures so the newer remote will be recognized by the
driver, thereby allowing the TiVo, LiveTV, and Thumbs Up/Down buttons to be
mapped with a hwdb file.

Signed-off-by: Forest Wilkinson <web11.forest@tibit.com>
---
 drivers/hid/hid-core.c | 1 +
 drivers/hid/hid-ids.h  | 1 +
 drivers/hid/hid-tivo.c | 1 +
 3 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index 1d0f2b6..722a925 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -1980,6 +1980,7 @@ static const struct hid_device_id hid_have_special_driver[] = {
 	{ HID_USB_DEVICE(USB_VENDOR_ID_THRUSTMASTER, 0xb65a) },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE_BT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE_PRO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED, USB_DEVICE_ID_TOPSEED_CYBERLINK) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TOPSEED2, USB_DEVICE_ID_TOPSEED2_RF_COMBO) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TWINHAN, USB_DEVICE_ID_TWINHAN_IR_REMOTE) },
diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 2dd6485..c739d3b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -900,6 +900,7 @@
 #define USB_VENDOR_ID_TIVO		0x150a
 #define USB_DEVICE_ID_TIVO_SLIDE_BT	0x1200
 #define USB_DEVICE_ID_TIVO_SLIDE	0x1201
+#define USB_DEVICE_ID_TIVO_SLIDE_PRO	0x1203
 
 #define USB_VENDOR_ID_TOPSEED		0x0766
 #define USB_DEVICE_ID_TOPSEED_CYBERLINK	0x0204
diff --git a/drivers/hid/hid-tivo.c b/drivers/hid/hid-tivo.c
index d790d8d..d986969 100644
--- a/drivers/hid/hid-tivo.c
+++ b/drivers/hid/hid-tivo.c
@@ -64,6 +64,7 @@ static const struct hid_device_id tivo_devices[] = {
 	/* TiVo Slide Bluetooth remote, pairs with a Broadcom dongle */
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE_BT) },
 	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE) },
+	{ HID_USB_DEVICE(USB_VENDOR_ID_TIVO, USB_DEVICE_ID_TIVO_SLIDE_PRO) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, tivo_devices);
-- 
1.9.1

