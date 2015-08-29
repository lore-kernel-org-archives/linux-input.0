From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: max8997_haptic - Fix module alias
Date: Fri, 28 Aug 2015 17:31:06 -0700
Message-ID: <20150829003106.GC8298@dtor-ws>
References: <1440548381-4148-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:33174 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753024AbbH2AbJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 28 Aug 2015 20:31:09 -0400
Content-Disposition: inline
In-Reply-To: <1440548381-4148-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, linux-input@vger.kernel.org

On Wed, Aug 26, 2015 at 02:19:41AM +0200, Javier Martinez Canillas wrote:
> The driver is a platform driver and not a I2C driver so its modalias
> should be exported with MODULE_DEVICE_TABLE(platform,...) instead of
> MODULE_DEVICE_TABLE(i2c,...).
> 
> Also, remove the unnecessary MODULE_ALIAS("platform:max8997-haptic")
> now that the correct module alias is created.
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> 
> ---
> 
>  drivers/input/misc/max8997_haptic.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/input/misc/max8997_haptic.c b/drivers/input/misc/max8997_haptic.c
> index d0f687281339..a806ba3818f7 100644
> --- a/drivers/input/misc/max8997_haptic.c
> +++ b/drivers/input/misc/max8997_haptic.c
> @@ -394,7 +394,7 @@ static const struct platform_device_id max8997_haptic_id[] = {
>  	{ "max8997-haptic", 0 },
>  	{ },
>  };
> -MODULE_DEVICE_TABLE(i2c, max8997_haptic_id);
> +MODULE_DEVICE_TABLE(platform, max8997_haptic_id);
>  
>  static struct platform_driver max8997_haptic_driver = {
>  	.driver	= {
> @@ -407,7 +407,6 @@ static struct platform_driver max8997_haptic_driver = {
>  };
>  module_platform_driver(max8997_haptic_driver);
>  
> -MODULE_ALIAS("platform:max8997-haptic");
>  MODULE_AUTHOR("Donggeun Kim <dg77.kim@samsung.com>");
>  MODULE_DESCRIPTION("max8997_haptic driver");
>  MODULE_LICENSE("GPL");
> -- 
> 2.4.3
> 

-- 
Dmitry
