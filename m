From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 2/6] input: pwm-beeper: Fix module autoload for OF
 platform driver
Date: Thu, 3 Sep 2015 10:50:06 -0700
Message-ID: <20150903175006.GD19537@dtor-ws>
References: <20150829104538.GA20677@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f45.google.com ([209.85.220.45]:35595 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbICRuJ (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:50:09 -0400
Content-Disposition: inline
In-Reply-To: <20150829104538.GA20677@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Jingoo Han <jg1.han@samsung.com>, Wolfram Sang <wsa@the-dreams.de>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Sat, Aug 29, 2015 at 12:45:38PM +0200, Luis de Bethencourt wrote:
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
>  drivers/input/misc/pwm-beeper.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-beeper.c
> index e82edf8..f2261ab 100644
> --- a/drivers/input/misc/pwm-beeper.c
> +++ b/drivers/input/misc/pwm-beeper.c
> @@ -173,6 +173,7 @@ static const struct of_device_id pwm_beeper_match[] = {
>  	{ .compatible = "pwm-beeper", },
>  	{ },
>  };
> +MODULE_DEVICE_TABLE(of, pwm_beeper_match);
>  #endif
>  
>  static struct platform_driver pwm_beeper_driver = {
> -- 
> 2.4.6
> 

-- 
Dmitry
