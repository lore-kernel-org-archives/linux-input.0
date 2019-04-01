From: Mark Brown <broonie@kernel.org>
Subject: Re: INFO: task hung in evdev_release
Date: Mon, 1 Apr 2019 04:01:40 +0100
Message-ID: <20190401030140.GA2059@sirena.org.uk>
References: <000000000000f1be430578524a20@google.com>
 <000000000000bf3ccd05851d68a7@google.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="AqsLC8rIMeq19msA"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000000000000bf3ccd05851d68a7@google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: syzbot <syzbot+a979743610b4755d4d57@syzkaller.appspotmail.com>
Cc: alsa-devel@alsa-project.org, devicetree@vger.kernel.org, dmitry.torokhov@gmail.com, jbrunet@baylibre.com, lgirdwood@gmail.com, linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, mark.rutland@arm.com, robh+dt@kernel.org, rydberg@bitmath.org, syzkaller-bugs@googlegroups.com
List-Id: linux-input@vger.kernel.org


--AqsLC8rIMeq19msA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2019 at 06:24:01PM -0700, syzbot wrote:

> syzbot has bisected this bug to:

This bug being...

> commit e32d99af6830c9a8f37b4f2637ef0cdc60fa79fb
> Author: Jerome Brunet <jbrunet@baylibre.com>
> Date:   Tue Jul 17 15:42:50 2018 +0000
>=20
>     ASoC: meson: add axg fifos DT binding documentation

This is fairly clearly a false bisection result.

--AqsLC8rIMeq19msA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlyhfxIACgkQJNaLcl1U
h9CYJgf/UNLYpBORuC8ySyXKjv9u88zc9YzTYOz9msumtsKzL05CjdW72UucOcW+
xF71zVLPkWxpOiiz1GY0i6KR6T/H2BZ/nOLm+RK57DE+d06FNkrZY5WFkoqBT8WV
HjOs/QJYpH+tIlirwTzrnxp1ADaROD6otZfhVhFsQGE3VoYIPn9A7quYaEbVMHeM
i6/Bs/q1g3K6B3zrBEueeGS4bew2Pha8Jd33/BBOCbiODNnIuBuCeOUc5LLcyVJg
BdewxSIh7TU+bAvJvFNYEtOJTM1hbMNv23ZH/GETjakfjql014dpzzN77zdRhnBO
XWgjVW7HaG0ycAwLYu1hbc+F9VoI7A==
=RbAG
-----END PGP SIGNATURE-----

--AqsLC8rIMeq19msA--
