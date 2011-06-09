From: Antonio Ospite <ospite-aNJ+ML1ZbiP93QAQaVx+gl6hYfS7NtTn@public.gmane.org>
Subject: Re: [PATCHv3 0/3] Sixaxis plugin for Bluez
Date: Thu, 9 Jun 2011 16:54:49 +0200
Message-ID: <20110609165449.21966d01.ospite@studenti.unina.it>
References: <1307538557-9287-1-git-send-email-ospite@studenti.unina.it>
	<1307543625.2669.180.camel@novo.hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Thu__9_Jun_2011_16_54_50_+0200_Uz14N7zKr0eeDytr"
Return-path: <linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1307543625.2669.180.camel-7u+x0O+HiKDXoxyGr5pmpw@public.gmane.org>
Sender: linux-bluetooth-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org>
Cc: linux-bluetooth-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Jim Paris <jim-XrPbb/hENzg@public.gmane.org>, Ranulf Doswell <ralf-fD3LYpizeBGsTnJN9+BGXg@public.gmane.org>, "Pascal A . Brisset" <pascal44973-dXI0m6hRz7k@public.gmane.org>, Marcin Tolysz <tolysz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Christian Birchinger <joker-vQrvfurPyUjk1uMJSBkQmQ@public.gmane.org>, Filipe Lopes <falktx-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, Mikko Virkkila <virkkila-/1wQRMveznE@public.gmane.org>, Simon Wood <simon-wM4F9T/ekXmXDw4h08c5KA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

--Signature=_Thu__9_Jun_2011_16_54_50_+0200_Uz14N7zKr0eeDytr
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, 08 Jun 2011 15:33:42 +0100
Bastien Nocera <hadess-0MeiytkfxGOsTnJN9+BGXg@public.gmane.org> wrote:

> On Wed, 2011-06-08 at 15:09 +0200, Antonio Ospite wrote:
> >=20
> >  - When the controller is connected via USB the led is set, but then=20
> >  it goes blinking again waiting for the PS button to be pressed,=20
> >  maybe we should wait for the PS button before setting leds, maybe =20
> >  with a simple blocking read() on the hidraw device.
>=20
> One hard thing to handle is when the device is already in use via USB,
> it should automatically connect via Bluetooth when unplugged. I'm not
> sure this works right now (I'm a bit hazy on the interaction with the=20
> PS button tbh).
>=20

Oh, this works if the user already pressed the PS button when connected=20
via USB, it is just the LED setting which is still weak on USB
connection (before and after PS button) because of the PS button
requirement.

BTW Bastien I'd really appreciate a run-time test by other people
before this gets is :)

> >  - When the controller is connected via USB after it is working over=20
> >  BT, it is seen as a second controller and the second led it turned=20
> >  on, should we force BT disconnection on USB connection?=20
>=20
> As we can identify the device uniquely through its bdaddr, I'd say=20
> yes.
>=20

I had done some experiment about that, but I didn't find a good way=20
using the bluez API, I'll be back on that after the first iteration
goes in, OK? I guess one problem will be about the numbering of=20
/dev/input/jsX, can we disconnect the BT device _before_ the kernel=20
enumerates the USB one?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Thu__9_Jun_2011_16_54_50_+0200_Uz14N7zKr0eeDytr
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3w3roACgkQ5xr2akVTsAHTHgCeMDhu1MfE6yszKv8jVBuAjdG0
FHgAoJWOGD13SXmlVi4ommVn4LSrZhEl
=i3d9
-----END PGP SIGNATURE-----

--Signature=_Thu__9_Jun_2011_16_54_50_+0200_Uz14N7zKr0eeDytr--
