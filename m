From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] Input: drv260x/drv2665/drv2667 - Constify reg_default
 tables
Date: Wed, 8 Jul 2015 08:26:25 -0700
Message-ID: <20150708152625.GB40116@dtor-ws>
References: <1436230899.10336.2.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33544 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758270AbbGHP0a (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 8 Jul 2015 11:26:30 -0400
Received: by ieru20 with SMTP id u20so14455607ier.0
        for <linux-input@vger.kernel.org>; Wed, 08 Jul 2015 08:26:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1436230899.10336.2.camel@ingics.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Axel Lin <axel.lin@ingics.com>
Cc: Dan Murphy <dmurphy@ti.com>, linux-input@vger.kernel.org

On Tue, Jul 07, 2015 at 09:01:39AM +0800, Axel Lin wrote:
> These reg_default tables are not modified after initialized, so make them
> const.
> 
> Signed-off-by: Axel Lin <axel.lin@ingics.com>

Applied, thank you.

> ---
>  drivers/input/misc/drv260x.c | 2 +-
>  drivers/input/misc/drv2665.c | 2 +-
>  drivers/input/misc/drv2667.c | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/input/misc/drv260x.c b/drivers/input/misc/drv260x.c
> index e5d60ec..0e3af55 100644
> --- a/drivers/input/misc/drv260x.c
> +++ b/drivers/input/misc/drv260x.c
> @@ -204,7 +204,7 @@ struct drv260x_data {
>  	int overdrive_voltage;
>  };
>  
> -static struct reg_default drv260x_reg_defs[] = {
> +static const struct reg_default drv260x_reg_defs[] = {
>  	{ DRV260X_STATUS, 0xe0 },
>  	{ DRV260X_MODE, 0x40 },
>  	{ DRV260X_RT_PB_IN, 0x00 },
> diff --git a/drivers/input/misc/drv2665.c b/drivers/input/misc/drv2665.c
> index 0afaa33..e9501fd 100644
> --- a/drivers/input/misc/drv2665.c
> +++ b/drivers/input/misc/drv2665.c
> @@ -74,7 +74,7 @@ static const u8 drv2665_sine_wave_form[] = {
>  	0x9b, 0x9f, 0xa5, 0xad, 0xb8, 0xc4, 0xd2, 0xe0, 0xf0, 0x00,
>  };
>  
> -static struct reg_default drv2665_reg_defs[] = {
> +static const struct reg_default drv2665_reg_defs[] = {
>  	{ DRV2665_STATUS, 0x02 },
>  	{ DRV2665_CTRL_1, 0x28 },
>  	{ DRV2665_CTRL_2, 0x40 },
> diff --git a/drivers/input/misc/drv2667.c b/drivers/input/misc/drv2667.c
> index fc0fddf..a231342 100644
> --- a/drivers/input/misc/drv2667.c
> +++ b/drivers/input/misc/drv2667.c
> @@ -116,7 +116,7 @@ struct drv2667_data {
>  	u32 frequency;
>  };
>  
> -static struct reg_default drv2667_reg_defs[] = {
> +static const struct reg_default drv2667_reg_defs[] = {
>  	{ DRV2667_STATUS, 0x02 },
>  	{ DRV2667_CTRL_1, 0x28 },
>  	{ DRV2667_CTRL_2, 0x40 },
> -- 
> 2.1.0
> 
> 
> 

-- 
Dmitry
