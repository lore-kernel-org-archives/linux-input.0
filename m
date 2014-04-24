From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Thu, 24 Apr 2014 14:30:36 +0100
Message-ID: <20140424133036.GY12304@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
 <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
 <20140418151551.GZ12304@sirena.org.uk>
 <20140423202546.GA3890@nuc.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mnCTX6PGn0YCGXCv"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBGFE4SNAKGQE36JTD5Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140423202546.GA3890-OP/Sd6KM9CusbfqNwF1Yyl6hYfS7NtTn@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Charles Keepax <ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
List-Id: linux-input@vger.kernel.org


--mnCTX6PGn0YCGXCv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 23, 2014 at 10:25:46PM +0200, Carlo Caione wrote:

> I'm having a really hard time with this problem, so any hint is welcome
> :) The small modification I'm using on top of the patches in this series
> is here: http://bpaste.net/show/228330/

> Unfortunately as I said I got this when booting:
> http://bpaste.net/show/nUhUTzELT32v9HNPathL/

Huh, actually the arizona drivers do show this (it was being masked in
my logs by another unrelated bug).  I guess the Wolfson guys aren't
working with upstream much (though Charles did write the orignal code
here...).

The issue is the MFD core, it shouldn't be using managed allocations
here - the error reported by the assert is entirely correct.  If the
CODEC driver is bound and unbound it'll not be possible to reload it
as things stand. =20

Your driver is correct but the implementation needs to be fixed -
possibly with an API change on free since at the minute the cells to be
freed don't get passed back into the MFD core when deallocating.

--mnCTX6PGn0YCGXCv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTWRH4AAoJELSic+t+oim9yWUP/01uMXUDyIcRQg/jTR9k0kWu
UkxtQ4qqP2KeWFQReuVtLpmd72yrGOFs6+lHlWUQtrpxEQuhZO4/Pni+Ypf0Hp1C
Zw1Xj4s6NORhElOVw5DGx48aZUWLjNa/daF0eFgb3UK3IqnzsMQ7mg9idSJC+3px
/pMFO64x8IpvaP7Y7c7svX/RBSukMG/Ko9l/6jkGc7qScyM7Cmi/Y6Mo1l1Hz2Y+
OsCiRxT7lrxA0c6sh2GjvczruQQvGLqBP1MDExxL8UTqr4t/71IcN08HkQZQTDol
fCiNhgPQUbt6cwTMkFCzc7hO8DIpbnDmVpIRDV+PEKB7FSXBZYpuA/7uJes5ilhQ
WZGqFOM/sruE9lkTUX60oYij7zacRgpku8geevzMCqrMpaH2KFlMTZddOjgoJdMD
X36RY3lznzApN/l6TWCdLS+o9tKoChVG25nv5Q4jSjbl3rl+ccadBx0J9862b1cH
zRwXdXJtHgvkHMT1i1Wo6aDSYQb3iFUERHKRd73Phl16naigtIX5lfxW2366/JD0
bDtn4yMGTt4+rZMll5gnKgWoY0B7Eqz6FqUJdOfQnvA8sPeFETsr9csFCkAUvqMx
+Wlp+DUZAHubDD3kkxGP/nQg1/StPYqyys4egI9Eat/CcD8n5ckR5eZDafxpBPsf
Sb7S2js/ajG61S9OfVD0
=+Ie9
-----END PGP SIGNATURE-----

--mnCTX6PGn0YCGXCv--
