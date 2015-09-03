From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 6/6] input: mms114: Fix module autoload for OF
 platform driver
Date: Thu, 3 Sep 2015 10:54:14 -0700
Message-ID: <20150903175414.GH19537@dtor-ws>
References: <20150829105055.GA20965@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f50.google.com ([209.85.220.50]:33455 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755222AbbICRyS (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:54:18 -0400
Content-Disposition: inline
In-Reply-To: <20150829105055.GA20965@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Sat, Aug 29, 2015 at 12:50:55PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>

Already have this one as well.

> ---
> 
> Moving the MODULE_DEVICE_TABLE into the CONFIG_OF #ifdef block.
> As suggested by Dmitry Torokhov.
> 
> Thanks for the review Dmitry,
> Luis
> 
>  drivers/input/touchscreen/mms114.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/mms114.c b/drivers/input/touchscreen/mms114.c
> index 67c0d31..df778f4 100644
> --- a/drivers/input/touchscreen/mms114.c
> +++ b/drivers/input/touchscreen/mms114.c
> @@ -572,6 +572,7 @@ static const struct of_device_id mms114_dt_match[] = {
>  	{ .compatible = "melfas,mms114" },
>  	{ }
>  };
> +MODULE_DEVICE_TABLE(of, mms114_dt_match);
>  #endif
>  
>  static struct i2c_driver mms114_driver = {
> -- 
> 2.4.6
> 

-- 
Dmitry
