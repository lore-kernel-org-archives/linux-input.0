From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature
     Reports from hidraw
Date: Sat, 2 Oct 2010 09:50:09 +0200
Message-ID: <20101002095009.ce1df06d.ospite@studenti.unina.it>
References: <1281442367.12579.206.camel@localhost.localdomain>
	<1281990059-3562-2-git-send-email-alan@signal11.us>
	<20100930015104.49fc5acf.ospite@studenti.unina.it>
	<4CA40605.6080800@signal11.us>
	<20101001000309.9bb53de4.ospite@studenti.unina.it>
	<4CA67D2C.6060505@signal11.us>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__2_Oct_2010_09_50_10_+0200_mVJvIi7WU0TVf/la"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp207.alice.it ([82.57.200.103]:46400 "EHLO smtp207.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751207Ab0JBHuW (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 03:50:22 -0400
In-Reply-To: <4CA67D2C.6060505@signal11.us>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

--Signature=_Sat__2_Oct_2010_09_50_10_+0200_mVJvIi7WU0TVf/la
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 01 Oct 2010 20:30:36 -0400
Alan Ott <alan@signal11.us> wrote:

> > diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-cor=
e.c
> > index df80532..83e1b48 100644
> > --- a/drivers/hid/usbhid/hid-core.c
> > +++ b/drivers/hid/usbhid/hid-core.c
> > @@ -875,6 +875,9 @@ static int usbhid_output_raw_report(struct hid_devi=
ce *hid, __u8 *buf, size_t co
> >                          ((report_type + 1)<<  8) | report_id,
> >                          interface->desc.bInterfaceNumber, buf, count,
> >                          USB_CTRL_SET_TIMEOUT);
> > +               /* restore report ID into the buffer, some non conforma=
nt usb
> > +                * device could have mangled it */
> > +               buf[0] =3D report_id;
> >                  /* count also the report id, if this was a numbered re=
port. */
> >                  if (ret>  0&&  skipped_report_id)
> >                          ret++;
> >
> >
> > But I haven't even taken a look at the HID spec about this, so take it
> > just for the sake of discussion. Anyone could run some tests with other
> > devices?
> >   =20
>=20
> I actually don't like it (I did see your later email about how you=20
> really meant for it to be in usbhid_get_raw_report(), so consider this=20
> my response to that). I don't like it because hidraw is supposed to be=20
> raw. If the device sends back bogus stuff, then bogus stuff should be=20
> passed back to userspace. Likewise, if the host tries to send bogus=20
> stuff to the device, then it should be able to (or be able to try). The=20
> problem with enforcing rules here is determining which rules to enforce.=
=20
> For example, with hiddev, you can't get or set reports that aren't in=20
> the HID descriptor. That keeps you from being able to get report 0xf5=20
> which is required to use the sixaxis device. I think this goes against=20
> the idea of "raw," and could even mislead the user to think that a=20
> device is functioning properly (or has been implemented properly) when=20
> it is not.
>

Ok, I see your point and you convinced me, let it be "raw" then.
If you are going through another iteration of the documentation patch
maybe you can mention that buf[0] in the returned descriptor can be
pretty much everything when dealing with deviated devices.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__2_Oct_2010_09_50_10_+0200_mVJvIi7WU0TVf/la
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkym5DIACgkQ5xr2akVTsAFRngCfclhnvA+hvrGT2261+4EmwXOf
uHgAn0Vr0Pzqt+BzGuL37RZCcXBv8hj4
=fD71
-----END PGP SIGNATURE-----

--Signature=_Sat__2_Oct_2010_09_50_10_+0200_mVJvIi7WU0TVf/la--
