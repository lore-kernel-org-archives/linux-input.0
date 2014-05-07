From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH 13/13] Input: zforce - Make of_device_id array const
Date: Wed, 07 May 2014 11:30:28 +0200
Message-ID: <1469911.0j9b7cZ7cd@diego>
References: <022e01cf69d4$62d1e5e0$2875b1a0$%han@samsung.com> <023a01cf69d6$6b46beb0$41d43c10$%han@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:40086 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932123AbaEGJ3z (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Wed, 7 May 2014 05:29:55 -0400
In-Reply-To: <023a01cf69d6$6b46beb0$41d43c10$%han@samsung.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jingoo Han <jg1.han@samsung.com>
Cc: 'Dmitry Torokhov' <dmitry.torokhov@gmail.com>, 'Dmitry Torokhov' <dtor@mail.ru>, linux-input@vger.kernel.org

Am Mittwoch, 7. Mai 2014, 18:26:25 schrieb Jingoo Han:
> Make of_device_id array const, because all OF functions
> handle it as const.
> 
> Signed-off-by: Jingoo Han <jg1.han@samsung.com>
Acked-by: Heiko Stuebner <heiko@sntech.de>

> ---
>  drivers/input/touchscreen/zforce_ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/input/touchscreen/zforce_ts.c
> b/drivers/input/touchscreen/zforce_ts.c index 01d30ce..feea85b 100644
> --- a/drivers/input/touchscreen/zforce_ts.c
> +++ b/drivers/input/touchscreen/zforce_ts.c
> @@ -880,7 +880,7 @@ static struct i2c_device_id zforce_idtable[] = {
>  MODULE_DEVICE_TABLE(i2c, zforce_idtable);
> 
>  #ifdef CONFIG_OF
> -static struct of_device_id zforce_dt_idtable[] = {
> +static const struct of_device_id zforce_dt_idtable[] = {
>  	{ .compatible = "neonode,zforce" },
>  	{},
>  };

