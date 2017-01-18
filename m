From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 32/33] Input: sis_i2c - Drop unnecessary call to
 i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 14:27:15 -0800
Message-ID: <20170118222715.GA11881@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484771819-13761-1-git-send-email-linux@roeck-us.net>
 <1484771819-13761-3-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33277 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750717AbdARW1T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 17:27:19 -0500
Content-Disposition: inline
In-Reply-To: <1484771819-13761-3-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Mika =?iso-8859-1?Q?Penttil=E4?= <mika.penttila@nextfour.com>, Tammy Tseng <tammy_tseng@sis.com>, Yuger Yu <yuger_yu@sis.com>

On Wed, Jan 18, 2017 at 12:36:49PM -0800, Guenter Roeck wrote:
> There is no call to i2c_get_clientdata() or dev_get_drvdata().
> Drop the unnecessary call to i2c_set_clientdata().
> 
> This conversion was done automatically with coccinelle using the
> following semantic patches. The semantic patches and the scripts
> used to generate this commit log are available at
> https://github.com/groeck/coccinelle-patches
> 
> - Drop i2c_set_clientdata()
> 
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>

Applied, thank you.

> ---
>  drivers/input/touchscreen/sis_i2c.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/sis_i2c.c b/drivers/input/touchscreen/sis_i2c.c
> index 8d93f8c9a403..67c2563031d6 100644
> --- a/drivers/input/touchscreen/sis_i2c.c
> +++ b/drivers/input/touchscreen/sis_i2c.c
> @@ -316,7 +316,6 @@ static int sis_ts_probe(struct i2c_client *client,
>  		return -ENOMEM;
>  
>  	ts->client = client;
> -	i2c_set_clientdata(client, ts);
>  
>  	ts->attn_gpio = devm_gpiod_get_optional(&client->dev,
>  						"attn", GPIOD_IN);
> -- 
> 2.7.4
> 

-- 
Dmitry
