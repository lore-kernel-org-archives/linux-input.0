From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v3 3/3] input: touchscreen mc13xxx: Add mc34708 support
Date: Wed, 17 Jul 2019 11:07:09 +0200
Message-ID: <20190717110709.7ae3c9f3@jawa>
References: <20190716221929.3782-1-lukma@denx.de>
        <20190716221929.3782-4-lukma@denx.de>
        <20190717033655.GC621@penguin>
        <20190717101704.2ff4d877@jawa>
        <20190717085338.GA581@penguin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/J3YSRAFC6/++9p0DylGe61+"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190717085338.GA581@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_/J3YSRAFC6/++9p0DylGe61+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> Hi Lukasz,
>=20
> On Wed, Jul 17, 2019 at 10:17:04AM +0200, Lukasz Majewski wrote:
> > Hi Dmitry,
> >  =20
> > > On Wed, Jul 17, 2019 at 12:19:29AM +0200, Lukasz Majewski wrote: =20
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > >=20
> > > > The mc34708 has a different bit to enable pen detection. This
> > > > adds the driver data and devtype necessary to probe the device
> > > > and to distinguish between the mc13783 and the mc34708.
> > > >=20
> > > > Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> > > > Signed-off-by: Lukasz Majewski <lukma@denx.de>
> > > >=20
> > > > ---
> > > > Changes for v3:
> > > > - Replace forward declaration of mc13xxx_driver_data with
> > > >   structure definition
> > > > - Rename mc13xxx_driver_data with mc13xxx_chip
> > > > - Move static struct mc13xxx_chip mc13783_chip and mc34708_chip
> > > >   closer to ID table
> > > > - Do not check mc13xxx device type   =20
> > >=20
> > > You do not even need to define or store the type. Once it is
> > > dropped please feel free to add =20
> >=20
> > Ok. I will remove the type definition.
> >  =20
> > >=20
> > > Acked-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > >=20
> > > and merge with the other 2 patches.
> > >  =20
> >=20
> > Ok. I will squash those three patches into a single one, add your
> > Acked-by and wait for Lee to pull this single patch to his MFD
> > tree. =20
>=20
> Sorry, it looks like there is misunderstanding. I did not ask to
> squash together the 3 patches, I meant that they can all go together
> through the same tree (MFD). That is what I meant by them being
> merged together.
>=20

Thanks for the explanation.

> Sorry for being unclear.

No problem - big thanks for very prompt review.

>=20
> Thanks.
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/J3YSRAFC6/++9p0DylGe61+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl0u5T0ACgkQAR8vZIA0
zr0FkAf/byAxKc6UDdbwve8hkqfG9u3wRAtzDy75Lu+JDBEJbDSFcq5hzKd2dyqD
1eAvwzGUidwNktfvq5mA/a66/PCssfjmkIDiigdYsuACclmw/1jo1+Em25YRes/n
NfF72JfaMO4K/m71rZGWSPnQQsl00VY96rsY0dkV2M3dgy+VoB3UVRfQz8lNN8bS
6j+T/CEVzcGmbLIrLDs3r0FwHvGq5MN2fHMCd6ja3OWJfJ+0MsQuVX/tT14l5Quj
sJp6WdgaIpdRBwPCIoi69lyPz4EuBNK11XfjybN+I0Np/V6HDA8nNzxMMBpWsq2s
UxCG35VrFVyjk/p0z4MUNp+xHZd33Q==
=ldUl
-----END PGP SIGNATURE-----

--Sig_/J3YSRAFC6/++9p0DylGe61+--
