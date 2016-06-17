From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [RESEND v7 1/6] mfd: max8997: Use regmap to access registers
Date: Fri, 17 Jun 2016 13:59:23 +0100
Message-ID: <20160617125923.GQ26099@sirena.org.uk>
References: <1466143833-5856-1-git-send-email-k.kozlowski@samsung.com>
 <1466143833-5856-2-git-send-email-k.kozlowski@samsung.com>
Reply-To: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rUztinBX/EQDJOOk"
Return-path: <rtc-linux+bncBDQ2L75W5QGBBXHIR65QKGQERZKRBOQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <1466143833-5856-2-git-send-email-k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Post: <https://groups.google.com/group/rtc-linux/post>, <mailto:rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:rtc-linux+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/rtc-linux
List-Subscribe: <https://groups.google.com/group/rtc-linux/subscribe>, <mailto:rtc-linux+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+712029733259+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/rtc-linux/subscribe>
To: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Richard Purdie <rpurdie-Fm38FmjxZ/leoWH0uzbU5w@public.gmane.org>, Jacek Anaszewski <j.anaszewski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alessandro Zummo <a.zummo-BfzFCNDTiLLj+vYz1yj4TQ@public.gmane.org>, Alexandre Belloni <alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-samsung-soc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-leds-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, rtc-linux-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, r.baldyga-anjuHVi6/WSaMJb+Lgu22Q@public.gmane.org, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--rUztinBX/EQDJOOk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Fri, Jun 17, 2016 at 08:10:28AM +0200, Krzysztof Kozlowski wrote:

>  drivers/extcon/extcon-max8997.c       |  31 ++++----
>  drivers/input/misc/max8997_haptic.c   |  34 ++++----
>  drivers/leds/leds-max8997.c           |  13 ++--
>  drivers/mfd/Kconfig                   |   1 +
>  drivers/mfd/max8997-irq.c             |  64 ++++++---------
>  drivers/mfd/max8997.c                 | 141 +++++++++++++++-------------------
>  drivers/power/max8997_charger.c       |  33 ++++----
>  drivers/regulator/max8997-regulator.c |  87 ++++++++++-----------
>  drivers/rtc/rtc-max8997.c             |  56 ++++++++------
>  include/linux/mfd/max8997-private.h   |  17 ++--
>  10 files changed, 228 insertions(+), 249 deletions(-)

This is doing two things at once - it's changing the I/O mechanism over
to regmap and updating all the client drivers in a single commit.
Conversions like this are normally done by first converting the
driver-specific I/O functions to use regmap internally and then
subsequently updating the individual client drivers (if that's even
useful, sometimes people don't bother as the static inlines you
usually end up with in the header are not a real cost).  This makes for
a set of smaller, more focused patches which are easier to get reviewed.

As it is due to the subject line not looking at all relevant and these
Maxim PMIC drivers generating an awful lot of resends this is the first
time I actually looked at this enough to notice there's any regulator
code, I suspect I've either deleted older versions unread or scanned
the commit message and not seen that there was a regulator change.  I
only saw it at all because it was mentioned to me on IRC and a copy
forwarded on to me.

> @@ -464,15 +449,15 @@ static int max8997_restore(struct device *dev)
>  	int i;
>  
>  	for (i = 0; i < ARRAY_SIZE(max8997_dumpaddr_pmic); i++)
> -		max8997_write_reg(i2c, max8997_dumpaddr_pmic[i],
> +		regmap_write(max8997->regmap, max8997_dumpaddr_pmic[i],
>  				max8997->reg_dump[i]);
>  

Looks like a conversion to regcache is also useful but that can be done
as a followup.

> @@ -257,15 +258,14 @@ static int max8997_get_enable_register(struct regulator_dev *rdev,
>  static int max8997_reg_is_enabled(struct regulator_dev *rdev)
>  {
>  	struct max8997_data *max8997 = rdev_get_drvdata(rdev);
> -	struct i2c_client *i2c = max8997->iodev->i2c;
>  	int ret, reg, mask, pattern;
> -	u8 val;
> +	unsigned int val;
>  
>  	ret = max8997_get_enable_register(rdev, &reg, &mask, &pattern);
>  	if (ret)
>  		return ret;
>  
> -	ret = max8997_read_reg(i2c, reg, &val);
> +	ret = regmap_read(max8997->iodev->regmap, reg, &val);
>  	if (ret)
>  		return ret;
>  

A proper regmap conversion of this driver would be to convert the
driver to use the core regmap operations and remove all the driver
specific code.  It's a step in the right direction but it's making a
bunch of code that's obviously problematic so it's hard to get
enthusiastic.  

-- 
You received this message because you are subscribed to "rtc-linux".
Membership options at http://groups.google.com/group/rtc-linux .
Please read http://groups.google.com/group/rtc-linux/web/checklist
before submitting a driver.
--- 
You received this message because you are subscribed to the Google Groups "rtc-linux" group.
To unsubscribe from this group and stop receiving emails from it, send an email to rtc-linux+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.

--rUztinBX/EQDJOOk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXY/QpAAoJECTWi3JdVIfQS8oIAIWyNG8L5BMcQ8vAOFQbbOo/
ieB8e00FZLsG9ZaHLdT7ZL0ZhHAPjolUYzIW0lrgHuvSyX/vGjy25EIa/cGbeQ6M
KSHtHVJRjiEPCO8WtKDZmml1niRLM8xpGne/D9ZzUTeRU0K/C2TbQSAdESkjyQ/L
IRdyw8UEN2eYu4OQ9ZawBdrxUru4H5tU5AqCpcXe0v2P4Tv74l9n7vYuTEr0xz9/
orfU5z8jU/6RDqXa72p+vqPHTKucLhM3KxF4I8MT1vAwDCyPbtGyQRVOJQ8RLOgp
72S4A4X+1xKJsJUuUU4sBQ0cKs36982x/o4xhr6gtu+/LZQbi0+aJwNcIkER58E=
=1Ep9
-----END PGP SIGNATURE-----

--rUztinBX/EQDJOOk--
