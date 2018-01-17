From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH v4] input: pxrc: new driver for PhoenixRC Flight
 Controller Adapter
Date: Wed, 17 Jan 2018 20:45:16 +0100
Message-ID: <20180117194516.GC10949@gmail.com>
References: <20180117190716.22380-1-marcus.folkesson@gmail.com>
 <9607d51a-4382-396c-a4bd-46bbb24ba46e@infradead.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-lf0-f68.google.com ([209.85.215.68]:41139 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750888AbeAQTpW (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 17 Jan 2018 14:45:22 -0500
Content-Disposition: inline
In-Reply-To: <9607d51a-4382-396c-a4bd-46bbb24ba46e@infradead.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Tomohiro Yoshidomi <sylph23k@gmail.com>, David Herrmann <dh.herrmann@gmail.com>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org


--mxv5cy4qt+RJ9ypb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Randy!

On Wed, Jan 17, 2018 at 11:13:43AM -0800, Randy Dunlap wrote:
> On 01/17/2018 11:07 AM, Marcus Folkesson wrote:
> > This driver let you plug in your RC controller to the adapter and
> > use it as input device in various RC simulators.
> >=20
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
>=20
> > diff --git a/drivers/input/joystick/Kconfig b/drivers/input/joystick/Kc=
onfig
> > index f3c2f6ea8b44..18ab6dafff41 100644
> > --- a/drivers/input/joystick/Kconfig
> > +++ b/drivers/input/joystick/Kconfig
> > @@ -351,4 +351,13 @@ config JOYSTICK_PSXPAD_SPI_FF
> > =20
> >  	  To drive rumble motor a dedicated power supply is required.
> > =20
> > +config JOYSTICK_PXRC
> > +	tristate "PhoenixRC Flight Controller Adapter"
> > +	depends on USB_ARCH_HAS_HCD
> > +	select USB
>=20
> Drop the (first) depends and change "select USB" to "depends on USB".
>=20
> Argh, there are lots of input/ drivers that do that.  That's bad/wrong.
> A driver should not select (enable) an entire subsystem.  If the user had
> the subsystem disabled, it should stay that way.
>=20
> Dmitry, you can expect some patches...
>=20

Hah, of course it should be "depends on" :-)
Other drivers fooled me...

Should I fix the other drivers too when I'm on it, or do you?


> > +	help
> > +	  Say Y here if you want to use the PhoenixRC Flight Controller Adapt=
er.
> > +
> > +	  To compile this driver as a module, choose M here: the
> > +	  module will be called pxrc.
> >  endif
>=20
> --=20
> ~Randy


Best regards
Marcus Folkesson

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAlpfp8YACgkQiIBOb1ld
UjLStg//fdSW3QIp4nfEJPMCabzcWNbdaGeFBQKCTEWzNIeoI/HnzVk4FSggk06e
30Kd6OZCYqkRAT3lndTTUPi2dSIZ18JOAMm1urZ8WzTnrd0x3MrPqdbzpfvIqsrf
qCbnz+NB44bo50VgG7rOE8gGk9KUMNW59h+CnvlIfE+s0jqtNQ3Lmi8ZHe0eUKQ4
1+OghVRl0kmjPfE5bQzJ5saqNruaMgjKo2tP1p0fLlFgjp+Kvk61CutNX7KS6iHr
BqvTbDN3NXpyjXa51Du7r/47D3DG2uN47rkas1p5Tc/fV2rfSByyDEZVQkWQ9Lx6
LgNykA7L47WxpHnjPn9S6EP8RmO141gIGAuTMK/smcfdBg+vTWuXRHaIDpAJBDQl
Oqh7FU/0TkZkmGvXVot+d/HjPVmUgVluj1VPIXawV9PbDDlSEoKaE0qfDPJeEbuh
PElWg2U2fKjD2jSY3QtZN6rjIOzZ3eDaWJ9WdC8zKPeFG9aOx3FI/YXbeXK6RXJ0
pQmM2dEgvUsj0ri4lIAmnTcbCRIdH9YuCZlJ3FU+CUX8z7t4o2pct/zAGFALfmwJ
n1tqJU+o5o8NlPXemUQd94yAih7vJsEizcX8bddShXV1Q7NAHjTbkFy6xjH1EN+u
TeOuI4WsWtiyvUGOz6tiYhXQqflDX05AzmWhB9IXkrmIPbT0cRg=
=X1na
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
