From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/2] Input: ads7846 - extend the driver for ads7845
 controller support
Date: Wed, 30 Jun 2010 01:18:05 -0700
Message-ID: <20100630081805.GD4154@core.coreip.homeip.net>
References: <1272630181-5364-2-git-send-email-agust@denx.de>
 <1277803793-15077-1-git-send-email-agust@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pv0-f174.google.com ([74.125.83.174]:35764 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752313Ab0F3ISL (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 30 Jun 2010 04:18:11 -0400
Received: by pvc7 with SMTP id 7so250210pvc.19
        for <linux-input@vger.kernel.org>; Wed, 30 Jun 2010 01:18:10 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1277803793-15077-1-git-send-email-agust@denx.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Anatolij Gustschin <agust@denx.de>
Cc: linux-input@vger.kernel.org, Detlev Zundel <dzu@denx.de>

On Tue, Jun 29, 2010 at 11:29:53AM +0200, Anatolij Gustschin wrote:
> ADS7845 is a controller for 5-wire touch screens and
> somewhat different from 7846. It requires three serial
> communications to accomplish one complete conversion.
> Unlike 7846 it doesn't allow Z1-/Z2- position measurement.
> 
> The patch extends the ads7846 driver to also support
> ads7845. The packet struct is extended to contain
> needed command and conversion buffers. ads7846_rx()
> and ads7846_rx_val() now differentiate between 7845
> and 7846 case. ads7846_probe() is modified to setup
> ads7845 specific command and conversion messages and
> to switch ads7845 into power-down mode, since this is
> needed to be prepared to respond to pendown interrupts.
> 

Thank you for making changes Anatolij, I iwll be applying the patch to
my 2.6.36 queue.

I just noticed that your previous patch alters pdata which I belive is
wrong thing to do. Could you please try the following patch and let me
know if I broke anything?

Thanks!

-- 
Dmitry

Input: ads7846 - do not allow altering platform data

From: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/input/touchscreen/ads7846.c |   35 +++++++++++++++++++----------------
 include/linux/spi/ads7846.h         |    2 +-
 2 files changed, 20 insertions(+), 17 deletions(-)


diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
index 69210cb..8c9b316 100644
--- a/drivers/input/touchscreen/ads7846.c
+++ b/drivers/input/touchscreen/ads7846.c
@@ -878,14 +878,15 @@ static int __devinit setup_pendown(struct spi_device *spi, struct ads7846 *ts)
 
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
@@ -1174,20 +1175,22 @@ static int __devinit ads7846_probe(struct spi_device *spi)
 		goto err_put_regulator;
 	}
 
-	if (!pdata->irq_flags)
-		pdata->irq_flags = IRQF_TRIGGER_FALLING;
+	irq_flags = pdata->irq_flags ? : IRQF_TRIGGER_FALLING;
 
-	if (request_irq(spi->irq, ads7846_irq, pdata->irq_flags,
-			spi->dev.driver->name, ts)) {
+	err = request_irq(spi->irq, ads7846_irq, pdata->irq_flags,
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
