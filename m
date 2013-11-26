From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: ixp4xx-beeper: don't use symbols from
 <mach/timex.h>
Date: Tue, 26 Nov 2013 10:53:07 -0800
Message-ID: <20131126185307.GA22242@core.coreip.homeip.net>
References: <1385476141-29131-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pd0-f172.google.com ([209.85.192.172]:38215 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752548Ab3KZSxM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 26 Nov 2013 13:53:12 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so8285899pdj.3
        for <linux-input@vger.kernel.org>; Tue, 26 Nov 2013 10:53:12 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1385476141-29131-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Linus Walleij <linus.walleij@linaro.org>, Arnd Bergmann <arnd@arndb.de>, linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Imre Kaloz <kaloz@openwrt.org>, kernel@pengutronix.de

On Tue, Nov 26, 2013 at 03:29:01PM +0100, Uwe Kleine-K=F6nig wrote:
> mach/timex.h is about to be dropped so don't use symbols defined in
> there. For ixp4xx there is a suitable substitute for IXP4XX_TIMER_FRE=
Q,
> i.e. a global and exported variable that holds the same value.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Please feel free to merge through soc tree.

> ---
>=20
> Hello,
>=20
> I'd like to keep that patch in a series for the arm-soc people to pul=
l that
> get's rid of <mach/timex.h>, so please don't take this patch but only=
 ack to
> keep coordinating the series as easy as possible.
>=20
> I don't know who's Ack is good enough to be counted as maintainer ack=
, so
> please point that out in your reply, too.
>=20
> Thanks
> Uwe
>=20
>  drivers/input/misc/ixp4xx-beeper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/input/misc/ixp4xx-beeper.c b/drivers/input/misc/=
ixp4xx-beeper.c
> index 17ccba8..ed8e5e8 100644
> --- a/drivers/input/misc/ixp4xx-beeper.c
> +++ b/drivers/input/misc/ixp4xx-beeper.c
> @@ -67,7 +67,7 @@ static int ixp4xx_spkr_event(struct input_dev *dev,=
 unsigned int type, unsigned
>  	}
> =20
>  	if (value > 20 && value < 32767)
> -		count =3D (IXP4XX_TIMER_FREQ / (value * 4)) - 1;
> +		count =3D (ixp4xx_timer_freq / (value * 4)) - 1;
> =20
>  	ixp4xx_spkr_control(pin, count);
> =20
> --=20
> 1.8.4.2
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
