From: Thierry Reding <thierry.reding@avionic-design.de>
Subject: Re: [PATCH 2/5] tsc2007: Add max_rt module parameter.
Date: Tue, 17 May 2011 07:46:20 +0200
Message-ID: <20110517054620.GB9943@avionic-0098.mockup.avionic-design.de>
References: <1305534783-4917-1-git-send-email-thierry.reding@avionic-design.de>
 <1305534783-4917-2-git-send-email-thierry.reding@avionic-design.de>
 <20110516165300.GB21232@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from moutng.kundenserver.de ([212.227.17.10]:53900 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1EQFq2 (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 17 May 2011 01:46:28 -0400
Content-Disposition: inline
In-Reply-To: <20110516165300.GB21232@core.coreip.homeip.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Kwangwoo Lee <kwlee@mtekvision.com>


--GRPZ8SYKNexpdSJ7
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

I was using module parameters because it allows the parameters to be tuned =
at
runtime. You are correct however in that they don't vary after being select=
ed
once. I can resend an updated patch series with those parameters added to t=
he
platform data if you prefer.

By the way, Kwangwoo's email address no longer seems to be valid. Searching
the kernel tree, there also seems to be kwangwoo.lee@gmail.com. Do you know
if it is current?

Thierry

--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk3SC6wACgkQZ+BJyKLjJp+07gCfTluFYJy5X/5XYYVadPU7vAX+
ez0An3i0ppuPNAV3ce0rR1xpBFiyLTpa
=6BMZ
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
