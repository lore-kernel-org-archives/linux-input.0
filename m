From: Alberto Panizzo <maramaopercheseimorto@gmail.com>
Subject: Re: [PATCH v3] input: MXC: add mxc-keypad driver to support the
 Keypad Port present in the mxc application processors family.
Date: Wed, 27 Jan 2010 13:17:30 +0100
Message-ID: <1264594650.2463.66.camel@realization>
References: <1264586106.2463.23.camel@realization>
	 <19296.5728.557535.920849@ipc1.ka-ro>
	 <20100127104537.GB17421@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.24]:6153 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751864Ab0A0MRf (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 27 Jan 2010 07:17:35 -0500
Received: by ey-out-2122.google.com with SMTP id d26so1479208eyd.19
        for <linux-input@vger.kernel.org>; Wed, 27 Jan 2010 04:17:33 -0800 (PST)
In-Reply-To: <20100127104537.GB17421@pengutronix.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Lothar =?ISO-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, H Hartley Sweeten <hartleys@visionengravers.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sascha linux-arm <s.hauer@pengutronix.de>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-input <linux-input@vger.kernel.org>

On mer, 2010-01-27 at 11:45 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hallo Alberto,
>=20
> On Wed, Jan 27, 2010 at 11:33:04AM +0100, Lothar Wa=C3=9Fmann wrote:
> > > +	keypad->clk =3D clk_get(NULL, "kpp");
> > >
> > clk_get(&pdev->dev, "kpp");
> Maybe even
>=20
> 	clk_get(&pdev->dev, NULL);
>=20

Mmm.. kpp clock is defined as:
	_REGISTER_CLOCK(NULL, "kpp", kpp_clk)

what you say should work if it would be defined as follow right?
	_REGISTER_CLOCK("mxc_keypad", "kpp", kpp_clk)

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
