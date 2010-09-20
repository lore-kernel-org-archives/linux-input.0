From: Maciej Rutecki <maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [BUG, Regression, bisected] USB mouse causes bug on 1st insert, ignored on 2nd insert, lsusb stuck at usbdev_open
Date: Mon, 20 Sep 2010 21:35:41 +0200
Message-ID: <201009202135.41833.maciej.rutecki@gmail.com>
References: <4C96B9DB.8030403@turmel.org>
Reply-To: maciej.rutecki-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <4C96B9DB.8030403-xiX+HWoRdKcdnm+yROfE0A@public.gmane.org>
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Phil Turmel <philip-xiX+HWoRdKcdnm+yROfE0A@public.gmane.org>
Cc: Guillaume Chazarain <guichaz-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Jiri Kosina <jkosina-AlSwsSmVLrQ@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Greg Kroah-Hartman <gregkh-l3A5Bk7waGM@public.gmane.org>, Alan Stern <stern-nwvwT67g6+6dFdvTe/nMLpVzexx5G7lz@public.gmane.org>, Oliver Neukum <oliver-GvhC2dPhHPQdnm+yROfE0A@public.gmane.org>, Alan Ott <alan-yzvJWuRpmD1zbRFIqnYvSA@public.gmane.org>, linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-input-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-input@vger.kernel.org

On poniedzia=C5=82ek, 20 wrze=C5=9Bnia 2010 o 03:33:15 Phil Turmel wrot=
e:
> A new regression was introduced between -rc3 and -rc4:
>=20
> The USB mouse I use with my laptop is causing a BUG when inserted.  I=
t
> works at that point, but if removed and re-inserted, it is ignored.  =
Also,
> after the 2nd insert, other USB devices (like my thumb drive) are als=
o
> ignored.
>=20

I created a Bugzilla entry at=20
https://bugzilla.kernel.org/show_bug.cgi?id=3D18892
for your bug report, please add your address to the CC list in there, t=
hanks!

--=20
Maciej Rutecki
http://www.maciek.unixy.pl
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
