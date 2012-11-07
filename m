From: Forest Bond <forest@alittletooquiet.net>
Subject: Re: [PATCH] HID: Ignore D-WAV/eGalax devices handled by
 usbtouchscreen
Date: Wed, 7 Nov 2012 08:57:18 -0500
Message-ID: <20121107135718.GA4834@alittletooquiet.net>
References: <20121106184122.GT12501@alittletooquiet.net>
 <509A460C.8000401@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:42266 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750768Ab2KGOAm (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Wed, 7 Nov 2012 09:00:42 -0500
Content-Disposition: inline
In-Reply-To: <509A460C.8000401@mvista.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: Jiri Kosina <jkosina@suse.cz>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Daniel Ritz <daniel.ritz@gmx.ch>, Alan Stern <stern@rowland.harvard.edu>, linux-input@vger.kernel.org, linux-usb@vger.kernel.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Sergei,

On Wed, Nov 07, 2012 at 03:29:16PM +0400, Sergei Shtylyov wrote:
> Hello.
>=20
> On 06-11-2012 22:41, Forest Bond wrote:
>=20
> >From: Forest Bond <forest.bond@rapidrollout.com>
>=20
> >Previously, both usbhid and usbtouchscreen would bind to D-WAV devices
> >with class HID and protocol None, so they would be claimed by whichever
> >driver was loaded first.  Some of these devices do in fact work with
> >usbhid, but not all of them do.  OTOH they all work with usbtouchscreen
> >as of commit 037a833ed05a86d01ea27a2c32043b86c549be1b ("Input:
> >usbtouchscreen - initialize eGalax devices").  So we ignore them in
> >usbhid to prevent getting in the way of usbtouchscreen and claiming an
> >interface that we may not be able to do anything useful with.
>=20
> >Signed-off-by: Forest Bond <forest.bond@rapidrollout.com>
> >---
> >  drivers/hid/hid-core.c |   11 ++++++++++-
> >  drivers/hid/hid-ids.h  |    1 +
> >  2 files changed, 11 insertions(+), 1 deletions(-)
>=20
> >diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> >index f4109fd..f2d614e 100644
> >--- a/drivers/hid/hid-core.c
> >+++ b/drivers/hid/hid-core.c
> >@@ -2188,7 +2188,16 @@ static bool hid_ignore(struct hid_device *hdev)
> >  		if (hdev->product =3D=3D USB_DEVICE_ID_JESS_YUREX &&
> >  				hdev->type =3D=3D HID_TYPE_USBNONE)
> >  			return true;
> >-	break;
> >+		break;
> >+	case USB_VENDOR_ID_DWAV:
> >+		/* These are handled by usbtouchscreen. hdev->type is probably
> >+		 * HID_TYPE_USBNONE, but we say !HID_TYPE_USBMOUSE to match
> >+		 * usbtouchscreen. */
>=20
>    Note that the preferred style of multi-line comments is this,
> according to CodingStyle:
>=20
> /*
>  * bla
>  * bla
>  */
>=20
> WBR, Sergei

Thanks for the feedback.  I had scanned the file and saw both styles.  It w=
ould
be nice if checkpatch.pl issued a warning for this.

Jiri, would you like me to resend?

Thanks,
Forest
--=20
Forest Bond
http://www.alittletooquiet.net
http://www.rapidrollout.com

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAlCaaL4ACgkQRO4fQQdv5Ay/1wCeI7r0eGj0nk+T1g20iLpNyljF
D/QAoIFejxzHT2SfxIXKbSW3ifdQLGPR
=Wabr
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
