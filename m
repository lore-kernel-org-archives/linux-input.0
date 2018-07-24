From: Marcus Folkesson <marcus.folkesson@gmail.com>
Subject: Re: [PATCH] input: pxrc - do not store USB device in private struct
Date: Tue, 24 Jul 2018 20:09:59 +0200
Message-ID: <20180724180959.GA2864@gmail.com>
References: <20180716144014.6331-1-marcus.folkesson@gmail.com>
 <20180724023804.6mnbstzdrcp74rev@penguin>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="YiEDa0DAkWCtVeE4"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180724023804.6mnbstzdrcp74rev@penguin>
Sender: linux-kernel-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Alexey Khoroshilov <khoroshilov@ispras.ru>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--YiEDa0DAkWCtVeE4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Dmitry,

On Tue, Jul 24, 2018 at 02:38:04AM +0000, Dmitry Torokhov wrote:
> Hi Marcus,
>=20
> On Mon, Jul 16, 2018 at 04:40:14PM +0200, Marcus Folkesson wrote:
> > The USB device is only needed during setup, so put it back after
> > initialization and do not store it in our private struct.
> >=20
> > Also, the USB device is a parent of USB interface so our driver
> > model rules ensure that USB device should not disappear while
> > interface device is still there.
> > So not keep a refcount on the device is safe.
> >=20
> > Reported-by: Alexey Khoroshilov <khoroshilov@ispras.ru>
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > ---
> >  drivers/input/joystick/pxrc.c | 22 ++++++++++++----------
> >  1 file changed, 12 insertions(+), 10 deletions(-)
> >=20
> > diff --git a/drivers/input/joystick/pxrc.c b/drivers/input/joystick/pxr=
c.c
> > index 07a0dbd3ced2..46a7acb747bf 100644
> > --- a/drivers/input/joystick/pxrc.c
> > +++ b/drivers/input/joystick/pxrc.c
> ...
>=20
> > @@ -204,23 +204,25 @@ static int pxrc_probe(struct usb_interface *intf,
> >  		return -ENOMEM;
> > =20
> >  	mutex_init(&pxrc->pm_mutex);
> > -	pxrc->udev =3D usb_get_dev(interface_to_usbdev(intf));
> > +	udev =3D usb_get_dev(interface_to_usbdev(intf));
>=20
> There is really no need to "get" device for the probe duration, or in
> general, when you are not storing the reference to it.
>=20
> I posted series with an updated version of this patch plus couple more
> cleanups/fixes, and would appreciate if you could give it a spin.

Thank you for doing this.

I have reviewed the patchset and tested on real hardware, and it looks good
to me.

For what it's worth:

Reviewed-by: Marcus Folkesson <marcus.folkesson@gmail.com>
Tested-by: Marcus Folkesson <marcus.folkesson@gmail.com>=20

On the whole patchset.

>=20
> Thanks.
>=20
> --=20
> Dmitry

Best regards
Marcus Folkesson

--YiEDa0DAkWCtVeE4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEBVGi6LZstU1kwSxliIBOb1ldUjIFAltXa3EACgkQiIBOb1ld
UjKr6RAAxBBPXuGaXIepNqA8k4QPrnfqoD4Giy9cteMeKIC4AF4baWejBZHqf+8D
qhq65jx1IoP+ZRXZVDNRT5HPKGnAaIMPLe1+1Mer2tMwQkmDjZNYtbxcSKjCrhoz
51UhUEsMIpGKuiB1doQ8IOPywBiUik6SvpJeXJQOehnFMo+hiozOy/re0E8ZsK62
h7aPLFAn2dgOsUWbikVSVoduc/Wcik1+3BFLkkBdXdajRqTYG/6mOSS6+4aSnPND
UowfABodFGb6U7PgU1B2iCvxClMyw1STY6TqwAUa1uotkfPj5bB6Zce+lAU0BbWR
IRTdA5MiRe+AnFqfexlQNu81RVtIGy4Qej0cCQ87QI5HO1vza3d4nLo7yWXhFops
WW7UeMGiFAjari4oHJNWfk9VH2HI4S32eeCe3xqdPzNMdIMhX0Xrlb1Bo+iFW9lx
dD2Y3XNuiX0WITmrLx7+dr+SEqgDvhgxjvXUUqQYlii0yZMagKt+iA3paypFr960
AzKdqpGi2EkJUZ2acwR61S8pbib68X1Rpvq0D4QDCqeDKZ0v0SN/vTN6mTBYh1Uz
IVU89c09T902uORhbLRiEAUVe809KiSIVCgqvlJQJJw1rSLW+o4nOVR6dXMlshsf
gnaPTut28qETXr/nDkQ1setbDDDanv5643j8JAKc2GOwkLwGaJU=
=t1xJ
-----END PGP SIGNATURE-----

--YiEDa0DAkWCtVeE4--
