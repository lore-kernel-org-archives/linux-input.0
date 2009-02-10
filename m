From: Eric Miao <eric.y.miao@gmail.com>
Subject: [PATCH] input: ads7846: introduce platform specific way to synchronize
 sampling
Date: Tue, 10 Feb 2009 10:49:55 +0800
Message-ID: <4990EB53.5060809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ti-out-0910.google.com ([209.85.142.186]:28814 "EHLO
	ti-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbZBJCvA (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 9 Feb 2009 21:51:00 -0500
Received: by ti-out-0910.google.com with SMTP id d10so2047673tib.23
        for <linux-input@vger.kernel.org>; Mon, 09 Feb 2009 18:50:58 -0800 (PST)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: David Brownell <dbrownell@users.sourceforge.net>


Noices can be introduced when LCD signals are being driven, some platforms
provide a signal to assist the synchronization of this sampling procedure,
introduce a platform specific 'wait_for_sync' for this.

Signed-off-by: Eric Miao <eric.miao@marvell.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>
---
 drivers/input/touchscreen/ads7846.c |   10 ++++++++++
 include/linux/spi/ads7846.h         |    2 ++
 2 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 7c27c8b..e18775a 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -127,6 +127,8 @@ struct ads7846 {
 	void			(*filter_cleanup)(void *data);
 	int			(*get_pendown_state)(void);
 	int			gpio_pendown;
+
+	void			(*wait_for_sync)(void);
 };
 
 /* leave chip selected when we're done, for quicker re-select? */
@@ -511,6 +513,10 @@ static int get_pendown_state(struct ads7846 *ts)
 	return !gpio_get_value(ts->gpio_pendown);
 }
 
+static void null_wait_for_sync(void)
+{
+}
+
 /*
  * PENIRQ only kicks the timer.  The timer only reissues the SPI transfer,
  * to retrieve touchscreen status.
@@ -686,6 +692,7 @@ static void ads7846_rx_val(void *ads)
 	default:
 		BUG();
 	}
+	ts->wait_for_sync();
 	status = spi_async(ts->spi, m);
 	if (status)
 		dev_err(&ts->spi->dev, "spi_async --> %d\n",
@@ -723,6 +730,7 @@ static enum hrtimer_restart ads7846_timer(struct hrtimer *handle)
 	} else {
 		/* pen is still down, continue with the measurement */
 		ts->msg_idx = 0;
+		ts->wait_for_sync();
 		status = spi_async(ts->spi, &ts->msg[0]);
 		if (status)
 			dev_err(&ts->spi->dev, "spi_async --> %d\n", status);
@@ -947,6 +955,8 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		ts->penirq_recheck_delay_usecs =
 				pdata->penirq_recheck_delay_usecs;
 
+	ts->wait_for_sync = (pdata->wait_for_sync) ? : null_wait_for_sync;
+
 	snprintf(ts->phys, sizeof(ts->phys), "%s/input0", dev_name(&spi->dev));
 
 	input_dev->name = "ADS784x Touchscreen";
diff --git a/include/linux/spi/ads7846.h b/include/linux/spi/ads7846.h
index 05eab2f..186c5aa 100644
--- a/include/linux/spi/ads7846.h
+++ b/include/linux/spi/ads7846.h
@@ -51,5 +51,7 @@ struct ads7846_platform_data {
 				 void **filter_data);
 	int	(*filter)	(void *filter_data, int data_idx, int *val);
 	void	(*filter_cleanup)(void *filter_data);
+
+	void	(*wait_for_sync)(void);
 };
 
-- 
1.6.0.4

