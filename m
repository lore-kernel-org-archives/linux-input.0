From: Pali =?utf-8?q?Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: Re: input question: ambient light sensor button
Date: Fri, 22 Nov 2013 12:13:49 +0100
Message-ID: <201311221213.49580@pali>
References: <201309151553.34000@pali> <201311201550.05800@pali> <CAN+gG=HwuES-H4y5=_VcEQg4OiE2NYmra2+MzsbPusiOEq7Qsw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart4428584.doDzpflCvy";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-bk0-f48.google.com ([209.85.214.48]:61434 "EHLO
	mail-bk0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3KVLNx (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Fri, 22 Nov 2013 06:13:53 -0500
In-Reply-To: <CAN+gG=HwuES-H4y5=_VcEQg4OiE2NYmra2+MzsbPusiOEq7Qsw@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Benjamin Tissoires <benjamin.tissoires@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Jiri Kosina <jkosina@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, linux-input <linux-input@vger.kernel.org>

--nextPart4428584.doDzpflCvy
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wednesday 20 November 2013 16:59:42 Benjamin Tissoires wrote:
> Hi,
>=20
> On Wed, Nov 20, 2013 at 9:50 AM, Pali Roh=C3=A1r <pali.rohar@gmail.com> w=
rote:
> >> > > I guess we need patch adding
> >> > >=20
> >> > >   #define KEY_ALS_TOGGLE  0x230
> >> > >=20
> >> > > Thanks.
> >> >=20
> >> > So there is no good key for als yet?
> >>=20
> >> No, but if you send me a patch adding it I will gladly
> >> apply it.
> >>=20
> >> Thanks.
> >=20
> > Ok, here is patch:
> >=20
> > Add key code for ambient light sensor button
> >=20
> > More notebooks have special button for enabling/disabling
> > ambient light sensor. This patch adding new als code to
> > input.h header file.
> >=20
> > Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
> >=20
> > diff --git a/include/uapi/linux/input.h
> > b/include/uapi/linux/input.h index a372627..1562f10 100644
> > --- a/include/uapi/linux/input.h
> > +++ b/include/uapi/linux/input.h
> > @@ -719,6 +719,8 @@ struct input_keymap_entry {
> >=20
> >  #define BTN_DPAD_LEFT          0x222
> >  #define BTN_DPAD_RIGHT         0x223
> >=20
> > +#define KEY_ALS_TOGGLE         0x230
>=20
> Could you just add a comment explaining that ALS is ambiant
> light sensor? Otherwise, I'm sure someone else will use this
> event code for an other thing... :)
>=20
> Cheers,
> Benjamin

Ok, here is new diff with comment:

diff --git a/include/uapi/linux/input.h b/include/uapi/linux/input.h
index a372627..7bacdb5 100644
=2D-- a/include/uapi/linux/input.h
+++ b/include/uapi/linux/input.h
@@ -719,6 +719,8 @@ struct input_keymap_entry {
 #define BTN_DPAD_LEFT		0x222
 #define BTN_DPAD_RIGHT		0x223
=20
+#define KEY_ALS_TOGGLE		0x230	/* Ambient light sensor */
+
 #define BTN_TRIGGER_HAPPY		0x2c0
 #define BTN_TRIGGER_HAPPY1		0x2c0
 #define BTN_TRIGGER_HAPPY2		0x2c1


=2D-=20
Pali Roh=C3=A1r
pali.rohar@gmail.com

--nextPart4428584.doDzpflCvy
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEABECAAYFAlKPPG0ACgkQi/DJPQPkQ1JLmACdH4q7tq0z6veB4E5kgXskuKb0
gjsAoKvVExlIePcdRJ6UhpdRp9DgcGMz
=mfe3
-----END PGP SIGNATURE-----

--nextPart4428584.doDzpflCvy--
