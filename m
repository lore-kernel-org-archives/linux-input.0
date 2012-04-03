From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input/tps6507x-ts: fix MODULE_ALIAS to match driver name
Date: Tue, 3 Apr 2012 09:51:15 -0700
Message-ID: <20120403165114.GE24832@core.coreip.homeip.net>
References: <1333463051-29986-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:39307 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864Ab2DCQvV (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 3 Apr 2012 12:51:21 -0400
Received: by pbcun15 with SMTP id un15so89481pbc.19
        for <linux-input@vger.kernel.org>; Tue, 03 Apr 2012 09:51:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1333463051-29986-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, Todd Fischer <todd.fischer@ridgerun.com>

On Tue, Apr 03, 2012 at 04:24:11PM +0200, Uwe Kleine-K=F6nig wrote:
> This is needed to make module auto loading work.
>=20
> Cc: Todd Fischer <todd.fischer@ridgerun.com>
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Applied, thank you.

> ---
>  drivers/input/touchscreen/tps6507x-ts.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/touchscreen/tps6507x-ts.c b/drivers/input/=
touchscreen/tps6507x-ts.c
> index 6c6f6d8..da2cb08 100644
> --- a/drivers/input/touchscreen/tps6507x-ts.c
> +++ b/drivers/input/touchscreen/tps6507x-ts.c
> @@ -376,4 +376,4 @@ module_platform_driver(tps6507x_ts_driver);
>  MODULE_AUTHOR("Todd Fischer <todd.fischer@ridgerun.com>");
>  MODULE_DESCRIPTION("TPS6507x - TouchScreen driver");
>  MODULE_LICENSE("GPL v2");
> -MODULE_ALIAS("platform:tps6507x-tsc");
> +MODULE_ALIAS("platform:tps6507x-ts");
> --=20
> 1.7.9.5
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
