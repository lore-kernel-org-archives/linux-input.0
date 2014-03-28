From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 28 Mar 2014 13:12:10 +0000
Message-ID: <20140328131210.GP30768@sirena.org.uk>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
 <20140328101146.GP6120@lukather>
 <20140328113839.GB30768@sirena.org.uk>
 <20140328125412.GT6120@lukather>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tkgDj+SHwLLR9ce9"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBWXK2WMQKGQETONIISQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140328125412.GT6120@lukather>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--tkgDj+SHwLLR9ce9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 28, 2014 at 01:54:12PM +0100, Maxime Ripard wrote:
> On Fri, Mar 28, 2014 at 11:38:39AM +0000, Mark Brown wrote:

> > Hang on, what is an include file setting up regulators for?

> Look at patch 7. To share the regulators declaration across all boards
> and avoid duplication.

Oh, wonderful.  I'll go and reply to that...

--tkgDj+SHwLLR9ce9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNXUmAAoJELSic+t+oim9YaIP/0UAwAHvNs7u2wbOYeOA/gCU
LC5KDzqOfWTFH3Mbpuvji0mtwp1kiT7xzwZhoSTLwMtlQ+ywBgHi3UKorNkfaqiK
mRB+/wshkpLSOrtOh06xiQ8qsC0f4s8mJJjSZN31vxBg0GnaIE1hQFK9tHVkNLa+
DYYRnNs3FPv9E77kAocPJxhtHz7Vy2xf65NGH1FmAyIxwxqsnvj+WtiFZWqABfqi
spcCwqjxJj73b4A7YP/U/EELuZQvdvkMaQYTQD1pY95cjuRMrac0PsxDq84Vabjr
+rq23EcVOdxsiw91857aXn+ZOJCY0tdbwNA4yjZqIIv7EB/zouKEjJoIIm9lXBhF
f9R7EC1M49q5qcNPMtsUE3nIhpKJ2XxVKTckF7eHlE0hu+27SDDgp5g2Suu0/vng
/Gv9ZcyK5pZlX9l+47Oc0YYIqIe9yjn0XlwEo5ybZBpkfclgqsFJMk5QGs6QwYCJ
skUZFYKhCb2VeaRWuImSD8re+TAigmJmI2zMrUsexRNwqZAo/9/uaWrQkC0+dR1c
Vh+s2mXD/ss7xaHrB3iHKEEtsUv3HJH65ettGKkA4VxxF2r/4d5xbxwM1eKJkkZs
EUQPc1UIznMIvKesU81tuUMea7Yijov1UOGfOGCBgD9neeFpwJBl3y30IVEJdNNq
L4SIq1VT68xQ1UnXCojT
=fGXH
-----END PGP SIGNATURE-----

--tkgDj+SHwLLR9ce9--
