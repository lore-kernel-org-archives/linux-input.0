From: Mark Brown <broonie@kernel.org>
Subject: Re: [linux-sunxi] Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
Date: Sun, 9 Mar 2014 07:51:48 +0000
Message-ID: <20140309075148.GJ28112@sirena.org.uk>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140307182213.GC607@lukather>
 <CAOQ7t2YSidSPVSBrBzj3R1SYS_Xb10a2vfEs+u1DEkrhEJQCaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9wW02hG+pBvRTRBg"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2YSidSPVSBrBzj3R1SYS_Xb10a2vfEs+u1DEkrhEJQCaQ@mail.gmail.com>
Sender: linux-doc-owner@vger.kernel.org
To: Carlo Caione <carlo@caione.org>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>, linux-arm-kernel@lists.infradead.org, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, lee.jones@linaro.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, linux-sunxi@googlegroups.com
List-Id: linux-input@vger.kernel.org


--9wW02hG+pBvRTRBg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 08, 2014 at 12:43:04PM +0100, Carlo Caione wrote:
> On Fri, Mar 7, 2014 at 7:22 PM, Maxime Ripard
> > On Sat, Mar 01, 2014 at 05:45:51PM +0100, Carlo Caione wrote:

> >> +     return platform_driver_register(&axp20x_regulator_driver);

> > I thought the AXP was only connected through I2C? How is that a
> > platform device then?

> Not really. It is plain wrong.
> I'll fix it in v2.

Are you sure this is wrong?  For MFDs the core MFD is a driver of
whatever bus type is in use but the function drivers are platform
devices which talk to the hardware via the core device.

--9wW02hG+pBvRTRBg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTHB2QAAoJELSic+t+oim9bpgP/38efi+vZmadMoeQu7+Poa9d
nq3X5m01GyJoyMIB3uSfjulMCfTmZ6zEd14oDNEbU62oo9aCStmewT863p70eh/u
Lt2AJW2A2OZsOxPzWJeK2DWpAviwW7STXAtkiLoX7VWqW26J1bhZsk/wcaogpKlJ
Sr4dRd5o7MDX2jKcMjxJelFOYdNu7yTZP4ko5x9ENImsG8OETZ1SFYCE7N+lMd4K
Zam9ehRiB6hMa5jXyqoQQ4FydI90I8bZCgUXnuZUxiPdxK+2sDIc1/JtrdlTTtYe
0Q0EQZ5mtnvmrRKW0ATgiXhvKQZSKXu0srJ+Jm9L7NUzw+aVuHLSsXyXKWDdLn4f
BIwZb8a1aeH3TSvvjLXQpxRp5btdBgjyYQ97uo4BGGLUrYVVaOIcrBwqDskCY2gh
wMpNJpCYp27GXfwv3l9yNC3W+QiRuU4bCP4Ptp86t+sMztAyitsp2w/Y9R6v2iN2
RiIUV8FYZqkjR2RtLxIedZTxqKL4HENpw8Tam+u6+PtLnMdoMvMAeDOxloqifyUi
N/L65DAGa7d+bf3DkVXNss2sUgTFjI5GztQs2ntQiRJ05uH1O9pICsWe3SmhpCcj
WkBmwIcuMSscQzTJtm/Bt2lf4bLO/yoa0FGQWSIRBjTVrM+ssoQGaprPn9Six1cZ
0GFPTo2Jmc3kh/ChA6q7
=gJPf
-----END PGP SIGNATURE-----

--9wW02hG+pBvRTRBg--
