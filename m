From: Mike Frysinger <vapier@gentoo.org>
Subject: [PATCH] input/misc: ad714x: add support for the AD7143/8/7A parts
Date: Tue,  9 Mar 2010 10:00:57 -0500
Message-ID: <1268146857-15869-1-git-send-email-vapier@gentoo.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49614 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751775Ab0CIO5l (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Tue, 9 Mar 2010 09:57:41 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, Barry Song <barry.song@analog.com>

From: Barry Song <barry.song@analog.com>

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/input/misc/Kconfig      |    2 +-
 drivers/input/misc/ad714x-i2c.c |    3 +++
 drivers/input/misc/ad714x.c     |   27 +++++++++++++++++++++------
 3 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
index 10d3195..49a31bd 100644
--- a/drivers/input/misc/Kconfig
+++ b/drivers/input/misc/Kconfig
@@ -332,7 +332,7 @@ config INPUT_PCAP
 config INPUT_AD714X
 	tristate "Analog Devices AD714x Capacitance Touch Sensor"
 	help
-	  Say Y here if you want to support an AD7142/AD7147 touch sensor.
+	  Say Y here if you want to support an AD7142/3/7/8/7A touch sensor.
 
 	  You should select a bus connection too.
 
diff --git a/drivers/input/misc/ad714x-i2c.c b/drivers/input/misc/ad714x-i2c.c
index 596c199..7242e01 100644
--- a/drivers/input/misc/ad714x-i2c.c
+++ b/drivers/input/misc/ad714x-i2c.c
@@ -101,7 +101,10 @@ static int __devexit ad714x_i2c_remove(struct i2c_client *client)
 
 static const struct i2c_device_id ad714x_id[] = {
 	{ "ad7142_captouch", 0 },
+	{ "ad7143_captouch", 0 },
 	{ "ad7147_captouch", 0 },
+	{ "ad7147a_captouch", 0 },
+	{ "ad7148_captouch", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, ad714x_id);
diff --git a/drivers/input/misc/ad714x.c b/drivers/input/misc/ad714x.c
index bc4f042..028aee2 100644
--- a/drivers/input/misc/ad714x.c
+++ b/drivers/input/misc/ad714x.c
@@ -1,5 +1,5 @@
 /*
- * AD714X CapTouch Programmable Controller driver
+ * AD714X CapTouch Programmable Controller driver supporting AD7142/3/7/8/7A
  *
  * Copyright 2009 Analog Devices Inc.
  *
@@ -17,8 +17,10 @@
 #define AD714X_STG_CAL_EN_REG     0x1
 #define AD714X_AMB_COMP_CTRL0_REG 0x2
 #define AD714X_PARTID_REG         0x17
-#define AD7147_PARTID             0x1470
 #define AD7142_PARTID             0xE620
+#define AD7143_PARTID             0xE630
+#define AD7147_PARTID             0x1470
+#define AD7148_PARTID             0x1480
 #define AD714X_STAGECFG_REG       0x80
 #define AD714X_SYSCFG_REG         0x0
 
@@ -934,18 +936,31 @@ static int ad714x_hw_detect(struct ad714x_chip *ad714x)
 
 	ad714x->read(ad714x->dev, AD714X_PARTID_REG, &data);
 	switch (data & 0xFFF0) {
+	case AD7142_PARTID:
+		ad714x->product = 0x7142;
+		ad714x->version = data & 0xF;
+		dev_info(ad714x->dev, "found AD7142 captouch, rev:%d\n",
+				ad714x->version);
+		return 0;
+	case AD7143_PARTID:
+		ad714x->product = 0x7143;
+		ad714x->version = data & 0xF;
+		dev_info(ad714x->dev, "found AD7143 captouch, rev:%d\n",
+				ad714x->version);
+		return 0;
 	case AD7147_PARTID:
 		ad714x->product = 0x7147;
 		ad714x->version = data & 0xF;
-		dev_info(ad714x->dev, "found AD7147 captouch, rev:%d\n",
+		dev_info(ad714x->dev, "found AD7147(A) captouch, rev:%d\n",
 				ad714x->version);
 		return 0;
-	case AD7142_PARTID:
-		ad714x->product = 0x7142;
+	case AD7148_PARTID:
+		ad714x->product = 0x7148;
 		ad714x->version = data & 0xF;
-		dev_info(ad714x->dev, "found AD7142 captouch, rev:%d\n",
+		dev_info(ad714x->dev, "found AD7148 captouch, rev:%d\n",
 				ad714x->version);
 		return 0;
+
 	default:
 		dev_err(ad714x->dev,
 			"fail to detect AD714X captouch, read ID is %04x\n",
-- 
1.7.0.2

