From: Marek Vasut <marek.vasut@gmail.com>
Subject: [PATCH] UCB1400: Allow passing IRQ through platfrom_data
Date: Sun, 8 Nov 2009 03:10:03 +0100
Message-ID: <200911080310.04121.marek.vasut@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bw0-f227.google.com ([209.85.218.227]:33563 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751917AbZKHCLK convert rfc822-to-8bit (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 7 Nov 2009 21:11:10 -0500
Received: by bwz27 with SMTP id 27so2388530bwz.21
        for <linux-input@vger.kernel.org>; Sat, 07 Nov 2009 18:11:15 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

>From b8d3ab594008dd2714d4dedf12348d05c08a48fd Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut@gmail.com>
Date: Sun, 8 Nov 2009 02:51:55 +0100
Subject: [PATCH] UCB1400: Allow passing IRQ through platfrom_data

This patch allows UCB1400 to get IRQ GPIO from platform data. In case
platform_data are not supplied or the IRQ set in the platform_data is lower than
zero, fall back to the old IRQ detection algorithm.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 drivers/input/touchscreen/ucb1400_ts.c |   11 +++++++----
 drivers/mfd/ucb1400_core.c             |    7 +++++++
 include/linux/ucb1400.h                |    4 ++++
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/input/touchscreen/ucb1400_ts.c 
b/drivers/input/touchscreen/ucb1400_ts.c
index 095f84b..89dcbe7 100644
--- a/drivers/input/touchscreen/ucb1400_ts.c
+++ b/drivers/input/touchscreen/ucb1400_ts.c
@@ -355,10 +355,13 @@ static int ucb1400_ts_probe(struct platform_device *dev)
 		goto err;
 	}
 
-	error = ucb1400_ts_detect_irq(ucb);
-	if (error) {
-		printk(KERN_ERR "UCB1400: IRQ probe failed\n");
-		goto err_free_devs;
+	/* Only in case the IRQ line wasn't supplied, try detecting it */
+	if (ucb->irq < 0) {
+		error = ucb1400_ts_detect_irq(ucb);
+		if (error) {
+			printk(KERN_ERR "UCB1400: IRQ probe failed\n");
+			goto err_free_devs;
+		}
 	}
 
 	init_waitqueue_head(&ucb->ts_wait);
diff --git a/drivers/mfd/ucb1400_core.c b/drivers/mfd/ucb1400_core.c
index fa294b6..85fd942 100644
--- a/drivers/mfd/ucb1400_core.c
+++ b/drivers/mfd/ucb1400_core.c
@@ -51,6 +51,7 @@ static int ucb1400_core_probe(struct device *dev)
 	struct ucb1400_ts ucb_ts;
 	struct ucb1400_gpio ucb_gpio;
 	struct snd_ac97 *ac97;
+	struct ucb1400_pdata *pdata = dev->platform_data;
 
 	memset(&ucb_ts, 0, sizeof(ucb_ts));
 	memset(&ucb_gpio, 0, sizeof(ucb_gpio));
@@ -88,6 +89,12 @@ static int ucb1400_core_probe(struct device *dev)
 
 	/* TOUCHSCREEN */
 	ucb_ts.ac97 = ac97;
+
+	if (pdata != NULL && pdata->irq >= 0)
+		ucb_ts.irq = pdata->irq;
+	else
+		ucb_ts.irq = -1;
+
 	ucb->ucb1400_ts = platform_device_alloc("ucb1400_ts", -1);
 	if (!ucb->ucb1400_ts) {
 		err = -ENOMEM;
diff --git a/include/linux/ucb1400.h b/include/linux/ucb1400.h
index adb4406..1b47909 100644
--- a/include/linux/ucb1400.h
+++ b/include/linux/ucb1400.h
@@ -110,6 +110,10 @@ struct ucb1400 {
 	struct platform_device	*ucb1400_gpio;
 };
 
+struct ucb1400_pdata {
+	int	irq;
+};
+
 static inline u16 ucb1400_reg_read(struct snd_ac97 *ac97, u16 reg)
 {
 	return ac97->bus->ops->read(ac97, reg);
-- 
1.6.5

