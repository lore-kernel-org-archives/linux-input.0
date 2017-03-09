From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] drivers: Remove OF dependency in drv260x driver
Date: Thu, 9 Mar 2017 09:46:31 -0800
Message-ID: <20170309174631.GB20077@dtor-ws>
References: <1489022677-52409-1-git-send-email-jkwang@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:35649 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751313AbdCISRy (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 9 Mar 2017 13:17:54 -0500
Received: by mail-pg0-f65.google.com with SMTP id g2so3126013pge.2
        for <linux-input@vger.kernel.org>; Thu, 09 Mar 2017 10:16:46 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1489022677-52409-1-git-send-email-jkwang@google.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingkui Wang <jkwang@google.com>
Cc: linux-input@vger.kernel.org

On Wed, Mar 08, 2017 at 05:24:36PM -0800, Jingkui Wang wrote:
> As the driver is using generic device properties, it should work
> properly when CONFIG_OF is turned off. This patch removes the
> ifdef CONFIGOF and make sure the driver always have of_match_table.
> 
> Signed-off-by: Jingkui Wang <jkwang@google.com>

Applied, thank you.

> ---
>  drivers/input/misc/drv260x.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index fb089d3..17eb84a 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -652,7 +652,6 @@ static const struct i2c_device_id drv260x_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, drv260x_id);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id drv260x_of_match[] = {
>  	{ .compatible = "ti,drv2604", },
>  	{ .compatible = "ti,drv2604l", },
> @@ -661,13 +660,12 @@ static const struct of_device_id drv260x_of_match[] = {
>  	{ }
>  };
>  MODULE_DEVICE_TABLE(of, drv260x_of_match);
> -#endif
>  
>  static struct i2c_driver drv260x_driver = {
>  	.probe		= drv260x_probe,
>  	.driver		= {
>  		.name	= "drv260x-haptics",
> -		.of_match_table = of_match_ptr(drv260x_of_match),
> +		.of_match_table = drv260x_of_match,
>  		.pm	= &drv260x_pm_ops,
>  	},
>  	.id_table = drv260x_id,
> -- 
> 2.6.6
> 

-- 
Dmitry
