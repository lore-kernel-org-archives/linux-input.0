From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Spurious touchpad events with closed LID
Date: Thu, 29 Jun 2017 12:08:37 +0200
Message-ID: <20170629100837.GA1709@amd>
References: <201706261854.53970@pali>
 <20170626170312.GB4965@dtor-ws>
 <201706262109.42628@pali>
 <20170628201530.GB18101@amd>
 <1498689867.6564.6.camel@hadess.net>
 <20170629073102.GG25196@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:59259 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751557AbdF2KIk (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 29 Jun 2017 06:08:40 -0400
Content-Disposition: inline
In-Reply-To: <20170629073102.GG25196@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Bastien Nocera <hadess@hadess.net>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

On Thu 2017-06-29 09:31:02, Pali Roh=E1r wrote:
> On Thursday 29 June 2017 00:44:27 Bastien Nocera wrote:
> > On Wed, 2017-06-28 at 22:15 +0200, Pavel Machek wrote:
> > >=20
> > <snip>
> > > While policy normally belongs to userspace, I'd argue this is
> > > workaround for a hardware bug, and in-kernel solution would be
> > > acceptable.
> > >=20
> > > Anyway, disable attribute would be nice first step.
> >=20
> > It's already fixed for those of us on recent distributions. The
> > "ID_INPUT_TOUCHPAD_INTEGRATION=3Dinternal" touchpads will be disabled
> > when the lid is closed, when libinput is used to process the events.
>=20
> But this does not fix other usage of /dev/input/* and also does not fix
> pressing spurious keys in linux virtual tty (ctrl+alt+f1). So it is not
> a fix.
>=20
> Also important question is: How you detect which input device is
> "internal", non-removable part of notebook and which one is external?
>=20
> You can have external USB touchpad, and also you can have external PS/2
> keyboard connected to docking station (which was e.g. my situation).
>=20
> Also there are PS/2 to active USB converters, to make whole situation
> complicated.
>=20
> And moreover some internal notebook keyboards are connected via USB and
> some touchpads via i2c/smbus.
>=20
> I think this detection is not easy or at least I have no idea how to do
> properly. Existence of PS/2 keyboard does not mean it is internal and
> existence of USB keyboard does not mean it is external.
>=20
> Maybe ACPI/DSDT provides some information? (No idea, just asking)

I'm not sure it is complex. You simply add DMI blacklist of the bad
systems, with IDs of bad devices.

									Pavel
--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllU0aUACgkQMOfwapXb+vJFuACgjxAfScHtInGOTj1wFABieMQQ
4SMAn2De6SHNALwqWIxz2QiyK7uNjTWG
=PDxZ
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
