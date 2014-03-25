From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2 6/8] ARM: sunxi: dt: Add
 x-powers-axp209.dtsi file
Date: Tue, 25 Mar 2014 11:11:39 +0100
Message-ID: <20140325101139.GB6120@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-7-git-send-email-carlo@caione.org>
 <20140318090450.GV27873@lukather>
 <20140322143157.GB20668@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBKFOYWMQKGQEPZSFIHA-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140322143157.GB20668-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2014 at 03:31:57PM +0100, Carlo Caione wrote:
> > > +	compatible =3D "x-powers,axp209";
> > > +	interrupt-controller;
> > > +	#interrupt-cells =3D <1>;
> >=20
> > However, I'd move this out of it, and in the board file, so that we
> > actually get an idea by looking at the board DTS of what device we are
> > actually registering at this given address, and what it's capable of.
>=20
> Do you mean the whole dtsi or just those three lines?

Just those three lines.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTMVZbAAoJEBx+YmzsjxAgk+cQAICCEfwYy3uMDPGmu0jMbQzE
PeLHkX1Lasj6oxYLCla638dLlRYYORDF/JuKoPB0FJHTyPYGtI5zbNPxt1CQwLdS
yvggHjlJhSF3TIIraX21jw6osJW6sLTrTaDPvDy/BX4XW1VJDM1CdK2g2+Bt+IlV
3LsXNlOeF6H43DyFwjddwxQOWlDwE/QMA6Twv8Uyec3AG4evG8l0hjqoaL8kIydA
zMT9j46zvSKcRrMURxwsI1R1FgX1tETG1VD+FTOc+GvgrV3+qynPCvsGsC43p1fS
bBrgBhJ81zue3fmp+RvUK4Kl/jG7tPPjLhsq+8bTjJmOrO/8psO4kq8sinjvzw1O
OJDqPyPed0fuOOSrzjlbSY4Od4weWmqOyNg0JrT0MZP7FeolqsWEGIK3j1XvQWpi
hzGhpyQ5OsLbF9ssxYaB1EBfLCRrphLghdVezgwoXBfjOwrFGjxU50u96SdgQLSc
4XzK6UarPB+WHmEqWdzwdL0TJiw32iXtK0D595q+m5L7Ft4QSP5ERXRqaDhuqHMY
Rw/JH+7kEVISUXxnN6yRShnhTwih1VaqgtlzjXafx85OE2MkHT8Zuqe5jXreYE/n
lmwZNdPhYSPDwcBj6WNY+OeagqecjRWFAQ8+5LlGVIwNzrk520iVrS3rqMRRk5t5
MYN+gCH1YCahnNJ9EvBG
=no5/
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
