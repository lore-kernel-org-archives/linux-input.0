From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: i2c-hid: Disable runtime PM on Goodix touchpad
Date: Mon, 14 Jan 2019 16:47:34 +0800
Message-ID: <20190114084734.3362-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

A Goodix touchpad doesn't work. Touching the touchpad can trigger IRQ
but there's no input event from HID subsystem.

Turns out it reports some invalid data:
[   22.136630] i2c_hid i2c-DELL091F:00: input: 0b 00 01 00 00 00 00 00 00 00 00

After some trial and error, it's another device that doesn't work well
with ON/SLEEP commands. Disable runtime PM to fix the issue.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-ids.h         | 3 +++
 drivers/hid/i2c-hid/i2c-hid.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 3171db744c1c..6a8cb0679961 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -442,6 +442,9 @@
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_010A 0x010a
 #define USB_DEVICE_ID_GENERAL_TOUCH_WIN8_PIT_E100 0xe100
 
+#define I2C_VENDOR_ID_GOODIX		0x27c6
+#define I2C_DEVICE_ID_GOODIX_01F0	0x01f0
+
 #define USB_VENDOR_ID_GOODTOUCH		0x1aad
 #define USB_DEVICE_ID_GOODTOUCH_000f	0x000f
 
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 103916c6026c..b235d2b38f39 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -178,6 +178,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_RESEND_REPORT_DESCR },
 	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
+	{ I2C_VENDOR_ID_GOODIX, I2C_DEVICE_ID_GOODIX_01F0,
+		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ 0, 0 }
 };
 
-- 
2.17.1
