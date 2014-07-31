From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: mcs5000_ts - Remove ifdef
Date: Wed, 30 Jul 2014 23:01:23 -0700
Message-ID: <20140731060123.GA4844@core.coreip.homeip.net>
References: <1406737039-1404-1-git-send-email-festevam@gmail.com>
 <1406737039-1404-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f49.google.com ([209.85.220.49]:33969 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751499AbaGaGB1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 31 Jul 2014 02:01:27 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so2955501pad.36
        for <linux-input@vger.kernel.org>; Wed, 30 Jul 2014 23:01:27 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1406737039-1404-2-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: beomho.seo@samsung.com, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Wed, Jul 30, 2014 at 01:17:19PM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> We can annonate the suspend/resume functions with '__maybe_unused' and get rid
> of the ifdef, which makes the code smaller and simpler.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied both, thank you.

> ---
>  drivers/input/touchscreen/mcs5000_ts.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mcs5000_ts.c b/drivers/input/touchscreen/mcs5000_ts.c
> index 1fb760c..8b47e1f 100644
> --- a/drivers/input/touchscreen/mcs5000_ts.c
> +++ b/drivers/input/touchscreen/mcs5000_ts.c
> @@ -248,8 +248,7 @@ static int mcs5000_ts_probe(struct i2c_client *client,
>  	return 0;
>  }
>  
> -#ifdef CONFIG_PM_SLEEP
> -static int mcs5000_ts_suspend(struct device *dev)
> +static int __maybe_unused mcs5000_ts_suspend(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  
> @@ -259,7 +258,7 @@ static int mcs5000_ts_suspend(struct device *dev)
>  	return 0;
>  }
>  
> -static int mcs5000_ts_resume(struct device *dev)
> +static int __maybe_unused mcs5000_ts_resume(struct device *dev)
>  {
>  	struct i2c_client *client = to_i2c_client(dev);
>  	struct mcs5000_ts_data *data = i2c_get_clientdata(client);
> @@ -269,7 +268,6 @@ static int mcs5000_ts_resume(struct device *dev)
>  
>  	return 0;
>  }
> -#endif
>  
>  static SIMPLE_DEV_PM_OPS(mcs5000_ts_pm, mcs5000_ts_suspend, mcs5000_ts_resume);
>  
> -- 
> 1.9.1
> 

-- 
Dmitry
