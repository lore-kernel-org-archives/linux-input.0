From: cascardo@holoscopio.com
Subject: Re: [PATCH] eeepc-wmi: new driver for WMI based hotkeys on Eee PC
 laptops
Date: Sat, 20 Mar 2010 09:20:50 -0300
Message-ID: <20100320122049.GA1478@holoscopio.com>
References: <20100319133924.GA30427@ywang-moblin2.bj.intel.com>
 <20100319135929.GA29027@srcf.ucam.org>
 <20100319151054.GA30664@ywang-moblin2.bj.intel.com>
 <20100319152323.GA30456@srcf.ucam.org>
 <20100320005553.GB32163@ywang-moblin2.bj.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from liberdade.minaslivre.org ([72.232.254.139]:33753 "EHLO
	liberdade.minaslivre.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751604Ab0CTMU5 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 20 Mar 2010 08:20:57 -0400
Content-Disposition: inline
In-Reply-To: <20100320005553.GB32163@ywang-moblin2.bj.intel.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Yong Wang <yong.y.wang@linux.intel.com>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Corentin Chary <corentincj@iksaif.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 20, 2010 at 08:55:53AM +0800, Yong Wang wrote:
> On Fri, Mar 19, 2010 at 03:23:23PM +0000, Matthew Garrett wrote:
> >=20
> > > > > +		if (code >=3D NOTIFY_BRNUP_MIN && code <=3D NOTIFY_BRNUP_MAX)
> > > > > +			code =3D NOTIFY_BRNUP_MIN;
> > > > > +		else if (code >=3D NOTIFY_BRNDOWN_MIN && code <=3D NOTIFY_BRND=
OWN_MAX)
> > > > > +			code =3D NOTIFY_BRNDOWN_MIN;
> > > >=20
> > > > Do the brightness keys just send notifications, or do they actually=
=20
> > > > change the brightness? If they actually change the brightness, we=
=20
> > > > shouldn't send input events.
> > > >=20
> > >=20
> > > Yes, hardware and bios change brightness by themselves without softwa=
re intervention
> > > on my Eee PC 1005 when pressing the hotkeys.
> >=20
> > Ok. In that case, you shouldn't send input events. Once backlight=20
> > control is implemented in the eee-wmi driver you can send notifications=
=20
> > via that instead.
> >=20
>=20
> One question just popped off the top my head. What if there is a power
> applet that wants to display a slider field at the bottom of the screen
> showing the current brightness real time whenever users press brightness
> hotkeys? Shouldn't it listen to the standard input events translated by
> X into standard XF86 keysyms? Or shall it listen to the ACPI backlight
> events? If so, it is the ACPI LCD event when using acpi backlight
> driver. But what if those vendor specific backlight drivers are used?
>=20
> Thanks
> -Yong
> --

You may select/poll for the sysfs file actual_brightness. It will return
POLLPRI. Basically, backlight devices end up calling sysfs_notify that
will allow sysfs_poll to work. Read the comments about sysfs_poll at
fs/sysfs/file.c.

You should either use backlight_force_update in your driver or let the
user update it writing to the brightness file. In your case, I'd say you
should use backlight_force_update and give BACKLIGHT_UPDATE_HOTKEY as
the reason.

Regards,
Cascardo.

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkukvaEACgkQyTpryRcqtS3bCwCeJwCb/JsOcIDjVaF8FFAbm+fF
ULEAn0HH1Fy3d+SFrkG6Bk9OJLZo/uDv
=PBNG
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
