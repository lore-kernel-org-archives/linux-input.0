From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: Re: [PATCH v2 1/8] mfd: AXP20x: Add mfd driver for
 AXP20x PMIC
Date: Sat, 22 Mar 2014 19:29:06 +0000
Message-ID: <20140322192906.GA2269@sirena.org.uk>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-2-git-send-email-carlo@caione.org>
 <20140318155919.GS25478@lee--X1>
 <20140322165132.GC20668@localhost.fastwebnet.it>
 <20140322173313.GU552@sirena.org.uk>
 <CAOQ7t2Yg5pp_rXYfsdnHpy-zGFGimzT3EW15P_0ugYMtgPtOrw@mail.gmail.com>
 <20140322184201.GA27611@core.coreip.homeip.net>
 <20140322190803.GA20987@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBMOJW6MQKGQER3F6FTQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140322190803.GA20987-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Mar 22, 2014 at 08:08:03PM +0100, Carlo Caione wrote:
> On Sat, Mar 22, 2014 at 11:42:01AM -0700, Dmitry Torokhov wrote:

> > > drivers/mfd/axp20x.c:172:18: warning: assignment makes integer
> > > frompointer without a cast [enabled by default]

> > You need to cast to long, otherwise you will get warnings when compiling
> > on 64 bit arches.

> Actually no warning also with (int) cast.

That's because you squashed it to something smaller than a long using
the cast.  The other option is to make the variable you're assigning to
suitable to hold the value - intptr_t or a long.

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTLeR/AAoJELSic+t+oim945gP/0F2aPNYJ0SJKBDBQ/SE8mO3
V40X2MwNe/0EQWnsnwb8UFJ8nqr6WMsShqme6jy4A9DW+W2yjNjCZAhT9fiBJAVP
s5BZI1wlZh3V6tchEk4prNAGS07/jCPqsOKuCoWSvixCqwjMW0JP4u73nnT3V9ws
iN/qKsViyUKwH+kN6J+Lk6mAZAMl6WUOJwk5NC3lWRtRJPy5vJoHyZWXSfdj2vWn
Xe8p0e4wZlRdnMcHWFhphKtpzibK3YwvxtDfp4QuB9M456rCbAjQrvgZKjhaW0VX
Q4iJKrlbjSFPIh5ovIxAwZ3lIY3fA9MG5lynD1a8VEMu4jXclLj6MX751tWKchzP
PQhryBPiFO5U7d8mojJTyw78lqxZvrbP5XOU/XfpfBPUDDqsc+atB1sc/oqWZ04M
FFWYY0t7g5gcw3zBiFOAlXHuLl2YThk7I/05poPu1RUMgUpjk0+0cXRanL9F4D6C
K//jrjUX7byp/lFMNMYwk30kX/obPBrBmc4nJ7jmNaMZITKRA50w1vrZaACHGijP
GgutooLNGCLDTIXBBhhRXylQIHClesiWPLopRYUXPU8o9JYG7Rkyg63m5YzvK/5k
qY/zul2BsntINNoU1iOvqDG06xla6mdbp0Pd4dQFz+yf3d82uFgrw+olhYzTX4nj
nxV95w4KVr5lCpDXyKsb
=ueW9
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
