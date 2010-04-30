From: Anatolij Gustschin <agust@denx.de>
Subject: [PATCH 1/2] Input: ads7846 - allow specifying irq trigger type in platform data
Date: Fri, 30 Apr 2010 14:23:00 +0200
Message-ID: <1272630181-5364-1-git-send-email-agust@denx.de>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out.m-online.net ([212.18.0.10]:40908 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758398Ab0D3RUR (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 30 Apr 2010 13:20:17 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Detlev Zundel <dzu@denx.de>

On some platforms, for example with GPIO interrupts
on mpc5121, it is not possible to configure falling edge
interrupts.

Specifying irq trigger type in platform data structure
allows using ads7846 driver on such platforms.

Signed-off-by: Anatolij Gustschin <agust@denx.de>
---
 drivers/input/touchscreen/ads7846.c |    5 ++++-
 include/linux/spi/ads7846.h         |    1 +
 2 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 532279c..9cfc865 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -1174,7 +1174,10 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		goto err_put_regulator;
 	}
 
-	if (request_irq(spi->irq, ads7846_irq, IRQF_TRIGGER_FALLING,
+	if (!pdata->irq_trigger)
+		pdata->irq_trigger = IRQF_TRIGGER_FALLING;
+
+	if (request_irq(spi->irq, ads7846_irq, pdata->irq_trigger,
 			spi->dev.driver->name, ts)) {
 		dev_info(&spi->dev,
 			"trying pin change workaround on irq %d\n", spi->irq);
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index b4ae570..32e34ba 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -54,5 +54,6 @@ struct ads7846_platform_data {
 	void	(*filter_cleanup)(void *filter_data);
 	void	(*wait_for_sync)(void);
 	bool	wakeup;
+	u8	irq_trigger;
 };
 
-- 
1.6.3.3

