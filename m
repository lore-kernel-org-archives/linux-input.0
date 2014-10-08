From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/2] input: cros_ec_keyb: Add of match table
Date: Wed, 8 Oct 2014 11:39:51 -0700
Message-ID: <20141008183951.GG14423@dtor-ws>
References: <1411114093-3505-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <1411114093-3505-3-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50911 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750979AbaJHSj4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Oct 2014 14:39:56 -0400
Content-Disposition: inline
In-Reply-To: <1411114093-3505-3-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
Cc: Lee Jones <lee.jones@linaro.org>, Wolfram Sang <wsa@the-dreams.de>, Doug Anderson <dianders@chromium.org>, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, linux-i2c@vger.kernel.org, linux-input@vger.kernel.org

On Fri, Sep 19, 2014 at 10:08:13AM +0200, Sjoerd Simons wrote:
> To enable the cros_ec_keyb driver to be auto-loaded when build as
> module add an of match table (and export it) to match the modalias
> information passed on to userspace as the Cros EC MFD driver registers
> the MFD subdevices with an of_compatibility string.
> 
> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>

Applied, thank you.

> ---
>  Changes in v2: Fixed some indentation issues
> 
>  drivers/input/keyboard/cros_ec_keyb.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/drivers/input/keyboard/cros_ec_keyb.c b/drivers/input/keyboard/cros_ec_keyb.c
> index 791781a..e1903ec 100644
> --- a/drivers/input/keyboard/cros_ec_keyb.c
> +++ b/drivers/input/keyboard/cros_ec_keyb.c
> @@ -342,10 +342,19 @@ static int cros_ec_keyb_resume(struct device *dev)
>  
>  static SIMPLE_DEV_PM_OPS(cros_ec_keyb_pm_ops, NULL, cros_ec_keyb_resume);
>  
> +#ifdef CONFIG_OF
> +static const struct of_device_id cros_ec_keyb_of_match[] = {
> +	{ .compatible = "google,cros-ec-keyb" },
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, cros_ec_keyb_of_match);
> +#endif
> +
>  static struct platform_driver cros_ec_keyb_driver = {
>  	.probe = cros_ec_keyb_probe,
>  	.driver = {
>  		.name = "cros-ec-keyb",
> +		.of_match_table = of_match_ptr(cros_ec_keyb_of_match),
>  		.pm	= &cros_ec_keyb_pm_ops,
>  	},
>  };
> -- 
> 2.1.0
> 

-- 
Dmitry
