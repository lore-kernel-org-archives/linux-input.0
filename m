From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 4/8] regulator: stpmic1: add stpmic1 regulator driver
Date: Fri, 26 Oct 2018 21:33:44 +0100
Message-ID: <20181026203344.GD27137@sirena.org.uk>
References: <1539853324-29051-1-git-send-email-p.paillet@st.com>
 <1539853324-29051-5-git-send-email-p.paillet@st.com>
 <20181019115015.GC5895@sirena.org.uk>
 <5BD06B96.3080809@st.com>
 <20181024131716.GQ2103@sirena.org.uk>
 <5BD1C3BB.6060500@st.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WChQLJJJfbwij+9x"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5BD1C3BB.6060500@st.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Pascal PAILLET-LME <p.paillet@st.com>
Cc: "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "lee.jones@linaro.org" <lee.jones@linaro.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "wim@linux-watchdog.org" <wim@linux-watchdog.org>, "linux@roeck-us.net" <linux@roeck-us.net>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>, "benjamin.gaignard@linaro.org" <benjamin.gaignard@linaro.org>, "eballetbo@gmail.com" <eballetbo@gmail.com>
List-Id: linux-input@vger.kernel.org


--WChQLJJJfbwij+9x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 25, 2018 at 01:23:08PM +0000, Pascal PAILLET-LME wrote:

> I have reworked the code so that we don't touch any more to the init_data.
> the new loop to register the regulators is below:
>=20
>      for (i =3D 0; i < ARRAY_SIZE(stpmic1_regulator_cfgs); i++) {
>          ret =3D stpmic1_regulator_register(pdev, i, &stpmic1_matches[i],
>                           regul);
>          if (ret < 0)
>              return ret;
>          regul++;
>      }
>=20
> Each regulator is registered, even is it is not described in the=20
> device-tree.

Looks good.

--WChQLJJJfbwij+9x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlvTeicACgkQJNaLcl1U
h9BNawf/cbL/eN87EoAK84d4Blf5KW/72h2ON2hIQ4Zz17sppoHuiZaArEUDLbjv
tDanZ8eCfCKDWaysFbU8014ck8IO74gnCgehAh9RAu4UMmFHBX3JBpfgnWtOhYYX
Kw3MuAnBzFqeDq11wTdjUW3vfd6SZsm+/Zaezw/Py7btUesDIbo4Rg7OAtaG5Rkn
2xnh/Upm2W0dHxwN3aH1Y9zxxJrr6xyROTO5LZnkkPmYNewAgW9UFuyzsmqJq8+N
W7u9b900oQWhEa7cwxlwDMeVV+TPb5SOU8xTP0soHgLKf8ymDvom6Xf2Oi9jsKLX
73RVLYgMgNl607gHIfWVbpaX61LQIg==
=Uxw5
-----END PGP SIGNATURE-----

--WChQLJJJfbwij+9x--
