From: Florian Ragwitz <rafl@debian.org>
Subject: Re: [PATCH 1/2] elantech: Report tool width when it is known
Date: Wed, 5 May 2010 20:00:48 +0200
Message-ID: <20100505180048.GH6075@perldition.org>
References: <4BE16121.8040000@tudelft.nl> <20100505163951.GB7337@core.coreip.homeip.net> <4BE1A3AA.1090401@tudelft.nl> <20100505171350.GE7337@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tT3UgwmDxwvOMqfu"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from weedy.perldition.org ([85.10.210.75]:39361 "EHLO
	weedy.perldition.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757052Ab0EESAv (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 5 May 2010 14:00:51 -0400
Content-Disposition: inline
In-Reply-To: <20100505171350.GE7337@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: =?iso-8859-15?Q?=C9ric?= Piel <E.A.B.Piel@tudelft.nl>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>


--tT3UgwmDxwvOMqfu
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 05, 2010 at 10:13:50AM -0700, Dmitry Torokhov wrote:
> On Wed, May 05, 2010 at 06:58:18PM +0200, =C9ric Piel wrote:
> > Op 05-05-10 18:39, Dmitry Torokhov schreef:
> > > I think we shoudl have threshold for the firmware version when we sta=
rt
> > > reporting the width.
> > >
> > What do you mean? That the width might not be reported correctly by all
> > the firmwares? I have no idea if that is the case. For info, IIRC my
> > firmware report 2.1 with middle byte 8.
>
> My understanding was that older firmwares would report 0. I might be
> mistaken.

Some firmwares always set the upper bits to 0. Others don't.

As far as I can see, we only know about firmware version 2.1 and 4.1
using those high bits for width reports.

However, there's firmware versions inbetween, like 2.48, which don't
report width information. And there's even other firmware versions
inbetween, like 2.36, which actually implment what the driver calls
hardware version 1. Those have a quite different packet format, and also
no width information.

Currently it seems to be unknown how to detect hw ver 1 vs. 2 based on
the firmware version. Guesses tend towards the middle bit being
signifficant, somehow.


--=20
BOFH excuse #136:
Daemons loose in system.

--tT3UgwmDxwvOMqfu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFL4bJQdC8qQo5jWl4RApLlAJ9nOMi61Vz9NXz/rXQKEzutzj83RgCePwok
tD7z28kns7QMicxCkv/AaSo=
=+aTU
-----END PGP SIGNATURE-----

--tT3UgwmDxwvOMqfu--
