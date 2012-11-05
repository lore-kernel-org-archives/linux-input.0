From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH resend2] Input: usbtouchscreen - initialize eGalax
 devices
Date: Mon, 5 Nov 2012 13:34:07 -0500
Message-ID: <20121105183406.GQ12501@alittletooquiet.net>
References: <20120903132648.GC11919@newmaster.mivlgu.local>
 <20120905060704.GC25962@core.coreip.homeip.net>
 <20120907204232.GA24528@alittletooquiet.net>
 <3475963.zdirdksHlt@dtor-d630.eng.vmware.com>
 <alpine.LNX.2.00.1211011137260.6606@pobox.suse.cz>
 <20121102195130.GJ12501@alittletooquiet.net>
 <alpine.LNX.2.00.1211051516530.24253@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZfOjI3PrQbgiZnxM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:35302 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754640Ab2KESh1 (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Mon, 5 Nov 2012 13:37:27 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1211051516530.24253@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org


--ZfOjI3PrQbgiZnxM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Mon, Nov 05, 2012 at 03:19:34PM +0100, Jiri Kosina wrote:
> On Fri, 2 Nov 2012, Forest Bond wrote:
>=20
> > We have some eGalax devices with class HID and protocol None that both=
=20
> > usbhid and usbtouchscreen will bind to, but we only want them bound to=
=20
> > usbtouchscreen. Some do in fact work with usbhid, but not all of them=
=20
> > do.  OTOH they all work with usbtouchscreen as of commit=20
> > 037a833ed05a86d01ea27a2c32043b86c549be1b.
> >=20
> > We want to blacklist these devices in usbhid to avoid binding to it if=
=20
> > it is loaded first.  But usbhid should continue to handle eGalax device=
s=20
> > with class HID and protocol other than None (e.g. Mouse).  They all hav=
e=20
> > the same vendor and product IDs, so we need to be able to blacklist on=
=20
> > (VID, PID, protocol) instead of just (VID, PID).
>=20
> I see, thanks for the explanation.
>=20
> As this is the first time we are having this problem, I'd just propose to=
=20
> put just another switch into hid_ignore() for USB_VENDOR_ID_DWAV, and=20
> looking at hdev->type there to see whether we should ignore the device or=
=20
> not.
>=20
> If it turns, over time, to be a more general problem for multiple devices=
,=20
> we'll just introduce the more general blacklist matching then.
>=20
> How does that sound?

Makes sense to me.  I didn't notice the checks in hid_ignore until now.

I'll send a patch in shortly.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--ZfOjI3PrQbgiZnxM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlCYBp4ACgkQRO4fQQdv5Ay+awCgx+rnCg85lrsyBLufinoodRw2
OnsAn3JIFxFhGQy2jSDi2qKQeSC6/nX7
=7tA8
-----END PGP SIGNATURE-----

--ZfOjI3PrQbgiZnxM--
