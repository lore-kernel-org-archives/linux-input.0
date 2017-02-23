From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 3/3] Input: qt1070 - Add OF device ID table
Date: Thu, 23 Feb 2017 00:25:24 -0800
Message-ID: <20170223082524.GB18639@dtor-ws>
References: <20170221181254.14748-1-javier@osg.samsung.com>
 <20170221181254.14748-3-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36646 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751119AbdBWIZ1 (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 23 Feb 2017 03:25:27 -0500
Content-Disposition: inline
In-Reply-To: <20170221181254.14748-3-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Rob Herring <robh+dt@kernel.org>

On Tue, Feb 21, 2017 at 03:12:54PM -0300, Javier Martinez Canillas wrote:
> The driver doesn't have a struct of_device_id table but supported devices
> are registered via Device Trees. This is working on the assumption that a
> I2C device registered via OF will always match a legacy I2C device ID and
> that the MODALIAS reported will always be of the form i2c:<device>.
> 
> But this could change in the future so the correct approach is to have an
> OF device ID table if the devices are registered via OF.
> 
> The compatible strings don't have a vendor prefix because that's how it's
> used currently, and changing this will be a Device Tree ABI break.

Are you saying that all legacy I2C names now form DT ABI? Even for
drivers that do not have of_match_table or OF MODULE_DEVICE_TABLE not
binding documentation?

I think this is a bit too much.

> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
> ---
> 
>  drivers/input/keyboard/qt1070.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/keyboard/qt1070.c b/drivers/input/keyboard/qt1070.c
> index 5a5778729e37..76bb51309a78 100644
> --- a/drivers/input/keyboard/qt1070.c
> +++ b/drivers/input/keyboard/qt1070.c
> @@ -274,9 +274,18 @@ static const struct i2c_device_id qt1070_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, qt1070_id);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id qt1070_of_match[] = {
> +	{ .compatible = "qt1070", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, qt1070_of_match);
> +#endif
> +
>  static struct i2c_driver qt1070_driver = {
>  	.driver	= {
>  		.name	= "qt1070",
> +		.of_match_table = of_match_ptr(qt1070_of_match),
>  		.pm	= &qt1070_pm_ops,
>  	},
>  	.id_table	= qt1070_id,
> -- 
> 2.9.3
> 

-- 
Dmitry
