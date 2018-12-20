From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: [PATCH v2 2/2] input: add official Raspberry Pi's touchscreen
 driver
Date: Thu, 20 Dec 2018 20:12:23 +0100
Message-ID: <2c433e120c2cf375b7d431f79ce6bfbace803c7e.camel@suse.de>
References: <20181211112408.9524-1-nsaenzjulienne@suse.de>
         <20181211112408.9524-3-nsaenzjulienne@suse.de> <87r2ecdovo.fsf@anholt.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-VNpI8kJnLV6TKHOFqu+A"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <87r2ecdovo.fsf@anholt.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Anholt <eric@anholt.net>, Henrik Rydberg <rydberg@bitmath.org>
Cc: linux-rpi-kernel@lists.infradead.org, stefan.wahren@i2se.com, agraf@suse.de, afaerber@suse.com, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Labbe <clabbe.montjoie@gmail.com>, Mark Jonas <mark.jonas@de.bosch.com>, Masanari Iida <standby24x7@gmail.com>, Heiko Schocher <hs@denx.de>, Hans de Goede <hdegoede@redhat.com>, Eugen Hristev <eugen.hristev@microchip.com>, Zhu Yi <yi.zhu5@cn.bosch.com>, Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-VNpI8kJnLV6TKHOFqu+A
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2018-12-20 at 10:39 -0800, Eric Anholt wrote:
> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> writes:
>=20
> > Add's support to Raspberry Pi's 7" Touch device. Instead of using a
> > conventional bus all information is copied into a memory mapped
> > area by
> > RPi's firmware.
> >=20
> > Based on the driver found in RPi's kernel repository.
> >=20
> > Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
>=20
> While I wish we could just have a native driver instead, it does make
> sense to have this driver upstream given the constraints.
>=20
> Acked-by: Eric Anholt <eric@anholt.net>

Thanks Eric.

FYI I did manage to access the touchscreen after altering the native
driver (edt-ft5x06). That said, as commented in the cover letter, it's
not good enough as it breaks the camera. I plan on posting the patch
and an overlay. I'm just waiting to see how these first patches are
received.

--=-VNpI8kJnLV6TKHOFqu+A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAlwb6ZcACgkQlfZmHno8
x/6Y8ggAi7oMS/uM+2GYb+jaxFtxar1otppH5rs755UJAiVYcVw66W8wfOz5hKKt
1V92UBBGnfrvGlZB0vZsDyef+C6MFuBWNwUdiXatgWO+keAVKAg+EqiI7jH84GRj
H3TD3urFXUGGsknN5ZSZA9OpFFDtWguW+hn5vDfSmK4SuxJV6/wa9DWgKuk+y+H+
Uc6CNc0wlNXnTFHns9mi8moujpph5BEDdUAm/6EXtw/uxNP01LhdARBc0sCGrRL5
LlOMTZOggkd2IxCVbB2xtK2HKEIrVmDvqOfgZKjbYo6a2RI4g/F6vjxxBxUG0Tpr
31bZdKMfgVlNnGJilD5XxXE9pEzEAA==
=uELI
-----END PGP SIGNATURE-----

--=-VNpI8kJnLV6TKHOFqu+A--
