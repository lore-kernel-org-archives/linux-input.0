From: Stefan =?ISO-8859-1?Q?Br=FCns?= <stefan.bruens@rwth-aachen.de>
Subject: Re: [PATCH v2 4/5] platform/x86: intel-vbtn: support KEY_ROTATE_LOCK_TOGGLE
Date: Fri, 10 Nov 2017 01:15:09 +0100
Message-ID: <6070680.Ajd9sKXNqZ@pebbles>
References: <20171109224436.16472-1-stefan.bruens@rwth-aachen.de> <1a034599-ff6c-4a42-8252-4f6007894f4a@rwthex-w2-a.rwth-ad.de> <1510270246.2624.43.camel@hadess.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2213328.B2MEAP0t9l";
        micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-out-1.itc.rwth-aachen.de ([134.130.5.46]:45704 "EHLO
        mail-out-1.itc.rwth-aachen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754122AbdKJAQG (ORCPT
        <rfc822;linux-input@vger.kernel.org>);
        Thu, 9 Nov 2017 19:16:06 -0500
In-Reply-To: <1510270246.2624.43.camel@hadess.net>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Bastien Nocera <hadess@hadess.net>
Cc: platform-driver-x86@vger.kernel.org, linux-input@vger.kernel.org, AceLan Kao <acelan.kao@canonical.com>, Andy Shevchenko <andy@infradead.org>, Darren Hart <dvhart@infradead.org>, linux-kernel@vger.kernel.org

--nextPart2213328.B2MEAP0t9l
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

On Friday, November 10, 2017 12:30:46 AM CET Bastien Nocera wrote:
> On Thu, 2017-11-09 at 23:44 +0100, Stefan Br=FCns wrote:
> > The Rotate Lock button event is emitted on the XPS 12 (BIOS A8, but
> > not
> > on BIOS A2).
> >=20
> > Signed-off-by: Stefan Br=FCns <stefan.bruens@rwth-aachen.de>
> > ---
> >=20
> > Changes in v2:
> > - Emit KEY_ROTATE_LOCK_TOGGLE instead of KEY_ROTATE_DISPLAY
> > - Use separate up/down events
> >=20
> >  drivers/platform/x86/intel-vbtn.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >=20
> > diff --git a/drivers/platform/x86/intel-vbtn.c
> > b/drivers/platform/x86/intel-vbtn.c index e3f6375af85c..a484bcc6393b
> > 100644
> > --- a/drivers/platform/x86/intel-vbtn.c
> > +++ b/drivers/platform/x86/intel-vbtn.c
> > @@ -42,6 +42,8 @@ static const struct key_entry intel_vbtn_keymap[] =3D=
 {
> >=20
> >  	{ KE_IGNORE, 0xC5, { KEY_VOLUMEUP } },		/* volume-up key release */
> >  	{ KE_KEY, 0xC6, { KEY_VOLUMEDOWN } },		/* volume-down key press */
> >  	{ KE_IGNORE, 0xC7, { KEY_VOLUMEDOWN } },	/* volume-down key release=20
*/
> >=20
> > +	{ KE_KEY,    0xC8, { KEY_ROTATE_LOCK_TOGGLE } },	/* rotate-lock key
> > press */ +	{ KE_KEY,    0xC9, { KEY_ROTATE_LOCK_TOGGLE } },	/*
> > rotate-lock key release */
> How are those events sent? When pressing and releasing the key, do you
> receive 0xC8 followed by 0xC9? Or do you receive 0xC8 when pressing and
> releasing the first time, and 0xC9 when pressing and releasing a second
> time?
>=20
> If the former, then it's not going to work. The release is supposed to
> be ignored, as you send the event with sparse_keymap_report_event().
>=20
> If the latter, and there's an actual state, does it disable a device
> on-board, or activate an LED? If so, then it would need to be a switch,
> not a key.

Do you think I don't test the patches before sending? Let me tell you, it=20
*does* work.

You could also read the cover letter, where you find more details, putting =
the=20
patches in relation to each other.

Just in case its not yet clear:
The codes are emitted when pressing a button. It is a button, not a switch.=
=20
There is no state handled in hardware. On press (as noted by the code=20
comment), event code 0xc8 is emitted. On release, event code 0xc9 is emitte=
d.

Regards,

Stefan
=2D-=20
Stefan Br=FCns  /  Bergstra=DFe 21  /  52062 Aachen
home: +49 241 53809034     mobile: +49 151 50412019
--nextPart2213328.B2MEAP0t9l
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSwWRWIpJbl0W4DemNvf0o9jP6qUwUCWgTvjQAKCRBvf0o9jP6q
U7r6AJ9hiJWEwyFHYEBfvsyPxnUuRLJKAQCgp2dyb6epZGQuTUtaOg4kQnuoYiU=
=exfs
-----END PGP SIGNATURE-----

--nextPart2213328.B2MEAP0t9l--
