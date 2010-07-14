From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH] hid: ignore digitizer usage Undefined (0x00)
Date: Tue, 13 Jul 2010 21:32:50 -0400
Message-ID: <20100714013250.GB7316@alittletooquiet.net>
References: <20100527151808.GA484@alittletooquiet.net> <alpine.LRH.2.00.1007132351050.21712@twin.jikos.cz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAbsdosE1cNLO4uF"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:45471 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751137Ab0GNBcu (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 13 Jul 2010 21:32:50 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LRH.2.00.1007132351050.21712@twin.jikos.cz>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Jiri Kosina <jkosina@suse.cz>
Cc: linux-input@vger.kernel.org, Bjorn Behrendt <bbehrendt@msjvermont.org>


--eAbsdosE1cNLO4uF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Jiri,

On Tue, Jul 13, 2010 at 11:52:27PM +0200, Jiri Kosina wrote:
> On Thu, 27 May 2010, Forest Bond wrote:
> > SMART Technologies has recommended this change to fix a problem reported
> > with SMART Board series interactive whiteboards.
> >=20
> > A description of the device-specific symptom follows:
> >=20
> >   When the board is connected my mouse bounces up to the top left corne=
r.
> >=20
> > Bjorn has tested this fix with model SB680.
> >=20
> > Tested-by: Bjorn Behrendt <bbehrendt@msjvermont.org>
> > Signed-off-by: Forest Bond <forest@alittletooquiet.net>
> > ---
> >  drivers/hid/hid-input.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >=20
> > diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
> > index 7a0d2e4..6b10e5a 100644
> > --- a/drivers/hid/hid-input.c
> > +++ b/drivers/hid/hid-input.c
> > @@ -301,6 +301,9 @@ static void hidinput_configure_usage(struct hid_inp=
ut *hidinput, struct hid_fiel
> > =20
> >  	case HID_UP_DIGITIZER:
> >  		switch (usage->hid & 0xff) {
> > +		case 0x00: /* Undefined */
> > +			goto ignore;
> > +
> >  		case 0x30: /* TipPressure */
> >  			if (!test_bit(BTN_TOUCH, input->keybit)) {
> >  				device->quirks |=3D HID_QUIRK_NOTOUCH;
>=20
> Hi,
>=20
> I have applied the patch as it makes sense per se.

Thanks!  I hope your holiday was pleasant.

> Still, I'd be interested to know what is the device in question actually=
=20
> sending and what it has in its report descriptor. Does it indeed use 0x00=
=20
> code? For what reason?

I wish I could answer that for you.  I don't really know much about the dev=
ice
(I haven't actually seen one myself).

I'll try to request more information from the manufacturer.

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.pytagsfs.org

--eAbsdosE1cNLO4uF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFMPRPBRO4fQQdv5AwRAsm3AKCPXcsusNEP4LLyr2515Wv3iQfDCwCgj+tG
M+EO0vfWtirEdkauUlGYk7o=
=QFih
-----END PGP SIGNATURE-----

--eAbsdosE1cNLO4uF--
