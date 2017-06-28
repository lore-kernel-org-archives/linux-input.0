From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Spurious touchpad events with closed LID
Date: Wed, 28 Jun 2017 22:15:30 +0200
Message-ID: <20170628201530.GB18101@amd>
References: <201706261854.53970@pali>
 <20170626170312.GB4965@dtor-ws>
 <201706262109.42628@pali>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38152 "EHLO
        atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751795AbdF1UPd (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Wed, 28 Jun 2017 16:15:33 -0400
Content-Disposition: inline
In-Reply-To: <201706262109.42628@pali>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org, linux-input@vger.kernel.org


--JP+T4n/bALQSJXh8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

> > > When I'm using dock with external input devices (keyboard + mouse)
> > > and LID is closed, I'm getting spurious touchpad events and random
> > > mouse clicks and movements.
> > >=20
> > > It is because top part of LID is above touchpad and probably
> > > generates touch pushes.
> > >=20
> > > Year (or two?) when I had conversation with ALPS people I was told
> > > that Windows driver is automatically turning touchpad off when
> > > ACPI LID close event is received (and similarly turn touchpad on).
> > >=20
> > > Maybe Linux should do similar thing? Random movement or touchpad
> > > clicks is really annoying. But I'm not sure if kernel or userspace
> > > should do this job... What do you think?
> >=20
> > It is a matter of policy (deciding when device is "usable") and this
> > should be controlled from userspace. Kernel should provide necessary
> > knobs for it though. For a long time I was saying that it should be
> > done at device core level, but I do not think we will ever get
> > there.
> >=20
> > On ChromeOS input devices export "inhibit" attribute that basically
> > overrides open/close count and prevents delivery of events to
> > userspace, and power management driver controls this attribute
> > together with wake up and others.
>=20
> Hm... this sounds like a "disable" property for each event device which=
=20
> I was talking about months ago (ccing Pavel). Very similar problem is on=
=20
> Nokia N900, where touchscreen needs to be turned off when screen is=20
> locked and phone in pocket.

Yes, disable property would be nice.

> > This allows us to implement
> > policies like "the touchpad should only be active and a wakeup
> > source while the device is in laptop mode, but not in tablet or tent
> > mode, or when lid is closed", "disable keyboard in tablet mode or
> > when list is closed", etc.

While policy normally belongs to userspace, I'd argue this is
workaround for a hardware bug, and in-kernel solution would be
acceptable.

Anyway, disable attribute would be nice first step.

Best regards,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAllUDmIACgkQMOfwapXb+vIQJACfWpfhlihNYl67CUnRqSVrnjtP
DAcAn3OelGU0zgnf3ycOUaPjbpOKVIln
=YVaK
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--
