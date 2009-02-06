From: Eric Miao <eric.y.miao@gmail.com>
Subject: Re: [PATCH] input: let's remove the now deprecated corgi_ts.c
Date: Fri, 6 Feb 2009 16:20:40 +0800
Message-ID: <f17812d70902060020y789c0d5t1a088fa44faa6e75@mail.gmail.com>
References: <f17812d70902050226g1780ca58m4d271b55ba3d3166@mail.gmail.com>
	 <1233840784.5350.8.camel@dax.rpnet.com>
	 <f17812d70902051756t464eb58au187c2f03d9780142@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from rv-out-0506.google.com ([209.85.198.234]:18010 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750885AbZBFIUm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 6 Feb 2009 03:20:42 -0500
Received: by rv-out-0506.google.com with SMTP id k40so691982rvb.1
        for <linux-input@vger.kernel.org>; Fri, 06 Feb 2009 00:20:40 -0800 (PST)
In-Reply-To: <f17812d70902051756t464eb58au187c2f03d9780142@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Richard Purdie <rpurdie@rpsys.net>
Cc: linux-input@vger.kernel.org, David Brownell <david-b@pacbell.net>

On Fri, Feb 6, 2009 at 9:56 AM, Eric Miao <eric.y.miao@gmail.com> wrote:
> On Thu, Feb 5, 2009 at 9:33 PM, Richard Purdie <rpurdie@rpsys.net> wrote:
>>
>> On Thu, 2009-02-05 at 18:26 +0800, Eric Miao wrote:
>>> Let's move to the generic SPI based ADS7846 touchscreen driver.
>>>
>>> Signed-off-by: Eric Miao <eric.miao@marvell.com>
>>> ---
>>>
>>> Richard, any concern on this move?
>>
>> Does the SPI based ADS7846 touchscreen driver have the facility to sync
>> the touchscreen readings with the video blanking period to reduce
>> interference now? That was the main feature that needed porting over.
>>
>
> Yeah, I was once heard of this yet don't know the exact reason for
> doing so. And I'm afraid this is missing from the SPI-based ADS7846
> driver. Richard, do you have any more info on this, so that I can
> have trials later on this?
>

OK, test shows that the problem do exist that there are intermittent
incorrect sampling reported which can be observed easily.

Here's a preliminary analysis of the sampling process from corgi_ts.c:

1. PENDOWN IRQ
2. wait for HSYNC becoming inactive (on falling edge)
3. dummy command send and dummy data readback
4. wait for HSYNC becoming active
5. send the command to read Y/X/Z
6. goto (2) til Y/X/Z are all read

I doubt this process is overly engineered in that:
a. dummy command send and read-back may be unnecessary
b. using a pre-calculated HSYNC invalid period to wait for the
next HSYNC active may be unnecessary either.

Below is a simplified patch for the existing ads7846 and tested
code on akita, which I found working all right (no intermittent
glitches cursor movement so far):

David,

I'd like to know from you if this is somehow near the acceptable shape?

diff --git a/arch/arm/mach-pxa/spitz.c b/arch/arm/mach-pxa/spitz.c
index 6d447c9..88148ca 100644
--- a/arch/arm/mach-pxa/spitz.c
+++ b/arch/arm/mach-pxa/spitz.c
@@ -295,12 +295,23 @@ static struct pxa2xx_spi_master spitz_spi_info = {
 	.num_chipselect	= 3,
 };

+static void spitz_wait_for_hsync(void)
+{
+	while (gpio_get_value(SPITZ_GPIO_HSYNC))
+		cpu_relax();
+
+	while (!gpio_get_value(SPITZ_GPIO_HSYNC))
+		cpu_relax();
+}
+
 static struct ads7846_platform_data spitz_ads7846_info = {
 	.model			= 7846,
 	.vref_delay_usecs	= 100,
+	.keep_vref_on		= 1,
 	.x_plate_ohms		= 419,
 	.y_plate_ohms		= 486,
 	.gpio_pendown		= SPITZ_GPIO_TP_INT,
+	.wait_for_sync		= spitz_wait_for_hsync,
 };

 static void spitz_ads7846_cs(u32 command)
diff --git a/drivers/input/touchscreen/ads7846.c
b/drivers/input/touchscreen/ads7846.c
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
@@ -723,6 +730,7 @@ static enum hrtimer_restart ads7846_timer(struct
hrtimer *handle)
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
