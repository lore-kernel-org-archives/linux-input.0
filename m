From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: zforce_ts - use devm_add_action_or_reset()
Date: Wed, 6 Jul 2016 11:00:35 -0700
Message-ID: <20160706180035.GE5447@dtor-ws>
References: <1467578926-32297-1-git-send-email-sudipm.mukherjee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35551 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932298AbcGFSAo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 6 Jul 2016 14:00:44 -0400
Content-Disposition: inline
In-Reply-To: <1467578926-32297-1-git-send-email-sudipm.mukherjee@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org

On Sun, Jul 03, 2016 at 09:48:46PM +0100, Sudip Mukherjee wrote:
> If devm_add_action() fails we are explicitly calling the cleanup to free
> the resources allocated.  Lets use the helper devm_add_action_or_reset()
> and return directly in case of error, as we know that the cleanup function
> has been already called by the helper if there was any error.
> 
> Signed-off-by: Sudip Mukherjee <sudip.mukherjee@codethink.co.uk>

This seems reasonable, I'll apply, thank you.

> ---
>  drivers/input/touchscreen/zforce_ts.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c b/drivers/input/touchscreen/zforce_ts.c
> index 7b3845a..6053e31 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -820,15 +820,12 @@ static int zforce_probe(struct i2c_client *client,
>  		udelay(100);
>  	}
>  
> -	ret = devm_add_action(&client->dev, zforce_reset, ts);
> +	ret = devm_add_action_or_reset(&client->dev, zforce_reset, ts);
>  	if (ret) {
>  		dev_err(&client->dev, "failed to register reset action, %d\n",
>  			ret);
>  
>  		/* hereafter the regulator will be disabled by the action */
> -		if (!IS_ERR(ts->reg_vdd))
> -			regulator_disable(ts->reg_vdd);
> -
>  		return ret;
>  	}
>  
> -- 
> 1.9.1
> 

-- 
Dmitry
