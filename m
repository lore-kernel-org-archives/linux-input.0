From: Martin Kepplinger <martin.kepplinger@ginzinger.com>
Subject: [PATCH 1/2] input: touchscreen: ar1021_i2c: enable touch mode during open
Date: Thu, 27 Apr 2017 14:22:35 +0200
Message-ID: <1493295756-17812-1-git-send-email-martin.kepplinger@ginzinger.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.ginzinger.com ([31.193.165.229]:61507 "EHLO
        mail.ginzinger.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754322AbdD0MXJ (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 27 Apr 2017 08:23:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Kepplinger <martin.kepplinger@ginzinger.com>

The device could as well be in command mode, in which this driver cannot
handle the device. When opening the device, let's make sure the device
will be in the mode we expect it to be for this driver.

Signed-off-by: Martin Kepplinger <martin.kepplinger@ginzinger.com>
---
 drivers/input/touchscreen/ar1021_i2c.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
index 1a94d8b..2a76231 100644
--- a/drivers/input/touchscreen/ar1021_i2c.c
+++ b/drivers/input/touchscreen/ar1021_i2c.c
@@ -18,6 +18,12 @@
 #define AR1021_MAX_X	4095
 #define AR1021_MAX_Y	4095
 
+#define AR1021_CMD	0x55
+#define AR1021_TOUCH	0x80
+
+#define AR1021_CMD_ENABLE_TOUCH		0x12
+#define AR1021_CMD_DISABLE_TOUCH	0x13
+
 struct ar1021_i2c {
 	struct i2c_client *client;
 	struct input_dev *input;
@@ -58,6 +64,15 @@ static int ar1021_i2c_open(struct input_dev *dev)
 {
 	struct ar1021_i2c *ar1021 = input_get_drvdata(dev);
 	struct i2c_client *client = ar1021->client;
+	int error;
+	u8 cmd_enable_touch[3] = {AR1021_CMD,
+				  0x01, /* number of bytes after this */
+				  AR1021_CMD_ENABLE_TOUCH };
+
+	error = i2c_master_send(ar1021->client, cmd_enable_touch,
+				sizeof(cmd_enable_touch));
+	if (error < 0)
+		return error;
 
 	enable_irq(client->irq);
 
-- 
2.1.4

