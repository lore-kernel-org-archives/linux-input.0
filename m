From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 2/3] Input: tps6507x-ts - remove vref from platform data
Date: Sun,  9 Jun 2013 22:53:46 -0700
Message-ID: <1370843627-30823-2-git-send-email-dmitry.torokhov@gmail.com>
References: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f176.google.com ([209.85.192.176]:42807 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765Ab3FJFxu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 10 Jun 2013 01:53:50 -0400
Received: by mail-pd0-f176.google.com with SMTP id t12so2236621pdi.21
        for <linux-input@vger.kernel.org>; Sun, 09 Jun 2013 22:53:50 -0700 (PDT)
In-Reply-To: <1370843627-30823-1-git-send-email-dmitry.torokhov@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: manishv.b@ti.com, davinci-linux-open-source@linux.davincidsp.com

Although defined in platform data, vref is not used anywhere.

Also remove model, irq, and clear_penirq as they are not used either.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/touchscreen/tps6507x-ts.c | 5 -----
 include/linux/input/tps6507x-ts.h       | 1 -
 2 files changed, 6 deletions(-)

diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/touchscreen/tps6507x-ts.c
index c981ccf..d3c2967 100644
--- a/drivers/input/touchscreen/tps6507x-ts.c
+++ b/drivers/input/touchscreen/tps6507x-ts.c
@@ -44,12 +44,8 @@ struct tps6507x_ts {
 	struct delayed_work	work;
 	struct ts_event		tc;
 	struct tps6507x_dev	*mfd;
-	u16			model;
 	u16			min_pressure;
-	int			irq;
-	void			(*clear_penirq)(void);
 	unsigned long		poll_period;	/* ms */
-	int			vref;		/* non-zero to leave vref on */
 	bool			pendown;
 };
 
@@ -291,7 +287,6 @@ static int tps6507x_ts_probe(struct platform_device *pdev)
 
 	if (init_data) {
 		tsc->poll_period = init_data->poll_period;
-		tsc->vref = init_data->vref;
 		tsc->min_pressure = init_data->min_pressure;
 		input_dev->id.vendor = init_data->vendor;
 		input_dev->id.product = init_data->product;
diff --git a/include/linux/input/tps6507x-ts.h b/include/linux/input/tps6507x-ts.h
index ab14403..b433df8 100644
--- a/include/linux/input/tps6507x-ts.h
+++ b/include/linux/input/tps6507x-ts.h
@@ -14,7 +14,6 @@
 /* Board specific touch screen initial values */
 struct touchscreen_init_data {
 	int	poll_period;	/* ms */
-	int	vref;		/* non-zero to leave vref on */
 	__u16	min_pressure;	/* min reading to be treated as a touch */
 	__u16	vendor;
 	__u16	product;
-- 
1.8.1.4

