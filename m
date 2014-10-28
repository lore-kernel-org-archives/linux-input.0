From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 00/15] new locomo driver
Date: Tue, 28 Oct 2014 00:29:28 +0000
Message-ID: <20141028002928.GK18557@sirena.org.uk>
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <20141028001338.GZ27405@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="vkzoT2Bc9VsM/9ev"
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20141028001338.GZ27405@n2100.arm.linux.org.uk>
Sender: linux-gpio-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Greg KH <greg@kroah.com>, linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org, linux-input@vger.kernel.org, linux-leds@vger.kernel.org, linux-spi@vger.kernel.org, linux-fbdev@vger.kernel.org, alsa-devel@alsa-project.org, Andrea Adami <andrea.adami@gmail.com>, Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Robert Jarzmik <robert.jarzmik@free.fr>, Linus Walleij <linus.walleij@linaro.org>, Alexandre Courbot <gnurou@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Bryan Wu <cooloney@gmail.com>, Richard Purdie <rpurdie@rpsys.net>, Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Jingoo Han <jg1.han@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: linux-input@vger.kernel.org


--vkzoT2Bc9VsM/9ev
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 28, 2014 at 12:13:39AM +0000, Russell King - ARM Linux wrote:
> On Tue, Oct 28, 2014 at 03:01:53AM +0300, Dmitry Eremin-Solenikov wrote:
> > Sharp Zaurus SL-5500 and SL-5600 use special companion Gate Array. Current
> > drivers present in Linux kernel has some problems:

> >  * It uses custom bus instead of platform bus/mfd core.

> I believe Greg wouldn't see that as a positive point.

> Don't think that the platform bus _should_ always be used.  It shouldn't
> (Greg has said he'd like to see the platform bus to be totally killed off.)
> Instead, custom buses properly suited to the class of device in question
> is much preferred, especially if it aids in...

> >  * Device drivers are not well layered/separated.

> ... better layering or separation of drivers.

> So, thinking that converting from a custom bus to a platform bus
> definitely is /not/ a positive step forward.

> (Why mfd was ever allowed to re-use the platform bus stuff is a separate
> question not relevent to these patches.)

The reason we ended up reusing the platform bus so much was that
originally people were doing custom buses but people started complaining
that the code was (or should be) a cut'n'paste of the platform bus and
that this duplication was both not pretty and a bit tedious for anyone
doing anything that involved deploying good practice over a lot of
buses.  Early MFDs were actually MMIO devices so the platform bus was a
good fit, then people (including me when I upstreamed the wm97xx drivers
and apparently whoever worked on these devices) started adding custom
buses and then people complianed that we should reuse both the bus type
and the MFD infrastructure so here we are.

Probably a way of sharing the platform code but giving the bus another
name and bus_type would allow for better separation here.

--vkzoT2Bc9VsM/9ev
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUTuNnAAoJECTWi3JdVIfQ/RIH/13QFgkARw+0ATxYA3IhJU00
xxCwDEGaCEzBxYxnPxxS44qRJdLa8M2ewRTStp/8W7ecZ/LzqwMLJq/IKfOYkQMO
o9MxJ8y6dk2RMbXw5CcnXj7cBZxfkxSKh401TYWnJpW98NHj/vufWjkOSDpHuVfL
tzCiVMhYYoC7Rsadji1r5ChEBjn4jQgqvHnVrm+rVNcNGAeHwYyM6cb1rY7Knbwv
fPpqFx1qDWs9E2lYCCkzsS1y8sjqMO5M2fyE9e2kE0ndVPM42OLplEH4wMLighKu
90ukluplp5DR0SEXaFN/KDC1uGmoeGyklSHnp7a2gXyuFQN/UjdXss0gxQc5QE4=
=65AP
-----END PGP SIGNATURE-----

--vkzoT2Bc9VsM/9ev--
