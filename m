From: Sebastian Reichel <sre@kernel.org>
Subject: Re: [PATCH v10 00/11] mfd: add support for max77650 PMIC
Date: Thu, 25 Apr 2019 23:46:09 +0200
Message-ID: <20190425214609.rav7ooxovzhvgn7e@earth.universe>
References: <20190423090451.23711-1-brgl@bgdev.pl>
 <20190424083127.GB6699@amd>
 <CAMRc=McN78_gJw_T4EPucM8veTC9XRUu7TGJ0J+zPsU=0Hu2GQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hkqjlur2zgw6jemw"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMRc=McN78_gJw_T4EPucM8veTC9XRUu7TGJ0J+zPsU=0Hu2GQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Pavel Machek <pavel@denx.de>, Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Linus Walleij <linus.walleij@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jacek Anaszewski <jacek.anaszewski@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>, Linux Input <linux-input@vger.kernel.org>, Linux LED Subsystem <linux-leds@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Bartosz Golaszewski <bgolaszewski@baylibre.com>
List-Id: linux-input@vger.kernel.org


--hkqjlur2zgw6jemw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Apr 24, 2019 at 10:45:00AM +0200, Bartosz Golaszewski wrote:
> =C5=9Br., 24 kwi 2019 o 10:31 Pavel Machek <pavel@denx.de> napisa=C5=82(a=
):
> >
> > On Tue 2019-04-23 11:04:40, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > >
> > > This series adds support for max77650 ultra low-power PMIC. It provid=
es
> > > the core mfd driver and a set of five sub-drivers for the regulator,
> > > power supply, gpio, leds and input subsystems.
> > >
> > > Patches 1-4 add the DT binding documents. Patch 5 documents mfd_add_d=
evices().
> > > Patches 6-10 add all drivers. Last patch adds a MAINTAINERS entry for=
 this
> > > device.
> > >
> > > The regulator part is already upstream.
> >
> > I see v10 in my inbox... and acks from all over the place, but patches
> > not going in. Who takes these? I don't think I need another 10
> > versions in my inbox...
> >                                                                 Pavel
>=20
> I think Lee Jones should take them through the MFD tree. With the ack
> from Sebastian Reichel on the driver part and the example in the
> charger binding fixed I think they are ready to be picked up.

Fine with me.

-- Sebastian

--hkqjlur2zgw6jemw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAlzCKpoACgkQ2O7X88g7
+pr2mBAAkSSqMITsZQW+RCxTbutrVPO+dqNO9WPo6/0+bjuOfMLt5V9ty3vimvhi
K/dCIpbQRO417ZwlyCM+mt5wuhPBGbgOy/65EBAcdFKweDFv4q/tug45qh6V3fZ8
6iaSwd9wXMf2UttkJZ5UeOX+O+ud19RjBVmoJ8HqUG5LA+ud0ZbUcVDhlUEiMcEJ
+zNMo0HQpUuKMmHRp2iKlWkoekPFDhEWnQZbuBxwhVhKbvZCX4LavbHeiR3GCkO8
Q1onr1MjkpFJfrQTjbQLOKFB5i2/I4EMmZ63LECwv5PhaYkb3Rf7dtGj7koS+4ni
rVKYEvSuiCXDPliimXmV6zorkK4FQd2ykZc+pHamTdEMsqanOr+K/BpSh4qOZvqH
Mo2t4FiEqKZ2ATKnfimQsqnPG37cr5yq4cKwukL+hND36maWjws0jF9o2HkXJI8Y
CTcIs+ZGjuDRDgW5bxkpao9P+M16FlKzrkO1EP6LLCBtIQde4nWf5jn26xHj8j56
QHGToQk12PykVLrXrzpWFYxHilzCtV7ZNdSj02rMFJFiCwcxkqPv2jJqQhILJnuR
CcdSpEILZZgcTan0H4p7plyOJWoPpminEHFZLHTNkQyywFYXXQRGHVRvNXjc/P/I
vpvXVsB8WQCEXVhUtJz1fzyEhBSKN0XGOPEWEe6OYtI4rgtm+io=
=X5TB
-----END PGP SIGNATURE-----

--hkqjlur2zgw6jemw--
