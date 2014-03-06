From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] mfd: max8997: use regmap to access registers
Date: Thu, 6 Mar 2014 12:31:13 +0800
Message-ID: <20140306043113.GA13126@sirena.org.uk>
References: <1394031497-16648-1-git-send-email-r.baldyga@samsung.com>
 <20140305185439.GC5453@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DEZnBEgdqIPZuRMC"
Return-path: <linux-leds-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20140305185439.GC5453@core.coreip.homeip.net>
Sender: linux-leds-owner@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Robert Baldyga <r.baldyga@samsung.com>, sameo@linux.intel.com, lee.jones@linaro.org, myungjoo.ham@samsung.com, cw00.choi@samsung.com, cooloney@gmail.com, rpurdie@rpsys.net, dbaryshkov@gmail.com, dwmw2@infradead.org, lgirdwood@gmail.com, a.zummo@towertech.it, paul.gortmaker@windriver.com, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, rtc-linux@googlegroups.com, m.szyprowski@samsung.com, k.kozlowski@samsung.com
List-Id: linux-input@vger.kernel.org


--DEZnBEgdqIPZuRMC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 05, 2014 at 10:54:39AM -0800, Dmitry Torokhov wrote:
> On Wed, Mar 05, 2014 at 03:58:17PM +0100, Robert Baldyga wrote:

> > -int max8997_write_reg(struct i2c_client *i2c, u8 reg, u8 value)
> > +int max8997_write_reg(struct regmap *map, u8 reg, u8 value)

> Why don't you make read/write reg to take struct max8997_dev as argument
> instead of regmap? regmap seems to be the current implementation du jur,
> but that is core's detail, functions do not need to care.

Indeed, and had this been done originally this refactoring would be much
smoother.

--DEZnBEgdqIPZuRMC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTF/oOAAoJELSic+t+oim9SV4QAJ0hWcPKgrqbYA6YlM2R8YIJ
S+9Hv2ZRFanc3PKNkSlyW2nHAULgSBfYvE0eBwBiXY55d12M//14LX8zUDpxClxH
0fx3vAB+W1GgHyICJPNJjms03BJlqrhCxUo/Q5pz9p91WRCgGnajOUUE0O+otsPQ
wqGGr47mtIOuzeiRHRQqnUq5TtENfVDWBx+ctigu5fuficrAQbMI2qQSklfFHyfR
VJfOGBQ35qX9rHZ0urbZS3V9BEFRx/V6ND1PVq35hQtwTIFWEv3WbMDtZL7HYUoV
M7NCXQ9hT+ErDymJifMUxjK7UYitORNTgDifKiOx56AZe+v/wpblTq50e3SsKvmw
YU6ajaSdsBd1BoBBq9KFYQ21X5Y1YRt6Otl+vYRfj3YlkQwmhe/0utJfydEw89sT
3A5dZpON3t2z9ad8K6/RH1Lzqm4Dt/D8VnZcSQfcc8m7W1yn1BXZhwORdjExbsA4
ttoofTsFItCuEi2UsYapPWpSWXzmKLn9fZcczENZzltzZ9QBPZFO+maunHDK6MqA
5zbdXuy5Gh9Tgo8jevU4wVaIm7xF1DQoGDuuctrSq1fHUZslZQAfjdHTbDOz4YKV
7LJr9mGFIMHM2JwsP4zpGyC786EATp7HjQ763b99tdnZ/WTV19j8wwKjv/fEWmLj
EgN2la0J+bsInnPlb8OD
=adsm
-----END PGP SIGNATURE-----

--DEZnBEgdqIPZuRMC--
