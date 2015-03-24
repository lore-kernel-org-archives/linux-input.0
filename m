From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Tue, 24 Mar 2015 11:45:20 -0700
Message-ID: <20150324184520.GE4951@lukather>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150324001002.GJ15676@lukather>
 <20150324164722.GA11352@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:49944 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752401AbbCXSuH (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 14:50:07 -0400
Content-Disposition: inline
In-Reply-To: <20150324164722.GA11352@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 09:47:22AM -0700, Dmitry Torokhov wrote:
> On Mon, Mar 23, 2015 at 05:10:02PM -0700, Maxime Ripard wrote:
> > Hi Lothar, Dmitry,
> >=20
> > On Tue, Mar 03, 2015 at 02:50:42PM +0100, Maxime Ripard wrote:
> > > Hi,
> > >=20
> > > The current ft5x06 reports to the user-space that its maximum
> > > coordinates are, on both X and Y, way higher than what could be
> > > actually usable on the screen (in my case, 5759x1151 instead of
> > > 480x800).
> > >=20
> > > This causes trouble on some userspace stacks that then try to re-scale
> > > these coordinates back to the framebuffer resolution, like QT does.
> > >=20
> > > Use the of_touchscreen code to find the real touchscreen limits in the
> > > DT case, and report that to the userspace.
> >=20
> > Do you have any comments on that?
>=20
> Yes, I'll apply it, although if you could supply the updated patch
> description for #1 that would be great. The current one seems from the
> old version and is no longer accurate.
>=20
> Thanks.

You're right.

Would something like:

"""
input: touchscreen: of: Rework the DT parsing function

The DT parsing function currently duplicates a lot of the code to
parse the touchscreen DT properties.

In order to ease further additions to this parsing routine, rework it
slightly to create new helper functions.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
"""

be good enough?

Thanks,
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEbDAAAoJEBx+YmzsjxAg8BQP/2JfoFNVl+CkeKmJpkRRdZbs
jTXLiEDVfdI5wCzRKycGuPCNaNA8g4fb1Z06Ah//dnDa+YX9QyPQyvU091hykA2/
0wuXqHFqkZXEJMMQkx0gZ5ZkGW7/N5Yhj+4prVa1vJP0gHoEMg722PSpeq4Mxn//
mDp1TkxbBSxKeczIIsxJDuFCPI/4L4EtWnhyqXtXLDGS+rgsmTGp+BeXvcVHmjzH
s3frmQiNIgybFAUtKQU0q8Tcjq4ObuYLTPK62vSqsm69H4sJCYqGSOCqnwcwW0Ya
7FshnADHpbEA2fkxOzowkSnjCUdbzmmfq89SmuVhE/nghTy2b9cQ/qNbdNY4NIKQ
U5J6uLJ4XzFeDWwZvzlb3t1k0TnE5L5CJRXDOhQibohwDpkZCKxxcGNl8W3+MXHg
mm24cyu7K/hhp6OjPYKhc6bLzWKZGupAA3CqbA0n+zHGVYDvG0pdnNAVi96N2G2h
a+OLy1T0hlWnyPNPPDCj2Bfvsue5kgNLCUyShvqzPHUZ9qJ5ZTurxzZ2MLKr+3Cr
AtPUuv3b3v2NR0QHTaF4oEJLvRVDQKnobH6p1cDyDTgd04DUeQiXLAQoGIPyhRKv
IvaDCMrABUdCc/+miTJdvpTU5RLFuTgjUrp2GXJ74D4oqMtVfDYNGXLTh+paPPxk
fujfctIWcVH0ocLF5eCf
=ZEnP
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
