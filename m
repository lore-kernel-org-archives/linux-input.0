From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCHv3 3/3] Add sixaxis plugin: USB pairing and LEDs settings
Date: Thu, 9 Jun 2011 17:48:22 +0200
Message-ID: <20110609174822.3e922722.ospite@studenti.unina.it>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	<1307538557-9287-4-git-send-email-ospite@studenti.unina.it>
	<20110608175251.GC20343@piper>
	<20110609155731.bd2c5a8b.ospite@studenti.unina.it>
	<BANLkTimJ20rf8rJVPROLiJidq3dtVRGuig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <BANLkTimJ20rf8rJVPROLiJidq3dtVRGuig-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anderson Lizardo <anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org>
Cc: Vinicius Costa Gomes <vinicius.gomes-430g2QfJUUCGglJvpFV4uA@public.gmane.org>, linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 9 Jun 2011 11:30:56 -0400
Anderson Lizardo <anderson.lizardo-430g2QfJUUCGglJvpFV4uA@public.gmane.org> wrote:

> Hi,
>=20
> On Thu, Jun 9, 2011 at 9:57 AM, Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>=
 wrote:
> > Would you mind if I keep these three stdlib ones in? I use this code
> > verbatim in another program which does not link against Glib.
>=20
> But you use e.g. "g_strcmp0()", GIOChannel etc. How is that?
>=20
> Also remember sed is your friend :)
>=20

I was referring to the "low level" functions:
  get_feature_report()
  set_feature_report()
  get_device_bdaddr()
  set_master_bdaddr()

sorry, I use them in a command line tool which opens the hidraw node
directly without udev.

But as you say, it is not a big deal to substitute them, if you like a
more uniform style in the bluez plugin then I'll comply.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3w60cACgkQ5xr2akVTsAG6hwCfWy1bqaNEBBVpj7wiJQUqxDQx
4c8An05AvTFkh9DaIhcyt2kp4THbY2L2
=i0Wa
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Jun_2011_17_48_22_+0200_Ls037v=Jla_DenRm--
