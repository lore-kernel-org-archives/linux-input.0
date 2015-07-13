From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/3] Input: zforce - enable irq only if we are ready to
 process it
Date: Mon, 13 Jul 2015 10:07:35 -0700
Message-ID: <20150713170735.GC5039@dtor-ws>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
 <1436791779-21798-2-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f178.google.com ([209.85.213.178]:35068 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792AbbGMRHj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 13:07:39 -0400
Received: by igcqs7 with SMTP id qs7so62271840igc.0
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 10:07:39 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436791779-21798-2-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On Mon, Jul 13, 2015 at 02:49:38PM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> 
> If zforce is not ready to process the interrupt, the touchscreen will
> be lost forever. Make sure we enable the interrupt only if processing
> is ready.
> 
> Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  drivers/input/touchscreen/zforce_ts.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index 19dc297..a1889e5 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -22,6 +22,7 @@
>  #include <linux/slab.h>
>  #include <linux/input.h>
>  #include <linux/interrupt.h>
> +#include <linux/irq.h>
>  #include <linux/i2c.h>
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
> @@ -741,6 +742,7 @@ static int zforce_probe(struct i2c_client *client,
>  	struct zforce_ts *ts;
>  	struct input_dev *input_dev;
>  	int ret;
> +	unsigned int irq;
>  
>  	if (!pdata) {
>  		pdata = zforce_parse_dt(&client->dev);
> @@ -835,6 +837,7 @@ static int zforce_probe(struct i2c_client *client,
>  
>  	init_completion(&ts->command_done);
>  
> +	irq = client->irq;
>  	/*
>  	 * The zforce pulls the interrupt low when it has data ready.
>  	 * After it is triggered the isr thread runs until all the available
> @@ -842,7 +845,8 @@ static int zforce_probe(struct i2c_client *client,
>  	 * Therefore we can trigger the interrupt anytime it is low and do
>  	 * not need to limit it to the interrupt edge.
>  	 */
> -	ret = devm_request_threaded_irq(&client->dev, client->irq,
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);

Instead of playing with the flags should we simply request irq after we
release the reset pin?

> +	ret = devm_request_threaded_irq(&client->dev, irq,
>  					zforce_irq, zforce_irq_thread,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					input_dev->name, ts);
> @@ -855,6 +859,7 @@ static int zforce_probe(struct i2c_client *client,
>  
>  	/* let the controller boot */
>  	zforce_reset_deassert(ts);
> +	enable_irq(irq);
>  
>  	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
>  	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
> -- 
> 2.3.4
> 

Thanks.

-- 
Dmitry
