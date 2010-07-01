From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH] Input: ads7846 - do not allow altering platform data
Date: Thu,  1 Jul 2010 13:26:45 +0200
Message-ID: <1277983605-27726-1-git-send-email-agust@denx.de>
References: <20100630081805.GD4154@core.coreip.homeip.net>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:39710 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754513Ab0GAL1I (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 1 Jul 2010 07:27:08 -0400
In-Reply-To: <20100630081805.GD4154@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Detlev Zundel <dzu@denx.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Dmitry Torokhov <dtor@mail.ru>

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
Tested-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/input/touchscreen/ads7846.c |   35 +++++++++++++++++++----------------
 include/linux/spi/ads7846.h         |    2 +-
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 8ab90dd..82290ff 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -942,14 +942,15 @@ static int __devinit setup_pendown(struct spi_device *spi, struct ads7846 *ts)
 
 static int __devinit ads7846_probe(struct spi_device *spi)
 {
-	struct ads7846			*ts;
-	struct ads7846_packet		*packet;
-	struct input_dev		*input_dev;
-	struct ads7846_platform_data	*pdata = spi->dev.platform_data;
-	struct spi_message		*m;
-	struct spi_transfer		*x;
-	int				vref;
-	int				err;
+	struct ads7846 *ts;
+	struct ads7846_packet *packet;
+	struct input_dev *input_dev;
+	const struct ads7846_platform_data *pdata = spi->dev.platform_data;
+	struct spi_message *m;
+	struct spi_transfer *x;
+	unsigned long irq_flags;
+	int vref;
+	int err;
 
 	if (!spi->irq) {
 		dev_dbg(&spi->dev, "no IRQ?\n");
@@ -1269,20 +1270,22 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		goto err_put_regulator;
 	}
 
-	if (!pdata->irq_flags)
-		pdata->irq_flags = IRQF_TRIGGER_FALLING;
+	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
 
-	if (request_irq(spi->irq, ads7846_irq, pdata->irq_flags,
-			spi->dev.driver->name, ts)) {
+	err = request_irq(spi->irq, ads7846_irq, irq_flags,
+			  spi->dev.driver->name, ts);
+
+	if (err && !pdata->irq_flags) {
 		dev_info(&spi->dev,
 			"trying pin change workaround on irq %d\n", spi->irq);
 		err = request_irq(spi->irq, ads7846_irq,
 				  IRQF_TRIGGER_FALLING | IRQF_TRIGGER_RISING,
 				  spi->dev.driver->name, ts);
-		if (err) {
-			dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
-			goto err_disable_regulator;
-		}
+	}
+
+	if (err) {
+		dev_dbg(&spi->dev, "irq %d busy?\n", spi->irq);
+		goto err_disable_regulator;
 	}
 
 	err = ads784x_hwmon_register(spi, ts);
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 95d36bf..92bd083 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -48,7 +48,7 @@ struct ads7846_platform_data {
 					 * state if get_pendown_state == NULL
 					 */
 	int	(*get_pendown_state)(void);
-	int	(*filter_init)	(struct ads7846_platform_data *pdata,
+	int	(*filter_init)	(const struct ads7846_platform_data *pdata,
 				 void **filter_data);
 	int	(*filter)	(void *filter_data, int data_idx, int *val);
 	void	(*filter_cleanup)(void *filter_data);
-- 
1.7.0.4

