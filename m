From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2 12/12] ASoC: Fix use-after-free at card
 unregistration
Date: Fri, 30 Jun 2017 12:56:00 +0100
Message-ID: <20170630115600.btemrql3aso4s45z@sirena.org.uk>
References: <1497857229-12049-1-git-send-email-robert.jarzmik@free.fr>
 <1497857229-12049-13-git-send-email-robert.jarzmik@free.fr>
 <s5hefug72iu.wl-tiwai@suse.de> <87injstckf.fsf@belgarion.home>
 <20170628195349.pqeb3dceddxar75s@sirena.org.uk>
 <87o9t7u5v5.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5981917661803958415=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <87o9t7u5v5.fsf@belgarion.home>
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


--===============5981917661803958415==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="myrzyy6jr4lqgr7p"
Content-Disposition: inline


--myrzyy6jr4lqgr7p
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 29, 2017 at 12:03:58AM +0200, Robert Jarzmik wrote:
> Mark Brown <broonie@kernel.org> writes:

> > Based on the missing first patch I was expecting the series to get
> > reposted?

> The first patch is only moving around a .h file. I was expecting a review before
> reposting a v3.

I can't tell what's in the first patch if you didn't send it.... :(
In general it's best to resend for things like this, I know I focus my
review on things that can progress as-is.

--myrzyy6jr4lqgr7p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAllWPE8ACgkQJNaLcl1U
h9BfWgf+MNz3C/+kbcY/hHm3cVx+/LAqMX1DTs1J1LaZIwf2eieegzOy4ZP4OljI
c2K6G63yM7TzB33tICGQIU5RCgPHvQLhoj+2WcmxRMU37eBELuT7C9+RJgD2i4l3
xtc44D87e2pZe84mCG+cYXKnv2sS7XEDUn7rc9x+Qa1xBlafmS5q+z4G6GzVfNSE
16+c3tHDyfBECz/NNGNHBdVTRpwtGKBcsi9kkUC1GmvFwbBqjkjXxuue2H+qAwO4
mbc21nN6NHrQpFf/utggp0QmV/fbNax6he88sMt64vKONLl81lsb/VakHUHFEayr
dT++NE/d13hnNEdAWDmlMaEksJQtzA==
=K7yJ
-----END PGP SIGNATURE-----

--myrzyy6jr4lqgr7p--

--===============5981917661803958415==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5981917661803958415==--
