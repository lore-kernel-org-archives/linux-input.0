From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 02/15] GPIO: port LoCoMo gpio support from old driver
Date: Thu, 6 Nov 2014 06:03:35 +0000
Message-ID: <20141106060335.GR8509@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-3-git-send-email-dbaryshkov@gmail.com>
 <CACRpkdY7tRadod2vQfEytmw-ubaMAvr_=XTczD5bUMkqie0xkg@mail.gmail.com>
 <CALT56yOgMUA7o2dzfHph=S2zkDV4zERzMh4ishpPwpAx7Cqj6Q@mail.gmail.com>
 <CACRpkdb7v3LmOhbhQ9TPk1_bnLnpwizawW6RQvhQRLSjRewAaQ@mail.gmail.com>
 <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YttKMwf6abDJOSyE"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44395 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768AbaKFGEB (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Thu, 6 Nov 2014 01:04:01 -0500
Content-Disposition: inline
In-Reply-To: <CALT56yO9f8wzaArnmfQSDzCM3S+2oT+62anH5kbFY3WdEt_HZg@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, "linux-leds@vger.kernel.org" <linux-leds@vger.kernel.org>, "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>, "linux-fbdev@vger.kernel.org" <linux-fbdev@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Andrea Adami <andrea.adami@gmail.com>, Russell King <linux@arm.linux.org.uk>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>


--YttKMwf6abDJOSyE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 06, 2014 at 01:33:24AM +0400, Dmitry Eremin-Solenikov wrote:
> 2014-11-03 16:43 GMT+03:00 Linus Walleij <linus.walleij@linaro.org>:

> > Yes that's the point: if you use regmap mmio you get the RMW-locking
> > for free, with the regmap implementation.

> Just to be more concrete. Currently locomo_gpio_ack_irq() function uses
> one lock and one unlock for doing 3 consecutive RMW I I convert locomo
> to regmap, will that be 3 lock/unlock calls or still one? (Or maybe I'm
> trying to be over-protective here and adding more lock/unlock cycles
> won't matter that much?)

You'll get three lock/unlocks, we could add an interface for bulk
updates under one lock if it's important though.

> Next question: if I have to export regmap to several subdrivers, is it better
> to have one big regmap or to have one-map-per-driver approach?

One regmap for the physical register map which is shared between all the
users.

--YttKMwf6abDJOSyE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUWw82AAoJECTWi3JdVIfQzMAH/27/lKZbrTrd1rIoHTVxu3Pz
qQzFDvoBmssvSLHk0fMkvcx7cJ9IahKBs9EtmyM5dR3lhDIfZZi5OYTw+dmyiyVu
07BxmlnkvP7mv5HuI1VrUyfz0SeBxfAIQDsLgiwwikXZD+3eUZgjlZVuWHt3WlAM
ITH5dFFv3enp692X0hMRz9XWiFwqlW3w5SXhpqlP5h3PgWPEjIei1QNqe3H9ELBr
5Or31N42bBWSzA1FA5HzBoEbOx8D11E8RUtnhWgixmzFcKoYQmXHDPe+DJ11XCPe
9hhOpeDthhrSKUFi4M6kQxJ218uHjoWNjYsgRAIYgL2bG8dFLKSjSsAUgSXZY94=
=saoU
-----END PGP SIGNATURE-----

--YttKMwf6abDJOSyE--
