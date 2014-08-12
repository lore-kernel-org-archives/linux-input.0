From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] input/joystick: use get_cycles on ARMv8
Date: Tue, 12 Aug 2014 18:36:53 +0100
Message-ID: <20140812173653.GW17528@sirena.org.uk>
References: <1407771730-1641-1-git-send-email-broonie@kernel.org>
 <20140812170149.GB5563@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x1+AGLzVZdX4V68E"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:60227 "EHLO
	mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753199AbaHLRg5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 12 Aug 2014 13:36:57 -0400
Content-Disposition: inline
In-Reply-To: <20140812170149.GB5563@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linaro-kernel@lists.linaro.org


--x1+AGLzVZdX4V68E
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 12, 2014 at 10:01:49AM -0700, Dmitry Torokhov wrote:
> On Mon, Aug 11, 2014 at 04:42:10PM +0100, Mark Brown wrote:

> > As with ARM the ARMv8 architecture provides a cycle counter which can be
> > used to provide a high resolution time for the joystick driver and sile=
nce
> > the build warning that results from not having a precise timer on ARMv8,
> > making allmodconfig and allyesconfig quieter.

> Applied, although I wonder if it is time to retire whole gamecon subsyste=
m. I
> don't think there are many users left...=20

OTOH it doesn't really do much harm either, the rate of updates seems
pretty low.  I was wondering about converting the warning to a runtime
one - it'll probably be more likely to be seen by anyone who is using it
and makes for less of these porting issues but I couldn't quite find the
motivation.

--x1+AGLzVZdX4V68E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIbBAEBAgAGBQJT6lCxAAoJELSic+t+oim9G6sP90QQwHf+gdHm45cECDt0vzQH
FFMbNKxXwrOz7Y1ofqn+kHBBbNSPnw6xsFX3puo+opPSqGHbaGjv4MGQdebHuTE1
ZITU5ynJvCxeMcoesGbhcc2msk3k+a8EY2/A7Xkdl/+oqsZGaQ4lsqToso0gQnmN
J5BoNXIsGzAHggcDos2Y08kXvuZF4oZsJEdU43GnCl/81s7y5Y3xvWyrDlhylhkB
OZCEesIFbnxIKHIYwIKYyUo2SuJ1Ikolmonck0l0O5DFnbPZzOvXNsJN6dm4AjUo
Twfzk2Vt3SmVmozN0laSuvdcWuFlUB7gQZNPUd90N+CEtrqmDCUXI5S2hJXU/7lB
6/xB4FyaIM379AbNs/tqab/hDlKjnqCdQuc7A/EzxOXpEs0+0gaN7QV1FJEdhonF
1Vv4VGgZnSUSkwu91Rb9eB7vQOZlJCE/NeSPmaYcq0KNm9qsEKdYOTmziYUfFW9f
7Dj2WBpN8oLybJFKcwnMb9tpIoIMOV6hyp1q1D+NaclZgGbcFmMCEA/t1s1vHksR
pUeEivKJJvTaOwy0uuaINuU2i9qOErXRwvVY6UL8goNLW5YGYIqFDzbPr4QOg/aH
kWd7LwSsyCHTwimHh8XLSn8Q95935yIOnyVFnOpaKyh+qufl4peDyUdoFUHz+IY/
WlNwp1Jtk4m5khHN1vw=
=R3Ly
-----END PGP SIGNATURE-----

--x1+AGLzVZdX4V68E--
