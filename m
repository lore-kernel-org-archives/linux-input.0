From: Mark Brown <broonie@kernel.org>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Wed, 4 Oct 2017 15:57:10 +0100
Message-ID: <20171004145710.kk5bmuf3fqqmiuqv@sirena.co.uk>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
 <20171004103213.4ezs6ie6z6dq7pvh@sirena.co.uk>
 <e0352de3-f346-f6c0-5fab-7353d4c0d696@majess.pl>
 <20171004112704.beqzaxwsb5tg4nbm@sirena.co.uk>
 <abe393e3-66fe-3c00-8b87-2375cc01d6f5@majess.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="nvdy7jgoq6imvt5h"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <abe393e3-66fe-3c00-8b87-2375cc01d6f5@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@majess.pl>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org


--nvdy7jgoq6imvt5h
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 01:54:49PM +0200, =C5=81ukasz Majewski wrote:
> > On Wed, Oct 04, 2017 at 12:45:39PM +0200, =C5=81ukasz Majewski wrote:
> > > > On Tue, Oct 03, 2017 at 06:58:00PM +0200, =C5=81ukasz Majewski wrot=
e:

> > > In this case we use VBUS as a power supply voltage. The problem with
> > > regulator API used in this case is that we enable it on boot-up, but =
then we
> > > cannot "symulate hotplug" anymore.

> > I don't really understand what you mean there, sorry.

> I do use "regulator-fixed" to control VBUS.

> The USB driver used regulator_enable/disable to supply power of VBUS.

> What I do want to achieve:

> For testing purpose I would like to enable/disable this supply (VBUS) and
> force/restart of re-enumeration.

I'm having a hard time connecting that with what you wrote above or with
the suggestion to do this in the USB framework, sorry.

--nvdy7jgoq6imvt5h
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnU9sUACgkQJNaLcl1U
h9Bc6Af/cCN176V0XHul68PzwlKFBOYoK14JCUgf1iN9Z+COJqF5MttY+NG3aTk4
IVo5RbTi0kOFWBrwAOCp3JSO5kp09XfTV4eX/H9Lnq2kyBOKWTCwo28UveOFYEMW
2wp0DrtXEWCoyuO9oacAv30JKewLMiDQFx08vXxuGkvq95i7AQbzME6ZS+6XF1al
gchawgbKFDS57h/qckbSZNJezvlCqx5YMYxUU1eKYGcmJV5lgQ7XAcJWLmTlBa8E
S+QIPqkI8IPZ9Qv2MAH1aKlw5f/UqvK7OQHUlL+UG8oYE0NxRLI/OuaJ3I6IJai5
tmCmv+t+p+GiVM9DkLBM8fkt+svuIg==
=+jMH
-----END PGP SIGNATURE-----

--nvdy7jgoq6imvt5h--
