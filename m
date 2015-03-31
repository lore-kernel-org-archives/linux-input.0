From: Oliver Neukum <oneukum@suse.de>
Subject: [PATCH] hid-ids.h: fix typo
Date: Tue, 31 Mar 2015 14:36:17 +0200
Message-ID: <1427805377-13568-1-git-send-email-oneukum@suse.de>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: jslaby@suse.cz, linux-input@vger.kernel.org
Cc: Oliver Neukum <oneukum@suse.de>, stable@vger.kernel.org
List-Id: linux-input@vger.kernel.org

There is a typo in a device ID

Signed-off-by: Oliver Neukum <oneukum@suse.de>
CC: stable@vger.kernel.org
---
 drivers/hid/hid-ids.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 56a4ed6..4ee0fb0 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -555,7 +555,7 @@
 
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
-#define USB_DEVICE_ID_LOGITECH_C077	0xc007
+#define USB_DEVICE_ID_LOGITECH_C077	0xc077
 #define USB_DEVICE_ID_LOGITECH_RECEIVER	0xc101
 #define USB_DEVICE_ID_LOGITECH_HARMONY_FIRST  0xc110
 #define USB_DEVICE_ID_LOGITECH_HARMONY_LAST 0xc14f
-- 
2.1.4
