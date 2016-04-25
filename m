From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: atmel_mxt_ts - use mxt_acquire_irq in
 mxt_soft_reset
Date: Mon, 25 Apr 2016 14:28:53 -0700
Message-ID: <20160425212853.GI26059@dtor-ws>
References: <20160408233034.GN23166@bill-the-cat>
 <1460367105-29258-1-git-send-email-nick.dyer@itdev.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36619 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933361AbcDYV25 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 25 Apr 2016 17:28:57 -0400
Content-Disposition: inline
In-Reply-To: <1460367105-29258-1-git-send-email-nick.dyer@itdev.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Nick Dyer <nick.dyer@itdev.co.uk>
Cc: Tom Rini <trini@konsulko.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Henrik Rydberg <rydberg@bitmath.org>, simon.raphael@gmail.com, Olof Johansson <olof@lixom.net>

On Mon, Apr 11, 2016 at 10:31:45AM +0100, Nick Dyer wrote:
> If using IRQF_TRIGGER_FALLING, then there is a race here: if the reset
> completes before we enable the IRQ, then CHG is already low and touch
> will be broken.
> 
> This has been seen on Chromebook Pixel 2.
> 
> A workaround is to reconfig T18 COMMSCONFIG to enable the RETRIGEN bit
> using mxt-app:
>     mxt-app -W -T18 44
>     mxt-app --backup
> 
> Tested-by: Tom Rini <trini@konsulko.com>
> Signed-off-by: Nick Dyer <nick.dyer@itdev.co.uk>

Applied, thank you.

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 2160512..5af7907 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1093,6 +1093,19 @@ static int mxt_t6_command(struct mxt_data *data, u16 cmd_offset,
>  	return 0;
>  }
>  
> +static int mxt_acquire_irq(struct mxt_data *data)
> +{
> +	int error;
> +
> +	enable_irq(data->irq);
> +
> +	error = mxt_process_messages_until_invalid(data);
> +	if (error)
> +		return error;
> +
> +	return 0;
> +}
> +
>  static int mxt_soft_reset(struct mxt_data *data)
>  {
>  	struct device *dev = &data->client->dev;
> @@ -1111,7 +1124,7 @@ static int mxt_soft_reset(struct mxt_data *data)
>  	/* Ignore CHG line for 100ms after reset */
>  	msleep(100);
>  
> -	enable_irq(data->irq);
> +	mxt_acquire_irq(data);
>  
>  	ret = mxt_wait_for_completion(data, &data->reset_completion,
>  				      MXT_RESET_TIMEOUT);
> @@ -1466,19 +1479,6 @@ release_mem:
>  	return ret;
>  }
>  
> -static int mxt_acquire_irq(struct mxt_data *data)
> -{
> -	int error;
> -
> -	enable_irq(data->irq);
> -
> -	error = mxt_process_messages_until_invalid(data);
> -	if (error)
> -		return error;
> -
> -	return 0;
> -}
> -
>  static int mxt_get_info(struct mxt_data *data)
>  {
>  	struct i2c_client *client = data->client;
> -- 
> 2.5.0
> 

-- 
Dmitry
