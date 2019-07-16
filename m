From: Lukasz Majewski <lukma@denx.de>
Subject: Re: [PATCH v2 2/3] input: touchscreen mc13xxx: Make platform data
 optional
Date: Tue, 16 Jul 2019 09:02:56 +0200
Message-ID: <20190716090256.45a8ef72@jawa>
References: <20190711222346.5245-1-lukma@denx.de>
        <20190711222346.5245-3-lukma@denx.de>
        <20190715071048.GB153485@dtor-ws>
        <20190715104344.3f17b660@jawa>
        <20190715182757.GA136092@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/S/G4zS2240TH5M1dL3+/d+n"; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190715182757.GA136092@dtor-ws>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>, Enrico Weigelt <info@metux.net>, Thomas Gleixner <tglx@linutronix.de>, Kate Stewart <kstewart@linuxfoundation.org>, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--Sig_/S/G4zS2240TH5M1dL3+/d+n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

> On Mon, Jul 15, 2019 at 10:43:44AM +0200, Lukasz Majewski wrote:
> > Hi Dmitry,
> >=20
> > Thank you for your reply.
> >  =20
> > > On Fri, Jul 12, 2019 at 12:23:45AM +0200, Lukasz Majewski wrote: =20
> > > > From: Sascha Hauer <s.hauer@pengutronix.de>
> > > >=20
> > > > The platform data once was optional, make it optional again.
> > > > This is a first step towards device tree support for the mc13xxx
> > > > touchscreen driver.   =20
> > >=20
> > > I would prefer seeing it together with patches introducing device
> > > tree support. =20
> >=20
> > Ok, I will merge this patch to patch 3/3. =20
>=20
> Uh, I must be missing something, but I do not see anything dedicated
> to device tree handling in 3/3...

Yes, you are right - the 3/3 adds only IDs for mc34708 device.

The device tree conversion/handling is not planned for now.

Patches, which I've sent in this series, allow the mc34708 device to be
usable with contemporary kernel (e.g. 5.2).

>=20
> Thanks.
>=20




Best regards,

Lukasz Majewski

--

DENX Software Engineering GmbH,      Managing Director: Wolfgang Denk
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-59 Fax: (+49)-8142-66989-80 Email: lukma@denx.de

--Sig_/S/G4zS2240TH5M1dL3+/d+n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEgAyFJ+N6uu6+XupJAR8vZIA0zr0FAl0tdqAACgkQAR8vZIA0
zr30pQgAgDagYgbZwHeoyVrm0adqmFFFGxmcQA+0mEyy9n5i6XMNC9lLTIvPg6+Y
I6C0QBXGGFxJQKbGHYD8sAG21Z4IUAcBmiJ7LyepYc9w2PJnHDWLqPBgWXqlB/L5
3X+lj5qYQNp7BxEuY0tJHdnFS9gzE6yK6pW85RLz5zKP8JTaqr2UE7FrIQtLM8i+
+H065ekVlplyJ8g+YLKLT0IOxnz01uqSEkAHELyGuxyMZYYOh/RxwP0URNXygFnE
VNrnGZoe4oSkf4OUoZUthZmztYj/Kr1yxjUNRR1My1CXxSctoLMUsW+xQnTYZQHR
H4lqi/mYCDM+v2YoKpXW6v7uOqUJNA==
=TSRN
-----END PGP SIGNATURE-----

--Sig_/S/G4zS2240TH5M1dL3+/d+n--
