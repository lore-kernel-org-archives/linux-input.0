From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v2] input: tca8418: Use the interrupt trigger from the
 device tree
Date: Thu, 1 Dec 2016 10:59:46 +0100
Message-ID: <20161201095946.6ntfrmlrfndbzvyp@lukather>
References: <20161114083911.2423-1-maxime.ripard@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vv5wjcs74zdl6xmq"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53473 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754014AbcLAJ77 (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Thu, 1 Dec 2016 04:59:59 -0500
Content-Disposition: inline
In-Reply-To: <20161114083911.2423-1-maxime.ripard@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org


--vv5wjcs74zdl6xmq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Dmitry,

On Mon, Nov 14, 2016 at 09:39:11AM +0100, Maxime Ripard wrote:
> The TCA8418 might be used using different interrupt triggers on various
> boards. This is not working so far because the current code forces a
> falling edge trigger.
>=20
> The device tree already provides a trigger type, so let's use whatever it
> sets up, and since we can be loaded without DT, keep the old behaviour for
> the non-DT case.
>=20
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Did you have some time to review this?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--vv5wjcs74zdl6xmq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYP/SNAAoJEBx+YmzsjxAgXRQP/1LlcF8LO2XJFsSQtZmYZDpd
ACD03sFq6lmCfUUU6xBNJ3CK04NfQ4vHiBKqwAAkhSsbehCcZlaxnLF9kHBXHvbd
xszBeoto+JJPEBaSOnTe8xciPK1xtN7dAPiw/VVdNF0AA5TyW0jXR/B/2z5l0Sm3
jWgQ1fIjh4xAAwvUiZQo0m2+HkAK2AazU5ANL5v4hezj1DOj+GkrS/mfpzs3G5iL
fHVp2wb7ZxcdRSF8vsPBn/ZgcDdHvxF2AWWGdYhp0tYVvhEMcwtbpWT3o+wvM4j/
MT9fvv0bDj6G8Q6h202xBfvujMsEsfEysXS91P6hMDQKm/w0+9x/Y9VXbV/OZIOb
lnQJkzYcHyCsDiI8uawgpqtuIFk+DZvmhIwEmlNNF8rK8TXz8h0mhmfwZ8hYjI0I
hjAgKqs/mDJAaM0bODgjlZ/eDmI1OBgskxIZfOriz6+7dat1zFWk+GRDBb5amIzT
4r1hW59gWX3zKyDbgwARe/IOobzAsnCcYP261dFUg0ckPeSnaH5gEdYYERbLLd7O
7WLY9SllJ26qaahK3SuWMV+owihebX8JJ+FRGX3xss4+eYu1CuaPKTmGmVdMivPf
+NWVfC7f4iHK9YXOIvmW1a0XQ1GZ76o59ed/uukMlVIG938pV3c2mfw96DXCiM39
FzL2f/2k5knmICWGI1FW
=KRp2
-----END PGP SIGNATURE-----

--vv5wjcs74zdl6xmq--
