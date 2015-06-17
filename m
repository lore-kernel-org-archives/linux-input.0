From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] input: improve usage of gpiod API
Date: Tue, 16 Jun 2015 17:06:08 -0700
Message-ID: <20150617000608.GF17610@dtor-ws>
References: <1424256433-8090-1-git-send-email-u.kleine-koenig@pengutronix.de>
 <20150615203847.GC19996@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ig0-f181.google.com ([209.85.213.181]:34552 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915AbbFQAGM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 16 Jun 2015 20:06:12 -0400
Received: by igboe5 with SMTP id oe5so67842190igb.1
        for <linux-input@vger.kernel.org>; Tue, 16 Jun 2015 17:06:12 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150615203847.GC19996@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: linux-input@vger.kernel.org, kernel@pengutronix.de, Alexandre Courbot <acourbot@nvidia.com>, Linus Walleij <linus.walleij@linaro.org>, Mark Brown <broonie@linaro.org>

On Mon, Jun 15, 2015 at 10:38:47PM +0200, Uwe Kleine-K=F6nig wrote:
> Hello Dmitry,
>=20
> On Wed, Feb 18, 2015 at 11:47:13AM +0100, Uwe Kleine-K=F6nig wrote:
> > Since 39b2bbe3d715 (gpio: add flags argument to gpiod_get*() functi=
ons)
> > which appeared in v3.17-rc1, the gpiod_get* functions take an addit=
ional
> > parameter that allows to specify direction and initial value for
> > output. Simplify drivers accordingly.
> >=20
> > Note that in the case of the drv260x driver error checking is more
> > strict now because -ENOSYS is reported to the caller now. But this
> > should only be returned if GPIOLIB is disabled which shouldn't happ=
en as
> > the driver depends on GPIOLIB.
> >=20
> > Signed-off-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> > ---
> >  drivers/input/keyboard/clps711x-keypad.c |  7 +------
> >  drivers/input/misc/drv260x.c             | 13 ++++---------
> >  drivers/input/misc/gpio-beeper.c         |  7 +------
> >  3 files changed, 6 insertions(+), 21 deletions(-)
> are you willing to take this? I intend to make the flags parameter
> mandatory for 4.3 and so if this change doesn't make it into 4.2-rc1,
> would it be ok for you if I send it as part of the series that makes
> flags required?

Yes, I am sorry, applied now.

Thanks.

--=20
Dmitry
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
