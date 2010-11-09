From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 5/8] qt2160: fix starting of device calibration
Date: Tue,  9 Nov 2010 13:15:08 +1100
Message-ID: <1289268911-32322-5-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f174.google.com ([209.85.213.174]:64206 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752148Ab0KICP5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:15:57 -0500
Received: by yxk8 with SMTP id 8so3945261yxk.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:15:57 -0800 (PST)
In-Reply-To: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Writing of calibration command and non-zero data value must be performed in one I2C transaction.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>
---
 drivers/input/keyboard/qt2160.c |   23 +----------------------
 1 files changed, 1 insertions(+), 22 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 0d662e2..7647849 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -264,27 +264,6 @@ static int __devinit qt2160_read(struct i2c_client *client, u8 reg)
 	return ret;
 }
 
-static int __devinit qt2160_write(struct i2c_client *client, u8 reg, u8 data)
-{
-	int error;
-
-	error = i2c_smbus_write_byte(client, reg);
-	if (error) {
-		dev_err(&client->dev,
-			"couldn't send request. Returned %d\n", error);
-		return error;
-	}
-
-	error = i2c_smbus_write_byte(client, data);
-	if (error) {
-		dev_err(&client->dev,
-			"couldn't write data. Returned %d\n", error);
-		return error;
-	}
-
-	return error;
-}
-
 static int __devinit qt2160_configure_device(struct i2c_client *client,
 					     struct qt2160_data *qt2160)
 {
@@ -489,7 +468,7 @@ static int __devinit qt2160_probe(struct i2c_client *client,
 	}
 
 	/* Calibrate device */
-	error = qt2160_write(client, QT2160_CMD_CALIBRATE, 1);
+	error = i2c_smbus_write_byte_data(client, QT2160_CMD_CALIBRATE, 1);
 	if (error) {
 		dev_err(&client->dev, "failed to calibrate device\n");
 		goto err_free_mem;
-- 
1.7.0.4

