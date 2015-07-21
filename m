From: Dirk Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH 4/4 v2] Input: zforce - enable irq only if we are ready to
 process it
Date: Tue, 21 Jul 2015 10:47:02 +0200
Message-ID: <55AE0706.1080207@de.bosch.com>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
 <1437396997-3182-5-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp6-v.fe.bosch.de ([139.15.237.11]:60295 "EHLO
	smtp6-v.fe.bosch.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753193AbbGUIrG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jul 2015 04:47:06 -0400
In-Reply-To: <1437396997-3182-5-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On 20.07.2015 14:56, Dirk Behme wrote:
> From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
>
> If zforce is not ready to process the interrupt, the touchscreen will
> be lost forever. Make sure we enable the interrupt only if processing
> is ready.


Talking with Oleksij about the discussion in v1 of this patch I think 
the conclusion is that we can drop this patch from this series.

We'll revert this change in our local version, too, and see if it has 
any consequences. If so, we might come back, maybe with a better 
explanation, then ;)

Just for the logs, what's left open from this series are patch 2/4 and 
3/4, then.

Best regards

Dirk


> Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
> Changes in v2: No changes, just re-send
>
>   drivers/input/touchscreen/zforce_ts.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index fdd00b1..fab1bb0 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -22,6 +22,7 @@
>   #include <linux/slab.h>
>   #include <linux/input.h>
>   #include <linux/interrupt.h>
> +#include <linux/irq.h>
>   #include <linux/i2c.h>
>   #include <linux/delay.h>
>   #include <linux/gpio/consumer.h>
> @@ -755,6 +756,7 @@ static int zforce_probe(struct i2c_client *client,
>   	struct zforce_ts *ts;
>   	struct input_dev *input_dev;
>   	int ret;
> +	unsigned int irq;
>
>   	if (!pdata) {
>   		pdata = zforce_parse_dt(&client->dev);
> @@ -859,6 +861,7 @@ static int zforce_probe(struct i2c_client *client,
>
>   	init_completion(&ts->command_done);
>
> +	irq = client->irq;
>   	/*
>   	 * The zforce pulls the interrupt low when it has data ready.
>   	 * After it is triggered the isr thread runs until all the available
> @@ -866,7 +869,8 @@ static int zforce_probe(struct i2c_client *client,
>   	 * Therefore we can trigger the interrupt anytime it is low and do
>   	 * not need to limit it to the interrupt edge.
>   	 */
> -	ret = devm_request_threaded_irq(&client->dev, client->irq,
> +	irq_set_status_flags(irq, IRQ_NOAUTOEN);
> +	ret = devm_request_threaded_irq(&client->dev, irq,
>   					zforce_irq, zforce_irq_thread,
>   					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>   					input_dev->name, ts);
> @@ -879,6 +883,7 @@ static int zforce_probe(struct i2c_client *client,
>
>   	/* let the controller boot */
>   	zforce_reset_deassert(ts);
> +	enable_irq(irq);
>
>   	ts->command_waiting = NOTIFICATION_BOOTCOMPLETE;
>   	if (wait_for_completion_timeout(&ts->command_done, WAIT_TIMEOUT) == 0)
>


