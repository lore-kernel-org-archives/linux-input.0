From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 3/6] input: regulator-haptic: Fix module autoload for
 OF platform driver
Date: Thu, 3 Sep 2015 10:50:49 -0700
Message-ID: <20150903175049.GE19537@dtor-ws>
References: <20150829104726.GA20770@goodgumbo.baconseed.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f48.google.com ([209.85.220.48]:34487 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754001AbbICRuw (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 3 Sep 2015 13:50:52 -0400
Content-Disposition: inline
In-Reply-To: <20150829104726.GA20770@goodgumbo.baconseed.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Luis de Bethencourt <luis@debethencourt.com>
Cc: linux-kernel@vger.kernel.org, Jaewon Kim <jaewon02.kim@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Fabian Frederick <fabf@skynet.be>, Axel Lin <axel.lin@ingics.com>, linux-input@vger.kernel.org, Javier Martinez Canillas <javier@osg.samsung.com>

On Sat, Aug 29, 2015 at 12:47:26PM +0200, Luis de Bethencourt wrote:
> This platform driver has a OF device ID table but the OF module
> alias information is not created so module autoloading won't work.
> 
> Signed-off-by: Luis de Bethencourt <luis@debethencourt.com>

Applied, thank you.

> ---
> 
> Better without an empty line between of_device_id and MODULE_DEVICE_TABLE.
> 
> Thanks,
> Luis
> 
>  drivers/input/misc/regulator-haptic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
> index 6bf3f10..a804705 100644
> --- a/drivers/input/misc/regulator-haptic.c
> +++ b/drivers/input/misc/regulator-haptic.c
> @@ -249,6 +249,7 @@ static const struct of_device_id regulator_haptic_dt_match[] = {
>  	{ .compatible = "regulator-haptic" },
>  	{ /* sentinel */ },
>  };
> +MODULE_DEVICE_TABLE(of, regulator_haptic_dt_match);
>  
>  static struct platform_driver regulator_haptic_driver = {
>  	.probe		= regulator_haptic_probe,
> -- 
> 2.4.6
> 

-- 
Dmitry
