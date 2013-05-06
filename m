From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] Input: touchscreen: ads7846: copy info from pdata to
 private struct
Date: Mon, 6 May 2013 11:25:02 +0100
Message-ID: <20130506102502.GX4945@sirena.org.uk>
References: <1366889633-12577-1-git-send-email-zonque@gmail.com>
 <20130506032444.GD25084@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WVf18ZLo9bznw8Mz"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from cassiel.sirena.org.uk ([80.68.93.111]:54849 "EHLO
	cassiel.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753901Ab3EFKZl (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 6 May 2013 06:25:41 -0400
Content-Disposition: inline
In-Reply-To: <20130506032444.GD25084@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Daniel Mack <zonque@gmail.com>, linux-input@vger.kernel.org, grant.likely@linaro.org, agust@denx.de, imre.deak@nokia.com, chf@fritzc.com


--WVf18ZLo9bznw8Mz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, May 05, 2013 at 08:24:44PM -0700, Dmitry Torokhov wrote:
> On Thu, Apr 25, 2013 at 01:33:52PM +0200, Daniel Mack wrote:

> > In preparation for DT bindings, we have to store all runtime information
> > inside struct ads7846. Add more variable to struct ads7846 and refactor
> > some code so the probe-time supplied pdata is not used from any other
> > function than the probe() callback.

> I think more common pattern is to allocate platform data structure when
> parsing device tree, often with devm_kzalloc() so it is cleaned up after
> driver is unbound.

Both are used fairly widely.  It's very common to do the separate
allocation when converting an existing driver to device tree as the code
using the platform data is frequently written with lots of pdata-> in it
and may potentially have some different behaviour if there's no platform
data at all (though that's a bit questionable) so allocating a new
struct is pretty natural and makes for a much less invasive patch.  When
there's no existing platform data code it's probably more common to
embed the structure as this saves an allocation and means that the users
can assume that there's a platform data struct there which makes them a
little simpler.

--WVf18ZLo9bznw8Mz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRh4T3AAoJELSic+t+oim9rmkP/2FGBskA0tZU1pY6t17H8bg3
Bp2Vebe2UZvEgpwDZds+fjoIa2wDxb6dEzY9mbLa+g52wlEDA54o8II1D+NpL0e1
zZj/hX3Y/qEHby8SDsiOU4TiYOvH9DWOD7nT9wH6OYA0o3iXqWaB4S29I1Pxv0EA
ysY7nONdMakKhH4iyYRcrk1pipA/qf/xgMW1TM6mEzKe/jqEyc/zh35i6x6TdrDS
5YJPWS62P7+U/uGlQn1g32+GyQl/ZKsxSaMafpraqPQ3dk8o2ptnMZ+zb4pQf+H8
CtF7DzcUlmNuyUWgn+dSMUFAeEeXQMijdwpD238beqtEP8s6fePMPm0dsLdJZg+I
z7zi+on4oZD9UHrcghSmuouEvRhWqF5gb9Hc2vBmBUdv0bkjvFcD2CrNSavfCRAB
sG7XZKUCGR/+n5t0VpMDNnVx59hr/2A42gpgCTNJiDmRdRmt3qcuB+8/WdmuyO/w
FEOzCnhbXis4BIEsOpqk4icOIXIiy4XCx4GIQfwPUUqR9fJ35tmH+PpJWY4FmBlh
dT3/2pY7FlT+GYIySTsXCVo/ZIhF9pxbwu3EpldmmnyLUlHfFKj9A3AfhrnX4bn0
Wznc8Q4IJ53iAQJRV7ncc8ZLWPWNndAPWIrOlaOd8P7F+oLoV9+9T4aVeThmz6xy
uDcZLtBwCUvLpXqUCURa
=69Kn
-----END PGP SIGNATURE-----

--WVf18ZLo9bznw8Mz--
