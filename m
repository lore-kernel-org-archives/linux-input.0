From: Daniel Mack <daniel@zonque.org>
Subject: Re: [PATCH] Input: cap11xx - Remove wrong and unneeded cap11xx modalias
Date: Sat, 31 Jan 2015 10:04:45 +0100
Message-ID: <54CC9AAD.9060403@zonque.org>
References: <1422679082.8722.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from svenfoo.org ([82.94.215.22]:54726 "EHLO mail.zonque.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752069AbbAaJOQ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 04:14:16 -0500
In-Reply-To: <1422679082.8722.1.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Matt Ranostay <mranostay@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On 01/31/2015 05:38 AM, Axel Lin wrote:
> This is a I2C driver, so it's wrong to use platform prefix for the modalias.
> We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
> so remove the wrong and unneeded cap11xx modalias.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Acked-by: Daniel Mack <linux@zonque.org>

Thanks!
Daniel


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
> 

