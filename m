From: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Add support for the Wacom Intuos 4 wireless
Date: Wed, 21 Apr 2010 14:52:00 +0100
Message-ID: <1271857920.1960.5.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from relay4-v.mail.gandi.net ([217.70.178.78]:57640 "EHLO
	relay4-v.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754531Ab0DUNwG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 21 Apr 2010 09:52:06 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Jiri Kosina <jkosina@suse.cz>

Same command set as the Graphire Bluetooth tablet.

Signed-off-by: Bastien Nocera <hadess@hadess.net>
---
 drivers/hid/hid-ids.h   |    1 +
 drivers/hid/hid-wacom.c |    2 +-
 2 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 66a2ca8..21f360f 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -456,6 +456,7 @@
 
 #define USB_VENDOR_ID_WACOM		0x056a
 #define USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH	0x81
+#define USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH	0xbd
 
 #define USB_VENDOR_ID_WISEGROUP		0x0925
 #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
diff --git a/drivers/hid/hid-wacom.c b/drivers/hid/hid-wacom.c
index 8d3b46f..91dbae3 100644
--- a/drivers/hid/hid-wacom.c
+++ b/drivers/hid/hid-wacom.c
@@ -256,7 +256,7 @@ static void wacom_remove(struct hid_device *hdev)
 
 static const struct hid_device_id wacom_devices[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_GRAPHIRE_BLUETOOTH) },
-
+	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_WACOM, USB_DEVICE_ID_WACOM_INTUOS4_BLUETOOTH) },
 	{ }
 };
 MODULE_DEVICE_TABLE(hid, wacom_devices);
-- 
1.6.6.1


