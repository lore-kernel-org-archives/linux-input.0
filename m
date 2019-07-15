From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 2/3] input: touchscreen mc13xxx: Make platform data
 optional
Date: Mon, 15 Jul 2019 10:43:44 +0200
Message-ID: <20190715104344.3f17b660@jawa>
References: <20190711222346.5245-1-lukma@denx.de>
        <20190711222346.5245-3-lukma@denx.de>
        <20190715071048.GB153485@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/wI5fB2=GD+px5yqNSN=ssGE"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715071048.GB153485@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_/wI5fB2=GD+px5yqNSN=ssGE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

Thank you for your reply.

> On Fri, Jul 12, 2019 at 12:23:45AM +0200, Lukasz Majewski wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > The platform data once was optional, make it optional again. This
> > is a first step towards device tree support for the mc13xxx
> > touchscreen driver. =20
>=20
> I would prefer seeing it together with patches introducing device tree
> support.

Ok, I will merge this patch to patch 3/3.

>=20
> Thanks.
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/wI5fB2=GD+px5yqNSN=ssGE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl0sPMAACgkQAR8vZIA0
zr0wPAf/ROYmcmtX42lnrcD6g5DX74eTlwFhs9G7ptA2kZpJlmPGO1rodMjar2Fx
UYwbBT5JTrcM4MoeAVTbydxTISQPJBzXOemHfUEe5F5nRbZNwTcc+W/EuRY/+Jtk
jwMlqPiOCygNvrALj1Ekd+Tiew8S/Wo+QA/GZHU2V/B7VQs9eFA4ZgsZujBkCMaS
ovGqRSb93fP0v7SbuskxPSkBCsd3BYCmitQQIS+z7VyS0FQOLEwV9c3GTUiJaJyd
5zK2s56g/BUBLfvy3Wv80eORiOfbqKXQNBqUOBnIbmsZx7zzdit/ZTSaw32k7auC
hLP3ZEI9JOMAoGWeS2IuqbA29JBxpg==
=96sO
-----END PGP SIGNATURE-----

--Sig_/wI5fB2=GD+px5yqNSN=ssGE--
