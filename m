From: Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH] Input: pwm-beeper - defer pwm config if pwm can sleep
Date: Thu, 12 May 2016 14:18:52 +0200
Message-ID: <20160512121852.GB26824@ulmo.ba.sec>
References: <56C4735E.6020300@gmx.at>
 <20160222194639.GD26177@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s2ZSL+KKDSLx8OML"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36236 "EHLO
	mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbcELMS4 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 12 May 2016 08:18:56 -0400
Content-Disposition: inline
In-Reply-To: <20160222194639.GD26177@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Manfred Schlaegl <manfred.schlaegl@gmx.at>, Manfred Schlaegl <manfred.schlaegl@ginzinger.com>, Luis de Bethencourt <luis@debethencourt.com>, Olivier Sobrie <olivier@sobrie.be>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>


--s2ZSL+KKDSLx8OML
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 22, 2016 at 11:46:39AM -0800, Dmitry Torokhov wrote:
> On Wed, Feb 17, 2016 at 02:19:26PM +0100, Manfred Schlaegl wrote:
> > If the pwm can sleep defer actions to it using a worker.
> > A similar approach was used in leds-pwm (c971ff185)
> >=20
> > Trigger:
> > On a Freescale i.MX53 based board we ran into "BUG: scheduling while
> > atomic" because input_inject_event locks interrupts, but
> > imx_pwm_config_v2 sleeps.
> >=20
> > Tested on Freescale i.MX53 SoC with 4.5-rc1 and 4.1.
> >=20
> > Unmodified applicable to
> >  * 4.5-rc4
> >  * 4.4.1 (stable)
> >  * 4.3.5 (stable)
> >  * 4.1.18 (longterm)
> >=20
> > Modified applicable to
> >  * 3.18.27 (longterm)
> >=20
> > Signed-off-by: Manfred Schlaegl <manfred.schlaegl@gmx.at>
> > ---
> >  drivers/input/misc/pwm-beeper.c | 62 +++++++++++++++++++++++++++++----=
--------
> >  1 file changed, 44 insertions(+), 18 deletions(-)
> >=20
> > diff --git a/drivers/input/misc/pwm-beeper.c b/drivers/input/misc/pwm-b=
eeper.c
> > index f2261ab..c160b5e 100644
> > --- a/drivers/input/misc/pwm-beeper.c
> > +++ b/drivers/input/misc/pwm-beeper.c
> > @@ -20,21 +20,42 @@
> >  #include <linux/platform_device.h>
> >  #include <linux/pwm.h>
> >  #include <linux/slab.h>
> > +#include <linux/workqueue.h>
> > =20
> >  struct pwm_beeper {
> >  	struct input_dev *input;
> >  	struct pwm_device *pwm;
> > +	struct work_struct work;
> >  	unsigned long period;
> > +	bool can_sleep;
>=20
> I wonder if it is not better to always schedule work, regardless of
> whether PWM may sleep or not.

I agree with Dmitry. Users of the PWM API should always assume that
calls to the PWM API might sleep. Conditionalizing on pwm_can_sleep()
isn't a good idea, since that function is scheduled to be removed. In
fact it's been returning true unconditionally since v4.5, so the fast
path is dead code anyway.

Thierry

--s2ZSL+KKDSLx8OML
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJXNHSrAAoJEN0jrNd/PrOhfQEQAKjywQddoy4dbUeHk0PdxSjW
Tj8lACnO/rlBfQ95ac78e6LIO6gi7/tgLT2QGg6YwR0RTM/f3WRIt7Dz2hUXQ9EX
VZ1IsTNbcighSveAHzXYeaaZVIUTpbO3NvgBf0TJ6/GCho9AN2m1rvnvo3DpD6QR
jSniR5o4ins3gZYL9nTpf9F4KLlKb1+bgXDMA2NNLKvAlmD+rDm7ZpYdIorBtrCN
ni63xQpciCqtopbVoLzgF/99c2T7xi3b3zH3mWUaqqvJ9I+jspNtI5PeUyWpsciZ
a5/QjtEoKKL4NdKjsiuU9Ns0U97G8fuo+PL1GcfhuRGT+zPBUuzF7Dr3Urx7yEJp
kffw44X0rdw6n1IcZmz5aG9qMcIWZC2MHPfOIUzxdUpwJ5rfmXsyYxMvYNgltMpf
VNvYiP6gZuLT1xQyQqmTlh+rrfI6UMLidmtCmiMPbwHeAApY0j94zsV9kInpXljL
2MqzXz9OO2UyD0iskHt6ZTYfNdPD27z65njXB0ATndC3WyaPKWRlgRbA6fH9ZWtO
GHOfvpzK00XkDsdDibRFUI49g7w/Bs5+M2dXUZXCAQ3X8KcLHGZj1MqW29VlZwmg
buaNwoeHVVOKyiOsty8hH5H5EtRq7QrFdzZNhoTYIe7FWIlQs+WaKKCUszX2pT/S
8Gps6OyGsqyJThQS4+Kc
=1ZWR
-----END PGP SIGNATURE-----

--s2ZSL+KKDSLx8OML--
