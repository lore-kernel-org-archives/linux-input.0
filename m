From: Chris@vger.kernel.org, Hudson@vger.kernel.org
Subject: [PATCH 1/1] input: kxtj9: who_am_i check value and initial data rate fixes
Date: Fri,  3 Feb 2012 10:27:52 -0500
Message-ID: <1328282872-10377-1-git-send-email-chudson@kionix.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kionix.com ([66.152.113.154]:40281 "EHLO mail.kionix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753604Ab2BCP22 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 3 Feb 2012 10:28:28 -0500
Received: from mail1.kionix.com (localhost [127.0.0.1])
	by mail.kionix.com (Spam Firewall) with ESMTP id 6265E2B72ED
	for <linux-input@vger.kernel.org>; Fri,  3 Feb 2012 10:27:54 -0500 (EST)
Received: from mail1.kionix.com ([10.0.0.125]) by mail.kionix.com with ESMTP id OtMa1fOZe855NlHU for <linux-input@vger.kernel.org>; Fri, 03 Feb 2012 10:27:54 -0500 (EST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, chris.hudson.comp.eng@gmail.com, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

Several fixes based on customer feedback:
- WHO_AM_I value has changed since preliminary parts used for initial testing
- Output of le16_to_cpu must be saved to memory before shifting to preserve sign
- Initial data rate was not extracted from data control register init.  This was
  causing the initial data rate to be set to maximum until it was changed.  To
  fix this problem, it made more sense to specify an initial data rate and
  extract the register mask from that.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 drivers/input/misc/kxtj9.c  |   25 ++++++++++++++++++++-----
 include/linux/input/kxtj9.h |   11 +----------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 783597a..7c4b955 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -41,6 +41,14 @@
 #define PC1_ON			(1 << 7)
 /* Data ready funtion enable bit: set during probe if using irq mode */
 #define DRDYE			(1 << 5)
+/* DATA CONTROL REGISTER BITS */
+#define ODR12_5F		0
+#define ODR25F			1
+#define ODR50F			2
+#define ODR100F			3
+#define ODR200F			4
+#define ODR400F			5
+#define ODR800F			6
 /* INTERRUPT CONTROL REGISTER 1 BITS */
 /* Set these during probe if using irq mode */
 #define KXTJ9_IEL		(1 << 3)
@@ -116,9 +124,13 @@ static void kxtj9_report_acceleration_data(struct kxtj9_data *tj9)
 	if (err < 0)
 		dev_err(&tj9->client->dev, "accelerometer data read failed\n");
 
-	x = le16_to_cpu(acc_data[tj9->pdata.axis_map_x]) >> tj9->shift;
-	y = le16_to_cpu(acc_data[tj9->pdata.axis_map_y]) >> tj9->shift;
-	z = le16_to_cpu(acc_data[tj9->pdata.axis_map_z]) >> tj9->shift;
+	x = le16_to_cpu(acc_data[tj9->pdata.axis_map_x]);
+	y = le16_to_cpu(acc_data[tj9->pdata.axis_map_y]);
+	z = le16_to_cpu(acc_data[tj9->pdata.axis_map_z]);
+
+	x >>= tj9->shift;
+	y >>= tj9->shift;
+	z >>= tj9->shift;
 
 	input_report_abs(tj9->input_dev, ABS_X, tj9->pdata.negate_x ? -x : x);
 	input_report_abs(tj9->input_dev, ABS_Y, tj9->pdata.negate_y ? -y : y);
@@ -487,7 +499,10 @@ static int __devinit kxtj9_verify(struct kxtj9_data *tj9)
 		goto out;
 	}
 
-	retval = retval != 0x06 ? -EIO : 0;
+	if ((retval != 0x07) && (retval != 0x08))
+		retval = -EIO;
+	else
+		retval = 0;
 
 out:
 	kxtj9_device_power_off(tj9);
@@ -537,7 +552,7 @@ static int __devinit kxtj9_probe(struct i2c_client *client,
 	i2c_set_clientdata(client, tj9);
 
 	tj9->ctrl_reg1 = tj9->pdata.res_12bit | tj9->pdata.g_range;
-	tj9->data_ctrl = tj9->pdata.data_odr_init;
+	tj9->last_poll_interval = tj9->pdata.init_interval;
 
 	if (client->irq) {
 		/* If in irq mode, populate INT_CTRL_REG1 and enable DRDY. */
diff --git a/include/linux/input/kxtj9.h b/include/linux/input/kxtj9.h
index f6bac89..d415579 100644
--- a/include/linux/input/kxtj9.h
+++ b/include/linux/input/kxtj9.h
@@ -24,6 +24,7 @@
 
 struct kxtj9_platform_data {
 	unsigned int min_interval;	/* minimum poll interval (in milli-seconds) */
+	unsigned int init_interval;	/* initial poll interval (in milli-seconds) */
 
 	/*
 	 * By default, x is axis 0, y is axis 1, z is axis 2; these can be
@@ -52,16 +53,6 @@ struct kxtj9_platform_data {
 	#define KXTJ9_G_8G		(1 << 4)
 	u8 g_range;
 
-	/* DATA_CTRL_REG: controls the output data rate of the part */
-	#define ODR12_5F		0
-	#define ODR25F			1
-	#define ODR50F			2
-	#define ODR100F			3
-	#define ODR200F			4
-	#define ODR400F			5
-	#define ODR800F			6
-	u8 data_odr_init;
-
 	int (*init)(void);
 	void (*exit)(void);
 	int (*power_on)(void);
-- 
1.5.4.3

