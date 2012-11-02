From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH resend2] Input: usbtouchscreen - initialize eGalax
 devices
Date: Fri, 2 Nov 2012 15:51:30 -0400
Message-ID: <20121102195130.GJ12501@alittletooquiet.net>
References: <20120903132648.GC11919@newmaster.mivlgu.local>
 <20120905060704.GC25962@core.coreip.homeip.net>
 <20120907204232.GA24528@alittletooquiet.net>
 <3475963.zdirdksHlt@dtor-d630.eng.vmware.com>
 <alpine.LNX.2.00.1211011137260.6606@pobox.suse.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:32986 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751730Ab2KBUEX (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 2 Nov 2012 16:04:23 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.1211011137260.6606@pobox.suse.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, Sergei Shtylyov <sshtylyov@mvista.com>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

Thanks for your message.  Pretty good timing, actually, as I was just about=
 to
pick this back up. ;)

On Thu, Nov 01, 2012 at 11:38:19AM +0100, Jiri Kosina wrote:
> On Mon, 10 Sep 2012, Dmitry Torokhov wrote:
>=20
> > > The other piece to this puzzle is that usbhid should blacklist these =
devices
> > > to avoid binding if it happens to be loaded before usbtouchscreen.  T=
o do
> > > this, usbhid needs to be able to blacklist devices based on interface
> > > protocol (right now it only supports blacklist on VID + PID).
> > >=20
> > > Would you accept a patch set that implements this?
> >=20
> > Juri, this question is really for you...
>=20
> Generally, I am not objecting to this idea in general.
>=20
> What is the particular use case here, so that it's needed?

We have some eGalax devices with class HID and protocol None that both usbh=
id
and usbtouchscreen will bind to, but we only want them bound to usbtouchscr=
een.
Some do in fact work with usbhid, but not all of them do.  OTOH they all wo=
rk
with usbtouchscreen as of commit 037a833ed05a86d01ea27a2c32043b86c549be1b.

We want to blacklist these devices in usbhid to avoid binding to it if it is
loaded first.  But usbhid should continue to handle eGalax devices with cla=
ss
HID and protocol other than None (e.g. Mouse).  They all have the same vend=
or
and product IDs, so we need to be able to blacklist on (VID, PID, protocol)
instead of just (VID, PID).

Does that make sense?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlCUJEIACgkQRO4fQQdv5AyryQCfQDrpIZ2HfRk5yKbuR0TE+oeH
iv4AnA8/GJO0qnf+1BBSLV6lHE+4GqwH
=mr7h
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
