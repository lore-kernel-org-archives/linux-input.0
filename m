From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCHv5] mfd: cpcap: implement irq sense helper
Date: Mon, 10 Apr 2017 16:27:49 +0200
Message-ID: <20170410142748.jxqd65jrcz2ijp47@earth>
References: <20170329080423.ijbl4seczla2s4nm@dell>
 <20170329121820.14237-1-sre@kernel.org>
 <20170403102615.h7i53ow2dqzpxox2@dell>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="dk2jctpdm2lzmjcm"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbdDJO1y (ORCPT <rfc822;linux-input@vger.kernel.org>);
        Mon, 10 Apr 2017 10:27:54 -0400
Content-Disposition: inline
In-Reply-To: <20170403102615.h7i53ow2dqzpxox2@dell>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Tony Lindgren <tony@atomide.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, linux-input@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org


--dk2jctpdm2lzmjcm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Mon, Apr 03, 2017 at 11:26:15AM +0100, Lee Jones wrote:
> On Wed, 29 Mar 2017, Sebastian Reichel wrote:
>=20
> > CPCAP can sense if IRQ is currently set or not. This
> > functionality is required for a few subdevices, such
> > as the power button and usb phy modules.
> >=20
> > Acked-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Sebastian Reichel <sre@kernel.org>
> > ---
> > Changes since PATCHv3:
> >  - add extern to function definition
> >  - use BIT macro for mask variable
> >  - avoid magic numbers
> > Changes since PATCHv4:
> >  - rename base to irq_base
> > ---
> >  drivers/mfd/motorola-cpcap.c       | 28 ++++++++++++++++++++++++++++
> >  include/linux/mfd/motorola-cpcap.h |  2 ++
> >  2 files changed, 30 insertions(+)
>=20
> Applied, thanks.

Thanks, will you also pick up the input patch?

https://patchwork.kernel.org/patch/9637807/

-- Sebastian

--dk2jctpdm2lzmjcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAljrlmIACgkQ2O7X88g7
+poBfg//ZSpjRMZz+mYrBNoDv1MzlJbdP03h+HZhG53ciaYaDM7mdcR+IIKcZxmp
EYSBeP+9I8jBUBeAInBCOQdCc0rty5C+BmvYvu3xYjiqDpmiWkE7nEGxh6D4lhGF
zvOhkArJ2hQBP2ZIFI4zg/aDlJi1++//ces3jRnW0V+XJ4aFmFCr1Rk5nftnlEwu
s06laxGMNK22s2yj91hf69m2stuIIJmS83Mm9AZjJlvVK7ZCAL03cLI4irThsK89
XiDGqLs/chg/PHWtT9M95Iq3kbEsHHIORTc3HIN+P8BJGwbIUzcviUOg8WOstMP1
0In1BFNlKER4lENYwLsXO+09UzGQ9aVEoNvvm1ka4FDJySgGt7i91SGihQQ9AKjT
rQ7m3i9M+qSgTk1CNFL0J8ZYYHRXTjDzdU0ox3OSWZf+XRUnwHCWdD0ERrJ5HyLh
gu6Qi76HmSu13OznLCBSXzPqGvObMPFZnmZ9UH3ml5S6RRBQPraippklCulyaQmY
fjg1FQE+DMnnSEzUj21qQx04US1EO7t3AlTauxgYUSodjz9W7wfldAF/1nBPF7bp
xpMJPKvH86gm6mpSab7/zUHqKjzdD0xobWG19WcXWblWSZk4fvgTNcTpxwgFOsvF
UCckzU1zqKQ9F+VNe2a75hZYXNBe2UtPNHa4vzLSo4AeAd+JKdM=
=txJq
-----END PGP SIGNATURE-----

--dk2jctpdm2lzmjcm--
