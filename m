From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 7 Aug 2015 14:30:05 +0100
Message-ID: <20150807133005.GG10301@sirena.org.uk>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
 <55C468BC.60500@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="sClP8c1IaQxyux9v"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33037 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753088AbbHGNa0 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 09:30:26 -0400
Content-Disposition: inline
In-Reply-To: <55C468BC.60500@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org


--sClP8c1IaQxyux9v
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 10:13:48AM +0200, Lars-Peter Clausen wrote:
> On 08/07/2015 12:55 AM, Dmitry Torokhov wrote:

> > Pull this out of #ifdef block and kill entire #else/endif along with
> > WM97XX_PM_OPS define: SIMPLE_DEV_PM_OPS will result in an empty
> > structure if CONFIG_PM_SLEEP is not set.

> It will create a struct dev_pm_ops full of NULLs. That's kind of
> counterproductive to removing PM related data and functions from the kernel
> if PM support is no enabled.

Indeed, a major goal of disabling PM support is to save space.

--sClP8c1IaQxyux9v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxLLcAAoJECTWi3JdVIfQFO8H/1KZH4uCaw64aYv/4EwG2bsa
XJLHCFU5ae4i72WWnw1RDE1cHW6NCm1Kw6WJC8H5WVt8tDN449XUOzq6KpaKT6hf
4dB3x/BBasMcaDzcubhFl6yrErrsgK/zrZkSVjXcOluh+36n+izkB6Zj4N22LZ4h
RV/QzS05IGUHer1CLbah2STwOUM/95UjR8navMJTFeZZ2hLxb8F7Z0M5YVAN5zb0
mYwoC1qjTAfXEMBRjVm3LNQHjU4c9kJ3yT4tbjLmGNQL2hKLLd/oIJq7yYRwxhEZ
cXph5Ss9/PAqrfeez39GBW4DmSlOr01MCQRiNWlad+6XayA7T/6X4MFV4fpDfZQ=
=pGXO
-----END PGP SIGNATURE-----

--sClP8c1IaQxyux9v--
