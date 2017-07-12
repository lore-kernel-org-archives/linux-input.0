From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v3 00/12] AC97 device/driver model revamp
Date: Wed, 12 Jul 2017 11:55:30 +0100
Message-ID: <20170712105530.p3yb2gj3vt3thlab@sirena.org.uk>
References: <20170630194408.24978-1-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="xfp3lqwfrgd6coml"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:48952 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754528AbdGLK4T (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 12 Jul 2017 06:56:19 -0400
Content-Disposition: inline
In-Reply-To: <20170630194408.24978-1-robert.jarzmik@free.fr>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org


--xfp3lqwfrgd6coml
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 30, 2017 at 09:43:56PM +0200, Robert Jarzmik wrote:
> Hi Lars, Mark, Charles, Lee,
>=20
> This is a resend of the v2, with patch 1 added (forgotten in v2). Patch 1=
2 was
> slightly modified after module unloading tests, and Dmitry acks were adde=
d.

This all looks good to me modulo the naming thing Takashi raised.

--xfp3lqwfrgd6coml
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllmACIACgkQJNaLcl1U
h9BXIwf/Zj3vuqVYZozqaWjj7tUBJhb7dZnyYnKNNGpM9vQXRN1l8XRIYNuFn56j
fvnh70UUdrYtCO2ZKbRmJ9s4KDBaQ3Vma8SAzyTLVtoJls9Qn6IYWQ7OYhfOKKk8
IVYMljrY2XnyZ/ipLB1dWhqCpK8ZRVnUvp+92glN4F8lugZkb3A5PXZxzw4FN1qy
tKars8BbXw8yONVhbGTyC3eNYghyi5ryCGYfQcNm79PDtFTm9T49A7ChgCZ3B+65
sMYDyIvT8OL/i5Jidjhq8NFngHf+b765IXoH9PN8Vq6IBmQg9TnsOKLnLYiGpg+7
iJhcxL2WwBwWXHjvAkkzm3KA4a1Jqw==
=7aZN
-----END PGP SIGNATURE-----

--xfp3lqwfrgd6coml--
