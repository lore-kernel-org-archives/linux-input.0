From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 16/33] Input: mma8450 - Drop unnecessary call to
 i2c_set_clientdata and other changes
Date: Wed, 18 Jan 2017 11:41:14 -0800
Message-ID: <20170118194114.GI33920@dtor-ws>
References: <1484761614-12225-1-git-send-email-linux@roeck-us.net>
 <1484761614-12225-17-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:34265 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752882AbdARTlR (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 18 Jan 2017 14:41:17 -0500
Content-Disposition: inline
In-Reply-To: <1484761614-12225-17-git-send-email-linux@roeck-us.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

On Wed, Jan 18, 2017 at 09:46:37AM -0800, Guenter Roeck wrote:
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
>  drivers/input/misc/mma8450.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/input/misc/mma8450.c b/drivers/input/misc/mma8450.c
> index 19c73574458e..b60cdea73826 100644
> --- a/drivers/input/misc/mma8450.c
> +++ b/drivers/input/misc/mma8450.c
> @@ -205,8 +205,6 @@ static int mma8450_probe(struct i2c_client *c,
>  		return err;
>  	}
>  
> -	i2c_set_clientdata(c, m);
> -
>  	return 0;
>  }
>  
> -- 
> 2.7.4
> 

-- 
Dmitry
