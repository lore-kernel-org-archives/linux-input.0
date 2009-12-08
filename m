From: Kevin Hilman <khilman@deeprootsystems.com>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci Keyscan platform data
Date: Mon, 07 Dec 2009 16:24:59 -0800
Message-ID: <87hbs25n38.fsf@deeprootsystems.com>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f187.google.com ([209.85.210.187]:37178 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935711AbZLHAY4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 7 Dec 2009 19:24:56 -0500
Received: by yxe17 with SMTP id 17so4461484yxe.33
        for <linux-input@vger.kernel.org>; Mon, 07 Dec 2009 16:25:02 -0800 (PST)
In-Reply-To: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com> (miguel aguilar's message of "Fri\, 13 Nov 2009 13\:43\:54 -0600")
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: miguel.aguilar@ridgerun.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, santiago.nunez@ridgerun.com, todd.fischer@ridgerun.com, clark.becker@ridgerun.com

<miguel.aguilar@ridgerun.com> writes:

> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
>
> Add a function pointer in the platform data of the DaVinci Keyscan driver
> called device_enabled, in order to perform board specific actions when
> the device is initialized, like setup the PINMUX configuration.
>
> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>

Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Dmitry,

Will you be queueing this driver (and this patch) for 2.6.34?  I
thought you had accepted the original driver, but I don't see it in
the master or next branch of your input tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input.git

Thanks or clarifying.

Kevin


> ---
>  arch/arm/mach-davinci/include/mach/keyscan.h |    1 +
>  drivers/input/keyboard/davinci_keyscan.c     |    8 ++++++++
>  2 files changed, 9 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mach-davinci/include/mach/keyscan.h b/arch/arm/mach-davinci/include/mach/keyscan.h
> index b4e21a2..7a560e0 100644
> --- a/arch/arm/mach-davinci/include/mach/keyscan.h
> +++ b/arch/arm/mach-davinci/include/mach/keyscan.h
> @@ -29,6 +29,7 @@ enum davinci_matrix_types {
>  };
>  
>  struct davinci_ks_platform_data {
> +	int		(*device_enable)(struct device *dev);
>  	unsigned short	*keymap;
>  	u32		keymapsize;
>  	u8		rep:1;
> diff --git a/drivers/input/keyboard/davinci_keyscan.c b/drivers/input/keyboard/davinci_keyscan.c
> index 6e52d85..d410d7a 100644
> --- a/drivers/input/keyboard/davinci_keyscan.c
> +++ b/drivers/input/keyboard/davinci_keyscan.c
> @@ -174,6 +174,14 @@ static int __init davinci_ks_probe(struct platform_device *pdev)
>  	struct davinci_ks_platform_data *pdata = pdev->dev.platform_data;
>  	int error, i;
>  
> +	if (pdata->device_enable) {
> +		error = pdata->device_enable(dev);
> +		if (error < 0) {
> +			dev_dbg(dev, "device enable function failed\n");
> +			return error;
> +		}
> +	}
> +
>  	if (!pdata->keymap) {
>  		dev_dbg(dev, "no keymap from pdata\n");
>  		return -EINVAL;
> -- 
> 1.6.0.4
>
>
> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
