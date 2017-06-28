From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 12/12] ASoC: Fix use-after-free at card
 unregistration
Date: Wed, 28 Jun 2017 20:53:49 +0100
Message-ID: <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5429251308396227574=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <87injstckf.fsf@belgarion.home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Takashi Iwai <tiwai@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, Haojian Zhuang <haojian.zhuang@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, patches@opensource.wolfsonmicro.com, stable@vger.kernel.org, linux-input@vger.kernel.org, Daniel Mack <daniel@zonque.org>, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Lee Jones <lee.jones@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-input@vger.kernel.org


--===============5429251308396227574==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="auuyw7lgbv2sjo2s"
Content-Disposition: inline


--auuyw7lgbv2sjo2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 19, 2017 at 01:57:20PM +0200, Robert Jarzmik wrote:

> My serie shifted by one, so the very first of the serie is therefore missing,
> formerly "ALSA: ac97: split out the generic ac97 registers" in
> https://patchwork.kernel.org/patch/9398143/, and the shift triggered the
> inclusion of the last patch of my tree, ie. yours :)

Based on the missing first patch I was expecting the series to get
reposted?

--auuyw7lgbv2sjo2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllUCUwACgkQJNaLcl1U
h9CpKgf8CA2LGASj5C3/jFqBwWzYJdSX2TyJwEcPDM+fHejEzXlY367DN1NUlgTU
JEXKCg1u6QtiTO0dpM18Gzrqi9i1Xg5NodrXJxZwUODT6BkNIbWLjBCrh7O/fwj/
hYAo9hsDjnP5+eRwwQDxltw22oF6ZqeRgYp/pt5BTB2YgXe+cl7D5ck2YzI0oFvB
Zo9+xc6eTQ917r5HKkYiIA9Jjzj087a7oueuGzM72CIOus/oBUFdrwh3rqHyFu3B
Jm1GnaqFxbNwxOTeja5Kea+qna6F6LJjvXYtRJngiUzm/+Af5pU8z7Z+gtgN3IAv
EqzqpKqXlUaX8SQEnyv09Zca4MJQnw==
=akUy
-----END PGP SIGNATURE-----

--auuyw7lgbv2sjo2s--

--===============5429251308396227574==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5429251308396227574==--
