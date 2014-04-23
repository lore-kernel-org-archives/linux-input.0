From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] Input: ads7877: Remove bitrotted comment
Date: Wed, 23 Apr 2014 11:16:23 +0100
Message-ID: <20140423101623.GL12304@sirena.org.uk>
References: <1398201501-13470-1-git-send-email-broonie@kernel.org>
 <20140423003928.GB22547@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZO1v73zIZGP5oL2q"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:42501 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752819AbaDWKQj (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 23 Apr 2014 06:16:39 -0400
Content-Disposition: inline
In-Reply-To: <20140423003928.GB22547@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org


--ZO1v73zIZGP5oL2q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 22, 2014 at 05:39:28PM -0700, Dmitry Torokhov wrote:
> On Tue, Apr 22, 2014 at 10:18:21PM +0100, Mark Brown wrote:

> > Remove the bitrotted comment, though in actual fact the use case mentioned
> > is a great use for spi_async() since it would cut down on latency handling
> > the interrupt by saving us a context switch before we start SPI.

> > This was previously implemented, it was removed in commit b534422b2d11
> > (Input: ad7877 - switch to using threaded IRQ) for code complexity reasons.
> > It may be better to revert that commit instead.

> Hmm, maybe.. although I think original would cause device 'stuck' if
> call to spi_async() fails, so probably not a straight revert...

Probably best just to apply this, then - someone can always reimplement
if they need to.

--ZO1v73zIZGP5oL2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTV5L0AAoJELSic+t+oim9trEP/iDeF9eX25c/uGi7DJshTn+7
FIh1Dx3rg4XWASBYlAq0MFUDGYUoMWrhxyXSdL32/vo5Iy3EelaXXjGlMiXlPF++
LDEy+j9ysJs7S5HoucdoM2WRmHvv6ihHAbOeXJEYFl4ZNDrF0dvG75FLDijNTimL
kX0Bvm90OyFqJlnLU6sye/N1EzVUF18j9+9DDISVA3/eNK9pAaSnUso0mE2MCk4x
rcw1nrgSGCi/tRiqsxjQwkOSHm6YwyxygHebqjyOou95+gOBi7RPJGHRLazSollQ
HsrPU/rCwVyoDipXmrUFHz4zLKPjCwB205yIVhRhTL5DTw8jGWEoHEU/IWHyVu2h
RgiBiAvVEvSPsBg+Yt6qNc82AcnRSDM31h0HCcNKim9ahJzwKbgLwI+A1dOhImCQ
F1LKKCBHeE9kHyQY4cPsTJNLc/WCMv+ruF5yX1h5f02QaxFAe3G01j4Xd+xo95tH
B1qtceuyejZiDWD6jMQjMtJd5rXteHOp7CFet8qv64+2Z7y8C8HqYKvOPmDA3IPi
PdU52A3w55YneF6AovmtJIYMyb/II3vT3kccCdNtMyXuUCA/kXPxbgU27xMK6e/t
/YcE0ySEyavpsrOOnpWHhuzXISMGbdiP5ovgXWBcuiCjJwdHmw9dHfgmEGL31TRO
hCWuMjkBLr+AOMzCmG2H
=Rn0T
-----END PGP SIGNATURE-----

--ZO1v73zIZGP5oL2q--
