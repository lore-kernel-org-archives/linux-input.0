From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: Re: [PATCH v5 8/8] ARM: sun7i/sun4i: dt: Add AXP209
 support to various boards
Date: Fri, 9 May 2014 20:06:34 -0500
Message-ID: <20140510010634.GG7047@lukather>
References: <1398947374-3115-1-git-send-email-carlo@caione.org>
 <1398947374-3115-9-git-send-email-carlo@caione.org>
 <20140503010936.GF4090@lukather>
 <CAOQ7t2Z6rLAMGXocPNcKgOUp9iy6XZkh4O6jThPkdm5M6UMGtw@mail.gmail.com>
 <20140505225139.GD9464@lukather>
 <CAOQ7t2bg5jkeruVnO+9cXMxxh+SL+ANGz3R0ssSMwrHewRKyYQ@mail.gmail.com>
 <20140508025337.GI7047@lukather>
 <CAOQ7t2ay7UNiCZyUw4RrQ+4O1CYUht32U_OSYkbVWRLUq8_hZw@mail.gmail.com>
Reply-To: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yHmUJ2Jgby4Rx//r"
Return-path: <linux-sunxi+bncBD2ZNBF5VYJRB6PYWWNQKGQEVH64VLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAOQ7t2ay7UNiCZyUw4RrQ+4O1CYUht32U_OSYkbVWRLUq8_hZw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Post: <http://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <http://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <http://groups.google.com/group/linux-sunxi>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Subscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <http://groups.google.com/group/linux-sunxi/subscribe>, <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
To: Carlo Caione <carlo-KA+7E9HrN00dnm+yROfE0A@public.gmane.org>
Cc: linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Hans De Goede <hdegoede-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, Emilio Lopez <emilio-0Z03zUJReD5OxF6Tv1QG9Q@public.gmane.org>, wens Tsai <wens-jdAy2FN1RRM@public.gmane.org>, sameo-VuQAYsv1563Yd54FQh9/CA@public.gmane.org, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-doc-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, boris.brezillon-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-input@vger.kernel.org


--yHmUJ2Jgby4Rx//r
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 08, 2014 at 10:17:16AM +0200, Carlo Caione wrote:
> On Thu, May 8, 2014 at 4:53 AM, Maxime Ripard
> <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
>=20
> <snip>
>=20
> > What I mean is that no information is still better than wrong
> > informations. If you don't have the schematics, then don't do anything
> > on this boards. Hopefully, someone with more infos on this will know
> > what to do.
>=20
> I partially agree here. Not specifying the voltage range for the
> regulators but only keeping them always-on from a practical point of
> view means that we do nothing with those regulators (see also
> https://www.mail-archive.com/linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org/msg09532.html
> )

But we don't even know if they are used on these boards or not in the
first place..

> > Moreover, I have the feeling that you just copy pasted all the
> > informations on this patch. The first example I'm seeing is the
> > cubieboard, for which we do have the schematics, and this patch says
> > that ldo4 is used for HDMI, and that is required to stays always on,
> > while LDO4 doesn't seem to be used at all, and that HDMI takes
> > directly its input source from DC-5V.
>=20
> The names for the regulators are taken from the original Allwinner
> driver and (of course) they can have nothing to do with the function
> they have in the board. I agree that this could be misleading so I'll
> change them with more general names. Concerning LDO4 that is always
> on, it was off until this v4, but I changed it back to have one common
> DT representation among all the boards.

I'm sorry, you did a great job on this PMIC driver, but this is just
wrong. I'm completely fine with the names. What I'm not fine with is
all this "one common DT representation across all boards". Pretty much
all the boards are wired differently when it comes to regulators. Why
do you want to just do some copy pasting without any checking on the
schematics side if not just for the joy of duplicating code?

> > I guess you need some more refining on this patch.
>=20
> Ok, I'll submit a v6 only for this patch.

Please, please, *please* make sure that the informations you put in
there are actually accurate.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--yHmUJ2Jgby4Rx//r
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.14 (GNU/Linux)

iQIcBAEBAgAGBQJTbXuaAAoJEBx+YmzsjxAg2q8QAKSvleUgTOl5ulWetlWMqMlu
tjGey9G4MW0MLvwvS2srObpW35+tc0NnXe8J0joUco26EWHo7lEon4t985t+s6ye
ZIeVK3y4EUvhvLLc6WdCfyYCTLXaH7K0kOYHuxY8jRI725KPAV3GV78uxu4vCNnK
oNmvw1Zds/tFDMgPcEcPLY/jZAza/qxg5iyONYIEMWQ3NbrR4zv1Ieklwki8/TlD
5RYyXTTGT0ulBlIYwjn86L67cQ4/Ndtkth3UWeg81xiRC4gvl0fuxbttuGNDeQZp
7gOrqYyfZNlEBpTvVdzQ+SWiyfMwZqmrReu+abaXdXFdhogdVGlENtV/kekjmBCS
/IaoXRvyuiHmzK1tifJ+3AWOS1W7ARYZz03hpe5qtFVwtbq9741QcHYg3WWvGO3J
SXD20+8PVXNO1PeSasl5K43oOn1zO+OAY4jx62c8XibWvjPzuwyNpZgSJL8KkRMl
sx419HrAmCcuAGbMpT5W4cSI9ZrYuXNH/a5CFWdmQflCIhhOlEWuBQRhgPecM+xR
eKlN86Z6xvukIcTkulHfYOmK1mzZs+QM/2g7StKpeSLWx5+p6gOpdrEMizJG5P/8
yEXfgW8Z1LZuyjiwOzcIjO04oy21S7azCMCDqX0Gaux4UTaYyxJSDpdFyi+Lpo0w
TBdl6fyXMB6MeJ8G8XDS
=9i95
-----END PGP SIGNATURE-----

--yHmUJ2Jgby4Rx//r--
