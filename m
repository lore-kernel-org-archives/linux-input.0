From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 5/6] input: egalax_ts: Fix module autoload for OF
 platform driver
Date: Thu, 3 Sep 2015 10:53:14 -0700
Message-ID: <20150903175314.GG19537@dtor-ws>
References: <20150829104857.GA20914@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:35382 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbICRxR (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:53:17 -0400
Content-Disposition: inline
In-Reply-To: <20150829104857.GA20914@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Sat, Aug 29, 2015 at 12:48:57PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>

I already applied patch form Javier Martinez Canillas doing this.

> ---
>  drivers/input/touchscreen/egalax_ts.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/egalax_ts.c b/drivers/input/touchscreen/egalax_ts.c
> index 4c56299..7229858 100644
> --- a/drivers/input/touchscreen/egalax_ts.c
> +++ b/drivers/input/touchscreen/egalax_ts.c
> @@ -264,6 +264,7 @@ static const struct of_device_id egalax_ts_dt_ids[] = {
>  	{ .compatible = "eeti,egalax_ts" },
>  	{ /* sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, egalax_ts_dt_ids);
>  
>  static struct i2c_driver egalax_ts_driver = {
>  	.driver = {
> -- 
> 2.4.6
> 

-- 
Dmitry
