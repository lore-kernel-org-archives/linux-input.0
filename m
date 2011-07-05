From: chris.hudson.comp.eng@gmail.com
Subject: [PATCH] input:Misc changes against kxtj9 v5 patch
Date: Tue,  5 Jul 2011 15:55:54 -0400
Message-ID: <1309895754-5441-1-git-send-email-chris.hudson.comp.eng@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kionix.com ([66.152.113.154]:59256 "EHLO mail.kionix.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753262Ab1GET4B (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 5 Jul 2011 15:56:01 -0400
Received: from mail1.kionix.com (localhost [127.0.0.1])
	by mail.kionix.com (Spam Firewall) with ESMTP id 36A5D24913F
	for <linux-input@vger.kernel.org>; Tue,  5 Jul 2011 15:55:54 -0400 (EDT)
Received: from mail1.kionix.com ([10.0.0.125]) by mail.kionix.com with ESMTP id pcqRnBCaLvIvnkLd for <linux-input@vger.kernel.org>; Tue, 05 Jul 2011 15:55:54 -0400 (EDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com, jic23@cam.ac.uk, Chris Hudson <chudson@kionix.com>

From: Chris Hudson <chudson@kionix.com>

As requested, miscellaneous changes originally suggested by Jonathan Cameron,
patched against the original kxtj9 v5 patch.

Signed-off-by: Chris Hudson <chudson@kionix.com>
---
 drivers/input/misc/kxtj9.c  |   38 +++++++++++++-------------------------
 include/linux/input/kxtj9.h |   10 +---------
 2 files changed, 14 insertions(+), 34 deletions(-)

diff --git a/drivers/input/misc/kxtj9.c b/drivers/input/misc/kxtj9.c
index 7faf155..b2da841 100644
--- a/drivers/input/misc/kxtj9.c
+++ b/drivers/input/misc/kxtj9.c
@@ -71,6 +71,15 @@ static const struct {
 	{ 0,	ODR12_5F},
 };
 
+static const struct {
+	u8 g_range;
+	u8 shift;
+} kxtj9_range[] = {
+	{ 0,		4 },	/* +/-2g */
+	{ (1 << 3),	3 },	/* +/-4g */
+	{ (1 << 4),	2 },	/* +/-8g */
+};
+
 struct kxtj9_data {
 	struct i2c_client *client;
 	struct kxtj9_platform_data pdata;
@@ -129,25 +138,9 @@ static void kxtj9_report_acceleration_data(struct kxtj9_data *tj9)
 
 static int kxtj9_update_g_range(struct kxtj9_data *tj9, u8 new_g_range)
 {
-	switch (new_g_range) {
-	case KXTJ9_G_2G:
-		tj9->shift = SHIFT_ADJ_2G;
-		break;
-
-	case KXTJ9_G_4G:
-		tj9->shift = SHIFT_ADJ_4G;
-		break;
-
-	case KXTJ9_G_8G:
-		tj9->shift = SHIFT_ADJ_8G;
-		break;
-
-	default:
-		return -EINVAL;
-	}
-
+	tj9->shift = kxtj9_range[new_g_range].shift;
 	tj9->ctrl_reg1 &= 0xe7;
-	tj9->ctrl_reg1 |= new_g_range;
+	tj9->ctrl_reg1 |= kxtj9_range[new_g_range].g_range;
 
 	return 0;
 }
@@ -181,13 +174,8 @@ static int kxtj9_update_odr(struct kxtj9_data *tj9, int poll_interval)
 
 static int kxtj9_device_power_on(struct kxtj9_data *tj9)
 {
-	int err;
-
-	if (tj9->pdata.power_on) {
-		err = tj9->pdata.power_on();
-		if (err < 0)
-			return err;
-	}
+	if (tj9->pdata.power_on)
+		return tj9->pdata.power_on();
 
 	return 0;
 }
diff --git a/include/linux/input/kxtj9.h b/include/linux/input/kxtj9.h
index cc5928b..6064d45 100644
--- a/include/linux/input/kxtj9.h
+++ b/include/linux/input/kxtj9.h
@@ -22,11 +22,6 @@
 
 #define KXTJ9_I2C_ADDR		0x0F
 
-/* These shift values are used to provide consistent output data */
-#define SHIFT_ADJ_2G		4
-#define SHIFT_ADJ_4G		3
-#define SHIFT_ADJ_8G		2
-
 #ifdef __KERNEL__
 struct kxtj9_platform_data {
 	int poll_interval;	/* current poll interval (in milli-seconds) */
@@ -49,10 +44,7 @@ struct kxtj9_platform_data {
 	#define RES_8BIT		0
 	#define RES_12BIT		(1 << 6)
 	u8 res_12bit;
-	/* Output g-range: +/-2g, 4g, or 8g */
-	#define KXTJ9_G_2G		0
-	#define KXTJ9_G_4G		(1 << 3)
-	#define KXTJ9_G_8G		(1 << 4)
+	/* Output g-range: 0 = +/-2g, 1 = 4g, or 2 = 8g */
 	u8 g_range;
 
 	/* DATA_CTRL_REG: controls the output data rate of the part */
-- 
1.5.4.3

