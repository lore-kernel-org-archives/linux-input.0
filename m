From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 1/2] Input: Add driver for Cypress Generation 5
 touchscreen
Date: Mon, 21 Aug 2017 22:28:15 +0200
Message-ID: <20170821202815.ndu5gzfhe2glv7wc@flea.lan>
References: <20170818062045.31280-1-mylene.josserand@free-electrons.com>
 <20170818062045.31280-2-mylene.josserand@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="2ebyd7pi4vduen4j"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170818062045.31280-2-mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--2ebyd7pi4vduen4j
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 18, 2017 at 08:20:44AM +0200, Myl=E8ne Josserand wrote:
> This is the basic driver for the Cypress TrueTouch Gen5 touchscreen
> controllers. This driver supports only the I2C bus but it uses regmap
> so SPI support could be added later.
> The touchscreen can retrieve some defined zone that are handled as
> buttons (according to the hardware). That is why it handles
> button and multitouch events.
>=20
> Signed-off-by: Myl=E8ne Josserand <mylene.josserand-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

Reviewed-by: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--2ebyd7pi4vduen4j
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZm0JfAAoJEBx+YmzsjxAgR2oP/1DJKsBbtunfKGHrqNAa4wup
e20/IC0rz1SVfubQKE+WXmh5ZjAo3UGjU4HSLCZhQQgqXXBL7qKWlORdXTk2Esvl
gA32fjuuPIvueWs0MI+/bIrqdu8DfB5khDuRJgGjyXZ6PnDRImK1de4/EykJgai2
hYLxnG+fvEyCG/olfOE7X+4pMCKXxXQnKcf5DnpR0FHtw2Y/jUyJmKjbCP8XN8ms
OmpyXnrPVta8/ihgO/85MyqL8HHgKH5BJcgmAcE6hwjNo/uar/Gmlr0WfUb2Y6uS
sdhsNDhqNOHJAes4KICFg5p/tXqoTSmJkkjRDtcc3LA0oXXimOTb9XwsITR6ttnU
9whut9H2H8BDYbbZjttNbJ69S8jKlnqRJstqecDo4U+KXcRw8G6kfIaSi0NWqlVf
FiTRa9S6JwCAZMJIJxdeRh0nL05svV99Fm8Vsk32NSx75dVjEBUwyHhT1wo4Wjfr
IhQEnepH+cJAPrQYnWZjc89sc4WhBFXrwg4sx4rdnHAQm7Jes/hmY4T1+5yVHACg
DNASBcpfMTY5zo7fxxCuVn/pV1sbFB+aelM8h5clDwi/Y/JO7OpsHmS1fyISTWgs
xW58CnVMenSnRfhbofHH94iWFlwSrUvJhfDfEi2eWt+8XKbrHN+xkJsR0Brx4taM
NFFgBEzJIOezOvnhdBuy
=l/8H
-----END PGP SIGNATURE-----

--2ebyd7pi4vduen4j--
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
