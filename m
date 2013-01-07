From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: touchscreen: mc13783_ts.c: Convert to platform
 driver
Date: Mon, 7 Jan 2013 12:50:10 -0800
Message-ID: <20130107205010.GA24637@core.coreip.homeip.net>
References: <1357590777-7498-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f46.google.com ([209.85.220.46]:39753 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300Ab3AGUuP (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Jan 2013 15:50:15 -0500
Received: by mail-pa0-f46.google.com with SMTP id bh2so10900079pad.5
        for <linux-input@vger.kernel.org>; Mon, 07 Jan 2013 12:50:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1357590777-7498-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: s.hauer@pengutronix.de, linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

Hi Fabio,

On Mon, Jan 07, 2013 at 06:32:57PM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using module_platform_driver() can make the code smaller and cleaner.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
>  drivers/input/touchscreen/mc13783_ts.c |   13 ++-----------
>  1 file changed, 2 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/touchscreen/mc13783_ts.c
> index 02103b6..e881c25 100644
> --- a/drivers/input/touchscreen/mc13783_ts.c
> +++ b/drivers/input/touchscreen/mc13783_ts.c
> @@ -243,6 +243,7 @@ static int mc13783_ts_remove(struct platform_device *pdev)
>  }
>  
>  static struct platform_driver mc13783_ts_driver = {
> +	.probe		= mc13783_ts_probe,
>  	.remove		= mc13783_ts_remove,
>  	.driver		= {
>  		.owner	= THIS_MODULE,
> @@ -250,17 +251,7 @@ static struct platform_driver mc13783_ts_driver = {
>  	},
>  };
>  
> -static int __init mc13783_ts_init(void)
> -{
> -	return platform_driver_probe(&mc13783_ts_driver, &mc13783_ts_probe);
> -}
> -module_init(mc13783_ts_init);
> -
> -static void __exit mc13783_ts_exit(void)
> -{
> -	platform_driver_unregister(&mc13783_ts_driver);
> -}
> -module_exit(mc13783_ts_exit);
> +module_platform_driver(mc13783_ts_driver);

This is not equivalent transformation. Did you intend to change the
behavior? If you this should be mentioned (and reasoned) in the
patch description.

Thanks.

-- 
Dmitry
