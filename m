From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 3/8] dt-bindings: regulator: document stpmic1 pmic
 regulators
Date: Wed, 28 Nov 2018 09:48:01 +0000
Message-ID: <20181128094801.GF6828@sirena.org.uk>
References: <1543337529-22301-1-git-send-email-p.paillet@st.com>
 <1543337529-22301-4-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="twz1s1Hj1O0rHoT0"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1543337529-22301-4-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>, "axel.lin@ingics.com" <axel.lin@ingics.com>
List-Id: linux-input@vger.kernel.org


--twz1s1Hj1O0rHoT0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 27, 2018 at 04:52:15PM +0000, Pascal PAILLET-LME wrote:
> The STPMIC1 regulators supply power to the application processor as well as
> to the external system peripherals such as DDR, Flash memories and system
> devices.

Please do not submit new versions of already applied patches, please
submit incremental updates to the existing code.  Modifying existing
commits creates problems for other users building on top of those
commits so it's best practice to only change pubished git commits if
absolutely essential.

--twz1s1Hj1O0rHoT0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlv+ZFAACgkQJNaLcl1U
h9AA3wf+PMfJhuWzSDo4Gyt+6hi/sZYBOjjmRyNUvr4h4+MD5GD+hKM/khHZHOAX
5DNTnPbq9QxpSz0diLf0ccI2gai1kxHGFeOn3rz6M7VTPPBM06h2KHDdNUQUOyFq
QRCbUmCBT1BvgRXorwBiVQvc7KyanV9MkXaNgleXpb5wMCilOIWREX00Ldo6pZEA
LZzRtxDzz+0HC0M8kADW56NfMKpATi4yW4qAejc/fnkkYAmpE4Jkt7tf2YzFgdRp
f2GNjyVVwMqYnvOcDNeY7rajJQJFTaRahTdUn8LAtsR8tEicx0WAzexFgx/iNjDn
TNPYztrJuVKThCXbbDQEOvlf8Q2EXg==
=rEEf
-----END PGP SIGNATURE-----

--twz1s1Hj1O0rHoT0--
