From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/6] input: ab8500-ponkey: Fix module autoload for OF
 platform driver
Date: Thu, 3 Sep 2015 10:49:33 -0700
Message-ID: <20150903174933.GC19537@dtor-ws>
References: <20150829104351.GA20626@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33397 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbICRth (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:49:37 -0400
Content-Disposition: inline
In-Reply-To: <20150829104351.GA20626@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Sat, Aug 29, 2015 at 12:43:51PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>

Applied, thank you.

> ---
> 
> Moving the MODULE_DEVICE_TABLE into the CONFIG_OF #ifdef block.
> As suggested by Dmitry Torokhov.
> 
> Thanks,
> Luis
> 
>  drivers/input/misc/ab8500-ponkey.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/ab8500-ponkey.c b/drivers/input/misc/ab8500-ponkey.c
> index 1f7e15c..4f5ef5b 100644
> --- a/drivers/input/misc/ab8500-ponkey.c
> +++ b/drivers/input/misc/ab8500-ponkey.c
> @@ -118,6 +118,7 @@ static const struct of_device_id ab8500_ponkey_match[] = {
>  	{ .compatible = "stericsson,ab8500-ponkey", },
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, ab8500_ponkey_match);
>  #endif
>  
>  static struct platform_driver ab8500_ponkey_driver = {
> -- 
> 2.4.6
> 

-- 
Dmitry
