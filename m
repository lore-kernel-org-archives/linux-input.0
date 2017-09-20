From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v7 2/8] mfd: wm97xx-core: core support for
	wm97xx Codec
Date: Wed, 20 Sep 2017 12:34:46 +0100
Message-ID: <20170920113446.ttwv23riutpp7e5i@sirena.org.uk>
References: <20170913193723.16234-1-robert.jarzmik@free.fr>
 <20170913193723.16234-3-robert.jarzmik@free.fr>
 <20170914074146.dnibkvom4yuzejf3@dell>
 <20170914074300.iobuwn2hrmnf6sen@dell>
 <20170914160453.gys3imt4eobckcrq@sirena.org.uk>
 <20170918085236.z6gmgrwvsjvvc4cd@dell>
 <20170919121539.mz2mettkefxf3oer@sirena.co.uk>
 <20170919152253.tvj3hheggrx4lgig@dell>
 <20170919160422.l7lxmfl6yrjnpalb@sirena.co.uk>
 <20170920082443.cqimrbhddum23lof@dell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4431593092095672079=="
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20170920082443.cqimrbhddum23lof@dell>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lee Jones <lee.jones@linaro.org>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, linux-kernel@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Takashi Iwai <tiwai@suse.com>, patches@opensource.wolfsonmicro.com, linux-arm-kernel@lists.infradead.org, linux-input@vger.kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Daniel Mack <daniel@zonque.org>
List-Id: linux-input@vger.kernel.org


--===============4431593092095672079==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="iqfv6xyjujg3qskx"
Content-Disposition: inline


--iqfv6xyjujg3qskx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 20, 2017 at 09:24:43AM +0100, Lee Jones wrote:
> On Tue, 19 Sep 2017, Mark Brown wrote:

> > It really helps if we can get the earlier parts of the series moving
> > even if the rest of it's in review still - I know I back off on
> > reviewing things if it looks like their dependencies aren't making
> > progress.

> Just for your FYI, I tend to review my parts then wait for the
> rest of the series to be reviewed, then discuss how the set should be
> handled.

> Holding back on reviewing your parts is not a good idea.  If everyone
> did that we'd end up in a circular Maintainer dependency and nothing
> would ever get reviewed.

I get fed up with having to re-review the same patches over and over and
over again while people work out what's going on with the earlier parts
of the series, that gets very time consuming and is error prone.  If
we're getting churn early on in the series that's causing things to
change then it's better to let that settle down and look properly at the
results than glaze over looking at each minor change as it comes in and
miss other things that get tweaked.  Once the dependencies are stable
then it becomes worthwhile again.

--iqfv6xyjujg3qskx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlnCUlUACgkQJNaLcl1U
h9DHfQf/dWq5QHmNfZ+y1dChZdcIAYCOnbpQunZ9WwLy6W4fxqQZZEqVO8egdj6m
Cs5mpm6KN6UYBTY5ud61Q0Ov/v2KEpN+UhGQ40XmwENvBdEyPBGRiwCHZCsbOEhD
D/gugg6yRHivFyikqe+40xsvqVFrIwJr88Nw3JNvCafNSaS9fGhy7XO4oXaqPxDI
STfDjw7PJuHGXC5/7dBFE4n/du95zZL19IioUetH+70YIuH0TwWS+jA5QnVVkIC2
4zoCw0WrfsNgcj2UnwRyyhYZhKGCc04unXvMUpAYbvO7JILuDlNrwnTh28eYJRXO
84VOD9YOvyJuOxy7Q53s1j0+wbUoZA==
=SORc
-----END PGP SIGNATURE-----

--iqfv6xyjujg3qskx--

--===============4431593092095672079==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4431593092095672079==--
