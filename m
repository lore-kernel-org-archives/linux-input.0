From: Antonio Ospite <ospite@studenti.unina.it>
Subject: hidraw, sixaxis and output reports.
Date: Sat, 2 Oct 2010 17:59:58 +0200
Message-ID: <20101002175958.fbb1aca4.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__2_Oct_2010_17_59_58_+0200_zfsbwloUzTEd+TSA"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:33949 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754462Ab0JBQAJ (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 2 Oct 2010 12:00:09 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Alan Ott <alan@signal11.us>, Jiri Kosina <trivial@kernel.org>, Jim Paris <jim@jtan.com>, Ranulf Doswell <ralf@ranulf.net>, fMikko =?ISO-8859-1?Q?Virkkil=E4?= <mvirkkil@cc.hut.fi>, alktx@gmail.com

--Signature=_Sat__2_Oct_2010_17_59_58_+0200_zfsbwloUzTEd+TSA
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I am trying to set leds on sixaxis now, and the code I have works OK
with libusb, but the equivalent for hidraw does not.

The procedure to set leds is to send an output report 0x01 with the
correct data. After looking at drivers/usbhid/hid-core.c in
usbhid_output_raw_report() I see that output reports are sent over the
interrupt endpoint when hid->urbout is defined (that is when the device
has an interrupt out ep, right?), but it looks like this particular
device is accepting output reports only on the _control_ endpoint; this
is exactly what the working libusb version does btw.

Just for the record, this dumb hack makes setting leds work on sixaxis
with hidraw:

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index df80532..731c08c 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -841,7 +841,7 @@ static int usbhid_output_raw_report(struct hid_device *=
hid, __u8 *buf, size_t co
        struct usb_host_interface *interface =3D intf->cur_altsetting;
        int ret;

-       if (usbhid->urbout && report_type !=3D HID_FEATURE_REPORT) {
+       if (0 && usbhid->urbout && report_type !=3D HID_FEATURE_REPORT) {
                int actual_length;
                int skipped_report_id =3D 0;
                if (buf[0] =3D=3D 0x0) {

If you are interested in the userspace programs, just ping me.

What can I do to handle this properly? Add another quirk? Something
like HID_QUIRK_NO_INTERRUPT_OUT_EP or HID_QUIRK_FORCE_CONTROL_OUT_EP?

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__2_Oct_2010_17_59_58_+0200_zfsbwloUzTEd+TSA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkynVv4ACgkQ5xr2akVTsAFQFgCgo1zvCLOOLfj903FTJBNWK91K
kwkAoIbyLiXgwYlAkXVT+xU4iT+o1lQm
=4ntS
-----END PGP SIGNATURE-----

--Signature=_Sat__2_Oct_2010_17_59_58_+0200_zfsbwloUzTEd+TSA--
