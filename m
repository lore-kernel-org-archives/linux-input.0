From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] Input: drv2667 - Remove wrong and unneeded
 drv2667-haptics modalias
Date: Sat, 31 Jan 2015 20:21:22 -0800
Message-ID: <20150201042122.GA24292@dtor-ws>
References: <1422681645.10152.1.camel@phoenix>
 <1422681705.10152.2.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:41721 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbbBAEV1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 31 Jan 2015 23:21:27 -0500
Received: by mail-ie0-f172.google.com with SMTP id at20so11384497iec.3
        for <linux-input@vger.kernel.org>; Sat, 31 Jan 2015 20:21:26 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1422681705.10152.2.camel@phoenix>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Dan Murphy <dmurphy@ti.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>

On Sat, Jan 31, 2015 at 01:21:45PM +0800, Axel Lin wrote:
> This is a I2C driver, so it's wrong to use platform prefix for the modalias.
> We have all needed i2c aliases coming form MODULE_DEVICE_TABLE,
> so remove the wrong and unneeded drv2667-haptics modalias.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied both, thank you.

> ---
>  drivers/input/misc/drv2667.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
> index a021744..fc0fddf 100644
> --- a/drivers/input/misc/drv2667.c
> +++ b/drivers/input/misc/drv2667.c
> @@ -492,7 +492,6 @@ static struct i2c_driver drv2667_driver = {
>  };
>  module_i2c_driver(drv2667_driver);
>  
> -MODULE_ALIAS("platform:drv2667-haptics");
>  MODULE_DESCRIPTION("TI DRV2667 haptics driver");
>  MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("Dan Murphy <dmurphy@ti.com>");
> -- 
> 1.9.1
> 
> 
> 

-- 
Dmitry
