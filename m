From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH V2 4/8] regulator: stpmic1: add stpmic1 regulator driver
Date: Fri, 7 Sep 2018 16:56:26 +0100
Message-ID: <20180907155626.GI17459@sirena.org.uk>
References: <1536325173-16617-1-git-send-email-p.paillet@st.com>
 <1536325173-16617-5-git-send-email-p.paillet@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Op27XXJsWz80g3oF"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1536325173-16617-5-git-send-email-p.paillet@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org


--Op27XXJsWz80g3oF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 07, 2018 at 12:59:44PM +0000, Pascal PAILLET-LME wrote:

> @@ -804,6 +804,18 @@ config REGULATOR_TI_ABB
>  	  on TI SoCs may be unstable without enabling this as it provides
>  	  device specific optimized bias to allow/optimize functionality.
> =20
> +config REGULATOR_STPMIC1

This looks good to me except the Kconfig isn't alphabetically sorted and
has a conflict.  If the series doesn't otherwise need a resend I should
be able to fix by hand, let me know.

--Op27XXJsWz80g3oF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAluSn6kACgkQJNaLcl1U
h9D0Hwf+Mz7oDPoli2YWJfuvAyjir33WC91k9f7g81u4O/QJ6AJJ+Tl2yc8D9VAd
sfPk5SF3UMl3eMbsQ8/al6P7j4H0gMvkvgVt/0baJGkHd+v4X+vTWGWiO1Rlk7Wk
2PeLVMwJJ4W/ma+jNo++WQngv/SHsRddiH7zDaHgrlCCiGEnsqPX1MBg/T/lwCkF
de/8sT5o3PWmbl9Uvfow7mX9FLRLPDZFKULPRQqJNTyW/pa/VPbdwC9vHf8aYGdg
y91SSOy/u4BoiegzZNMuLnuG9jekHultXFFsmlbZdBlAM3u1vyjqLuzwTEh3EpnU
MFMZNboU65z5qOhlMMCHIOJ/6nVEkw==
=M5Mz
-----END PGP SIGNATURE-----

--Op27XXJsWz80g3oF--
