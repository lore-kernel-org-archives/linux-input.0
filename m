From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] HID: i2c-hid: Disable runtime PM for LG touchscreen
Date: Wed, 14 Nov 2018 07:24:57 +0000
Message-ID: <20181114072457.19793-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: linux-input@vger.kernel.org

LG touchscreen (1fd2:8001) stops working after reboot:
[ 4.859153] i2c_hid i2c-SAPS2101:00: i2c_hid_get_input: incomplete report (64/66)
[ 4.936070] i2c_hid i2c-SAPS2101:00: i2c_hid_get_input: incomplete report (64/66)
[ 9.948224] i2c_hid i2c-SAPS2101:00: failed to reset device.

The device in question stops working after receives SLEEP, ON, SLEEP
commands in a short period. The scenario is like this:
- Once the desktop session closes, it also closed the hid device, so the
device gets runtime suspended and receives a SLEEP command.
- Before calling shutdown callback, it gets runtime resumed and received
an ON command.
- In the shutdown callback, it receives another SLEEP command.

I failed to find a reliable interval between ON/SLEEP commands that can
make it work, so let's simply disable runtime PM for the device.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/hid/hid-ids.h              | 1 +
 drivers/hid/i2c-hid/i2c-hid-core.c | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index c0d668944dbe..bd636f529fad 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -707,6 +707,7 @@
 #define USB_VENDOR_ID_LG		0x1fd2
 #define USB_DEVICE_ID_LG_MULTITOUCH	0x0064
 #define USB_DEVICE_ID_LG_MELFAS_MT	0x6007
+#define I2C_DEVICE_ID_LG_8001		0x8001
 
 #define USB_VENDOR_ID_LOGITECH		0x046d
 #define USB_DEVICE_ID_LOGITECH_AUDIOHUB 0x0a0e
diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 3cde7c1b9c33..8555ce7e737b 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -177,6 +177,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ I2C_VENDOR_ID_RAYDIUM, I2C_PRODUCT_ID_RAYDIUM_4B33,
 		I2C_HID_QUIRK_DELAY_AFTER_SLEEP },
+	{ USB_VENDOR_ID_LG, I2C_DEVICE_ID_LG_8001,
+		I2C_HID_QUIRK_NO_RUNTIME_PM },
 	{ 0, 0 }
 };
 
-- 
2.17.1
