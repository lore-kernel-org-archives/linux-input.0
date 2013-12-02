From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: ads7846 - Use IS_ENABLED() macro
Date: Sun, 1 Dec 2013 22:12:39 -0800
Message-ID: <20131202061239.GA21404@core.coreip.homeip.net>
References: <1385951651-19605-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f53.google.com ([209.85.160.53]:39270 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751179Ab3LBGMm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 2 Dec 2013 01:12:42 -0500
Received: by mail-pb0-f53.google.com with SMTP id ma3so18033574pbc.26
        for <linux-input@vger.kernel.org>; Sun, 01 Dec 2013 22:12:42 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385951651-19605-1-git-send-email-festevam@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Fabio Estevam <festevam@gmail.com>
Cc: linux-input@vger.kernel.org, Fabio Estevam <fabio.estevam@freescale.com>

On Mon, Dec 02, 2013 at 12:34:11AM -0200, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Using the IS_ENABLED() macro can make the code shorter and simpler
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>

Applied, thank you.

> ---
>  drivers/input/touchscreen/ads7846.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/input/touchscreen/ads7846.c b/drivers/input/touchscreen/ads7846.c
> index ea19536..5695786 100644
> --- a/drivers/input/touchscreen/ads7846.c
> +++ b/drivers/input/touchscreen/ads7846.c
> @@ -101,7 +101,7 @@ struct ads7846 {
>  	struct spi_device	*spi;
>  	struct regulator	*reg;
>  
> -#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
> +#if IS_ENABLED(CONFIG_HWMON)
>  	struct attribute_group	*attr_group;
>  	struct device		*hwmon;
>  #endif
> @@ -421,7 +421,7 @@ static int ads7845_read12_ser(struct device *dev, unsigned command)
>  	return status;
>  }
>  
> -#if defined(CONFIG_HWMON) || defined(CONFIG_HWMON_MODULE)
> +#if IS_ENABLED(CONFIG_HWMON)
>  
>  #define SHOW(name, var, adjust) static ssize_t \
>  name ## _show(struct device *dev, struct device_attribute *attr, char *buf) \
> -- 
> 1.8.1.2
> 

-- 
Dmitry
