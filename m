From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: [PATCH 05/15] drivers: input: Drop unlikely before IS_ERR(_OR_NULL)
Date: Sun, 2 Aug 2015 17:59:39 +0200
Message-ID: <201508021759.39451@pali>
References: <cover.1438331416.git.viresh.kumar@linaro.org> <201508011344.59372@pali> <20150802154352.GA28860@amd>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2015825.X8yx16d8M7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wi0-f173.google.com ([209.85.212.173]:37385 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751373AbbHBP7n (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sun, 2 Aug 2015 11:59:43 -0400
In-Reply-To: <20150802154352.GA28860@amd>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, akpm@linux-foundation.org, linaro-kernel@lists.linaro.org, linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, "open list:INPUT (KEYBOARD, MOUSE, JOYSTICK, TOUCHSCREEN)..." <linux-input@vger.kernel.org>, Masaki Ota <masaki.ota@jp.alps.com>

--nextPart2015825.X8yx16d8M7
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Sunday 02 August 2015 17:43:52 Pavel Machek wrote:
> On Sat 2015-08-01 13:44:59, Pali Roh=C3=A1r wrote:
> > On Saturday 01 August 2015 13:22:51 Viresh Kumar wrote:
> > > On 31-07-15, 09:58, Dmitry Torokhov wrote:
> > > > On Fri, Jul 31, 2015 at 02:08:25PM +0530, Viresh Kumar wrote:
> > > > > IS_ERR(_OR_NULL) already contain an 'unlikely' compiler flag
> > > > > and there is no need to do that again from its callers. Drop
> > > > > it.
> > > >=20
> > > > I'd rather keep it as it documents the expected behavior and
> > > > double unlikely should work just fine.
> > >=20
> > > TBH, I don't really agree that it is there for documentation. The
> > > only purpose of such compiler flags is to try make code more
> > > efficient.
> > >=20
> > > Anyway, I got to this series as someone asked me to fix this for
> > > one of my patches which used unlikely(IS_ERR_OR_NULL()). And so
> > > I thought about fixing all sites that are doing double unlikely
> > > (that shouldn't hurt for sure).
> > >=20
> > > I will leave it to you.
> >=20
> > I think that unlikely() macro here make code more readable. Yes, it
> > is also for compiler optimization, but also for me it looks like
> > Clean Code pattern <https://de.wikipedia.org/wiki/Clean_Code> --
> > is not it?
>=20
> People know that errors are unlikely, no need to tell them. I'd
> remove it.
> 									Pavel

Errors and bugs are always unlikely ;-)

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2015825.X8yx16d8M7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlW+PmsACgkQi/DJPQPkQ1I+IACgiIcIqam1aqdStW1wSAij/y92
fY0AnAy2TPdmBKlKsamPmZP3GM3jurlG
=xu/7
-----END PGP SIGNATURE-----

--nextPart2015825.X8yx16d8M7--
