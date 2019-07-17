From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v3 3/3] input: touchscreen mc13xxx: Add mc34708 support
Date: Wed, 17 Jul 2019 10:17:04 +0200
Message-ID: <20190717101704.2ff4d877@jawa>
References: <20190716221929.3782-1-lukma@denx.de>
        <20190716221929.3782-4-lukma@denx.de>
        <20190717033655.GC621@penguin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/bfopTdlYpTmTI0/.0Uf3PCA"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717033655.GC621@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_/bfopTdlYpTmTI0/.0Uf3PCA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> On Wed, Jul 17, 2019 at 12:19:29AM +0200, Lukasz Majewski wrote:
> > From: Sascha Hauer <s.hauer@pengutronix.de>
> >=20
> > The mc34708 has a different bit to enable pen detection. This
> > adds the driver data and devtype necessary to probe the device
> > and to distinguish between the mc13783 and the mc34708.
> >=20
> > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> >=20
> > ---
> > Changes for v3:
> > - Replace forward declaration of mc13xxx_driver_data with
> >   structure definition
> > - Rename mc13xxx_driver_data with mc13xxx_chip
> > - Move static struct mc13xxx_chip mc13783_chip and mc34708_chip
> >   closer to ID table
> > - Do not check mc13xxx device type =20
>=20
> You do not even need to define or store the type. Once it is dropped
> please feel free to add

Ok. I will remove the type definition.

>=20
> Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
>=20
> and merge with the other 2 patches.
>=20

Ok. I will squash those three patches into a single one, add your
Acked-by and wait for Lee to pull this single patch to his MFD tree.

Thanks for review and help :-).


Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/bfopTdlYpTmTI0/.0Uf3PCA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl0u2YEACgkQAR8vZIA0
zr1Gagf+P8RQt3O4pwxt7GUd1HpRpMLyELslWExzBG5Oqs0Mb7ZyhW/Wk5uHIyDg
0YFoYvyIe9kjVjgfxZAOAipIDCLQNFv+hUIDp/+VDcLPDdvZdokJHNzEPqb1LPGz
5+ZkKHm8UlzqiAu8+QzzXQ5vDHA31Y0IBtBiAtet+zPqrre2F1OAkSXRfnN7vXou
vguchQf/NASbsG9DvUDfhFUZKQ2PdNJxpDCg7nXbcDHTU45dutxpDmm8JNlnxeu8
dt03SQaqASiIBSFcI0l7pHl+e8pFpgXSdjdwlI1LbE0DIj884M3HuErzvpInX0Ua
jcrZ90ATOX0zUObbIlPiVOozngzCGw==
=ji12
-----END PGP SIGNATURE-----

--Sig_/bfopTdlYpTmTI0/.0Uf3PCA--
