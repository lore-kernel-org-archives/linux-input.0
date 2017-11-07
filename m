From: Hans de Goede <hdegoede@redhat.com>
Subject: [PATCH v2] HID: i2c-hid: Add no-irq-after-reset quirk for 0911:5288 device
Date: Tue,  7 Nov 2017 13:28:00 +0100
Message-ID: <20171107122800.23196-1-hdegoede@redhat.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58182 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752204AbdKGM2F (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Tue, 7 Nov 2017 07:28:05 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jikos@kernel.org>, Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc: Hans de Goede <hdegoede@redhat.com>, linux-input@vger.kernel.org

Several cheap Apollo Lake based laptops / 2-in-1s use an i2c-hid mt
touchpad which is advertised by the DSDT with an ACPI HID of "SYNA3602",
this touchpad can be found on e.g. the Cube Thinker and the EZBook 3 Pro.

On my "T-bao Tbook air" the i2c-hid driver fails to bind to this touchpad:
"i2c_hid i2c-SYNA3602:00: failed to reset device.".

After some debuging this it seems that this touchpad simply never sends
an interrupt after a reset as expected by the i2c hid driver. This commit
adds a quirk for this device, making i2c_hid_command sleep 100ms after
a reset instead of waiting for an irq, fixing i2c-hid failing to bind to
this touchpad.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Although the ACPI HID says SYNA3602, opening up the device has shown
 that this is not a Synaptics touchpad but a Hantick one, update
 the vendor and products #defines accordingly
---
 drivers/hid/hid-ids.h         | 3 +++
 drivers/hid/i2c-hid/i2c-hid.c | 7 ++++++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index be2e005c3c51..c81ea3fbaa6b 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -509,6 +509,9 @@
 #define USB_DEVICE_ID_GYRATION_REMOTE_2 0x0003
 #define USB_DEVICE_ID_GYRATION_REMOTE_3 0x0008
 
+#define I2C_VENDOR_ID_HANTICK		0x0911
+#define I2C_PRODUCT_ID_HANTICK_5288	0x5288
+
 #define USB_VENDOR_ID_HANWANG		0x0b57
 #define USB_DEVICE_ID_HANWANG_TABLET_FIRST	0x5000
 #define USB_DEVICE_ID_HANWANG_TABLET_LAST	0x8fff
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 7f701772edfe..40109dfb0c25 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -46,6 +46,7 @@
 
 /* quirks to control the device */
 #define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	BIT(0)
+#define I2C_HID_QUIRK_NO_IRQ_AFTER_RESET	BIT(1)
 
 /* flags */
 #define I2C_HID_STARTED		0
@@ -168,6 +169,8 @@ static const struct i2c_hid_quirks {
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
 	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
 		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
+	{ I2C_VENDOR_ID_HANTICK, I2C_PRODUCT_ID_HANTICK_5288,
+		I2C_HID_QUIRK_NO_IRQ_AFTER_RESET },
 	{ 0, 0 }
 };
 
@@ -252,7 +255,9 @@ static int __i2c_hid_command(struct i2c_client *client,
 
 	ret = 0;
 
-	if (wait) {
+	if (wait && (ihid->quirks & I2C_HID_QUIRK_NO_IRQ_AFTER_RESET)) {
+		msleep(100);
+	} else if (wait) {
 		i2c_hid_dbg(ihid, "%s: waiting...\n", __func__);
 		if (!wait_event_timeout(ihid->wait,
 				!test_bit(I2C_HID_RESET_PENDING, &ihid->flags),
-- 
2.14.3

