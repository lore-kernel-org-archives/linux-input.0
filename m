From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH 2/6] input/mc13783-ts: Don't use deprecated mc13783 API
 calls
Date: Mon, 1 Mar 2010 23:55:13 -0800
Message-ID: <20100302075513.GC17307@core.coreip.homeip.net>
References: <1267440825-14694-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <1267440825-14694-2-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-yx0-f182.google.com ([209.85.210.182]:50960 "EHLO
	mail-yx0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753478Ab0CBHzT (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 2 Mar 2010 02:55:19 -0500
Content-Disposition: inline
In-Reply-To: <1267440825-14694-2-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-input@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Luotao Fu <l.fu@pengutronix.de>

On Mon, Mar 01, 2010 at 11:53:41AM +0100, Uwe Kleine-K=F6nig wrote:
> mc13783_ackirq is deprecated, use the drop in replacement mc13783_irq=
_ack.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

I assume it will go thourgh MFD tree?

Acked-by: Dmitry Torokhov <dtor@mail.ru>

> ---
> Hello,
>=20
> note this obviously depends on patch 1/6.
>=20
> Best regards
> Uwe
>=20
>  drivers/input/touchscreen/mc13783_ts.c |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/input/touchscreen/mc13783_ts.c b/drivers/input/t=
ouchscreen/mc13783_ts.c
> index be115b3..be54fd6 100644
> --- a/drivers/input/touchscreen/mc13783_ts.c
> +++ b/drivers/input/touchscreen/mc13783_ts.c
> @@ -44,7 +44,7 @@ static irqreturn_t mc13783_ts_handler(int irq, void=
 *data)
>  {
>  	struct mc13783_ts_priv *priv =3D data;
> =20
> -	mc13783_ackirq(priv->mc13783, irq);
> +	mc13783_irq_ack(priv->mc13783, irq);
> =20
>  	/*
>  	 * Kick off reading coordinates. Note that if work happens already
> @@ -135,7 +135,7 @@ static int mc13783_ts_open(struct input_dev *dev)
> =20
>  	mc13783_lock(priv->mc13783);
> =20
> -	mc13783_ackirq(priv->mc13783, MC13783_IRQ_TS);
> +	mc13783_irq_ack(priv->mc13783, MC13783_IRQ_TS);
> =20
>  	ret =3D mc13783_irq_request(priv->mc13783, MC13783_IRQ_TS,
>  		mc13783_ts_handler, MC13783_TS_NAME, priv);
> --=20
> 1.7.0
>=20

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
