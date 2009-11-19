From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH v2 1/2] Input: Add device_enable handler to DaVinci
	Keyscan platform data
Date: Wed, 18 Nov 2009 18:59:46 -0800
Message-ID: <20091119025946.GC20172@core.coreip.homeip.net>
References: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-px0-f180.google.com ([209.85.216.180]:50628 "EHLO
	mail-px0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932347AbZKSC7n (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 18 Nov 2009 21:59:43 -0500
Received: by pxi10 with SMTP id 10so1290803pxi.33
        for <linux-input@vger.kernel.org>; Wed, 18 Nov 2009 18:59:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1258141434-18351-1-git-send-email-miguel.aguilar@ridgerun.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: miguel.aguilar@ridgerun.com
Cc: davinci-linux-open-source@linux.davincidsp.com, nsnehaprabha@ti.com, linux-input@vger.kernel.org, todd.fischer@ridgerun.com, diego.dompe@ridgerun.com, clark.becker@ridgerun.com, santiago.nunez@ridgerun.com

On Fri, Nov 13, 2009 at 01:43:54PM -0600, miguel.aguilar@ridgerun.com wrote:
> From: Miguel Aguilar <miguel.aguilar@ridgerun.com>
> 
> Add a function pointer in the platform data of the DaVinci Keyscan driver
> called device_enabled, in order to perform board specific actions when
> the device is initialized, like setup the PINMUX configuration.
> 
> Signed-off-by: Miguel Aguilar <miguel.aguilar@ridgerun.com>
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

Hi Miguel,

Does this need to live in the driver? Why can't platform code do this
for us?

Thanks.

-- 
Dmitry
