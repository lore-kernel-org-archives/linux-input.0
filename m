From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Thu, 20 Aug 2015 10:18:24 -0700
Message-ID: <20150820171824.GE12027@sirena.org.uk>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
 <55C468BC.60500@metafoo.de>
 <20150807163213.GB30852@dtor-ws>
 <20150820163301.GA12027@sirena.org.uk>
 <55D601CC.4030707@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YkJPYEFdoxh/AXLE"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:53939 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512AbbHTRSl (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 20 Aug 2015 13:18:41 -0400
Content-Disposition: inline
In-Reply-To: <55D601CC.4030707@metafoo.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org


--YkJPYEFdoxh/AXLE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 20, 2015 at 06:35:24PM +0200, Lars-Peter Clausen wrote:
> On 08/20/2015 06:33 PM, Mark Brown wrote:

> > Just discussed this in person with Dmitry: I'll apply the patch just now
> > for v4.3 and we can incrementally improve the ifdef handling after.

> Great, thanks. I was about to send a patch with the ifdefs removed tomorrow.

Oh, that'd be even better if we could get that into v4.3 instead - this
was partly given that I'd just met Dmitry and the merge window will be
opening very soon.  If you could get that patch done that'd be even
better.

--YkJPYEFdoxh/AXLE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJV1gvfAAoJECTWi3JdVIfQ+/gH+gMdODcYTXYbrOofGDcoChY+
yw+gNkjdhepxdCpJzBvi2z6WditmFxVVEJVNHYmP2M3o4Ge20Q2r64Y466fFmJ41
f0GOQxmc7NFsu0Veg4weUvlrHeQIxREMqKVGiWyw+l1qZU61T7s2ODsabOeM5EpR
Vo48CZ4zheiJzutCaC47iZ/IFNTYYQPqWQYAjggkE5bsTLNVdas94ZbUgiL1wdTi
6AU5zWvjYcEEpHKy0UdJ4wUFOZb0X0kuEYAGomrXN5BCbO4ZF5mO/k/0WkCCT8Nk
2GHWJP/REACnKNEuutMXQlkGPmVCq+rOt7OMILm5qk0aBifAr/lY+Hc3r7yKbHE=
=Uu7H
-----END PGP SIGNATURE-----

--YkJPYEFdoxh/AXLE--
