From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 4/5] platform/x86: intel-vbtn: support KEY_ROTATE_LOCK_TOGGLE
Date: Fri, 10 Nov 2017 03:20:19 +0100
Message-ID: <2529521.pNZ5jyQYNe@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <6070680.Ajd9sKXNqZ@pebbles> <20171110015422.GD9783@fury>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart6185159.Gd0MK2uq1p";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <platform-driver-x86-owner@vger.kernel.org>
In-Reply-To: <20171110015422.GD9783@fury>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Bastien Nocera <hadess@hadess.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart6185159.Gd0MK2uq1p
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 2:54:22 AM CET Darren Hart wrote:
> On Fri, Nov 10, 2017 at 01:15:09AM +0100, Stefan Br=FCns wrote:
> > On Friday, November 10, 2017 12:30:46 AM CET Bastien Nocera wrote:
> > > On Thu, 2017-11-09 at 23:44 +0100, Stefan Br=FCns wrote:
> > > > The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but
> > > > not
> > > > on BIOS A2).
> > > >=20
> > > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > > > ---
> > > >=20
> > > > Changes in v2:
> > > > - Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
> > > > - Use separate up/down events
> > > >=20
> > > >  drivers/platform/x86/intel-vbtn.c | 2 ++
> > > >  1 file changed, 2 insertions(+)
> > > >=20
> > > > diff --git a/drivers/platform/x86/intel-vbtn.c
> > > > b/drivers/platform/x86/intel-vbtn.c index e3f6375af85c..a484bcc6393b
> > > > 100644
> > > > --- a/drivers/platform/x86/intel-vbtn.c
> > > > +++ b/drivers/platform/x86/intel-vbtn.c
> > > > @@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[]=
 =3D
> > > > {
> > > >=20
> > > >  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release=
=20
*/
> > > >  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press=20
*/
> > > >  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key=20
release
> >=20
> > */
> >=20
> > > > +	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock k=
ey
> > > > press */ +	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/*
> > > > rotate-lock key release */
> > >=20
> > > How are those events sent? When pressing and releasing the key, do you
> > > receive 0xC8 followed by 0xC9? Or do you receive 0xC8 when pressing a=
nd
> > > releasing the first time, and 0xC9 when pressing and releasing a seco=
nd
> > > time?
> > >=20
> > > If the former, then it's not going to work. The release is supposed to
> > > be ignored, as you send the event with sparse_keymap_report_event().
> > >=20
> > > If the latter, and there's an actual state, does it disable a device
> > > on-board, or activate an LED? If so, then it would need to be a switc=
h,
> > > not a key.
> >=20
> > Do you think I don't test the patches before sending? Let me tell you, =
it
> > *does* work.
> >=20
> > You could also read the cover letter, where you find more details, putt=
ing
> > the patches in relation to each other.
>=20
> A point of process. If there is context that is needed to explain the
> patch, it belongs in the patch, not just in the cover letter. The cover
> letter is effectively lost once the patches are merged.
>=20
> > Just in case its not yet clear:
> > The codes are emitted when pressing a button. It is a button, not a
> > switch.
> > There is no state handled in hardware. On press (as noted by the code
> > comment), event code 0xc8 is emitted. On release, event code 0xc9 is
> > emitted.
> This sounds like the "former" scenario Bastien described, for which I
> understand the use case to be:
>=20
> User presses and releases the rotate lock button to prevent the
> accelerometer for triggering screen rotation.
>=20
> User presses and releases the rotate lock button to allow the acceleromet=
er
> to trigger screen rotation.
>=20
> Is that correct?
>=20
> If so, why do we need to emit two KEY_ROTATE_LOCK_TOGGLE events each time
> instead of just the press event like the volume buttons?

Volume buttons *should* send separate press/release events, to allow softwa=
re=20
autorepeat.

=46or the rotate lock button, I see no reason *not* to report the actual st=
ate=20
instead of doing an autorelease.

Kind regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart6185159.Gd0MK2uq1p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgUM4wAKCRBvf0o9jP6q
UyDsAKC1+BXXl5ZHKId965xeicoAxlpMCACgoiSdeK5Dql9AsbOJ42Tq9XGdKCk=
=Rlf1
-----END PGP SIGNATURE-----

--nextPart6185159.Gd0MK2uq1p--
