From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH] pwm: Get rid of HAVE_PWM
Date: Thu, 4 Oct 2012 20:29:31 +0200
Message-ID: <20121004182931.GA7228@avionic-0098.mockup.avionic-design.de>
References: <1349330819-11924-1-git-send-email-thierry.reding@avionic-design.de>
 <506DA487.9070400@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="OXfL5xGRrasGEqWY"
Return-path: <linux-mips-bounce@linux-mips.org>
Content-Disposition: inline
In-Reply-To: <506DA487.9070400@metafoo.de>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
To: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux-kernel@vger.kernel.org, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, Ralf Baechle <ralf@linux-mips.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <bryan.wu@canonical.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Ashish Jangam <ashish.jangam@kpitcummins.com>, Andrew Jones <drjones@redhat.com>, linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org
List-Id: linux-input@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 04, 2012 at 05:00:23PM +0200, Lars-Peter Clausen wrote:
> On 10/04/2012 08:06 AM, Thierry Reding wrote:
> > [...]
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 331d574..b38f23d 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -219,7 +219,8 @@ config MACH_JZ4740
> >  	select GENERIC_GPIO
> >  	select ARCH_REQUIRE_GPIOLIB
> >  	select SYS_HAS_EARLY_PRINTK
> > -	select HAVE_PWM
> > +	select PWM
> > +	select PWM_JZ4740
> >  	select HAVE_CLK
> >  	select GENERIC_IRQ_CHIP
>=20
> I'm not sure if this is such a good idea, not all jz4740 based board
> necessarily require PWM.

This really only restores previous behaviour. But I agree that this is
potentially not what we want. Maybe we should just not select this for
any boards but rather leave it up to some default configuration. If so
the patch can be made simpler by just removing the HAVE_PWM entries.

Thierry

--OXfL5xGRrasGEqWY
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQbdWKAAoJEN0jrNd/PrOhg7gQAJQ6YVy/tvgoCjJ4ESOIEmUF
cLyZDEsgwlHWcF2LilA9lync0s6ZcKAjg6RPOVRn8sCILBoxYqKQC2C7BGekETpC
1D+p6L0kq8YY8+bBSWPDc/me+J0S0OoSHNhjZ4WWeqs+vGVnefqjQUJEZsthvy55
tyQ2fmkXAFc/kCcpp+9PqJ71541uZqcaZcrFiYcDqdgAJA0MJ63OxbEQ4sgqjhJN
tHVpW0mlEJw/RBpCI/yzCgaWP8nhPPX4ThUkydMuEVj3YJ2tkmbEpDdcOkAYqm0r
iR551u4JM54ctWsztyWMbYa9dsntM8ZBVXjUeUgmw2C57J78wLIuPbkyiS2Q8wkO
W/CMv6s7TV2jh8XL2i+3DDibcY8oRatW0yEys50V/mLDdOl1GTi9AgvlLqBWTj1Y
mtRMoT2BVeVJtHzRWpEnbLizqIK4ItUc1/kAgIHlo/DWVJfctSz+EEr/BRVUFtJG
hb10QW6DcagvjEyUWMpKejrCfjv9TG2yuLxJxl8WcR4iFAUnkcrSHWFhQVzDgBoG
05wskTjr5rSKzUsEpUfFmrkbOW0Ks6FF9OmOcIEak3sOZM3RMRCJw9idfTClN+/k
mlaRk1VJeeFMaYFPnT+P4rmIMFK0gDx9YVM3OeDD1SBXbZ7QPU3jGooqWjDjqfbM
bhpeJuS1HCPiOe+ul0yN
=fqL5
-----END PGP SIGNATURE-----

--OXfL5xGRrasGEqWY--
