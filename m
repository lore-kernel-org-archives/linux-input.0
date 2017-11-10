From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 4/5] platform/x86: intel-vbtn: support KEY_ROTATE_LOCK_TOGGLE
Date: Fri, 10 Nov 2017 01:23:13 +0100
Message-ID: <1643367.Hfkyk2hqTC@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <1510270246.2624.43.camel@hadess.net> <20171109234630.GG21449@fury>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart3725212.deMVUTyXRG";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20171109234630.GG21449@fury>
Sender: linux-kernel-owner@vger.kernel.org
To: Darren Hart <dvhart@infradead.org>
Cc: Bastien Nocera <hadess@hadess.net>, platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, linux-kernel@vger.kernel.org
List-Id: linux-input@vger.kernel.org

--nextPart3725212.deMVUTyXRG
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 12:46:30 AM CET Darren Hart wrote:
> On Fri, Nov 10, 2017 at 12:30:46AM +0100, Bastien Nocera wrote:
> > On Thu, 2017-11-09 at 23:44 +0100, Stefan Br=FCns wrote:
> > > The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but
> > > not
> > > on BIOS A2).
> > >=20
> > > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > > ---
> > >=20
> > > Changes in v2:
> > > - Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
> > > - Use separate up/down events
> > >=20
> > >  drivers/platform/x86/intel-vbtn.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > >=20
> > > diff --git a/drivers/platform/x86/intel-vbtn.c
> > > b/drivers/platform/x86/intel-vbtn.c index e3f6375af85c..a484bcc6393b
> > > 100644
> > > --- a/drivers/platform/x86/intel-vbtn.c
> > > +++ b/drivers/platform/x86/intel-vbtn.c
> > > @@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] =
=3D {
> > >=20
> > >  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release=20
*/
> > >  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
> > >  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release=
=20
*/
> > >=20
> > > +	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key
> > > press */ +	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/*
> > > rotate-lock key release */>=20
> > How are those events sent? When pressing and releasing the key, do you
> > receive 0xC8 followed by 0xC9? Or do you receive 0xC8 when pressing and
> > releasing the first time, and 0xC9 when pressing and releasing a second
> > time?
> >=20
> > If the former, then it's not going to work. The release is supposed to
> > be ignored, as you send the event with sparse_keymap_report_event().
>=20
> I expect the former, which is consistent with the volume keys preceding it
> (also ignoring the release).

Read the whole series and the cover letter, and stop making assumptions.

Regards,

Stefan

=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart3725212.deMVUTyXRG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgTxcQAKCRBvf0o9jP6q
U+JfAKCYdmQfBhXotE4KT543F9sLyHVnlQCePRyZj1i/OROiZuo2WfApub3vH1o=
=sxrM
-----END PGP SIGNATURE-----

--nextPart3725212.deMVUTyXRG--
