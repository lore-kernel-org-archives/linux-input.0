From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH V7 5/7] regulator: da9061: BUCK and LDO regulator
 driver
Date: Wed, 7 Jun 2017 16:42:06 +0100
Message-ID: <20170607154206.3mcozi3fmue3dsuw@sirena.org.uk>
References: <cover.1496823229.git.stwiss.opensource@diasemi.com>
 <cb544b5c855ded286f2d0c824eb864630495c984.1496823229.git.stwiss.opensource@diasemi.com>
 <20170607094159.uua5zxmeq2z4zrbu@sirena.org.uk>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD927CE@SW-EX-MBX02.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="6zbzl4qxu3yjdd5b"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:44444 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751382AbdFGPmW (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Wed, 7 Jun 2017 11:42:22 -0400
Content-Disposition: inline
In-Reply-To: <6ED8E3B22081A4459DAC7699F3695FB7018CD927CE@SW-EX-MBX02.diasemi.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Steve Twiss <stwiss.opensource@diasemi.com>
Cc: LINUX-KERNEL <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, DEVICETREE <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Eduardo Valentin <edubezval@gmail.com>, Guenter Roeck <linux@roeck-us.net>, LINUX-INPUT <linux-input@vger.kernel.org>, LINUX-PM <linux-pm@vger.kernel.org>, LINUX-WATCHDOG <linux-watchdog@vger.kernel.org>, Lee Jones <lee.jones@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Rob Herring <robh+dt@kernel.org>, Support Opensource <Support.Opensource@diasemi.com>, Wim Van Sebroeck <wim@iguana.be>, Zhang Rui <rui.zhang@intel.com>


--6zbzl4qxu3yjdd5b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 07, 2017 at 02:09:56PM +0000, Steve Twiss wrote:
> On 07 June 2017 10:42, Mark Brown wrote:

> > I'm missing the other patches in this series and the cover letter, what
> > are the dependencies here?

> My apologies Mark. I didn't re-send the cover letter because this regulator
> patch is the last one and I assumed it would not add anything.
> Am I confusing you here by not renaming the patch and leaving its subject
> as [PATCH V7 5/7]?

Yes, you are confusing things.  You're missing the point of numbering
patches in a series, it's so that when working with a set of patches
that have been posted pople know what order to apply them in.  The
numbering only means anything in a given posting of the series, if
something is resent it doesn't matter if it was posted before the
numbering should reflect what's being posted at the current time.

--6zbzl4qxu3yjdd5b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlk4Hs0ACgkQJNaLcl1U
h9B5bwf/ZvvJ7ZHtR06N+uGqYWwXGhMkm/l4SADXZQup2IxJr/zOcGaV1a2Q3dHj
n/9/wX5Cbmp3aw79Hz/3hhWbTM17gETkVevozvWv5tWNFdt7JFosEeP62qHe+qYs
KvSxRBZUH4WxIfgJ6/UStPFRm0pvfBciavdREAjh0p6ff3Hw8BZr8ZLc5Ze8vbWY
J3vTaRXCGSeEN6alblId9rqvcjrD4qXBwEOR5Dpt29+KSlz/ZPpmKnxW9/XuHmIB
RapDAnPLI1+pev8UwmTXKeDOgDffOLbVm3aUF3J7fmjJtuwDwX6NY/wfF24NyvCk
oklcZx1xq55c0vrVPb0KVDgeu0KfZQ==
=wYEq
-----END PGP SIGNATURE-----

--6zbzl4qxu3yjdd5b--
