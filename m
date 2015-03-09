From: Markus Pargmann <mpa-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Subject: Re: [PATCH v7 0/8] imx25 adc and touchscreen driver
Date: Mon, 9 Mar 2015 10:24:41 +0100
Message-ID: <20150309092441.GC3632@pengutronix.de>
References: <1425369498-25541-1-git-send-email-mpa@pengutronix.de>
 <54FB4249.6070801@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TYecfFk8j8mZq+dy"
Return-path: <linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <54FB4249.6070801-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Sender: linux-iio-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jonathan Cameron <jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Samuel Ortiz <sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Peter Meerwald <pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org>, Hartmut Knaack <knaack.h-Mmb7MZpHnFY@public.gmane.org>, Denis Carikli <denis-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Eric =?utf-8?Q?B=C3=A9nard?= <eric-fO0SIAKYzcbQT0dZR+AlfA@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--TYecfFk8j8mZq+dy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 07, 2015 at 06:24:09PM +0000, Jonathan Cameron wrote:
> On 03/03/15 07:58, Markus Pargmann wrote:
> > Hi,
> >=20
> > This series adds a driver for the Freescale i.MX25 SoC internal ADC uni=
t which
> > is used for touchscreen and ADC. The driver consists of three parts, th=
e MFD
> > driver which handles interrupts and some central configuration register=
s, the
> > ADC driver and the touchscreen driver.
> >=20
> > v7 has some modifications in the probe functions to use devres irq requ=
ests.
> > irq checks were fixed to check for irqs <=3D 0. The header was cleaned =
up to have
> > a more uniform presentation of the bit fields. Detailed changelogs are =
attached
> > to the according mails.
> >=20
> > Best Regards,
> >=20
> > Markus
> Almost there as far as I am concerned.  Just that one unbalanced regulato=
r_enable
> that needs dealing with.  The bindings are pretty simple so whilst a devi=
ce-tree
> ack would of course be great I guess it could be taken without.
>=20
> This wants to go via mfd or I suppose the freescale/arm-soc tree.  Either=
 is fine
> with me.

Thanks for your review. I will fix the missing parts.

Best Regards,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--TYecfFk8j8mZq+dy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU/WbZAAoJEEpcgKtcEGQQZZMP/2U+HtuU0et/wosvOZ2YFd+K
pSDXn2zruTEVh1+LGZG4rD6MoQj6UnG29CTZiQDnC6UNPjp/SiXGexRsuMCJVWuz
hohqnf31zm4bmX6ZJlocxSb7jjldmk9P1nuOkzg/zF7sKI97JVG+s8ZIsH8r2BpM
IZodzn30nlpqLJZ0h5nq0+jug+4ie+n1RUXG95i9sHnkarLVBJ1OernmetyF6YcM
076e6RbzQp2jvXMUTFGz+wqUhYpIE27DY13fans/QgVe+GvN3Bo1hL1ik3BfgsiJ
VNPADOCfmKbVcPeqwVopCy0fByBPOJEkDp9q5I8mIpEt2cqSVLC23th0okHM52OV
EThSPB+cLRFC9TnjIQx+9EDDwDFKShC2C1VMwQxIpLxo+BlxE10NGcOBsw1DaLzU
fwsEIxhQIMJ+qLP+/+9J7AUOxt1ZA1RgGEpAgGtc4VGrFCPQo+VY7xPtWL+K2qFI
WLxfWyMz74kaYUOsAGZce4ewrvyP+a5swso6YrtCS2nFJQ32EYZnIoM36ov9VKTI
2rqY1+o2bJxc2PPVctneekL58Np7/bKaEXWmKu5D+60/dT1jQ7VSsHbJcOn4qktR
/h8xzHlHMtbJE/3q+BrhopFjC4S3F4nMjyqClKiUJJ2Xjf6Ja1GdjoiiCNgni+oi
eWvL+iHU/zms2zSOw0F+
=K/6l
-----END PGP SIGNATURE-----

--TYecfFk8j8mZq+dy--
