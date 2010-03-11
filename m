From: Ranjith Lohithakshan <ranjithl@ti.com>
Subject: [PATCH] Input: ads7846 - add wakeup support
Date: Thu, 11 Mar 2010 11:05:01 +0530
Message-ID: <1268285701-24086-1-git-send-email-ranjithl@ti.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:49046 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751046Ab0CKFfL (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Thu, 11 Mar 2010 00:35:11 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: dtor@mail.ru, ranjithl@ti.com

Add wakeup support to the ads7846 driver. Platforms can enable wakeup
capability by setting the wakeup flag in ads7846_platform_data. With this
patch the ads7846 driver can be used to wake the system from suspend.

Signed-off-by: Ranjith Lohithakshan <ranjithl@ti.com>
---
 drivers/input/touchscreen/ads7846.c |    8 ++++++++
 include/linux/spi/ads7846.h         |    1 +
 2 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 8b05d8e..38022dd 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -817,6 +817,8 @@ static int ads7846_suspend(struct spi_device *spi, pm_message_t message)
 	spin_lock_irq(&ts->lock);
 
 	ts->is_suspended = 1;
+	if (device_may_wakeup(&ts->spi->dev))
+		enable_irq_wake(ts->spi->irq);
 	ads7846_disable(ts);
 
 	spin_unlock_irq(&ts->lock);
@@ -833,6 +835,8 @@ static int ads7846_resume(struct spi_device *spi)
 
 	ts->is_suspended = 0;
 	ads7846_enable(ts);
+	if (device_may_wakeup(&ts->spi->dev))
+		disable_irq_wake(ts->spi->irq);
 
 	spin_unlock_irq(&ts->lock);
 
@@ -1191,6 +1195,9 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 	if (err)
 		goto err_remove_attr_group;
 
+	if (pdata->wakeup == true)
+		device_init_wakeup(&spi->dev, 1);
+
 	return 0;
 
  err_remove_attr_group:
@@ -1220,6 +1227,7 @@ static int __devexit ads7846_remove(struct spi_device *spi)
 {
 	struct ads7846		*ts = dev_get_drvdata(&spi->dev);
 
+	device_init_wakeup(&spi->dev, 0);
 	ads784x_hwmon_unregister(spi, ts);
 	input_unregister_device(ts->input);
 
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 51948eb..116e611 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -53,5 +53,6 @@ struct ads7846_platform_data {
 	int	(*filter)	(void *filter_data, int data_idx, int *val);
 	void	(*filter_cleanup)(void *filter_data);
 	void	(*wait_for_sync)(void);
+	bool	wakeup;
 };
 
-- 
1.6.2.4

