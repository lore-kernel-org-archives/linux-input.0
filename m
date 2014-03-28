From: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 07/10] ARM: sunxi: dt: Add
 x-powers-axp209.dtsi file
Date: Fri, 28 Mar 2014 13:34:38 +0000
Message-ID: <20140328133438.GA19846@sirena.org.uk>
References: <1395955764-18103-1-git-send-email-carlo@caione.org>
 <1395955764-18103-8-git-send-email-carlo@caione.org>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pWyiEgJYm5f9v55/"
Return-path: <linux-sunxi+bncBDQ2L75W5QGBBEHV2WMQKGQE3EXRPHQ-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1395955764-18103-8-git-send-email-carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: linux-input@vger.kernel.org


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 27, 2014 at 10:29:21PM +0100, Carlo Caione wrote:
> This dtsi describes the axp209 PMIC, and is to be included from inside
> the i2c controller node to which the axp209 is connected.

>  arch/arm/boot/dts/x-powers-axp209.dtsi | 54 ++++++++++++++++++++++++++++=
++++++

Something is wrong here.  Either the changelog is inaccurate or this is
broken, either way this should be cleaned up because this looks like
very bad practice.  If this is a common include file for boards derived
=66rom some reference design then the changelog is misleading and the DT
should be clearer about the board tie ins.  Otherwise the .dtsi is
defining what should be board specific parameters.

The fact that the DT names everything after the regulator on the PMIC
and not after the supply names on the board is especially suspicious and
glancing at a couple of the regulators it looks like the constraints
here are the maximum ranges the PMIC supports rather than anything to do
with any board.

Please take a step back and think about what the regulator constraints
are intended to do - they're about matching the regulator capabilities
to the board since it is rare for boards to be able to do everything the
regulator can support.  Duplicating the basic device capabilities into
the DT would be a pointless waste of time.

> +	axp_dcdc2: dcdc2 {
> +		regulator-min-microvolt =3D <700000>;
> +		regulator-max-microvolt =3D <2275000>;
> +		regulator-always-on;
> +	};

What is this configuration actually for - what guarantee do we have that
the above is safe for a given board using this regulator? =20

In general I'd expect to see anything specifying variability for a
regulator to also include the relevant consumer node.

--pWyiEgJYm5f9v55/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTNXprAAoJELSic+t+oim93yMP/2WUbpbgFcL+RdftzetFl+Fg
yxRJMhaJ6KxoDZJjlCbBH5cKs302noLEaaQ9RinbgokC7BGXZgk7oLXAVVQp8o+c
mmjMuXFIOWbFrcmVPWPHXQD5U2uFhgPBu+M8zgg6Li10Qqj+wxmCEW9lzaWo8l5n
NXHijs9UBYNreVG+oJomwbqrAZwHjmz/xUTZUMfSD0Mtt+R0r5XRk+8LbGn5yqfU
CEkbucB0DP8YE8JwwJ0hYMlPKfWRHVN54Hp//EZKy1TBWQWcy0pSc93A1/fQWMOR
Rr/zrSk7rS+JTOjgWLXUj6iOFKtg+exif+y+lJYRhLF/Y4Xa0TxE4vgWAbW0rrhX
p1JPmBktuGA/OLqZevQsXPAfxZ3O3p9lqCA2tNbgqvvup6iKlY9yBVIKlgwBV8DC
tNL6gioSijyNSMBs7THXKFa3MiYBbqtqEe6DkZs48wmyMkJ1nDPbFnmfAQK9v22E
X0se3T+1Sex3UZEOny1p4XDy/p1s5jTczvwJLcBMJicL9lvd+G5tP0+OmZo+1e6A
JQmHjz7tLg8KdQN+vXo05oq8gvG8TCv1WVSTdz2HviVqQ6hiXc2IeuGA/9iWykpM
2GP/3wt4RARGL9xhHeWSivc7/xXiEzhdFJS0sIuYJ80J6wYGebBOGf/apRbnQ2wi
DWRyUgF+IxY7W/MdOTke
=c+fy
-----END PGP SIGNATURE-----

--pWyiEgJYm5f9v55/--
