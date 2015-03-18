From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 24/35 linux-next] Input: constify of_device_id array
Date: Wed, 18 Mar 2015 09:59:40 -0700
Message-ID: <20150318165940.GC11485@dtor-ws>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-1-git-send-email-fabf@skynet.be>
 <1426535685-25996-3-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f182.google.com ([209.85.223.182]:33929 "EHLO
	mail-ie0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932923AbbCRQ7p (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Mar 2015 12:59:45 -0400
Content-Disposition: inline
In-Reply-To: <1426535685-25996-3-git-send-email-fabf@skynet.be>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org

On Mon, Mar 16, 2015 at 08:54:34PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)
> 
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Applied, thank you.

> ---
>  drivers/input/misc/palmas-pwrbutton.c   | 2 +-
>  drivers/input/misc/regulator-haptic.c   | 2 +-
>  drivers/input/misc/tps65218-pwrbutton.c | 2 +-
>  drivers/input/touchscreen/ar1021_i2c.c  | 2 +-
>  4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/input/misc/palmas-pwrbutton.c b/drivers/input/misc/palmas-pwrbutton.c
> index 1f9b5ee..1e1baed 100644
> --- a/drivers/input/misc/palmas-pwrbutton.c
> +++ b/drivers/input/misc/palmas-pwrbutton.c
> @@ -304,7 +304,7 @@ static SIMPLE_DEV_PM_OPS(palmas_pwron_pm,
>  			 palmas_pwron_suspend, palmas_pwron_resume);
>  
>  #ifdef CONFIG_OF
> -static struct of_device_id of_palmas_pwr_match[] = {
> +static const struct of_device_id of_palmas_pwr_match[] = {
>  	{ .compatible = "ti,palmas-pwrbutton" },
>  	{ },
>  };
> diff --git a/drivers/input/misc/regulator-haptic.c b/drivers/input/misc/regulator-haptic.c
> index 132eb91..6bf3f10 100644
> --- a/drivers/input/misc/regulator-haptic.c
> +++ b/drivers/input/misc/regulator-haptic.c
> @@ -245,7 +245,7 @@ static int __maybe_unused regulator_haptic_resume(struct device *dev)
>  static SIMPLE_DEV_PM_OPS(regulator_haptic_pm_ops,
>  		regulator_haptic_suspend, regulator_haptic_resume);
>  
> -static struct of_device_id regulator_haptic_dt_match[] = {
> +static const struct of_device_id regulator_haptic_dt_match[] = {
>  	{ .compatible = "regulator-haptic" },
>  	{ /* sentinel */ },
>  };
> diff --git a/drivers/input/misc/tps65218-pwrbutton.c b/drivers/input/misc/tps65218-pwrbutton.c
> index 54508dec..a39b626 100644
> --- a/drivers/input/misc/tps65218-pwrbutton.c
> +++ b/drivers/input/misc/tps65218-pwrbutton.c
> @@ -106,7 +106,7 @@ static int tps65218_pwron_probe(struct platform_device *pdev)
>  	return 0;
>  }
>  
> -static struct of_device_id of_tps65218_pwr_match[] = {
> +static const struct of_device_id of_tps65218_pwr_match[] = {
>  	{ .compatible = "ti,tps65218-pwrbutton" },
>  	{ },
>  };
> diff --git a/drivers/input/touchscreen/ar1021_i2c.c b/drivers/input/touchscreen/ar1021_i2c.c
> index ba30578..f0b954d 100644
> --- a/drivers/input/touchscreen/ar1021_i2c.c
> +++ b/drivers/input/touchscreen/ar1021_i2c.c
> @@ -157,7 +157,7 @@ static const struct i2c_device_id ar1021_i2c_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, ar1021_i2c_id);
>  
> -static struct of_device_id ar1021_i2c_of_match[] = {
> +static const struct of_device_id ar1021_i2c_of_match[] = {
>  	{ .compatible = "microchip,ar1021-i2c", },
>  	{ }
>  };
> -- 
> 2.1.0
> 

-- 
Dmitry
