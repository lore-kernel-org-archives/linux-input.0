From: Benjamin Tissoires <benjamin.tissoires@gmail.com>
Subject: [PATCH 06/14] HID: i2c-hid: remove unused static declarations
Date: Tue,  4 Dec 2012 16:27:47 +0100
Message-ID: <1354634875-5182-7-git-send-email-benjamin.tissoires@gmail.com>
References: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1354634875-5182-1-git-send-email-benjamin.tissoires@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Jiri Kosina <jkosina@suse.cz>, Jean Delvare <khali@linux-fr.org>, linux-input@vger.kernel.org, linux-i2c@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

These definitions are not used here, but are defined by the specification.
Keeping some of them for documentation purposes.

Signed-off-by: Benjamin Tissoires <benjamin.tissoires@gmail.com>
---
 drivers/hid/i2c-hid/i2c-hid.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/hid/i2c-hid/i2c-hid.c b/drivers/hid/i2c-hid/i2c-hid.c
index 54950be..4452611 100644
--- a/drivers/hid/i2c-hid/i2c-hid.c
+++ b/drivers/hid/i2c-hid/i2c-hid.c
@@ -106,22 +106,17 @@ static const struct i2c_hid_cmd hid_reset_cmd =		{ I2C_HID_CMD(0x01),
 							  .wait = true };
 static const struct i2c_hid_cmd hid_get_report_cmd =	{ I2C_HID_CMD(0x02) };
 static const struct i2c_hid_cmd hid_set_report_cmd =	{ I2C_HID_CMD(0x03) };
-static const struct i2c_hid_cmd hid_get_idle_cmd =	{ I2C_HID_CMD(0x04) };
-static const struct i2c_hid_cmd hid_set_idle_cmd =	{ I2C_HID_CMD(0x05) };
-static const struct i2c_hid_cmd hid_get_protocol_cmd =	{ I2C_HID_CMD(0x06) };
-static const struct i2c_hid_cmd hid_set_protocol_cmd =	{ I2C_HID_CMD(0x07) };
 static const struct i2c_hid_cmd hid_set_power_cmd =	{ I2C_HID_CMD(0x08) };
-/* read/write data register */
-static const struct i2c_hid_cmd hid_data_cmd = {
-		.registerIndex = offsetof(struct i2c_hid_desc, wDataRegister),
-		.opcode = 0x00,
-		.length = 2 };
-/* write output reports */
-static const struct i2c_hid_cmd hid_out_cmd = {
-		.registerIndex = offsetof(struct i2c_hid_desc,
-			wOutputRegister),
-		.opcode = 0x00,
-		.length = 2 };
+
+/*
+ * These definitions are not used here, but are defined by the spec.
+ * Keeping them here for documentation purposes.
+ *
+ * static const struct i2c_hid_cmd hid_get_idle_cmd = { I2C_HID_CMD(0x04) };
+ * static const struct i2c_hid_cmd hid_set_idle_cmd = { I2C_HID_CMD(0x05) };
+ * static const struct i2c_hid_cmd hid_get_protocol_cmd = { I2C_HID_CMD(0x06) };
+ * static const struct i2c_hid_cmd hid_set_protocol_cmd = { I2C_HID_CMD(0x07) };
+ */
 
 /* The main device structure */
 struct i2c_hid {
-- 
1.8.0.1
