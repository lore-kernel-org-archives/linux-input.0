From: Zhang Jiejing <jiejing.zhang@freescale.com>
Subject: [PATCH] input: mpr121: improve sensibility of touch key.
Date: Thu, 30 Jun 2011 00:34:41 +0800
Message-ID: <1309365281-3444-1-git-send-email-jiejing.zhang@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from db3ehsobe006.messaging.microsoft.com ([213.199.154.144]:29587
	"EHLO DB3EHSOBE006.bigfish.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752467Ab1F2IRx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 29 Jun 2011 04:17:53 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dmitry.torokhov@gmail.com

From: Jiejing Zhang <jiejing.zhang@freescale.com>

There was an Quick Charge bit in Electrode conf register
should be set in init function, this bit was missed in
chip's document, which may cause touch controller charge
too slow to generate an interrupt.

Also, adjust the default vlaue of touch and release threshold
to make touch key more sensitive, this fix touch may not sensitive
after setup with plastic case.

Signed-off-by: Jiejing Zhang <jiejing.zhang@freescale.com>
---
 drivers/input/keyboard/mpr121_touchkey.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/input/keyboard/mpr121_touchkey.c b/drivers/input/keyboard/mpr121_touchkey.c
index 0a9e811..0607699 100644
--- a/drivers/input/keyboard/mpr121_touchkey.c
+++ b/drivers/input/keyboard/mpr121_touchkey.c
@@ -43,14 +43,15 @@
  * enabled capacitance sensing inputs and its run/suspend mode.
  */
 #define ELECTRODE_CONF_ADDR		0x5e
+#define ELECTRODE_CONF_QUICK_CHARGE	0x80
 #define AUTO_CONFIG_CTRL_ADDR		0x7b
 #define AUTO_CONFIG_USL_ADDR		0x7d
 #define AUTO_CONFIG_LSL_ADDR		0x7e
 #define AUTO_CONFIG_TL_ADDR		0x7f
 
 /* Threshold of touch/release trigger */
-#define TOUCH_THRESHOLD			0x0f
-#define RELEASE_THRESHOLD		0x0a
+#define TOUCH_THRESHOLD			0x08
+#define RELEASE_THRESHOLD		0x05
 /* Masks for touch and release triggers */
 #define TOUCH_STATUS_MASK		0xfff
 /* MPR121 has 12 keys */
@@ -127,7 +128,7 @@ static int __devinit mpr121_phys_init(const struct mpr121_platform_data *pdata,
 				      struct i2c_client *client)
 {
 	const struct mpr121_init_register *reg;
-	unsigned char usl, lsl, tl;
+	unsigned char usl, lsl, tl, eleconf;
 	int i, t, vdd, ret;
 
 	/* Set up touch/release threshold for ele0-ele11 */
@@ -163,8 +164,13 @@ static int __devinit mpr121_phys_init(const struct mpr121_platform_data *pdata,
 	ret = i2c_smbus_write_byte_data(client, AUTO_CONFIG_USL_ADDR, usl);
 	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_LSL_ADDR, lsl);
 	ret |= i2c_smbus_write_byte_data(client, AUTO_CONFIG_TL_ADDR, tl);
+
+	/* Quick charge bit will let the capacitive charge to ready
+	   state quickly, or the button may not function after system
+	   boot */
+	eleconf = mpr121->keycount | ELECTRODE_CONF_QUICK_CHARGE;
 	ret |= i2c_smbus_write_byte_data(client, ELECTRODE_CONF_ADDR,
-					 mpr121->keycount);
+					 eleconf);
 	if (ret != 0)
 		goto err_i2c_write;
 
-- 
1.7.4.1


