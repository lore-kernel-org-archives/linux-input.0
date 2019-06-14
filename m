From: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Subject: Re: Regression post "HID: core: move Usage Page concatenation to
 Main item"
Date: Fri, 14 Jun 2019 10:29:36 +0200
Message-ID: <4bb29ccf9848d7147cf975d8ed1f7f649ed72be0.camel@suse.de>
References: <CAEXycp+Y-x7N_Yr==Xy_CT5K_a1DZYc85w1OUV+cKC5ZN+KB1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-U9yRqFBIo6enOd/x5jVj"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAEXycp+Y-x7N_Yr==Xy_CT5K_a1DZYc85w1OUV+cKC5ZN+KB1g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jean-Baptiste =?ISO-8859-1?Q?Th=E9ou?= <jb@essential.com>, Jiri Kosina <jikos@kernel.org>, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--=-U9yRqFBIo6enOd/x5jVj
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2019-06-14 at 09:01 +0900, Jean-Baptiste Th=C3=A9ou wrote:
> Hi,
>=20
> This patch (58e75155009cc800005629955d3482f36a1e0eec) is triggering a
> regression with the following descriptor (report not working as
> expected)
>=20
>=20
https://partner-android.googlesource.com/platform/cts/+/refs/heads/q-fs-rel=
ease/tests/tests/hardware/res/raw/asus_gamepad_register.json
>=20
> Didn't see anything obviously wrong with this gamepad descriptor, so
> not sure what's trigger the regression.
>=20

I'll have a look at it.

Do you have any more information on the regression? What exactly isn't work=
ing?

Regards,
Nicolas


--=-U9yRqFBIo6enOd/x5jVj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEErOkkGDHCg2EbPcGjlfZmHno8x/4FAl0DWvAACgkQlfZmHno8
x/7FBAf+JzgyfKk2vvWqED/dX0TFOZmtkPT14VCNY/I1UISIYlrf68w0q0h5KR6d
Dx4KWGlQ9WcoLjB2cn4qkKs3SLdCRJ/wSKoJhRvMGJQvw3xjGN+aAyk7F0/y199E
Or65Ty5CbADBWKMyAt5yzxyn+NFNvkLkU3Au0WnUvRdBFwFVz72vqLUQd10UU6GD
yGi2e7rRzm+PUpj5npx/Vw3K1IVl1f0Xax7JvXY237ZNaobcktWLqv57nJKWyaQ4
hCjlChopG2mITmZFLuIXQ28qRpoAKNrzMS8hJ2knHN+CFDKzCl+gGMPkmVAmc7fl
wxGT+xw9cNMKi0iDWY2alW1SKyESCw==
=ZkvD
-----END PGP SIGNATURE-----

--=-U9yRqFBIo6enOd/x5jVj--
