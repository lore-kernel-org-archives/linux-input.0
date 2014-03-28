From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v3 08/10] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 28 Mar 2014 13:54:12 +0100
Message-ID: <20140328125412.GT6120@lukather>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-9-git-send-email-carlo@caione.org>
 <20140328101146.GP6120@lukather>
 <20140328113839.GB30768@sirena.org.uk>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aEcIyhw0mmnxygNd"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBNHC2WMQKGQEM5KP44Q-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140328113839.GB30768-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--aEcIyhw0mmnxygNd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2014 at 11:38:39AM +0000, Mark Brown wrote:
> On Fri, Mar 28, 2014 at 11:11:46AM +0100, Maxime Ripard wrote:
>=20
> > Here, you would just include the dtsi at the top of the file, and in
> > the DTSI, you would have something like:
>=20
> > &axp209 {
> >    regulators {
> >       ...
> >    }
> > }
>=20
> Hang on, what is an include file setting up regulators for?

Look at patch 7. To share the regulators declaration across all boards
and avoid duplication.

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--aEcIyhw0mmnxygNd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTNXD0AAoJEBx+YmzsjxAg0+UP/iBeCwRkGIA61ORKnKrQok48
G4Szp6gylpK1jC5XPzw/Mop/9enWB8rkfsJpJ7XzkP/REDqP94a21CRt5yt8BHsT
UfA2rGn4OVEQNgVgRGXfsdEj69GImoedEyAOj9gU8yNbsGcmcXrRdnxsbJNtri+n
gGpj1kRQcC47hMCN0rZ2ZPO+fGm4wnKus0TkG9g0+GrVNqC7/G09lkV7Z9cPuxUx
p6VOeBI2DOKB3oAIjiOYMLhZ0mMAlCY4vUKYRYRjBqskCHseDU0I5L/BW+LrlBoE
/OMbGbs+raZnSXL8x7s7upfSyiLI63olJajVDNDfLDhbzUBX8JCArPEu96TRXgPq
fun6n7n14DFNCOA7z+q0v49UthyfhEidiyyTrEmHrGHAA/8PoM1ZjJkphrbxYL/V
nHq+muw6dkAFA8izasKz1zuX5XF+5/7K6uDdxKWMcINjLpUf9l7p3PY4TfJjc/Ja
otzewQHLcxYIdnOeLOcTnGigf862dhbChT0ViDAi2DcsSy1YU4t0ubRgMzJhWOB9
00Asi1t3vKwxhYKg0bx99MBfvstDR0W/h6JWr/I9+1mUZyURaLqcO2pSkDB+zpHE
qsXJkRIOZFra7rPD71jpJjsMDJeef4oE+B1eMrY7XDT2AbR77Zz4kPIOsSUCU5ig
wvjP+Cj8OZ4Cq24IxRGs
=Lao1
-----END PGP SIGNATURE-----

--aEcIyhw0mmnxygNd--
