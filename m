From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH 01/15] ASoC: CS42L51 and WM8962 codecs
 depend on INPUT
Date: Wed, 30 Apr 2014 18:31:03 -0700
Message-ID: <20140501013103.GK3245@sirena.org.uk>
References: <1398770316-19715-1-git-send-email-kaixu.xia@linaro.org>
 <1398770316-19715-2-git-send-email-kaixu.xia@linaro.org>
 <alpine.DEB.2.02.1404292124270.31465@heelrod>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ogUXNSQj4OI1q3LQ"
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.02.1404292124270.31465@heelrod>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Brian Austin <brian.austin@cirrus.com>
Cc: Xia Kaixu <kaixu.xia@linaro.org>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Lars-Peter Clausen <lars@metafoo.de>, arnd@arndb.de, Sangbeom Kim <sbkim73@samsung.com>, Timur Tabi <timur@tabi.org>, linux-samsung-soc@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>, linux-input@vger.kernel.org, Kukjin Kim <kgene.kim@samsung.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: linux-input@vger.kernel.org


--ogUXNSQj4OI1q3LQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 29, 2014 at 09:31:30PM -0500, Brian Austin wrote:

> I assume you mean the CS42L52 instead of the L51. INPUT is used for a BEEP
> Generator but when I disable CONFIG_INPUT I do not get an error. Is there
> any information available on what the error is?

I suspect it's ASoC built in and INPUT build as a module.

--ogUXNSQj4OI1q3LQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTYaPUAAoJELSic+t+oim9TuAP/jcLwvFYjhcTfC78p+CWG5Gu
yIkJnY+acf+PpwN/nqUjxa5Xk5vb1f85vJcE+g7wbuf97jqcjlxc2eZuXRYcm4aD
mY9j02EFr9swHWex5fHvEdoQ80ABXyrUXx789DPRSQHd5+Mr3kVnjgRx3BLpAOMh
q+JI/MrQ2kPUAMVaLZ3sXYVDfwXkq53/np25CfnJIUtRQDHh5/3ovtW0XnDDunAz
Dz6CsrXBG0KJbZQDPmRmhzewoRLwrUtZYY5yXyq7IctRdNABbix/O9zWgT5i1i7f
rm8jgBl6mL+IH/34A2TrwTUB5G+GICFw1xXyi8lm99Mwc1ZL89DjcTBFH3X0z9iP
loTOY4TBfRll6M5fFG4PAOdw1XZXa24/63KzU4QR1SxRE+/BKib2Dy+mEtp0nR5z
nTkBR/r/ss+v+2Ku/DXKQ/ChJKYldhTGl1z7d2jcK9yCnbq/iiHk8xYuCwaEwU0T
/smnJnavBz996Kc5tucybxZIE4uEvJPAcSi4euJIMjF5JH2GuMuAWNwtBbKSkLST
EKh0GPRzdqRMwZWNP8V/5uCMez6yQ2C5P+EVU3xBRZfHPja46sQxJZCpYeMoEkTq
EcO0c9yY32TDXFRWpZBMQDzI6sf4u0LAcNzl1ro1T9nY9L4QGjmXw2nWpSP938b1
pfd/YUNI20J0BpMR0L/v
=ih79
-----END PGP SIGNATURE-----

--ogUXNSQj4OI1q3LQ--
