From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v6 09/12] ASoC: wm9712: add ac97 new bus support
Date: Mon, 4 Sep 2017 17:42:35 +0100
Message-ID: <20170904164235.dkw7ngqmycg7k3tl@sirena.org.uk>
References: <20170902195414.3699-1-robert.jarzmik@free.fr>
 <20170902195414.3699-10-robert.jarzmik@free.fr>
 <20170904101849.7uefwhuqz4vtntrp@localhost.localdomain>
 <8760cyppvj.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="64pzcz7bnmxja27f"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <8760cyppvj.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Charles Keepax <ckeepax@opensource.cirrus.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Lee Jones <lee.jones@linaro.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--64pzcz7bnmxja27f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Sep 04, 2017 at 03:14:40PM +0200, Robert Jarzmik wrote:
> Charles Keepax <ckeepax@opensource.cirrus.com> writes:

> > This bit is still missing the ifdef it has in the preceeding
> > patch.

> Damn, you're right, it's missing in both wm9705 and wm9712, but not in wm9713.
> That will be for the hopefully last volley of this serie.

Given that this just missed the merge window but has now been reviewed
by Takashi as well what I'm thinking is that it's going to be easiest to
apply the start of it now so hopefully no need to respin the whole
series so often.

--64pzcz7bnmxja27f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlmtgnsACgkQJNaLcl1U
h9CNEgf/ScJc/pvnHZwJl/T2AiN/LXlKACqWexhNQcW43mBn631ynN2NBMUNc0eb
97h19ZeglQbBfV8dP2mGPssqe6q0F9GlZ7uP5XObVz+1cGBrR8DT4bB28Cn1/JxY
dZIezBpChvrhCIH/+VG7K19YTi5ieWO3UnyQaPSlQlYDcgXUzSVeap2Q1hNsUEMt
BOuGGzOarOJbgYmvNwBb8qoevPxlvvsG2+yZ7yf7vJJGXSaP9/Ywlk1Z5tqDoYDU
eNK9Y0fqVEaxSV4hnN9zBkGj6jPHV4o+MHQXBnIK3NU6MSAWEOhqUUSVhW1tyYeO
JDIRor2U2sJM7c19haPDmpgrLczHSw==
=LYJr
-----END PGP SIGNATURE-----

--64pzcz7bnmxja27f--
