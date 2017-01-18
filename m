From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 27/33] Input: eeti_ts - Drop unnecessary error messages
 and other changes
Date: Wed, 18 Jan 2017 11:26:44 -0800
Message-ID: <20170118192644.GD33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-28-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:34101 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752039AbdART0x (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:26:53 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-28-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 18, 2017 at 09:46:48AM -0800, Guenter Roeck wrote:
> Error messages after memory allocation failures are unnecessary and
> can be dropped.
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop unnecessary braces around conditional return statements
> - Drop error message after devm_kzalloc() failure
> - Replace 'goto l; ... l: return e;' with 'return e;'

Kept just the last part and applied, thank you.

> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  drivers/input/touchscreen/eeti_ts.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/eeti_ts.c b/drivers/input/touchscreen/eeti_ts.c
> index 09be6ced7151..de3f4a1e8416 100644
> --- a/drivers/input/touchscreen/eeti_ts.c
> +++ b/drivers/input/touchscreen/eeti_ts.c
> @@ -171,10 +171,8 @@ static int eeti_ts_probe(struct i2c_client *client,
>  	 */
>  
>  	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> -	if (!priv) {
> -		dev_err(&client->dev, "failed to allocate driver data\n");
> -		goto err0;
> -	}
> +	if (!priv)
> +		return err;
>  
>  	mutex_init(&priv->mutex);
>  	input = input_allocate_device();
> @@ -243,7 +241,6 @@ static int eeti_ts_probe(struct i2c_client *client,
>  err1:
>  	input_free_device(input);
>  	kfree(priv);
> -err0:
>  	return err;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
