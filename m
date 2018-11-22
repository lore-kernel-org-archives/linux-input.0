From: Peter Hutterer <peter.hutterer@who-t.net>
Subject: [PATCH 7/8] HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration"
Date: Thu, 22 Nov 2018 16:34:08 +1000
Message-ID: <20181122063409.15816-8-peter.hutterer@who-t.net>
References: <20181122063409.15816-1-peter.hutterer@who-t.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181122063409.15816-1-peter.hutterer@who-t.net>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, torvalds@linux-foundation.org, Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

From: Harry Cutts <hcutts@chromium.org>

"Scrolling acceleration" is a bit of a misnomer: it doesn't deal with
acceleration at all. However, that's the name used in Logitech's spec,
so I used it here.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
Reviewed-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Peter Hutterer <peter.hutterer@who-t.net>
---
Unmodified, same as the reverted 051dc9b0

 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 146feedd9a2f..67ca587aecfa 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -400,32 +400,53 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
-#define HIDPP_REG_GENERAL				0x00
-
-static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+/**
+ * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
+ * @hidpp_dev: the device to set the register on.
+ * @register_address: the address of the register to modify.
+ * @byte: the byte of the register to modify. Should be less than 3.
+ * Return: 0 if successful, otherwise a negative error code.
+ */
+static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
+	u8 register_address, u8 byte, u8 bit)
 {
 	struct hidpp_report response;
 	int ret;
 	u8 params[3] = { 0 };
 
 	ret = hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_GET_REGISTER,
-					HIDPP_REG_GENERAL,
-					NULL, 0, &response);
+					  REPORT_ID_HIDPP_SHORT,
+					  HIDPP_GET_REGISTER,
+					  register_address,
+					  NULL, 0, &response);
 	if (ret)
 		return ret;
 
 	memcpy(params, response.rap.params, 3);
 
-	/* Set the battery bit */
-	params[0] |= BIT(4);
+	params[byte] |= BIT(bit);
 
 	return hidpp_send_rap_command_sync(hidpp_dev,
-					REPORT_ID_HIDPP_SHORT,
-					HIDPP_SET_REGISTER,
-					HIDPP_REG_GENERAL,
-					params, 3, &response);
+					   REPORT_ID_HIDPP_SHORT,
+					   HIDPP_SET_REGISTER,
+					   register_address,
+					   params, 3, &response);
+}
+
+
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
+}
+
+#define HIDPP_REG_FEATURES				0x01
+
+/* On HID++ 1.0 devices, high-res scroll was called "scrolling acceleration". */
+static int hidpp10_enable_scrolling_acceleration(struct hidpp_device *hidpp_dev)
+{
+	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
 }
 
 #define HIDPP_REG_BATTERY_STATUS			0x07
-- 
2.19.1
