From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: cap11xx - Remove wrong and unneeded cap11xx
 modalias
Date: Sat, 31 Jan 2015 20:21:42 -0800
Message-ID: <20150201042142.GB24292@dtor-ws>
References: <1422679082.8722.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:53344 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751222AbbBAEVr (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 23:21:47 -0500
Received: by mail-ig0-f182.google.com with SMTP id r10so10712925igi.3
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 20:21:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422679082.8722.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Matt Ranostay <mranostay@gmail.com>, Daniel Mack <daniel@zonque.org>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, Jan 31, 2015 at 12:38:02PM +0800, Axel Lin wrote:
> This is a I2C driver, so it's wrong to use platform prefix for the modalias.
> We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
> so remove the wrong and unneeded cap11xx modalias.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied, thank you.

> ---
>  drivers/input/keyboard/cap11xx.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/keyboard/cap11xx.c b/drivers/input/keyboard/cap11xx.c
> index 4f59f0b..f07461a 100644
> --- a/drivers/input/keyboard/cap11xx.c
> +++ b/drivers/input/keyboard/cap11xx.c
> @@ -370,7 +370,6 @@ static struct i2c_driver cap11xx_i2c_driver = {
>  
>  module_i2c_driver(cap11xx_i2c_driver);
>  
> -MODULE_ALIAS("platform:cap11xx");
>  MODULE_DESCRIPTION("Microchip CAP11XX driver");
>  MODULE_AUTHOR("Daniel Mack <linux@zonque.org>");
>  MODULE_LICENSE("GPL v2");
> -- 
> 1.9.1
> 
> 
> 

-- 
Dmitry
