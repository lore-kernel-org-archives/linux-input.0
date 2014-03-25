From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v2 2/8] mfd: AXP20x: Add bindings documentation
Date: Tue, 25 Mar 2014 11:11:00 +0100
Message-ID: <20140325101100.GA6120@lukather>
References: <1394898225-28452-1-git-send-email-carlo@caione.org>
 <1394898225-28452-3-git-send-email-carlo@caione.org>
 <20140318084505.GT27873@lukather>
 <20140322141157.GA20668@localhost.fastwebnet.it>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRBJ5OYWMQKGQEPJWM6FI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20140322141157.GA20668-bi+AKbBUZKZeIdyRz4JgOMwOAu8XWILU@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-input@vger.kernel.org


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 22, 2014 at 03:11:57PM +0100, Carlo Caione wrote:
> > > +
> > > +Example:
> > > +
> > > +axp: axp20x@34 {
> > > +	reg =3D <0x34>;
> > > +	interrupt-parent =3D <&nmi_intc>;
> > > +	interrupts =3D <0 8>;
> > > +
> > > +	compatible =3D "x-powers,axp209";
> > > +	interrupt-controller;
> > > +	#interrupt-cells =3D <1>;
> > > +
> > > +	regulators {
> >=20
> > Do we really need that subnode ? it looks useless, and we already know
> > that we are defining regulators here.
>=20
> What do you mean? We are defining the MFD and regulators are just one of
> the subsystem here.

I mean that it's useless.

> Moveover I'm using the "regulators" node in the
> regulators driver (using of_find_node_by_name()) to get the regulators
> configuration.

Can't you just use the of_node field of whatever struct device you
get?

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTMVY0AAoJEBx+YmzsjxAgrLIP+gPzO1uIJR9g555E9lsajepM
TUtT2aQEZ9pcuyOClBfQU3Bcv0ykBySGqFdhovoLa3AZgifoe5VdVC/Lf84VqbH8
0Kp4OxSajYgboIovj5kpP330yNlpvh19v6NDA/4QL2DzNSz/SjqMSZ/RxfZCeWDF
8k40nAk3s/mMRxcBSl6r4X5ugoMoJDnxSpkOHFRhHXbS3VIpuyNPutJimzS43i7y
IP7oR3imWGgazWZzNBEGbRLN1LfQFpmC1qsu/qiOS5pJK1ybWP4xwFfLl+7DBwkT
yTPHE9mMY6BnV9sVceMsEMAaNt3O0nBoKWsI0S4FlOXkwhuHZjJJDlOjquAaOn1z
l60R5FzQQbg/gqPl8vAyunzND7oz4ntkH/1GY/4/tzoIQz3oaQUqbkj3tXz9kBPa
pkZ7E8c2k2VGgnyqfaorB4kfkAR9GleUOHWj5qItSy6Hr7XHqPVxLJlbQUrn0VLs
ZTlWssROvGBDLdEnFBwPXL3B2oKNmt6Ipo6J4LTl+qHw0wW3/LdHaawSLSbr0IuX
UQakfYz43XvGkyL+u1zbdfQ169k+D5nDctYKSaA3tdAONdV02ohHmOhzAp9drije
dTeGDTQe0WbwXU82lDjrOmak2oL0EUHajXyy2/bOZJ6/QSE86WUTYeMpDAdzOdaG
mEbi47o52ltoLF8/CA+g
=VgWr
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
