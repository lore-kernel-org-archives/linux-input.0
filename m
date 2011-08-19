From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCH BlueZ 2/4] Add sixaxis plugin: USB pairing and LEDs
 settings
Date: Fri, 19 Aug 2011 21:57:16 +0200
Message-ID: <20110819215716.71f6b39d3b5e783c4276f422@studenti.unina.it>
References: <1312553358-26280-1-git-send-email-ospite@studenti.unina.it>
	<1312553358-26280-3-git-send-email-ospite@studenti.unina.it>
	<4E41EBE5.7040908@signal11.us>
	<20110818161357.8084ab94bff57391e7ec3284@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20110818161357.8084ab94bff57391e7ec3284-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>, Arc Riley <arcriley-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Aug 2011 16:13:57 +0200
Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org> wrote:

[...]
> If the idea looks OK I'll fold those patches in v5, along with the
> plugin renaming to "sony-controller", and maybe I'll split the plugin in
> several modules too:
>   sony-controller.c 	/* udev and bluez stuff */
>   sony-controller-hid.c	/* hidraw and device specific stuff */
>   sony-controlled-hid.h
>=20

Do you think "controller" fits the PS3 headset as well?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk5OwBwACgkQ5xr2akVTsAHafwCgj1Aa2Nf1nIuN0zEB/9AX/NP3
XSwAnR76LfIbBagoqN7NwTMYUfNOg3wy
=lnyT
-----END PGP SIGNATURE-----

--Signature=_Fri__19_Aug_2011_21_57_16_+0200_3CazaYAU9D65uJ=9--
