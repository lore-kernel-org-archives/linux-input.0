From: Nick Dyer <nick.dyer@itdev.co.uk>
Subject: Re: [PATCH] Revert "Input: atmel_mxt_ts - disable interrupt for 50ms
 after reset"
Date: Fri, 8 Apr 2016 10:10:06 +0100
Message-ID: <5707756E.30506@itdev.co.uk>
References: <1460069545-10322-1-git-send-email-trini@konsulko.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from zencphosting06.zen.co.uk ([82.71.204.9]:45819 "EHLO
	zencphosting06.zen.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbcDHJKI (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 Apr 2016 05:10:08 -0400
In-Reply-To: <1460069545-10322-1-git-send-email-trini@konsulko.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tom Rini <trini@konsulko.com>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Olof Johansson <olof@lixom.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Henrik Rydberg <rydberg@bitmath.org>

On 2016-04-07 23:52, Tom Rini wrote:
> This reverts commit 885f3fb9fa1f9e185e8a4e905157087495734349 due to this
> change breaking the touchpad on the Chromebook Pixel 2015 on resume from
> sleep or warm resets.
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Nick Dyer <nick.dyer@itdev.co.uk>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: Henrik Rydberg <rydberg@bitmath.org>
> Signed-off-by: Tom Rini <trini@konsulko.com>

Hi Tom-

Sorry that this has caused a problem. I suggest we try and find a 3rd
option other than reverting this patch, because otherwise we will cause
problems on other platforms.

I have a Pixel 2 here - can you advise how to reproduce?

> ---
>  drivers/input/touchscreen/atmel_mxt_ts.c |    9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/atmel_mxt_ts.c b/drivers/input/touchscreen/atmel_mxt_ts.c
> index 2160512..9b92b60 100644
> --- a/drivers/input/touchscreen/atmel_mxt_ts.c
> +++ b/drivers/input/touchscreen/atmel_mxt_ts.c
> @@ -1098,9 +1098,7 @@ static int mxt_soft_reset(struct mxt_data *data)
>  	struct device *dev = &data->client->dev;
>  	int ret = 0;
>  
> -	dev_info(dev, "Resetting device\n");
> -
> -	disable_irq(data->irq);
> +	dev_info(dev, "Resetting chip\n");
>  
>  	reinit_completion(&data->reset_completion);
>  
> @@ -1108,11 +1106,6 @@ static int mxt_soft_reset(struct mxt_data *data)
>  	if (ret)
>  		return ret;
>  
> -	/* Ignore CHG line for 100ms after reset */
> -	msleep(100);
> -
> -	enable_irq(data->irq);

I suspect what is going on here is that Pixel 2 is using edge triggering
and we are missing the edge during the 100ms delay. Could you try just
changing this from "enable_irq" to
 mxt_acquire_irq(data);

> -
>  	ret = mxt_wait_for_completion(data, &data->reset_completion,
>  				      MXT_RESET_TIMEOUT);
>  	if (ret)
> 
