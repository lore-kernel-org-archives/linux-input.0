From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 4/8] qt2160: add configurable power mode
Date: Tue,  9 Nov 2010 13:15:07 +1100
Message-ID: <1289268911-32322-4-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49374 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753997Ab0KICPy (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:15:54 -0500
Received: by mail-gy0-f174.google.com with SMTP id 4so3965040gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:15:54 -0800 (PST)
In-Reply-To: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Add configurable low power mode to reduce power consumption. We trade off responsiveness for lower power consumption. Each +1 increment in value causes the chip to sleep 16ms longer before detecting a touch.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>
---
 drivers/input/keyboard/qt2160.c |   13 +++++++++++++
 include/linux/input/qt2160.h    |    3 +++
 2 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 6439e40..0d662e2 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -299,6 +299,15 @@ static int __devinit qt2160_configure_device(struct i2c_client *client,
 	/* perform dummy write to reset I2C state */
 	i2c_smbus_write_byte(client, QT2160_CMD_CHIPID);
 
+	/* setup LP mode */
+	if (pdata->low_power_mode) {
+		error = i2c_smbus_write_byte_data(client, QT2160_CMD_LP_MODE,
+						  pdata->low_power_mode);
+		if (error) {
+			dev_err(&client->dev, "could not write power config\n");
+			goto config_fault;
+		}
+	}
 	/* setup slider control and slider options */
 	if (pdata->slider_length) {
 		error |= i2c_smbus_write_byte_data(
@@ -547,9 +556,13 @@ static int qt2160_suspend(struct i2c_client *client, pm_message_t message)
 
 static int qt2160_resume(struct i2c_client *client)
 {
+	struct qt2160_data *qt2160 = i2c_get_clientdata(client);
+	struct qt2160_info *hw_info = qt2160->hw_info;
 	int error;
 	u8 lp_mode_val = QT2160_LP_MODE_DEFAULT_VALUE;
 
+	if (hw_info->low_power_mode)
+		lp_mode_val = hw_info->low_power_mode;
 	error = i2c_smbus_write_byte_data(client, QT2160_CMD_LP_MODE,
 					  lp_mode_val);
 	if (error)
diff --git a/include/linux/input/qt2160.h b/include/linux/input/qt2160.h
index 748c86e..8a1913f 100755
--- a/include/linux/input/qt2160.h
+++ b/include/linux/input/qt2160.h
@@ -16,6 +16,8 @@
  *  same aks group; keys in the same aks group will only report 1 active key at
  *  any time; value 0 disables aks group; valid aks groups are 1, 2, 3
  * @key_burst_length: key sensitivity; 0 use default
+ * @low_power_mode: value 0 use default; each +1 increment causes the chip to
+ *  sleep 16ms longer before detecting a touch (slower response); max 255
  */
 struct qt2160_info {
 	unsigned char slider_length;
@@ -23,6 +25,7 @@ struct qt2160_info {
 	unsigned short keycodes[QT2160_MAXKEYS];
 	unsigned char key_aks[QT2160_MAXKEYS];
 	unsigned char key_burst_length[QT2160_MAXKEYS];
+	unsigned char low_power_mode;
 };
 
 #endif /* __QT2160_H__ */
-- 
1.7.0.4

