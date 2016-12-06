From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 8/9] mfd: wm97xx-core: core support for wm97xx Codec
Date: Tue, 6 Dec 2016 11:13:53 +0000
Message-ID: <20161206111353.fq5445yuzsy7li4i@sirena.org.uk>
References: <1477510907-23495-1-git-send-email-robert.jarzmik@free.fr>
 <1477510907-23495-9-git-send-email-robert.jarzmik@free.fr>
 <20161118165040.GB19884@dell.home>
 <87twb3r94s.fsf@belgarion.home>
 <20161121101219.GB32509@dell>
 <87y406ppjl.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kfpxxoootg7fsnn6"
Return-path: <linux-pm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87y406ppjl.fsf@belgarion.home>
Sender: linux-pm-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Lee Jones <lee.jones@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Sebastian Reichel <sre@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, patches@opensource.wolfsonmicro.com, linux-pm@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--kfpxxoootg7fsnn6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Nov 26, 2016 at 10:18:38AM +0100, Robert Jarzmik wrote:

> >> >> +#define WM9705_VENDOR_ID 0x574d4c05
> >> >> +#define WM9712_VENDOR_ID 0x574d4c12
> >> >> +#define WM9713_VENDOR_ID 0x574d4c13
> >> >> +#define WM97xx_VENDOR_ID_MASK 0xffffffff

> >> > These are probably better represented as enums.
> >> These are ids, just as devicetree ids, or PCI ids, I don't think an enum will
> >> fit.

> > That's fine.  We can use enums to simply group items of a similar
> > type.  Representing these as enums would only serve to benefit code
> > cleanliness.  What makes you think they won't fit?

That would be like having all PCI or USB identifiers in an enum, it's
doable but it means having one big table that all drivers need to
modify.

> >> >> +static int wm97xx_ac97_probe(struct ac97_codec_device *adev)

> >> As for the "sound specific part", it's because AC97 bus is mainly used in sound
> >> oriented drivers, but still the codec IPs provide more than just sound, as the
> >> Wolfson codecs for instance.

> > I'd like to get Mark Brown's opinion on this.

I'm not sure what the question is, sorry.

--kfpxxoootg7fsnn6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlhGnXAACgkQJNaLcl1U
h9BlUQf+IDdEEhHBa2rYkX3rNpzLQ+WwYmYYNJAE8AGrr8d/JMMsf5eDiIlMnp27
yUvyKP46y/88S+5tK963DLSaqukd5NFLV83VGqVz5auX1B3rC2YLpewY0KpFlppC
IPy8+V2uano4HebwcpFAwV+YJh5esg578+lk4mG2WRIxTc04YVPZ16VfiBKwJAf7
yA0SEFhR3i9Ng/n2UCu3jARjs8q2gAFaglrGrKOp3H6y6Saxr9b5S9sjYte++tD5
Z4GP66xinmv/soW8eHYGQcZvq1Bp/K6TgOv94PdO8ZE6H4ha0crpp3hDUoxWzkmC
bW6HkmIgcgptOnX7ro9dsIVgfJrKSQ==
=BTZB
-----END PGP SIGNATURE-----

--kfpxxoootg7fsnn6--
