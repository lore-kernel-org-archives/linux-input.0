From: Rafi Rubin <rafi-hkHJxBBPWjbG6jMu9gPlYQ@public.gmane.org>
Subject: Re: To add a device support it should be BlackListed ?
Date: Wed, 13 May 2009 19:01:56 -0400
Message-ID: <4A0B5164.1060409@seas.upenn.edu>
References: <45cc95260905131004x186e4ff3ga79cc943f63680d0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <45cc95260905131004x186e4ff3ga79cc943f63680d0-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mohamed Ikbel Boulabiar <boulabiar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Andrew Morton <akpm-de/tnXTf+JLsfHDXvbKv3WD2FQJk+8+b@public.gmane.org>, Greg KH <greg-U8xfFu+wG4EAvxtiuMwx3w@public.gmane.org>, USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, USB list <linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-input@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The blacklist just tell the hid system a device needs some special hand=
ling.  The patch you link to
was actually an ntrig employee trying to nix the existing functionality=
 by telling the hid system to
ignore the device.  It is not a good positive example as to how to get =
hid to support your device.

The first thing you should check is if IS_INPUT_APPLICATION supports th=
e "usage" your device
reports.  I'm sure there's an easy way to see what usage a device repor=
ts, but I don't know about
it.  It's pretty easy to add a printk just before (or an else after)
            if (IS_INPUT_APPLICATION(col->usage))
in hid-input.c

Anyway, that will tell you if the hid system is ignoring your device, a=
nd what to add to
IS_INPUT_APPLICATION in include/linux/hid.h, if necessary.

Rafi

Mohamed Ikbel Boulabiar wrote:
> Hi,
>=20
> I am trying with my professor St=E9phane Chatty to add support to a
> Stantum multitouch tablet that is a HID device.
>=20
> We tried copying hid-ntrig.c and applying modification to get
> supported but we haven't reached something functional.
>=20
> Should we add more information to some place to reach our goals ?
> I have read this and we maybe need to blacklist the stantum somewhere
> (hid-quirks.c ?)
>=20
> "This patch is required for N-trig support for the Linux Environment.
> It requests the USBHID driver to ignore an N-trig device, when
> connected to the USB bus."
> http://kerneltrap.org/index.php?q=3Dmailarchive/linux-usb/2009/1/20/4=
772014/thread
>=20
>=20
> Is this true ? How should we do it ? And why (because we have at leas=
t
> 3 to 4 other devices from other constructors and we want to add
> support) ?
>=20
>=20
> Thanks
> ______________________________
> Mohamed-Ikbel BOULABIAR
> =C9l=E8ve Ing=E9nieur ENSI - Tunisie
> Stagiaire au LII - ENAC, Toulouse
>=20
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkoLUWQACgkQwuRiAT9o608k5gCfUt0Z7eyUD90pacILQaVzu3pW
2x4AniKheYq6fC0FFAMaQ2Z//RfGl61c
=3DzGPE
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
