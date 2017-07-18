From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH 1/2] Input: axp20x-pek: add support for AXP221 PEK
Date: Tue, 18 Jul 2017 09:57:07 +0200
Message-ID: <20170718075707.h2ul6vlhsco4ts5u@flea>
References: <20170717095307.15986-1-quentin.schulz@free-electrons.com>
 <20170717095307.15986-2-quentin.schulz@free-electrons.com>
 <20170717112912.rsi72f4t74nsp6nr@flea>
 <522ebac5-49ba-fb18-4d9a-b8e50c9d55c3@free-electrons.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="ldsmsoedk7lt6cdo"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:47159 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751334AbdGRH5T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Tue, 18 Jul 2017 03:57:19 -0400
Content-Disposition: inline
In-Reply-To: <522ebac5-49ba-fb18-4d9a-b8e50c9d55c3@free-electrons.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: dmitry.torokhov@gmail.com, wens@csie.org, lee.jones@linaro.org, hdegoede@redhat.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com


--ldsmsoedk7lt6cdo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 18, 2017 at 09:36:04AM +0200, Quentin Schulz wrote:
> >> +
> >> +	error =3D sysfs_create_group(&pdev->dev.kobj,
> >> +				   axp20x_pek->attribute_group);
> >=20
> > Wouldn't it make more sense to just store the startup_time structure
> > in the axp20x_pek structure, rather than duplicating all this?
> >=20
>=20
> I don't know. Basically, you would need to recreate manually all the
> structures in the probe function, but why not.

Why?

You have access to axp20x_pek in the readout function. You can just
use the table stored in the structure here, and just ignore any
argument you might have.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--ldsmsoedk7lt6cdo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZbb9TAAoJEBx+YmzsjxAg+7kP/1k2x+XciV//aTaB1cqRqZjh
sGkxE6YgGhbR3SAoP+D4eNZd28gIoZCszjUp0QxVwb3RhIfAZyNhxAnawhbv8l6c
7koUS3gkkFTEgSJnOFhK76LKGdm2lHRTpk3yMXGxgoDA5fefZKZGhaE1uThWKo93
Nj0DkKY4OIru/7a6dqCfkPWsTwxplbePNUzvnaKz5iXKVO1eP6Qe6NTxsFAxgkrR
9Hm9eEQl4b4AcAWSWtgcAGAEAQ5Bssej2823QXcxJBFnj49XV+OXOr+rShQ+d1Wa
RQWxW4OUku5GNdb28xPBNumvCK22ERZm1XOokhF+lUMP+gTJFJuWwxqipDud/Z17
BBty2EpwyvZpwkHWXxmR1RdSu3c3TgPZkV/OwIN4GdEh2iDpcZ6HL7eiJrr9bnPj
wqlIJ8y7ttuLA9hcIfUGAk5YByPw3JTHRjhu7mYcuRz3rphxtp9Jj4jo7DiybYns
7avhnGHtf6rjln3IzXrMg4Y/16LQYh1K4Uzejy2Zbnrt3pY5HkZaOlnYKddrOwn5
e19J+EIANk9WVcBklw0V+OnGkz0uZRugKod9QlWCQxRhcvoK2sqc5PAy5BEStR+h
mJxE2oQIjWmUAba7M3YvKMHdr2p5gwGAoqNoIgfUj9DEmH/e+VYJu6bn+qvtoeIV
LZy1PIAk37X1ODWdbIjM
=+d9a
-----END PGP SIGNATURE-----

--ldsmsoedk7lt6cdo--
