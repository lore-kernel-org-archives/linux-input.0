From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 7/9] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 18 Apr 2014 16:15:51 +0100
Message-ID: <20140418151551.GZ12304@sirena.org.uk>
References: <1397209093-10077-8-git-send-email-carlo@caione.org>
 <20140411122901.GE28800@sirena.org.uk>
 <CAOQ7t2Y2B7f+eZApDHKiKm9=bOXo6oUA2RLY7ENn7qPLQEboMA@mail.gmail.com>
 <20140411161813.GF28800@sirena.org.uk>
 <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="QEpBYEk8j4zMEQj8"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBOMDYWNAKGQER472D7Y-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2YO_MjUZkkoEe1Grft+fVttWoOro85Sru2P3LXbx8Kjbg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
List-Id: linux-input@vger.kernel.org


--QEpBYEk8j4zMEQj8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 17, 2014 at 12:06:34PM +0200, Carlo Caione wrote:

> I'm fighting with a small issue when using the
> regulator_bulk_register_supply_alias(). Problem is that when using the
> .parent_supplies entry in the MFD driver, I hit the
>=20
> WARN_ON(!list_empty(&dev->devres_head));
>=20
> in linux/drivers/base/dd.c#L272, but, apart from the warning,
> everything seems to work correctly.
> A possible explanation I gave myself is that in the mfd_add_device()
> we try to use the devm_* API when the regulator device is not bound to
> the driver yet (I found some information here
> http://lists.infradead.org/pipermail/linux-arm-kernel/2012-June/104442.ht=
ml).
> Is this the case?

Without knowing more about the case you're hitting it's hard to say - I
do run a board which exercises the API for a MFD (with the arizona
drivers) regularly and haven't noticed an issue so there must be
something different about what you're trying to do.

--QEpBYEk8j4zMEQj8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTUUGjAAoJELSic+t+oim9ddkQAIYHsCzM6rTT3xGzbu+zANEO
zFPZIBP6wfmlVNsgmDkH3JsI3T/tMNvhgPfwmVnMzSwpF7q4UgzEfId83U+EiHW+
0z6PLKkgvkX60pmZfUzCIY1jbXvUlAgy8zGqTPaKWyCKJfiCyi7v6Zsp9QLBnT7e
yPDIqE9rfSyHlpH6Ii0MlqGVUZuvkFT+sd3EZnCd9Zubf+QYphw9fsAMr47apYyc
qOWI2GbDs+JuyAJs+9LzBXiO+uQcFCxEVf0rDJiuClswlKn6HK9KRe7u/22oq7vH
5osK/Ltah4JCEaskpYVG4Nlvo9g22v0fXpdpw/f3wER5w6UjpK8rmpsiTzDE6wC1
BDZM5rAlUr14bxNGZEAXgfum6xCyE76nkT8TTIhAG9I4hwkW7lY7wiUlLimQBwWD
fBzOqdCUYwMA4sqngoH+vzd5K9pwCfY7ZwG/vEv2TbiToeiCoVSsjuP687CtHIUy
OMjzXakdUY6mr7DUh/jBUF6U9wV9tQkzw7hti6A6axukrTVJMZl3PvOgpKPA80WT
nLUOaxQJc1J8v048JhZUVEjxYETbUt/fBtffnFmZ8G90xNE2+W00pNyPg8PByt4b
KOQVH6qMSvrBTShHLHiUt4vQGelygKWMF46+l52D3Hmt5gnTmfzIFNq55VZm5kei
3QMVdyfdiGjoV13L607V
=32We
-----END PGP SIGNATURE-----

--QEpBYEk8j4zMEQj8--
