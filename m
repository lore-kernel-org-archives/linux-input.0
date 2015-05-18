From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=
	<u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] input: improve usage of gpiod API
Date: Mon, 18 May 2015 21:34:11 +0200
Message-ID: <20150518193411.GE28888@pengutronix.de>
References: <1424256433-8090-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:59817 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932245AbbERTeO (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Mon, 18 May 2015 15:34:14 -0400
Content-Disposition: inline
In-Reply-To: <1424256433-8090-1-git-send-email-u.kleine-koenig@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@linaro.org>

Hello Dmitry,

On Wed, Feb 18, 2015 at 11:47:13AM +0100, Uwe Kleine-K=F6nig wrote:
> Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() function=
s)
> which appeared in v3.17-rc1, the gpiod_get* functions take an additio=
nal
> parameter that allows to specify direction and initial value for
> output. Simplify drivers accordingly.
>=20
> Note that in the case of the drv260x driver error checking is more
> strict now because -ENOSYS is reported to the caller now. But this
> should only be returned if GPIOLIB is disabled which shouldn't happen=
 as
> the driver depends on GPIOLIB.
>=20
> Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
gentle ping

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig        =
    |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
