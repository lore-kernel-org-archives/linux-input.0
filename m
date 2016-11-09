From: <hn.chen@weidahitech.com>
Subject: [PATCH v2] HID:i2c-hid: add a simple quirk to fix device defects
Date: Wed, 9 Nov 2016 18:20:48 +0800
Message-ID: <1478686848-22968-1-git-send-email-hn.chen@weidahitech.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ml01.weidahitech.com ([61.222.87.235]:2032 "EHLO
        ml01.weidahitech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751277AbcKIKSg (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 9 Nov 2016 05:18:36 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: jkosina@suse.cz
Cc: benjamin.tissoires@redhat.com, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, HungNien Chen <hn.chen@weidahitech.com>

From: HungNien Chen <hn.chen@weidahitech.com>

Add a static quirk table and lookup for the quirks in i2c_hid_probe().
Also add comments and do return value check in i2c_hid_set_power().

Signed-off-by: HungNien Chen <hn.chen@weidahitech.com>
---
 drivers/hid/hid-ids.h         |  5 ++++
 drivers/hid/i2c-hid/i2c-hid.c | 57 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

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
index b3ec4f2..b32a063 100644
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
@@ -154,6 +160,39 @@ struct i2c_hid {
 	struct mutex		reset_lock;
 };
 
+static const struct i2c_hid_blacklist {
+	__u16 idVendor;
+	__u16 idProduct;
+	__u32 quirks;
+} i2c_hid_blacklist[] = {
+	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8752,
+		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
+	{ USB_VENDOR_ID_WEIDA, USB_DEVICE_ID_WEIDA_8755,
+		I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV },
+	{ 0, 0 }
+};
+
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
+	int n = 0;
+
+	for (; i2c_hid_blacklist[n].idVendor; n++)
+		if (i2c_hid_blacklist[n].idVendor == idVendor &&
+		    (i2c_hid_blacklist[n].idProduct == (__u16)HID_ANY_ID ||
+		     i2c_hid_blacklist[n].idProduct == idProduct))
+			quirks = i2c_hid_blacklist[n].quirks;
+
+	return quirks;
+}
+
 static int __i2c_hid_command(struct i2c_client *client,
 		const struct i2c_hid_cmd *command, u8 reportID,
 		u8 reportType, u8 *args, int args_len,
@@ -346,11 +385,27 @@ static int i2c_hid_set_power(struct i2c_client *client, int power_state)
 
 	i2c_hid_dbg(ihid, "%s\n", __func__);
 
+	/*
+	 * Some devices require to send a command to wakeup before power on.
+	 * The call will get a return value (EREMOTEIO) but device will be
+	 * triggered and activated. After that, it goes like a normal device.
+	 */
+	if (power_state == I2C_HID_PWR_ON &&
+	    ihid->quirks & I2C_HID_QUIRK_SET_PWR_WAKEUP_DEV) {
+		ret = i2c_hid_command(client, &hid_set_power_cmd, NULL, 0);
+
+		/* Device was already activated */
+		if (!ret)
+			goto set_pwr_exit;
+	}
+
 	ret = __i2c_hid_command(client, &hid_set_power_cmd, power_state,
 		0, NULL, 0, NULL, 0);
+
 	if (ret)
 		dev_err(&client->dev, "failed to change power setting.\n");
 
+set_pwr_exit:
 	return ret;
 }
 
@@ -1050,6 +1105,8 @@ static int i2c_hid_probe(struct i2c_client *client,
 		 client->name, hid->vendor, hid->product);
 	strlcpy(hid->phys, dev_name(&client->dev), sizeof(hid->phys));
 
+	ihid->quirks = i2c_hid_lookup_quirk(hid->vendor, hid->product);
+
 	ret = hid_add_device(hid);
 	if (ret) {
 		if (ret != -ENODEV)
-- 
1.9.1

