From: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Wishlist: Add support for software-rf-switch in Fujitsu-Siemens
 notebook
Date: Tue, 01 Nov 2011 04:33:25 +0000
Message-ID: <1320122005.30281.18.camel@deadeye>
References: <20110625211738.3615.21718.reportbug@lisa>
		 <1317441406.4068.43.camel@deadeye> <20111002221253.GA18253@elie>
		 <4E9B3DCC.7050106@gmx.net> <1318824232.3340.1.camel@deadeye>
	 <4EAEDB1A.3070906@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-y7SfA8JXHR47yZh3+pHY"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:44755 "EHLO
	shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750954Ab1KAEdt (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 1 Nov 2011 00:33:49 -0400
In-Reply-To: <4EAEDB1A.3070906@gmx.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Tino Schmidt <mailtinoshomepage@gmx.net>
Cc: Jonathan Nieder <jrnieder@gmail.com>, linux-input@vger.kernel.org, Miloslav Trmac <mitr@volny.cz>, Martin =?UTF-8?Q?Ve=C4=8De=C5=99a?= <ja@marvec.org>, Jonathan Woithe <jwoithe@physics.adelaide.edu.au>, =?ISO-8859-1?Q?=C9ric?= Piel <eric.piel@tremplin-utc.net>, 631664@bugs.debian.org


--=-y7SfA8JXHR47yZh3+pHY
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-10-31 at 18:30 +0100, Tino Schmidt wrote:
> > On Sun, 2011-10-16 at 22:25 +0200, Tino Schmidt wrote:
> > [...]
> >   =20
> >> Hi,
> >> I'm sorry for the long delay but I can use the laptop only on weekend.
> >> Here is the output:
> >>
> >> # modprobe wistron_btns force=3D1
> >> FATAL: Error inserting wistron_btns
> >> (/lib/modules/2.6.26-2-686/kernel/drivers/input/misc/wistron_btns.ko):
> >> No such device
> >>     =20
> > It looks like this model is rather different, maybe not a Wistron desig=
n
> > at all.
> >
> > I would prefer you to test against Linux 3.0, but it appears that the
> > model detection has not changed since 2.6.26.
> >
> >   =20
> >> # dmesg
> >> [  168.628474] wistron_btns: BIOS entry point not found
> >>
> >> and
> >> # grep . /sys/class/dmi/id/*_{vendor,name,version}
> >> /sys/class/dmi/id/bios_vendor:FUJITSU SIEMENS
> >> /sys/class/dmi/id/board_vendor:FUJITSU SIEMENS
> >> /sys/class/dmi/id/chassis_vendor:FUJITSU SIEMENS
> >> /sys/class/dmi/id/sys_vendor:FUJITSU SIEMENS
> >> /sys/class/dmi/id/board_name:AMILO A1655
> >> /sys/class/dmi/id/product_name:AMILO A Series
> >> /sys/class/dmi/id/bios_version:1.0C-8044-8A20
> >> /sys/class/dmi/id/board_version:Rev0.4b
> >> /sys/class/dmi/id/chassis_version:N/A
> >> /sys/class/dmi/id/product_version:0100
> >>     =20
> > Please build and test the attached driver (make&&  insmod
> > amilo-rfkill.ko).  It provides a standard rfkill device which you can
> > control with e.g. the 'rfkill' command, and will only bind to specific
> > models.
> >
> > If this works, I'll submit the code upstream.
> >
> > Ben.
> >
> >   =20
> Hi Ben,
> Thank you for your code!
>=20
> Before I built the module (Kernel 2.6.32) I had to insert the include=20
> line #include <asm/io.h> ( -> inb()-function ?)

That should be <linux/io.h>, actually.

> With Kernel 2.6.26 I couldn't even built the module.
>=20
> But loading of the module failed:
> # insmod amilo-rfkill.ko
> insmod: error inserting 'amilo-rfkill.ko': -1 No such device

Sorry, I made the driver look for product name "AMILO A1655" but that is
actually the board name.  Could you try changing DMI_PRODUCT_NAME to
DMI_BOARD_NAME?

> In kernel 2.6.32 exists /dev/rfkill but
>=20
> # rfkill list
> 0: phy0: Wireless LAN
>     Soft blocked: no
>     Hard blocked: yes
>=20
> # rfkill unblock all
>=20
> # rfkill list
> 0: phy0: Wireless LAN
>     Soft blocked: no
>     Hard blocked: yes
>=20
> doesn't work here. Nothing changed.

This is the rfkill device exposed by the regular wireless driver.  Since
it doesn't know anything about the model-specific blocking behaviour, it
appears to treat it as hard-blocking.  But that shouldn't matter if we
can get this new driver working.

Ben.

--=20
Ben Hutchings
Computers are not intelligent.	They only think they are.

--=-y7SfA8JXHR47yZh3+pHY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUATq92lee/yOyVhhEJAQqtlA//TrVy2lhHWvtO8NV5D9iyWQEKMDfzyjtp
WWhRt9SLMnzOuQ4Ijebf8kiYLUGFIZo6gmVgNZ0KOwXGPWAqGkELn6sidajMzzgJ
DxmbyMzJI65iieSRNrTjmBfIxq6ACu9ncSAG4TwKwTaRltLrB+Q93/xUv9KFH4pK
DM9L/5/DVA6LMkqyUV7sXrfJj8lVhMj8E89iZakqgJUBRHvYFdScFUPB/gqTJoMv
DVRHsm3keQRkkxq2nPpyWTffuffHuuZU7Q6lYPIP8IfmrZwM7KsRzJx5APRb8UHr
qdHSOn9P6LuctLM1JaYjpifT0hlKah/2wFpRzBRxMjGG0CN2CjGrmxH9g+pIAJ2Q
5x1Luo0+w5vd6YomN5XpXPNV4cPSGsAl08hEjPWQOHoyhMUjFfKxjFkoJFSK+mAr
Tck90afFIcWIrq1amQHY0eRCZyBFeBYnWNFhMauhI6M4J5uJoZhvhstblsXtivUm
XTi7OsgaZcnq67l0iQEJiukJ9TSUI1pnE4NzAFDIRxB7qWHiswDdrsnsngPEZWlS
D4mWPGaRAOyps5wAE7BDuZRe1ntNQ2iH9HD06xhZvlDB5KO5NQDbcexGRRLXKJeA
p5SF35lwmPgw+vyrTQGz8VO+jywMkKOikWw+UKHVReBNBu+I98S1D/7feQM1V1Fk
8FjsCsHcXK8=
=W9fQ
-----END PGP SIGNATURE-----

--=-y7SfA8JXHR47yZh3+pHY--
