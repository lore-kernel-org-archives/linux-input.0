From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 3/8] qt2160: add PM support
Date: Tue,  9 Nov 2010 13:15:06 +1100
Message-ID: <1289268911-32322-3-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:49374 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753818Ab0KICPv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:15:51 -0500
Received: by mail-gy0-f174.google.com with SMTP id 4so3965040gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:15:51 -0800 (PST)
In-Reply-To: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Add power management support.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>
---
 drivers/input/keyboard/qt2160.c |   34 ++++++++++++++++++++++++++++++++++
 1 files changed, 34 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index dcd05cd..6439e40 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -43,6 +43,7 @@
 #define QT2160_CMD_SUBVER     7
 #define QT2160_CMD_CALIBRATE  10
 #define QT2160_CMD_RESET      11
+#define QT2160_CMD_LP_MODE    12
 #define QT2160_CMD_BURST_REP  13
 #define QT2160_CMD_NEG_DRIFT  15
 #define QT2160_CMD_POS_DRIFT  16
@@ -66,6 +67,9 @@
 
 #define QT2160_CYCLE_INTERVAL	(2*HZ)
 
+#define QT2160_LP_MODE_DEFAULT_VALUE	(1)
+#define QT2160_LP_MODE_SLEEP_VALUE	(0)
+
 #define QT2160_SLIDE_RESOLUTION	(8)
 #define QT2160_SLIDE_HYSTERESIS	(10)
 #define QT2160_SLIDE_MAX_VALUE	(0xFF)
@@ -529,6 +533,34 @@ static int __devexit qt2160_remove(struct i2c_client *client)
 	return 0;
 }
 
+#ifdef CONFIG_PM
+static int qt2160_suspend(struct i2c_client *client, pm_message_t message)
+{
+	int error;
+
+	error = i2c_smbus_write_byte_data(client, QT2160_CMD_LP_MODE,
+					  QT2160_LP_MODE_SLEEP_VALUE);
+	if (error)
+		dev_err(&client->dev, "could not write power config\n");
+	return error;
+}
+
+static int qt2160_resume(struct i2c_client *client)
+{
+	int error;
+	u8 lp_mode_val = QT2160_LP_MODE_DEFAULT_VALUE;
+
+	error = i2c_smbus_write_byte_data(client, QT2160_CMD_LP_MODE,
+					  lp_mode_val);
+	if (error)
+		dev_err(&client->dev, "could not write power config\n");
+	return error;
+}
+#else
+#define qt2160_suspend NULL
+#define qt2160_resume  NULL
+#endif
+
 static const struct i2c_device_id qt2160_idtable[] = {
 	{ "qt2160", 0, },
 	{ }
@@ -545,6 +577,8 @@ static struct i2c_driver qt2160_driver = {
 	.id_table	= qt2160_idtable,
 	.probe		= qt2160_probe,
 	.remove		= __devexit_p(qt2160_remove),
+	.suspend	= qt2160_suspend,
+	.resume		= qt2160_resume,
 };
 
 static int __init qt2160_init(void)
-- 
1.7.0.4

