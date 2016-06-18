From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/5] regulator: qcom_rpm-regulator: Add support for
 pm8018 rpm regulator
Date: Sat, 18 Jun 2016 10:47:18 +0100
Message-ID: <20160618094718.GR26099@sirena.org.uk>
References: <1466158929-19524-1-git-send-email-narmstrong@baylibre.com>
 <1466158929-19524-6-git-send-email-narmstrong@baylibre.com>
 <20160617165352.GA1256@tuxbot>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="phbq2bkSb+hZnunM"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160617165352.GA1256@tuxbot>
Sender: linux-kernel-owner@vger.kernel.org
To: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Neil Armstrong <narmstrong@baylibre.com>, dmitry.torokhov@gmail.com, andy.gross@linaro.org, david.brown@linaro.org, lee.jones@linaro.org, lgirdwood@gmail.com, a.zummo@towertech.it, alexandre.belloni@free-electrons.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, rtc-linux@googlegroups.com
List-Id: linux-input@vger.kernel.org


--phbq2bkSb+hZnunM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 17, 2016 at 09:53:52AM -0700, Bjorn Andersson wrote:
> On Fri 17 Jun 03:22 PDT 2016, Neil Armstrong wrote:

> > +	{ "dig_corner", QCOM_RPM_VOLTAGE_CORNER, &pm8018_corner,
> > +						      "vdd_dig_corner" },
> > +
> > +	{ }
> > +};

> We have discussed the corners for a long time and I think we've
> concluded that they should be exposed as something like an OPP. What we
> have agreed on is that they should not be exposed as a regulator with
> voltages 1-4uV.

Oops, missed this - yes, that needs to go as it's definitely a complete
abuse of the API.

--phbq2bkSb+hZnunM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXZRilAAoJECTWi3JdVIfQY80H/1ivWNpPRnt2FJlX1ib3VwyJ
o6NL9+DqffRIIj4VN4lZJUiIXmHUbGy9OjiVdac29rA4QHicwz27jj1OQ1DsNQ+i
EdoR7STzH3e3YvwQBrSZzFoD0C2AXXaWPWLB5UbtA2s7Lcg3LPWuTQc2MazVYuLS
h4zyNZhWYzHRdr5Jm4EsXCbLbESjNWqLow/Wh+tI0szCVDiOnD4bSEzA0C2CmRwB
UJKtFyZeUPjE1Fozbu3FWB+T2g3ck+S40OkkIoWSArHxxlDzYY06/xUiEZXWDk2O
k6cD1Q5D1cM/q+j5M+KWhQ+rpa0q5+ToKHEcBf/1mJr8319IzgvpEF/zsuDqul8=
=DTu4
-----END PGP SIGNATURE-----

--phbq2bkSb+hZnunM--
