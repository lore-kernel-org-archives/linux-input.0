From: Maxime Ripard <maxime.ripard@free-electrons.com>
Subject: Re: [PATCH v3 0/4] input: ft5x06: Fix userspace reported maximum
 value
Date: Tue, 24 Mar 2015 12:05:05 -0700
Message-ID: <20150324190505.GF4951@lukather>
References: <1425390646-31196-1-git-send-email-maxime.ripard@free-electrons.com>
 <20150324001002.GJ15676@lukather>
 <20150324164722.GA11352@dtor-ws>
 <20150324184520.GE4951@lukather>
 <20150324185614.GC27693@dtor-ws>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="lIrNkN/7tmsD/ALM"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from down.free-electrons.com ([37.187.137.238]:50711 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752725AbbCXTKF (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 24 Mar 2015 15:10:05 -0400
Content-Disposition: inline
In-Reply-To: <20150324185614.GC27693@dtor-ws>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>, Henrik Rydberg <rydberg@euromail.se>, linux-input@vger.kernel.org, Markus Pargmann <mpa@pengutronix.de>, linux-kernel@vger.kernel.org


--lIrNkN/7tmsD/ALM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 24, 2015 at 11:56:14AM -0700, Dmitry Torokhov wrote:
> On Tue, Mar 24, 2015 at 11:45:20AM -0700, Maxime Ripard wrote:
> > On Tue, Mar 24, 2015 at 09:47:22AM -0700, Dmitry Torokhov wrote:
> > > On Mon, Mar 23, 2015 at 05:10:02PM -0700, Maxime Ripard wrote:
> > > > Hi Lothar, Dmitry,
> > > >=20
> > > > On Tue, Mar 03, 2015 at 02:50:42PM +0100, Maxime Ripard wrote:
> > > > > Hi,
> > > > >=20
> > > > > The current ft5x06 reports to the user-space that its maximum
> > > > > coordinates are, on both X and Y, way higher than what could be
> > > > > actually usable on the screen (in my case, 5759x1151 instead of
> > > > > 480x800).
> > > > >=20
> > > > > This causes trouble on some userspace stacks that then try to re-=
scale
> > > > > these coordinates back to the framebuffer resolution, like QT doe=
s.
> > > > >=20
> > > > > Use the of_touchscreen code to find the real touchscreen limits i=
n the
> > > > > DT case, and report that to the userspace.
> > > >=20
> > > > Do you have any comments on that?
> > >=20
> > > Yes, I'll apply it, although if you could supply the updated patch
> > > description for #1 that would be great. The current one seems from the
> > > old version and is no longer accurate.
> > >=20
> > > Thanks.
> >=20
> > You're right.
> >=20
> > Would something like:
> >=20
> > """
> > input: touchscreen: of: Rework the DT parsing function
> >=20
> > The DT parsing function currently duplicates a lot of the code to
> > parse the touchscreen DT properties.
> >=20
> > In order to ease further additions to this parsing routine, rework it
> > slightly to create new helper functions.
> >=20
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > """
> >=20
> > be good enough?
>=20
> Yep, thanks, I'll update the description, consider applied.
>=20
> Thanks.

Great, thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

--lIrNkN/7tmsD/ALM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVEbVgAAoJEBx+YmzsjxAgCWkQAKbvnPKdvi6OTQqPyLr93zDz
1UjPi/zSXwxTMC4P3Xc4Qo+Il76uDttQmtR2+6e9CiKfv6lM+NeEHt2DrvZ+D3kt
DVFcXbyL4HRtY87ftwxgJP24Gsu13JnAzFQ5afuv01JU38txseefmQg2acbi7aur
hMFm5IAfWSol0qPuFaIceuwr9uVR0XJfsNvIhZjHoUreU1tPQ+od++1c/bWYIlrV
cn8kb5zZNsXmyTUSQQHPlcwJrGdqFnMivoFxvcN+ve7eHD5iHZVgOo8KPMcrItjC
rwZWz5ulEDZrwytLbbF8khsLap5/60sYqDj7l3XP8uzdLQ+KOy5seYNJSDQc1I5u
4OEMLnkkzHr2JCekTBqYDcU32zKE/DMJfZhS9PuFN7Kf5lAlaTTCcreskSxdlbBL
1e6l/VmrYkECqwjmh8Nl8W5IKCAnL3av73Vf4tNZ4flwdBeASwxrUDANGi0MzUVB
tqMuXDAQ+TSce8qhQYunpjf42bSRVKCFa0D9kcZD432MmWQPtS1rndCL6I0yWoeR
O5rymH8aUqbKHBj9tZP5AEhRJzgLE24vVG/sZy1r9RmCs/pRglgQ+asb6tsnKHVA
NdMWxs0MoMHVqqGDLnPsfZ7hfVqxU8oyk//fstIW0O+Qef3J14yjeGJ6ha80v4vi
pRJfbcyBngjXc0qdJnPN
=hVLo
-----END PGP SIGNATURE-----

--lIrNkN/7tmsD/ALM--
