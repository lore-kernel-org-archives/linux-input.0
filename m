From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 1/2] Input: fsl-imx25-tcq - fix module autoload when
 registered via OF
Date: Wed, 26 Oct 2016 16:46:33 -0700
Message-ID: <20161026234633.GG27930@dtor-ws>
References: <1476460819-12809-1-git-send-email-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33179 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932887AbcJZXqg (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 26 Oct 2016 19:46:36 -0400
Content-Disposition: inline
In-Reply-To: <1476460819-12809-1-git-send-email-javier@osg.samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: linux-kernel@vger.kernel.org, Juergen Borleis <jbe@pengutronix.de>, linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, Lee Jones <lee.jones@linaro.org>, Denis Carikli <denis@eukrea.com>

On Fri, Oct 14, 2016 at 01:00:18PM -0300, Javier Martinez Canillas wrote:
> If the driver is built as a module, autoload won't work because the module
> alias information is not filled. So user-space can't match the registered
> device with the corresponding module.
> 
> Export the module alias information using the MODULE_DEVICE_TABLE() macro.
> 
> Before this patch:
> 
> $ modinfo drivers/input/touchscreen/fsl-imx25-tcq.ko | grep alias
> 
> After this patch:
> 
> $ modinfo drivers/input/touchscreen/fsl-imx25-tcq.ko | grep alias
> alias:          of:N*T*Cfsl,imx25-tcqC*
> alias:          of:N*T*Cfsl,imx25-tcq
> 
> Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

Applied, thank you.

> ---
> 
>  drivers/input/touchscreen/fsl-imx25-tcq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/input/touchscreen/fsl-imx25-tcq.c b/drivers/input/touchscreen/fsl-imx25-tcq.c
> index fe9877a6af9e..d50ee490c9cc 100644
> --- a/drivers/input/touchscreen/fsl-imx25-tcq.c
> +++ b/drivers/input/touchscreen/fsl-imx25-tcq.c
> @@ -55,6 +55,7 @@ static const struct of_device_id mx25_tcq_ids[] = {
>  	{ .compatible = "fsl,imx25-tcq", },
>  	{ /* Sentinel */ }
>  };
> +MODULE_DEVICE_TABLE(of, mx25_tcq_ids);
>  
>  #define TSC_4WIRE_PRE_INDEX 0
>  #define TSC_4WIRE_X_INDEX 1
> -- 
> 2.7.4
> 

-- 
Dmitry
