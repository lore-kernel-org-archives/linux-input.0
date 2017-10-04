From: Mark Brown <broonie@kernel.org>
Subject: Re: [Regulator] Request for clarification - GPIO controlled
 regulator, USB VBUS,
Date: Wed, 4 Oct 2017 12:27:04 +0100
Message-ID: <20171004112704.beqzaxwsb5tg4nbm@sirena.co.uk>
References: <c4ba36d3-c495-8ddf-9aa7-3e25e5b44672@majess.pl>
 <20171004103213.4ezs6ie6z6dq7pvh@sirena.co.uk>
 <e0352de3-f346-f6c0-5fab-7353d4c0d696@majess.pl>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ktxtzlkmflj546u7"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <e0352de3-f346-f6c0-5fab-7353d4c0d696@majess.pl>
Sender: linux-kernel-owner@vger.kernel.org
To: =?utf-8?Q?=C5=81ukasz?= Majewski <l.majewski@majess.pl>
Cc: linux-input@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org


--ktxtzlkmflj546u7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 04, 2017 at 12:45:39PM +0200, =C5=81ukasz Majewski wrote:
> > On Tue, Oct 03, 2017 at 06:58:00PM +0200, =C5=81ukasz Majewski wrote:

> >  Perhaps this is something
> > that could be implemented generically for USB as it's a hotpluggable bus

> In this case we use VBUS as a power supply voltage. The problem with
> regulator API used in this case is that we enable it on boot-up, but then=
 we
> cannot "symulate hotplug" anymore.

I don't really understand what you mean there, sorry.  The majority of
regulator usage is to supply power, use as reference voltages or
similar.

--ktxtzlkmflj546u7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnUxYgACgkQJNaLcl1U
h9Bdigf/TtbVtXK8dcgtCXqaePwxPoXRKYePFcJw2rI27UdQYRlC1YMVO5eCFnVc
quUmuvHfpyRHtKOgmmVW0CQaO+pdJklAk+wfBsbhG6KtUzBekb4iFudY2MGqrcUr
9WTLenFl7LSIrVcaMYYVVgkJexJdCYy94EComWL6lTfwbwwqku0WGcb/QwQyndcT
/r+sy5A5imKZxD/D90U3AO8KGlpDH9CZco7XHZshgtjVx3WLLiqVWwtqQJakVqoM
M++3cU6rUVs4/sGvhFSv233//WoML2ledHOhOVjh7DJdvzJp6JGfsz96VrzCoC1X
hm6dHINO3pV/DpEmg57b2J78VN45ww==
=2jZy
-----END PGP SIGNATURE-----

--ktxtzlkmflj546u7--
