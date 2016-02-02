From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v10 4/8] mfd: fsl imx25 Touchscreen ADC driver
Date: Tue, 02 Feb 2016 12:41:40 +0100
Message-ID: <6151166.y0HMDdqtvF@adelgunde>
References: <1450101234-2191-1-git-send-email-mpa@pengutronix.de> <1450101234-2191-5-git-send-email-mpa@pengutronix.de> <20160111065441.GW3331@x1>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2458794.MQBc4Lxljv"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20160111065441.GW3331@x1>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?ISO-8859-1?Q?B=E9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--nextPart2458794.MQBc4Lxljv
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi,

On Monday, January 11, 2016 06:54:41 AM Lee Jones wrote:
> On Mon, 14 Dec 2015, Markus Pargmann wrote:
>=20
> > This is the core driver for imx25 touchscreen/adc driver. The modul=
e
> > has one shared ADC and two different conversion queues which use th=
e
> > ADC. The two queues are identical. Both can be used for general pur=
pose
> > ADC but one is meant to be used for touchscreens.
> >=20
> > This driver is the core which manages the central components and
> > registers of the TSC/ADC unit. It manages the IRQs and forwards the=
m to
> > the correct components.
> >=20
> > Signed-off-by: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Signed-off-by: Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>
> >=20
> > [ensure correct ADC clock depending on the IPG clock]
> > Signed-off-by: Juergen Borleis <jbe-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
> > Acked-by: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> > ---
> >=20
> > Notes:
> >     Changes in v7:
> >      - Cleanup bit defines in header files to be more readable
> >      - Fix irq check to return with an error for irq <=3D 0
> >      - Add COMPILE_TEST in Kconfig file
> >    =20
> >     Changes in v5:
> >      - Remove ifdef CONFIG_OF as this driver is only for DT usage
> >      - Remove module owner
> >      - Add Kconfig dependencies ARCH_MX25 and OF
> >=20
> >  drivers/mfd/Kconfig             |   9 ++
> >  drivers/mfd/Makefile            |   2 +
> >  drivers/mfd/fsl-imx25-tsadc.c   | 203 ++++++++++++++++++++++++++++=
++++++++++++
> >  include/linux/mfd/imx25-tsadc.h | 140 +++++++++++++++++++++++++++
> >  4 files changed, 354 insertions(+)
> >  create mode 100644 drivers/mfd/fsl-imx25-tsadc.c
> >  create mode 100644 include/linux/mfd/imx25-tsadc.h
>=20
> For my own reference:
>   Acked-by: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>=20
> I will apply this and sent out pull-requests to the relevant
> maintainers once -rc1 is out.

Thanks. Do you mean just this patch or the whole series?

Shall I resend the whole series to fix the commit title of the first
patch?

Best Regards,

Markus

=2D-=20
Pengutronix e.K.                           |                           =
  |
Industrial Linux Solutions                 | http://www.pengutronix.de/=
  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0  =
  |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |

--nextPart2458794.MQBc4Lxljv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAABCAAGBQJWsJX0AAoJEEpcgKtcEGQQjNcP/214dQVDTNzK8gpUr6sMUCoF
L8b8setMn+y+qAQTQD+hJNCfSUMP7O5SFvR+k54XxmBvJxRzrSiGWKFHwBO2lkGu
zjCVNs8CFn941cBYYn44NKm7q7u11vBq74K0tpercVppG7q/mXkasDJz86Ni+wlN
FZ2jzGCqT+ct/ZV+AfuSMRc93A5ya2oFIajLw0/KnuR3/TbNKF/NpjFfFgQjyFtg
w+wdLQ19TxlldDJU8KEKs7dR5ComTNul9JSA+y4SHaiGcLEuR/mCUFhvtOB2S4ys
UgKhB8XkVVG6fHTBjqQgm9Gu3c9lvTnQKfyd1ywopfv1WH3bR4bU1/Pe3Rb8zEuz
WoFxgRWiDiPcNTeoO0g0M8uYu8WT4n7cMh/oZ6r1tncn5okPhm3dSeyH0GggpXJ3
saHc0YeMno3FLoE5sV7Sf5QL+IBM6tK5aB/BpPrTJbP05CFJsPp53gkXLO+UaQxK
wXnbRxBSynd3xLOjf8eQcZRAnRl6PJc7sGhV7AL9wLJaYXO/uLwKWL93ZEkvxx4/
at63+vTqw804s9eIxEFDJhUqQ7TpJX7JX09xR7SXuo0r0QLbODu9HLT2nHg0IibJ
8a3f7+LJuNlklffNdmvphN2DZogT6njaqDkiok4qoJ7uyREUjK44B7DoByH/e4/9
W4RVRyuZ4wjwXj73dpH4
=t7PK
-----END PGP SIGNATURE-----

--nextPart2458794.MQBc4Lxljv--
