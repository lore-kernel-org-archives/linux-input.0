From: Roland Stigge <stigge@antcom.de>
Subject: Re: PATCH 11/13] Input: lpc32xx_ts - Make of_device_id array const
Date: Wed, 07 May 2014 11:36:15 +0200
Message-ID: <5369FE8F.1030802@antcom.de>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com> <023801cf69d6$36ce6ed0$a46b4c70$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from antcom.de ([46.38.233.243]:39816 "EHLO chuck.antcom.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932261AbaEGJle (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 May 2014 05:41:34 -0400
In-Reply-To: <023801cf69d6$36ce6ed0$a46b4c70$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>, 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>
Cc: 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org

On 05/07/2014 11:24 AM, Jingoo Han wrote:
> Make of_device_id array const, because all OF functions
> handle it as const.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
> ---
>  drivers/input/touchscreen/lpc32xx_ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/lpc32xx_ts.c b/drivers/input/touchscreen/lpc32xx_ts.c
> index 2058253..bb47d34 100644
> --- a/drivers/input/touchscreen/lpc32xx_ts.c
> +++ b/drivers/input/touchscreen/lpc32xx_ts.c
> @@ -384,7 +384,7 @@ static const struct dev_pm_ops lpc32xx_ts_pm_ops = {
>  #endif
>  
>  #ifdef CONFIG_OF
> -static struct of_device_id lpc32xx_tsc_of_match[] = {
> +static const struct of_device_id lpc32xx_tsc_of_match[] = {
>  	{ .compatible = "nxp,lpc3220-tsc", },
>  	{ },
>  };
> 

Acked-by: Roland Stigge <stigge@antcom.de>
