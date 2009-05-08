From: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: lockdep report at resume
Date: Fri, 08 May 2009 12:25:13 +0200
Message-ID: <1241778313.4495.0.camel@johannes.local>
References: <1234022517.4175.107.camel@johannes.local>
	 <1238578840.5970.178.camel@johannes.local>
	 <alpine.LNX.2.00.0904211550280.13028@wotan.suse.de>
	 <200904211559.43497.oliver@neukum.org>
	 <alpine.LNX.2.00.0904211609220.13028@wotan.suse.de>
	 <1240323968.17388.22.camel@johannes.local>
	 <alpine.LNX.2.00.0905051446520.22532@wotan.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-EkdNSVHNJdAADibftIq/"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from xc.sipsolutions.net ([83.246.72.84]:51353 "EHLO
	sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751831AbZEHKaO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 8 May 2009 06:30:14 -0400
In-Reply-To: <alpine.LNX.2.00.0905051446520.22532@wotan.suse.de>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: Oliver Neukum <oliver@neukum.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-input <linux-input@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Oleg Nesterov <oleg@redhat.com>


--=-EkdNSVHNJdAADibftIq/
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2009-05-05 at 14:47 +0200, Jiri Kosina wrote:
> On Tue, 21 Apr 2009, Johannes Berg wrote:
>=20
> > > > > [ thanks for the analysis Johannes ... involving also Oliver here=
; really
> > > > >   seems like a false positive to me ]
> > > > I think he's right. But as a matter of principle I'd like to see=20
> > > > flush_scheduled_work() avoided where possible, hence the patch.
> > > I am not entirely sure that this is the same issue as the one from #1=
3136=20
> > > of kernel.org bugzilla.
> > > Anyway, for reference, the patch Oliver mentioned here is below.
> > Thanks. Unfortunately I have another problem that turns off lockdep so =
I
> > can't test this right now, sorry.
>=20
> Are you able to reproduce the problem with current git (the expected fix=20
> is 89092ddd7a).

I don't know, unfortunately, because I keep getting a different lockdep
report at _suspend_ time.

johannes

--=-EkdNSVHNJdAADibftIq/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQIcBAABAgAGBQJKBAiAAAoJEODzc/N7+Qma1SMQAM08DI+GbMwsBWd+52u3Z94Q
NlEW5StdITcDobWO8/H4TbBdp4grXE99hzCnw82AsdsA46JfUdUqbwjUGejVHRoG
watrTIKhLJGezMaighPYEvmlVG43aSl3Nkp3bq3llAmzRGOeuNZnt5WUOvRhvtTt
DDWuecWz7F2pH0ikfjhhFk1Gvoqvn+AleILN9vEtaLLrdk476S2c0/yuR63l2Xj5
i78cZUFrSWvBATifr8rbH6HKIkKcCrF0XoEQFvfYEn4LhpblN0trpHDijXsJbNDA
Gpmj8rXJDYDZ63wdw2Vd06jAdoGLXdRaMP8fkT3T3IzsUcXNXtdFAEyTqVZIvZ8n
clVLFRFpGSrzFAdk2urOk2ogFbpMBLZQI5ywUiT4wsPUynzWEmXq+ErDa9BBrtJZ
7AOp9ysSjeTW31HKPwAxlldRV7/IYpIR6QdxXdJ+9a2+nlczsRvp2ARz09IL33+f
poYFpZk7YATewIC7/sVnt6ebKgItt+xMQurJX999+g4Ji/mbyG/5Dr0oEsaskgXj
wrcSiSgvJEOUOVnpyjGsbUwmBxsUR0cm4Q6ejtWLPJ+Oe1x1RjPkL2yNmiDoE/d2
gIzxoSxKKp8rE2qbitxwZUzSJALXE94yEv3NZthWMQdTorHLyJKJ/k6gX7a1TYPI
yL4uQLovfTTArR4JQDCN
=ZA/b
-----END PGP SIGNATURE-----

--=-EkdNSVHNJdAADibftIq/--

