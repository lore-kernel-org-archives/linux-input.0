From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/5] tsc2007: Add max_rt module parameter.
Date: Tue, 17 May 2011 08:59:47 +0200
Message-ID: <20110517065947.GA7521@avionic-0098.mockup.avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <1305534783-4917-2-git-send-email-thierry.reding@avionic-design.de>
 <20110516165300.GB21232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="LZvS9be/3tNcYl/X"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.9]:59013 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752115Ab1EQG7t (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 02:59:49 -0400
Content-Disposition: inline
In-Reply-To: <20110516165300.GB21232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwangwoo.lee@gmail.com>


--LZvS9be/3tNcYl/X
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

* Dmitry Torokhov wrote:
> Hi Thierry,
>=20
> On Mon, May 16, 2011 at 10:33:00AM +0200, Thierry Reding wrote:
> > Finger touch events or very quick stylus events on low-quality panels
> > can cause the tsc2007 to read bogus values. Looking at oscilloscope
> > snapshots, this seems to be caused by the touch event disappearing
> > during the measurements. These bogus values result in misclicks, where
> > the X and Y values deviate from the real position.
> >=20
> > Most of these misclicks can be filtered out by setting a low enough
> > threshold for the maximum resistance (which is loosely the inverse of
> > the pressure) allowed to consider a set of values valid. Since this
> > behaviour is largely dependent on the type and quality of the panel,
> > this commit introduces the max_rt parameter. The default value is kept
> > at MAX_12BIT.
>=20
> I expect that the values, once selected, will not be changed for a given
> panel, so why don't we pass max_rt (and poll_delay and poll_interval) vi
> platform (board) data instead of being module parameters?

How do I best handle keeping the default values? Should I check whether the
value has been set at all in the platform data and set the default otherwis=
e?
That would reserve the value 0 as special. Or should I just assume that all
the values must be set explicitly?

Thierry

--LZvS9be/3tNcYl/X
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3SHOMACgkQZ+BJyKLjJp+QXgCgrFX/i5PYiHZFvvqNfZo0G9E3
KGMAn3LDSN8KPy1LvuwLt0rKk8jjvK87
=BO5e
-----END PGP SIGNATURE-----

--LZvS9be/3tNcYl/X--
