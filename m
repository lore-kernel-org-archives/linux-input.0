From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] input: schedule corgi_ssp and corgi_ts to be removed
Date: Fri, 5 Feb 2010 08:51:41 +0100
Message-ID: <20100205075141.GA31903@pengutronix.de>
References: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:33858 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754094Ab0BEHvo (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Feb 2010 02:51:44 -0500
Content-Disposition: inline
In-Reply-To: <f17812d71002041645n15e502a3sccc76fc3f2e75c76@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Eric Miao <eric.y.miao@gmail.com>
Cc: linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input@vger.kernel.org, Richard Purdie <rpurdie@rpsys.net>

Hi Eric,

> diff --git a/Documentation/feature-removal-schedule.txt
> b/Documentation/feature-removal-schedule.txt
> index 5860583..e16529e 100644
> --- a/Documentation/feature-removal-schedule.txt
> +++ b/Documentation/feature-removal-schedule.txt
> @@ -554,3 +554,15 @@ Why:	We now have a generic GPIO based matrix
> keyboard driver that
>  	and so are difficult to maintain.
>  Who:	Eric Miao <eric.y.miao@gmail.com>
>=20
> +----------------------------
> +
> +What:	corgi_ssp and corgi_ts driver
> +When:	2.6.35
> +Files:	arch/arm/mach-pxa/corgi_ssp.c, drivers/input/touchscreen/corg=
i_ts.c
> +Why:	The corgi touchscreen is now deprecated in favour of the generi=
c
> +	ads7846.c driver. The noise reduction technique used in corgi_ts.c
> +	that to wait til vsync before ADC sampling is also inte grated into
> +	ads7846 driver now. Provided that the original driver is no generic
s/no /not / or s/is no/isn't/

Best regards
Uwe

> +	and difficult to maintain, will be removed later.
> +Who:	Eric Miao <eric.y.miao@gmail.com>
> +

--=20
Pengutronix e.K.                              | Uwe Kleine-K=F6nig     =
       |
Industrial Linux Solutions                    | http://www.pengutronix.=
de/  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
