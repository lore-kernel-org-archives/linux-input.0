From: jooaun <jasaw81@gmail.com>
Subject: [PATCH 2/8] qt2160: configurable key sensitivity
Date: Tue,  9 Nov 2010 13:43:24 +1100
Message-ID: <1289270604-4259-1-git-send-email-jasaw81@gmail.com>
References: <1289268911-32322-2-git-send-email-jasaw81@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-gy0-f174.google.com ([209.85.160.174]:33342 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754415Ab0KICoB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 8 Nov 2010 21:44:01 -0500
Received: by gyh4 with SMTP id 4so3975908gyh.19
        for <linux-input@vger.kernel.org>; Mon, 08 Nov 2010 18:44:01 -0800 (PST)
In-Reply-To: <1289268911-32322-2-git-send-email-jasaw81@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: dmitry.torokhov@gmail.com
Cc: linux-input@vger.kernel.org, raphaelpereira@gmail.com, jooaun <jasaw81@gmail.com>

Add configurable key sensitivity, disable unused keys.
Configurable key sensitivity to compensate for different touch sensor circuits.
Disable unused keys to reduce power consumption.
Signed-off-by: Joo Aun Saw <jasaw81@gmail.com>
---
 drivers/input/keyboard/qt2160.c |   38 ++++++++++++++++++++++++++++++++++++++
 include/linux/input/qt2160.h    |    2 ++
 2 files changed, 40 insertions(+), 0 deletions(-)

diff --git a/drivers/input/keyboard/qt2160.c b/drivers/input/keyboard/qt2160.c
index 7ec256c..dcd05cd 100755
--- a/drivers/input/keyboard/qt2160.c
+++ b/drivers/input/keyboard/qt2160.c
@@ -43,9 +43,26 @@
 #define QT2160_CMD_SUBVER     7
 #define QT2160_CMD_CALIBRATE  10
 #define QT2160_CMD_RESET      11
+#define QT2160_CMD_BURST_REP  13
+#define QT2160_CMD_NEG_DRIFT  15
+#define QT2160_CMD_POS_DRIFT  16
+#define QT2160_CMD_DI_LIMIT   17
+#define QT2160_CMD_NEG_RECAL  18
+#define QT2160_CMD_DHTA       19
 #define QT2160_CMD_SLIDE_CTRL 20
 #define QT2160_CMD_SLIDE_OPT  21
 #define QT2160_CMD_KEY0_AKS   22
+#define QT2160_CMD_KEY0_NEGT  38
+#define QT2160_CMD_KEY0_BURST 54
+#define QT2160_CMD_GPIO_DRV1  70
+#define QT2160_CMD_GPIO_DRV2  71
+#define QT2160_CMD_GPIO_DIR   73
+#define QT2160_CMD_GPIO_PWM1  74
+#define QT2160_CMD_GPIO_PWM2  75
+#define QT2160_CMD_PWM_LEVEL  76
+#define QT2160_CMD_GPIO_WAKE  77
+#define QT2160_CMD_CC_KEYS1   78
+#define QT2160_CMD_CC_KEYS2   79
 
 #define QT2160_CYCLE_INTERVAL	(2*HZ)
 
@@ -297,6 +314,27 @@ static int __devinit qt2160_configure_device(struct i2c_client *client,
 	}
 
 	for (i = 0; i < QT2160_MAXKEYS; i++) {
+		/* setup burst length and disable unused keys */
+		if (i < pdata->slider_length) {
+			if (pdata->key_burst_length[i])
+				error |= i2c_smbus_write_byte_data(
+						client,
+						QT2160_CMD_KEY0_BURST + i,
+						pdata->key_burst_length[i]);
+		} else {
+			if (pdata->keycodes[i]) {
+				if (pdata->key_burst_length[i])
+					error |= i2c_smbus_write_byte_data(
+						client,
+						QT2160_CMD_KEY0_BURST + i,
+						pdata->key_burst_length[i]);
+			} else {
+				error |= i2c_smbus_write_byte_data(
+						client,
+						QT2160_CMD_KEY0_BURST + i,
+						0);
+			}
+		}
 		/* set AKS */
 		error |= i2c_smbus_write_byte_data(client,
 						   QT2160_CMD_KEY0_AKS + i,
diff --git a/include/linux/input/qt2160.h b/include/linux/input/qt2160.h
index 9d1252e..748c86e 100755
--- a/include/linux/input/qt2160.h
+++ b/include/linux/input/qt2160.h
@@ -15,12 +15,14 @@
  * @key_aks: adjacent key suppression; keys that form a slider must be in the
  *  same aks group; keys in the same aks group will only report 1 active key at
  *  any time; value 0 disables aks group; valid aks groups are 1, 2, 3
+ * @key_burst_length: key sensitivity; 0 use default
  */
 struct qt2160_info {
 	unsigned char slider_length;
 	unsigned int slider_axis;
 	unsigned short keycodes[QT2160_MAXKEYS];
 	unsigned char key_aks[QT2160_MAXKEYS];
+	unsigned char key_burst_length[QT2160_MAXKEYS];
 };
 
 #endif /* __QT2160_H__ */
-- 
1.7.0.4

