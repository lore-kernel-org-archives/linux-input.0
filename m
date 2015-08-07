From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ALSA: ac97: Switch to dev_pm_ops
Date: Fri, 7 Aug 2015 17:38:26 +0100
Message-ID: <20150807163826.GI10301@sirena.org.uk>
References: <1438890129-32621-1-git-send-email-lars@metafoo.de>
 <20150806225501.GA24261@dtor-ws>
 <55C468BC.60500@metafoo.de>
 <20150807133005.GG10301@sirena.org.uk>
 <20150807163029.GA30852@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ZY5CS28jBCfb727c"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:33278 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932727AbbHGQil (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 7 Aug 2015 12:38:41 -0400
Content-Disposition: inline
In-Reply-To: <20150807163029.GA30852@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.com>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com, linux-input@vger.kernel.org, alsa-devel@alsa-project.org


--ZY5CS28jBCfb727c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Aug 07, 2015 at 09:30:29AM -0700, Dmitry Torokhov wrote:
> On Fri, Aug 07, 2015 at 02:30:05PM +0100, Mark Brown wrote:

> > Indeed, a major goal of disabling PM support is to save space.

> Then maybe we should adjust dev_pm_ops definition to omit members that
> are not used if given state is not supported? We have a lot of drivers
> that are not doing silly pointer #define games.

Yeah, I've always been vaugely surprised that we don't do that.

--ZY5CS28jBCfb727c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVxN8BAAoJECTWi3JdVIfQTIIH/AzY6LpJCMNDirUHFTp9lIaP
Kyl4x8U8TvMEc9xUEnwzrw+QEERMpIFAJeiKEjO8B+iD7wNZNwJxqLW12hD32ei5
VskDuXGQ4bX8/24L3oSB0CX0NJXxaqQvkVJkksuiPZYGRULleqvEQYyCaG8t9qBI
3HjfgZeZ61wAwMS5Egmokw4XhUF9ewH8JN7QICEbmdrMdnd+CW9lFnp61/6H29/W
3E6HZ9R1Gp+8Ie2rKCwe5Wk0vQueNBPGWLUq5zR6F8YXLYKctUezcxE5l/6wVwmY
MwP3fivqb1C6OBMxbIxpjY8ZXEDpRtqzxdHFEv7bf47w+n4ZNXUfC/ytkZ1mhC8=
=AFNl
-----END PGP SIGNATURE-----

--ZY5CS28jBCfb727c--
