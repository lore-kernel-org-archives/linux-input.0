From: =?UTF-8?q?Istv=C3=A1n=20V=C3=A1radi?= <ivaradi@varadiistvan.hu>
Subject: [PATCH 1/2] HID: Add Saitek X52 to the HID IDs
Date: Wed, 24 Jul 2019 20:08:06 +0200
Message-ID: <20190724180806.5745-1-ivaradi@varadiistvan.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Cc: =?UTF-8?q?Istv=C3=A1n=20V=C3=A1radi?= <ivaradi@varadiistvan.hu>, Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

The USB device ID of the Saitek X52 joystick is added as a
define to hid-ids.h.

Signed-off-by: István Váradi <ivaradi@varadiistvan.hu>
---
 drivers/hid/hid-ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 0d695f8e1b2c..3a90962614ef 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -989,6 +989,7 @@
 #define USB_DEVICE_ID_SAITEK_RAT7	0x0cd7
 #define USB_DEVICE_ID_SAITEK_RAT9	0x0cfa
 #define USB_DEVICE_ID_SAITEK_MMO7	0x0cd0
+#define USB_DEVICE_ID_SAITEK_X52	0x075c
 
 #define USB_VENDOR_ID_SAMSUNG		0x0419
 #define USB_DEVICE_ID_SAMSUNG_IR_REMOTE	0x0001
-- 
2.20.1
