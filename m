From: <hn.chen@weidahitech.com>
Subject: [PATCH] HID: modify quirks of i2c-hid driver for weida's devices
Date: Fri, 30 Aug 2019 15:58:30 +0800
Message-ID: <1567151910-3819-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org, jikos@kernel.org, benjamin.tissoires@redhat.com
Cc: linux-kernel@vger.kernel.org, dmitry.torokhov@gmail.com, hn.chen@weidahitech.com
List-Id: linux-input@vger.kernel.org

From: HungNien Chen <hn.chen@weidahitech.com>

This 'SET_PWR_WAKEUP_DEV' quirk only works for weida's devices with pid
0xC300 & 0xC301. Some weida's devices with other pids also need this quirk
now. Use 'HID_ANY_ID' instead of 0xC300 to make all of weida's devices can be
fixed on the power on issue. This modification should be safe since devices
without power on issue will send the power on command only once.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/hid/i2c-hid/i2c-hid-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid-core.c b/drivers/hid/i2c-hid/i2c-hid-core.c
index 90164fe..2a7c6e3 100644
--- a/drivers/hid/i2c-hid/i2c-hid-core.c
+++ b/drivers/hid/i2c-hid/i2c-hid-core.c
@@ -169,9 +169,7 @@ struct i2c_hid {
 	__u16 idProduct;
 	__u32 quirks;
 } i2c_hid_quirks[] = {
-	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8752,
-		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
-	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
+	{ USB_VENDOR_ID_WEIDA, HID_ANY_ID,
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
 		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET |
-- 
1.9.1
