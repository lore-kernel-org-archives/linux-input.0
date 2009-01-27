From: Folkert van Heusden <folkert@vanheusden.com>
Subject: Re: 2.6.29rc1 breakes usb: hiddev device no longer available
Date: Tue, 27 Jan 2009 20:52:30 +0100
Message-ID: <20090127195229.GA6158@vanheusden.com>
References: <20090126170130.GG6158@vanheusden.com> <20090126182707.GI6158@vanheusden.com> <200901262005.08168.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp-vbr15.xs4all.nl ([194.109.24.35]:4234 "EHLO
	smtp-vbr15.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753459AbZA0Twe (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 27 Jan 2009 14:52:34 -0500
Content-Disposition: inline
In-Reply-To: <200901262005.08168.oliver@neukum.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org

> > > Since version 2.6.29rc1 querying cleware USb devices no longer wo=
rks.
> > > 2.6.28 works fine. 2.6.29-rc2 also no longer works.
> >=20
>=20
> > the is the FAILURE situation (2.6.29-rc*):
> > open("/dev/usb/hiddev0", O_RDWR)        =3D 3
> > ioctl(3, HIDIOCGDEVINFO, 0xbf90c0d8)    =3D 0
> > ioctl(3, HIDIOCAPPLICATION, 0)          =3D -6291455
> > ioctl(3, HIDIOCGSTRING, 0x804e2c0)      =3D -1 ENODEV (No such devi=
ce)
> Please try this patch.

Yes, that fixes it! Thanks!


Ack-by: folkert@vanheusden.com

> --- linux-2.6/drivers/hid/usbhid/hiddev.c.alt	2009-01-26 20:03:10.000=
000000 +0100
> +++ linux-2.6/drivers/hid/usbhid/hiddev.c	2009-01-26 20:03:17.0000000=
00 +0100
> @@ -656,7 +656,7 @@ static long hiddev_ioctl(struct file *fi
> =20
>  	case HIDIOCGSTRING:
>  		mutex_lock(&hiddev->existancelock);
> -		if (!hiddev->exist)
> +		if (hiddev->exist)
>  			r =3D hiddev_ioctl_string(hiddev, cmd, user_arg);
>  		else
>  			r =3D -ENODEV;


=46olkert van Heusden

--=20
MultiTail =E8 uno flexible tool per seguire di logfiles e effettuazione
di commissioni. Feltrare, provedere da colore, merge, 'diff-view',
etc. http://www.vanheusden.com/multitail/
----------------------------------------------------------------------
Phone: +31-6-41278122, PGP-key: 1F28D8AE, www.vanheusden.com
--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
