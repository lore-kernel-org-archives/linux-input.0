From: <hn.chen@weidahitech.com>
Subject: [PATCH] HID:i2c-hid: add a simple quirk to fix device defects
Date: Tue, 8 Nov 2016 16:43:19 +0800
Message-ID: <1478594599-25044-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2610 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752388AbcKHImz (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Tue, 8 Nov 2016 03:42:55 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, HungNien Chen <hn.chen@weidahitech.com>

From: HungNien Chen <hn.chen@weidahitech.com>

Weida's device can get a quirk value by the quirk function.
Base on the quirk value, set_power function will send a command
to wake up the device before send the PWR_ON command.

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/hid/hid-ids.h         |  5 +++++
 drivers/hid/i2c-hid/i2c-hid.c | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
index 6cfb5ca..787afdf 100644
--- a/drivers/hid/hid-ids.h
+++ b/drivers/hid/hid-ids.h
@@ -1033,6 +1033,11 @@
 #define USB_DEVICE_ID_WALTOP_MEDIA_TABLET_14_1_INCH	0x0500
 #define USB_DEVICE_ID_WALTOP_SIRIUS_BATTERY_FREE_TABLET	0x0502
 
+#define	USB_VENDOR_ID_WEIDA		0x2575
+#define	USB_DEVICE_ID_WEIDA_8756	0x8756
+#define	USB_DEVICE_ID_WEIDA_8752	0xC300
+#define	USB_DEVICE_ID_WEIDA_8755	0xC301
+
 #define USB_VENDOR_ID_WISEGROUP		0x0925
 #define USB_DEVICE_ID_SMARTJOY_PLUS	0x0005
 #define USB_DEVICE_ID_SUPER_JOY_BOX_3	0x8888
diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index b3ec4f2..7a9b100 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -41,6 +41,11 @@
 
 #include <linux/i2c/i2c-hid.h>
 
+#include "../hid-ids.h"
+
+/* quirks to control the device */
+#define I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV	(1 << 0)
+
 /* flags */
 #define I2C_HID_STARTED		0
 #define I2C_HID_RESET_PENDING	1
@@ -143,6 +148,7 @@ struct i2c_hid {
 	char			*argsbuf;	/* Command arguments buffer */
 
 	unsigned long		flags;		/* device flags */
+	unsigned long		quirks;		/* Various quirks */
 
 	wait_queue_head_t	wait;		/* For waiting the interrupt */
 	struct gpio_desc	*desc;
@@ -154,6 +160,25 @@ struct i2c_hid {
 	struct mutex		reset_lock;
 };
 
+/*
+ * i2c_hid_lookup_quirk: return any quirks associated with a I2C HID device
+ * @idVendor: the 16-bit vendor ID
+ * @idProduct: the 16-bit product ID
+ *
+ * Returns: a u32 quirks value.
+ */
+static u32 i2c_hid_lookup_quirk(const u16 idVendor, const u16 idProduct)
+{
+	u32 quirks = 0;
+
+	/* Weida devices check here */
+	if (idVendor == USB_VENDOR_ID_WEIDA &&
+	    idProduct >= USB_DEVICE_ID_WEIDA_8752)
+		return I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV;
+
+	return quirks;
+}
+
 static int __i2c_hid_command(struct i2c_client *client,
 		const struct i2c_hid_cmd *command, u8 reportID,
 		u8 reportType, u8 *args, int args_len,
@@ -346,6 +371,11 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
+	/* Some devices require to send a command to wakeup first */
+	if (power_state == I2C_HID_PWR_ON &&
+	    ihid->quirks & I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV)
+		i2c_hid_command(client, &hid_set_power_cmd, NULL, 0);
+
 	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
 		0, NULL, 0, NULL, 0);
 	if (ret)
@@ -661,6 +691,8 @@ static int i2c_hid_parse(struct hid_device *hid)
 
 	i2c_hid_dbg(ihid, "entering %s\n", __func__);
 
+	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
+
 	rsize = le16_to_cpu(hdesc->wReportDescLength);
 	if (!rsize || rsize > HID_MAX_DESCRIPTOR_SIZE) {
 		dbg_hid("weird size of report descriptor (%u)\n", rsize);
-- 
1.9.1

