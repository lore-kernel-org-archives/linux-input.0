From: Paul Menzel <paulepanter@users.sourceforge.net>
Subject: Re: [BUG] [input] Sometimes mouse gets detected as PS2++ Logitech
 Mouse instead of ImPS/2 Logitech Wheel Mouse
Date: Thu, 08 Oct 2009 09:42:16 +0000
Message-ID: <1254994936.6681.32.camel@mattotaupa.wohnung.familie-menzel.net>
References: <1244788506.6039.41.camel@mattotaupa.wohnung.familie-menzel.net>
	 <alpine.LRH.2.00.0906121649440.31685@twin.jikos.cz>
	 <1244968510.5898.53.camel@mattotaupa.wohnung.familie-menzel.net>
	 <alpine.LNX.2.00.0906161142340.7457@wotan.suse.de>
	 <1249914173.5526.4.camel@mattotaupa.wohnung.familie-menzel.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-d8H2/LXDbwoyYi0qSTTn"
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1757170AbZJHKlP@vger.kernel.org>
In-Reply-To: <1249914173.5526.4.camel@mattotaupa.wohnung.familie-menzel.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-input@vger.kernel.org


--=-d8H2/LXDbwoyYi0qSTTn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Am Montag, den 10.08.2009, 16:23 +0200 schrieb Paul Menzel:
> Am Dienstag, den 16.06.2009, 11:43 +0200 schrieb Jiri Kosina:
> > On Sun, 14 Jun 2009, Paul Menzel wrote:
>=20
> [=E2=80=A6]
>=20
> > > > > arbitrarily (I would say every two month) my Logitech Cordless Mo=
useMan
> > > > > Wheel gets detected as (in dmesg)
> > > > >=20
> > > > > PS2++ Logitech Mouse
> > > > >=20
> > > > > instead of
> > > > >=20
> > > > > ImPS/2 Logitech Wheel Mouse.
> > > > It would be nice if you could capture the dmesg output with i8042.d=
ebug=20
> > > > command-line from the situation the mouse gets mis-detected. But I=20
> > > > understand that with so low frequency of occurence, that would be a=
 major=20
> > > > pain.
> > > No problem. The problem has not yet surfaced again. But do I need to
> > > rebuild Linux or are those debug messages enough?
> >=20
> > No rebuilding needed, just booting with i8042.debug is enough. Please=20
> > provide us with the output once the bug triggers again.
>=20
> Please find the dmesg output attached. After noticing I also issued
>=20
> $ sudo rmmod psmouse

$ sudo modprobe -r psmouse # =E2=80=9Cmore correct=E2=80=9D

> $ sudo modprobe psmouse
>=20
> to fix the problem.
>=20
> It triggered today. I cannot remember the times before, but today I had
> to turn off the system holding the power button for some seconds because
> the system had crashed and the bug triggered the next boot. I do not
> know if that matters.

I just wanted to tell you that the problem surfaced yesterday again.
This time with

linux-image-2.6.30-2-amd64 2.6.30-8

under Debian sid/unstable.


Thanks,

Paul

--=-d8H2/LXDbwoyYi0qSTTn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEABECAAYFAkrNs/gACgkQPX1aK2wOHVj4rACfRuICiIGmIoQ1bX7551pDu3zp
4j4AoIofZcA2F8PrXzAXZfOUaqOcwdT9
=yWiT
-----END PGP SIGNATURE-----

--=-d8H2/LXDbwoyYi0qSTTn--
