From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 09/13] Input: auo-pixcir-ts - Make of_device_id array const
Date: Wed, 07 May 2014 11:30:13 +0200
Message-ID: <1519075.19EXHuOKvG@diego>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com> <023601cf69d5$d2f7f610$78e7e230$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:40075 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754818AbaEGJ3j (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 May 2014 05:29:39 -0400
In-Reply-To: <023601cf69d5$d2f7f610$78e7e230$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org

Am Mittwoch, 7. Mai 2014, 18:22:10 schrieb Jingoo Han:
> Make of_device_id array const, because all OF functions
> handle it as const.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/input/touchscreen/auo-pixcir-ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/auo-pixcir-ts.c
> b/drivers/input/touchscreen/auo-pixcir-ts.c index d3f9f6b..7f3c947 100644
> --- a/drivers/input/touchscreen/auo-pixcir-ts.c
> +++ b/drivers/input/touchscreen/auo-pixcir-ts.c
> @@ -679,7 +679,7 @@ static const struct i2c_device_id auo_pixcir_idtable[] =
> { MODULE_DEVICE_TABLE(i2c, auo_pixcir_idtable);
> 
>  #ifdef CONFIG_OF
> -static struct of_device_id auo_pixcir_ts_dt_idtable[] = {
> +static const struct of_device_id auo_pixcir_ts_dt_idtable[] = {
>  	{ .compatible = "auo,auo_pixcir_ts" },
>  	{},
>  };

