From: =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>
Subject: [PATCH] hid-logitech-dj: rename "gaming" receiver to "lightspeed"
Date: Tue, 16 Jul 2019 08:36:21 +0100
Message-ID: <20190716073621.4290-1-lains@archlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: nlopezcasad@logitech.com, =?UTF-8?q?Filipe=20La=C3=ADns?= <lains@archlinux.org>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

this should help people identify the receiver. there are several
receivers used in gaming mice. the "lightspeed" technology is pretty
well advertise so this won't just be an obscure name.

Signed-off-by: Filipe Laíns <lains@archlinux.org>
---
 drivers/hid/hid-ids.h         | 2 +-
 drivers/hid/hid-logitech-dj.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0d695f8e1b2c..ab9d382b067d 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -768,7 +768,7 @@
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER		0xc52f
 #define USB_DEVICE_ID_LOGITECH_UNIFYING_RECEIVER_2	0xc532
 #define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2		0xc534
-#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_GAMING	0xc539
+#define USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED	0xc539
 #define USB_DEVICE_ID_SPACETRAVELLER	0xc623
 #define USB_DEVICE_ID_SPACENAVIGATOR	0xc626
 #define USB_DEVICE_ID_DINOVO_DESKTOP	0xc704
diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
index 6196217a7d93..4334acb49129 100644
--- a/drivers/hid/hid-logitech-dj.c
+++ b/drivers/hid/hid-logitech-dj.c
@@ -1832,9 +1832,9 @@ static const struct hid_device_id logi_dj_receivers[] = {
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
 			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2),
 	 .driver_data = recvr_type_hidpp},
-	{ /* Logitech gaming receiver (0xc539) */
+	{ /* Logitech lightspeed receiver (0xc539) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
-		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_GAMING),
+		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED),
 	 .driver_data = recvr_type_gaming_hidpp},
 	{ /* Logitech 27 MHz HID++ 1.0 receiver (0xc513) */
 	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH, USB_DEVICE_ID_MX3000_RECEIVER),
-- 
2.22.0
