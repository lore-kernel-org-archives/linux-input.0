From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2 3/8] input: misc: Add driver for AXP20x Power Enable
 Key
Date: Tue, 18 Mar 2014 15:03:23 +0100
Message-ID: <20140318140323.GB27873@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-4-git-send-email-carlo@caione.org>
 <20140318090013.GU27873@lukather>
 <20140318095002.GM25478@lee--X1>
 <20140318101554.GZ27873@lukather>
 <20140318105851.GO25478@lee--X1>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ViWwB84N1zFtNiVD"
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140318105851.GO25478@lee--X1>
Sender: linux-doc-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Carlo Caione <carlo@caione.org>, linux-arm-kernel@lists.infradead.org, linux-sunxi@googlegroups.com, hdegoede@redhat.com, emilio@elopez.com.ar, wens@csie.org, sameo@linux.intel.com, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, linux-input@vger.kernel.org, linux-doc@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: linux-input@vger.kernel.org


--ViWwB84N1zFtNiVD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 18, 2014 at 10:58:51AM +0000, Lee Jones wrote:
> > > > > This patch add support for the Power Enable Key found on MFD AXP2=
02 and
> > > > > AXP209. Besides the basic support for the button, the driver adds=
 two
> > > > > entries in sysfs to configure the time delay for power on/off.
> > > > >=20
> > > > > Signed-off-by: Carlo Caione <carlo@caione.org>
> > > > > ---
> > > > >  drivers/input/misc/Kconfig      |  11 ++
> > > > >  drivers/input/misc/Makefile     |   1 +
> > > > >  drivers/input/misc/axp20x-pek.c | 267 ++++++++++++++++++++++++++=
++++++++++++++
> > > > >  3 files changed, 279 insertions(+)
> > > > >  create mode 100644 drivers/input/misc/axp20x-pek.c
> > > >=20
> > > > From what I understood of the MFD framework, you usually have a MFD
> > > > core driver that gets loaded from the DT and instantiate its various
> > > > functions through sub-devices, that are registered through
> > > > mfd_add_devices, and the drivers for these sub-devices are supported
> > > > in sub-drivers that are located in the driver/mfd, alongside the co=
re
> > > > driver.
> > > >=20
> > > > I believe that such a pattern allows for two interesting things:
> > > >   - You don't have to search around the whole kernel tree to find
> > > >     where a given sub-feature is supported.
> > > >   - You don't have to cripple your DT with instantiation of all the
> > > >     subcomponents, while you only really have one device.
> > > >=20
> > > > Do you have a reason for not following this pattern?
> > >=20
> > > Sorry Maxime, this is not the case.
> > >=20
> > > If an MFD contains Regulators and USB & GPIO Controllers, I'd expect
> > > to see the device represented in the following way:
> > >=20
> > >   drivers/mfd/<id>.c
> > >   drivers/{gpio,pinctrl}/{gpio,pinctrl}-<id>.c
> > >   drivers/regulator/<id>-regulator.c
> > >   drivers/usb/host/<id>.c
> >=20
> > Oh, ok. Nevermind then :)
> >=20
> > Just out of curiosity, some drivers at least seem to follow that trend
> > in drivers/mfd, is there any reason for this (other than historical) ?
>=20
> Would you mind providing an example?

I was under this impression given the naming scheme that they were
using. Looking into it just proved me how wrong I was :)

Sorry for the noise.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--ViWwB84N1zFtNiVD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTKFIrAAoJEBx+YmzsjxAg7KkP/j2mh9oDFJIT4wey7kUkqUL4
kOrO458skjeue6NjbyKwapYmZIz1PPmzkWAnHDJoI3mvW2shYS6WdnQ3/kYnSHyR
OTZyVOjKoy/QWRlgd4AmfF5/rg5e9nQ9+F5sW77FWbfA8yduKaQjDya+nPHmZmEI
OY6m7/o3qSqRvm5TSvDnO+RUKBaG2vKYMmQnqh3Up90P4MU1Ew9o43x+2xplmJiX
rtNpuWjrKeZu4oX+q7i39lxhGgo1+DJtguBKgUU9RBxKUWkiG6mOBIEuNaelpBFJ
YdfFRaiGiOllDI5RDw//BurHOjBhbQXR1uyS0fJafvHiAICfxzLi46d14A5qLySy
rVshtd2XUgBBGf8MsJ5tN/znW+qubrv+d23wRyrcsBWlfZtX7VU9mMSVvqm96T9X
TJT7gnqRpCj56ZmCx6A/t+UWjk+tyJocSoUu8zZbCJkLpaF6BdntAdBEVG4SG2Gq
2jrGMlXgMBwvySoRUFx/tNMXKGPdPsFDNYe8a76uUUC6EcpjrziB4KNWR65/csmN
QN+oOtUTTcPJswcVb464CjXiLjuRhFSFai91cHSFIetH/oEYWNzwlUGBk2D1qvPx
gNGYVDoWG+Dbs9aHBrYb6iGKlvLxrxj72Ttl/tH/riBQaXimm6LeHGpOINAvraeS
+Ipt8uvrYoa5wE3nSH6Q
=+Kem
-----END PGP SIGNATURE-----

--ViWwB84N1zFtNiVD--
