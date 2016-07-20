From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: v4.1 to v4.7: regression in tsc2005 driver
Date: Wed, 20 Jul 2016 18:33:01 +0200
Message-ID: <201607201833.01772@pali>
References: <20160717175257.GA26719@amd> <20160720003908.GA32423@deathstar> <20160720005307.GH19250@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2492214.xSXmbQjyOb";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wm0-f46.google.com ([74.125.82.46]:36541 "EHLO
	mail-wm0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752295AbcGTQdG (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 20 Jul 2016 12:33:06 -0400
In-Reply-To: <20160720005307.GH19250@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Michael Welling <mwelling@ieee.org>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-input@vger.kernel.org, sre@kernel.org, aaro.koskinen@iki.fi, ivo.g.dimitrov.75@gmail.com, patrikbachan@gmail.com, serge@hallyn.com

--nextPart2492214.xSXmbQjyOb
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 20 July 2016 02:53:07 Dmitry Torokhov wrote:
> On Tue, Jul 19, 2016 at 07:39:08PM -0500, Michael Welling wrote:
> > On Tue, Jul 19, 2016 at 04:51:20PM -0700, Dmitry Torokhov wrote:
> > > On Sun, Jul 17, 2016 at 05:56:36PM -0500, Michael Welling wrote:
> > > > On Sun, Jul 17, 2016 at 10:03:39PM +0200, Pavel Machek wrote:
> > > > > On Sun 2016-07-17 13:51:34, Michael Welling wrote:
> > > > > > On Sun, Jul 17, 2016 at 08:42:09PM +0200, Pavel Machek
> > > > > > wrote:
> > > > > > > On Sun 2016-07-17 13:24:45, Michael Welling wrote:
> > > > > > > > On Sun, Jul 17, 2016 at 07:52:57PM +0200, Pavel Machek
> > > > > > > > wrote:
> > > > > > > > > Hi!
> > > > > > > > >=20
> > > > > > > > > tsc2005 driver changed input device name, from
> > > > > > > > >=20
> > > > > > > > > drivers/input/touchscreen/tsc2005.c:	=20
> > > > > > > > > input_dev->name =3D "TSC2005 touchscreen";
> > > > > > > > >=20
> > > > > > > > > to "TSC200X touchscreen". Unfortunately, X seems to
> > > > > > > > > propagate that name to userspace, where it is needed
> > > > > > > > > to be able to do
> > >=20
> > > Technically X _is_ userspace.
> > >=20
> > > > > > > > > xinput --set-prop --type=3Dint ...
> > > > > > > > >=20
> > > > > > > > > with the right arguments to calibrate touchscreen.
> > > > > > > > > (Touchscreen is unusable without calibration).
> > > > > > > > >=20
> > > > > > > > > What to do with that?
> > >=20
> > > Hmm, I do not think we ever committed for the device names to be
> > > stable. You are supposed to locate touchscreen device based on
> > > its properties and you might need some heuristic if you
> > > encounter a system with more than one such touchscreen.
> > >=20
> > > > > > > > The input_dev name could be passed to the common probe
> > > > > > > > function.
> > > > > > > >=20
> > > > > > > > http://lxr.free-electrons.com/source/drivers/input/touc
> > > > > > > > hscreen/tsc2005.c#L65
> > > > > > >=20
> > > > > > > That would be preffered, I guess.
> > > > > > >=20
> > > > > > > How many stable releases are affected?
> > > > > >=20
> > > > > > Well this patch is 9 months old now. Lets see.
> > > > > >=20
> > > > > > It was introduced in v4.4-rc1. So v4.4, v4.5 and v4.6.
> > > > >=20
> > > > > Ok, thanks for the information. I believe changing it back to
> > > > > "TSC2005" version makes sense (and then fixing it in stable).
> > >=20
> > > Do we know how many users are affected?
> >=20
> > Anyone with an old N900 and the smarts to update the kernel.
>=20
> Soo... only Pavel? ;)

No, more are playing with upstream kernel and N900. Now I see that Maemo=20
applications looks also for string "TSC2005 touchscreen"...

I'm also for changing name back to "TSC2005 touchscreen" for TSC2005=20
touchscreen.

=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart2492214.xSXmbQjyOb
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlePp70ACgkQi/DJPQPkQ1I+TACgssvOxJ8tKN72np6ezW2m2hYp
vssAoJzNRbTs0jmXmioZ30+DBklxvpGk
=it5q
-----END PGP SIGNATURE-----

--nextPart2492214.xSXmbQjyOb--
