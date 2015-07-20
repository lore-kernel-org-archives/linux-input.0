From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/4] Input: zforce - don't invert the interrupt GPIO
Date: Mon, 20 Jul 2015 09:55:19 -0700
Message-ID: <20150720165519.GB30252@dtor-ws>
References: <1437396997-3182-1-git-send-email-dirk.behme@de.bosch.com>
 <1437396997-3182-2-git-send-email-dirk.behme@de.bosch.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34333 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbGTQzY (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 20 Jul 2015 12:55:24 -0400
Received: by pacan13 with SMTP id an13so104963700pac.1
        for <linux-input@vger.kernel.org>; Mon, 20 Jul 2015 09:55:23 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1437396997-3182-2-git-send-email-dirk.behme@de.bosch.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: linux-input@vger.kernel.org

On Mon, Jul 20, 2015 at 02:56:34PM +0200, Dirk Behme wrote:
> Commit 2d53809594af ("Input: zforce_ts - convert to use the gpiod
> interface") converted this driver to use the gpiod functions. These
> functions take the active low property into account, so we don't have
> to invert the result of gpiod_get_value_cansleep(). This has been
> missed in that commit. Fix it.
> 
> Signed-off-by: Dirk Behme <dirk.behme@de.bosch.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/zforce_ts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index 32749db..edf01c3 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -510,7 +510,7 @@ static irqreturn_t zforce_irq_thread(int irq, void *dev_id)
>  	if (!ts->suspending && device_may_wakeup(&client->dev))
>  		pm_stay_awake(&client->dev);
>  
> -	while (!gpiod_get_value_cansleep(ts->gpio_int)) {
> +	while (gpiod_get_value_cansleep(ts->gpio_int)) {
>  		ret = zforce_read_packet(ts, payload_buffer);
>  		if (ret < 0) {
>  			dev_err(&client->dev,
> -- 
> 2.3.4
> 

-- 
Dmitry
