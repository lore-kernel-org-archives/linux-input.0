From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: elants_i2c: fixed wake-on-touch issue
Date: Mon, 4 Jan 2016 17:02:40 -0800
Message-ID: <20160105010240.GC11801@dtor-ws>
References: <1451890670-29705-1-git-send-email-james.chen@emc.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:33111 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753472AbcAEBCn (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 4 Jan 2016 20:02:43 -0500
Content-Disposition: inline
In-Reply-To: <1451890670-29705-1-git-send-email-james.chen@emc.com.tw>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: "james.chen" <james.chen@emc.com.tw>
Cc: Herman Lin <herman.lin@emc.com.tw>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, charliemooney@chromium.org, Jennifer Tsai <jennifer.tsai@emc.com.tw>, Scott Liu <scott.liu@emc.com.tw>

Hi James,

On Mon, Jan 04, 2016 at 02:57:50PM +0800, james.chen wrote:
> From: "james.chen" <james.chen@emc.com.tw>
> 
> Fix function of wake-on-touch on suspend/resume.
> The function of device_may_wakeup will return true if
> the device supports wake-on-touch (for example, kitty and buddy).
> So, modify the code from "if (device_may_wakeup(dev))" to
> "if (!device_may_wakeup(dev))". And adjust the condition check of
> keep_power_in_suspend (designed for minnie).
> 2016.1.4: modify retry back to retry_cnt.
> 
> Signed-off-by: james.chen <james.chen@emc.com.tw>

I already applied a version of this patch and it is in mainline.

Thanks.

> ---
>  drivers/input/touchscreen/elants_i2c.c | 29 +++++++++++++++--------------
>  1 file changed, 15 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/elants_i2c.c b/drivers/input/touchscreen/elants_i2c.c
> index 17cc20e..3739646 100644
> --- a/drivers/input/touchscreen/elants_i2c.c
> +++ b/drivers/input/touchscreen/elants_i2c.c
> @@ -1316,24 +1316,25 @@ static int __maybe_unused elants_i2c_suspend(struct device *dev)
>  
>  	disable_irq(client->irq);
>  
> -	if (device_may_wakeup(dev) || ts->keep_power_in_suspend) {
> +	if (device_may_wakeup(dev)) {
> +		/*
> +		 * The device will automatically enter idle mode
> +		 * that has reduced power consumption.
> +		 */
> +		ts->wake_irq_enabled = (enable_irq_wake(client->irq) == 0);
> +	} else if (ts->keep_power_in_suspend) {
>  		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
>  			error = elants_i2c_send(client, set_sleep_cmd,
> -						sizeof(set_sleep_cmd));
> +					sizeof(set_sleep_cmd));
>  			if (!error)
>  				break;
>  
>  			dev_err(&client->dev,
>  				"suspend command failed: %d\n", error);
>  		}
> -
> -		if (device_may_wakeup(dev))
> -			ts->wake_irq_enabled =
> -					(enable_irq_wake(client->irq) == 0);
>  	} else {
> -		elants_i2c_power_off(ts);
> +			elants_i2c_power_off(ts);
>  	}
> -
>  	return 0;
>  }
>  
> @@ -1345,13 +1346,14 @@ static int __maybe_unused elants_i2c_resume(struct device *dev)
>  	int retry_cnt;
>  	int error;
>  
> -	if (device_may_wakeup(dev) && ts->wake_irq_enabled)
> -		disable_irq_wake(client->irq);
> -
> -	if (ts->keep_power_in_suspend) {
> +	if (device_may_wakeup(dev)) {
> +		if (ts->wake_irq_enabled)
> +			disable_irq_wake(client->irq);
> +		elants_i2c_sw_reset(client);
> +	} else if (ts->keep_power_in_suspend) {
>  		for (retry_cnt = 0; retry_cnt < MAX_RETRIES; retry_cnt++) {
>  			error = elants_i2c_send(client, set_active_cmd,
> -						sizeof(set_active_cmd));
> +					sizeof(set_active_cmd));
>  			if (!error)
>  				break;
>  
> @@ -1362,7 +1364,6 @@ static int __maybe_unused elants_i2c_resume(struct device *dev)
>  		elants_i2c_power_on(ts);
>  		elants_i2c_initialize(ts);
>  	}
> -
>  	ts->state = ELAN_STATE_NORMAL;
>  	enable_irq(client->irq);
>  
> -- 
> 1.8.3.2
> 

-- 
Dmitry
