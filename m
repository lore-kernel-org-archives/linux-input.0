From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5/7] Revert "HID: logitech: Add function to enable HID++ 1.0 "scrolling acceleration""
Date: Wed, 21 Nov 2018 16:27:10 +0100
Message-ID: <20181121152712.6770-6-benjamin.tissoires@redhat.com>
References: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181121152712.6770-1-benjamin.tissoires@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>, Harry Cutts <hcutts@chromium.org>, Peter Hutterer <peter.hutterer@who-t.net>, torvalds@linux-foundation.org
Cc: Nestor Lopez Casado <nlopezcasad@logitech.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Benjamin Tissoires <benjamin.tissoires@redhat.com>
List-Id: linux-input@vger.kernel.org

This reverts commit 051dc9b0579602bd63e9df74d0879b5293e71581.

It turns out the current API is not that compatible with
some Microsoft mice, so better start again from scratch.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
---
 drivers/hid/hid-logitech-hidpp.c | 47 +++++++++-----------------------
 1 file changed, 13 insertions(+), 34 deletions(-)

diff --git a/drivers/hid/hid-logitech-hidpp.c b/drivers/hid/hid-logitech-hidpp.c
index 7f8218f6ff56..19cc980eebce 100644
--- a/drivers/hid/hid-logitech-hidpp.c
+++ b/drivers/hid/hid-logitech-hidpp.c
@@ -400,53 +400,32 @@ static void hidpp_prefix_name(char **name, int name_length)
 #define HIDPP_SET_LONG_REGISTER				0x82
 #define HIDPP_GET_LONG_REGISTER				0x83
 
-/**
- * hidpp10_set_register_bit() - Sets a single bit in a HID++ 1.0 register.
- * @hidpp_dev: the device to set the register on.
- * @register_address: the address of the register to modify.
- * @byte: the byte of the register to modify. Should be less than 3.
- * Return: 0 if successful, otherwise a negative error code.
- */
-static int hidpp10_set_register_bit(struct hidpp_device *hidpp_dev,
-	u8 register_address, u8 byte, u8 bit)
+#define HIDPP_REG_GENERAL				0x00
+
+static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
 {
 	struct hidpp_report response;
 	int ret;
 	u8 params[3] = { 0 };
 
 	ret = hidpp_send_rap_command_sync(hidpp_dev,
-					  REPORT_ID_HIDPP_SHORT,
-					  HIDPP_GET_REGISTER,
-					  register_address,
-					  NULL, 0, &response);
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_GET_REGISTER,
+					HIDPP_REG_GENERAL,
+					NULL, 0, &response);
 	if (ret)
 		return ret;
 
 	memcpy(params, response.rap.params, 3);
 
-	params[byte] |= BIT(bit);
+	/* Set the battery bit */
+	params[0] |= BIT(4);
 
 	return hidpp_send_rap_command_sync(hidpp_dev,
-					   REPORT_ID_HIDPP_SHORT,
-					   HIDPP_SET_REGISTER,
-					   register_address,
-					   params, 3, &response);
-}
-
-
-#define HIDPP_REG_GENERAL				0x00
-
-static int hidpp10_enable_battery_reporting(struct hidpp_device *hidpp_dev)
-{
-	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_GENERAL, 0, 4);
-}
-
-#define HIDPP_REG_FEATURES				0x01
-
-/* On HID++ 1.0 devices, high-res scroll was called "scrolling acceleration". */
-static int hidpp10_enable_scrolling_acceleration(struct hidpp_device *hidpp_dev)
-{
-	return hidpp10_set_register_bit(hidpp_dev, HIDPP_REG_FEATURES, 0, 6);
+					REPORT_ID_HIDPP_SHORT,
+					HIDPP_SET_REGISTER,
+					HIDPP_REG_GENERAL,
+					params, 3, &response);
 }
 
 #define HIDPP_REG_BATTERY_STATUS			0x07
-- 
2.19.1
