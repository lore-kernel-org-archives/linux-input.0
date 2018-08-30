From: Harry Cutts <hcutts@chromium.org>
Subject: [PATCH v2 3/5] Add function to enable HID++ 1.0 "scrolling acceleration"
Date: Thu, 30 Aug 2018 14:56:20 -0700
Message-ID: <20180830215622.47550-4-hcutts@chromium.org>
References: <20180830215622.47550-1-hcutts@chromium.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180830215622.47550-1-hcutts@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-input <linux-input@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Jiri Kosina <jiri.kosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Benjamin Tissoires <benjamin.tissoires@redhat.com>, Harry Cutts <hcutts@chromium.org>, Jiri Kosina <jikos@kernel.org>
List-Id: linux-input@vger.kernel.org

"Scrolling acceleration" is a bit of a misnomer: it doesn't deal with
acceleration at all. However, that's the name used in Logitech's spec,
so I used it here.

Signed-off-by: Harry Cutts <hcutts@chromium.org>
---

Changes in v2: None

 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++++++++++++++++---------
 1 file changed, 34 insertions(+), 13 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 19cc980eebce..7f8218f6ff56 100644
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
2.19.0.rc0.228.g281dcd1b4d0-goog
