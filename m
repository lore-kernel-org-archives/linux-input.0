From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: zforce - remove zforce_irq
Date: Mon, 13 Jul 2015 10:11:47 -0700
Message-ID: <20150713171147.GD5039@dtor-ws>
References: <1436791779-21798-1-git-send-email-dirk.behme@de.bosch.com>
 <1436791779-21798-3-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34192 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751037AbbGMRLw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 13 Jul 2015 13:11:52 -0400
Received: by igvi1 with SMTP id i1so36333508igv.1
        for <linux-input@vger.kernel.org>; Mon, 13 Jul 2015 10:11:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436791779-21798-3-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org, Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>

On Mon, Jul 13, 2015 at 02:49:39PM +0200, Dirk Behme wrote:
> From: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> 
> zforce_irq will not be executed, since we use IRQF_ONESHOT.

? This does not make sense. Even with IRQF_ONESHOT the hard interrupt
handles does get called. See handle_irq_event_percpu().

Thanks.

> 
> Signed-off-by: Oleksij Rempel <external.Oleksij.Rempel@de.bosch.com>
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>
> ---
>  drivers/input/touchscreen/zforce_ts.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index a1889e5..96bec6a 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -477,17 +477,6 @@ static void zforce_complete(struct zforce_ts *ts, int cmd, int result)
>  	}
>  }
>  
> -static irqreturn_t zforce_irq(int irq, void *dev_id)
> -{
> -	struct zforce_ts *ts = dev_id;
> -	struct i2c_client *client = ts->client;
> -
> -	if (ts->suspended && device_may_wakeup(&client->dev))
> -		pm_wakeup_event(&client->dev, 500);
> -
> -	return IRQ_WAKE_THREAD;
> -}
> -
>  static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
>  {
>  	struct zforce_ts *ts = dev_id;
> @@ -847,7 +836,7 @@ static int zforce_probe(struct i2c_client *client,
>  	 */
>  	irq_set_status_flags(irq, IRQ_NOAUTOEN);
>  	ret = devm_request_threaded_irq(&client->dev, irq,
> -					zforce_irq, zforce_irq_thread,
> +					NULL, zforce_irq_thread,
>  					IRQF_TRIGGER_LOW | IRQF_ONESHOT,
>  					input_dev->name, ts);
>  	if (ret) {
> -- 
> 2.3.4
> 

-- 
Dmitry
