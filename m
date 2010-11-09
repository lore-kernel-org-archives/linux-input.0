From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 8/8] qt2160: add hardware reset
Date: Tue,  9 Nov 2010 13:15:11 +1100
Message-ID: <1289268911-32322-8-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gw0-f46.google.com ([74.125.83.46]:43507 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753369Ab0KICQI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:16:08 -0500
Received: by gwj21 with SMTP id 21so3921893gwj.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:16:07 -0800 (PST)
In-Reply-To: <1289268911-32322-1-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Use hardware reset if defined, fall back on soft reset.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>

Conflicts:

	include/linux/input/qt2160.h
---
 drivers/input/keyboard/qt2160.c |    8 +++++++-
 include/linux/input/qt2160.h    |    2 ++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index d2ce573..d4a8033 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -284,7 +284,13 @@ static int __devinit qt2160_configure_device(struct i2c_client *client,
 	int error = 0;
 
 	/* perform software reset and wait for at least 32ms */
-	i2c_smbus_write_byte_data(client, QT2160_CMD_RESET, 0xFF);
+	if (pdata->setrst) {
+		pdata->setrst(pdata->data, 0);
+		udelay(10);
+		pdata->setrst(pdata->data, 1);
+	} else {
+		i2c_smbus_write_byte_data(client, QT2160_CMD_RESET, 0xFF);
+	}
 	msleep(200);
 
 	/* perform dummy write to reset I2C state */
diff --git a/include/linux/input/qt2160.h b/include/linux/input/qt2160.h
index dad11bb..1b4b58d 100755
--- a/include/linux/input/qt2160.h
+++ b/include/linux/input/qt2160.h
@@ -10,6 +10,7 @@
  * @data: private data for lowlevel IO abstraction routines
  * @getchange: return 0 when CHANGE pin is active/low; return 1 when CHANGE pin
  *  is deactivated/high
+ * @setrst: 0 activates RESET pin; 1 deactivates RESET pin
  * @slider_length: number of keys to use as slider, max 8 keys, min 2 keys
  * @slider_axis: absolute axis type, value 0 is ABS_X
  * @keycodes: key codes for keys that are part of the slider are ignored; slider
@@ -26,6 +27,7 @@
 struct qt2160_info {
 	void *data;
 	int (*getchange) (void *data);
+	void (*setrst) (void *data, int state);
 	unsigned char slider_length;
 	unsigned int slider_axis;
 	unsigned short keycodes[QT2160_MAXKEYS];
-- 
1.7.0.4

