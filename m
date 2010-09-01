From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: add support for PowerOn(PonKey) button on the
 AB8500 MFD
Date: Wed, 1 Sep 2010 09:51:42 -0700
Message-ID: <20100901165142.GB6908@core.coreip.homeip.net>
References: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:50688 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755968Ab0IAQvt (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 1 Sep 2010 12:51:49 -0400
Received: by qwh6 with SMTP id 6so6536954qwh.19
        for <linux-input@vger.kernel.org>; Wed, 01 Sep 2010 09:51:49 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1283326551-13751-1-git-send-email-sundar.iyer@stericsson.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sundar Iyer <sundar.iyer@stericsson.com>
Cc: sameo@linux.intel.com, linux-input@vger.kernel.org, STEricsson_nomadik_linux@list.st.com

Hi Sundar,

On Wed, Sep 01, 2010 at 01:05:51PM +0530, Sundar Iyer wrote:
> From: Sundar R Iyer <sundar.iyer@stericsson.com>
> 
> Add the PowerOn(PonKey) button support to detect power on/off events
> 
> Acked-by: Linus Walleij <linus.walleij@stericsson.com>
> Signed-off-by: Sundar R Iyer <sundar.iyer@stericsson.com>
> ---
>  drivers/input/misc/Kconfig         |    7 ++
>  drivers/input/misc/Makefile        |    2 +-
>  drivers/input/misc/ab8500-ponkey.c |  156 ++++++++++++++++++++++++++++++++++++
>  drivers/mfd/ab8500-core.c          |   20 +++++
>  4 files changed, 184 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/input/misc/ab8500-ponkey.c
> 
> diff --git a/drivers/input/misc/Kconfig b/drivers/input/misc/Kconfig
> index b49e233..cab376c 100644
> --- a/drivers/input/misc/Kconfig
> +++ b/drivers/input/misc/Kconfig
> @@ -22,6 +22,13 @@ config INPUT_88PM860X_ONKEY
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called 88pm860x_onkey.
>  
> +config INPUT_AB8500_PONKEY
> +	bool "AB8500 Pon(PowerOn) Key"

Why not tristate?

> +	depends on AB8500_CORE
> +	help
> +	  Say Y here to use the PowerOn Key for ST-Ericsson's AB8500
> +	  Mix-Sig PMIC
> +
> +
> +	ret = request_threaded_irq(info->irq_dbf, NULL, ab8500_ponkey_handler,
> +					0, "ab8500-ponkey-dbf", info);
> +	if (ret < 0) {
> +		dev_err(ab8500->dev, "Failed to request dbf IRQ#%d: %d\n",
> +				info->irq_dbf, ret);
> +		goto out_unregisterdevice;
> +	}
> +
> +	ret = request_threaded_irq(info->irq_dbr, NULL, ab8500_ponkey_handler,
> +					0, "ab8500-ponkey-dbr", info);
> +	if (ret < 0) {
> +		dev_err(ab8500->dev, "Failed to request dbr IRQ#%d: %d\n",
> +				info->irq_dbr, ret);
> +		goto out_irq_dbf;
> +	}
> +

Why threaded IRQs? The interrupt handlers do not do _anything_ except for
passing the event up. Do you really think that starting 2 kernel threads
to handle 1 button is the best use of the resources???

I'll change it to use normal interrupts locally, no need to resubmit.

Thanks.

-- 
Dmitry
