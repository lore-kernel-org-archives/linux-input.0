From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: [PATCH v4 1/2] HID: Add Support for Setting and Getting Feature
 Reports from hidraw
Date: Sat, 2 Oct 2010 02:00:08 +0200
Message-ID: <20101002020008.4812d6a9.ospite@studenti.unina.it>
References: <1281442367.12579.206.camel@localhost.localdomain>
	<1281990059-3562-2-git-send-email-alan@signal11.us>
	<20100930015104.49fc5acf.ospite@studenti.unina.it>
	<4CA40605.6080800@signal11.us>
	<20101001000309.9bb53de4.ospite@studenti.unina.it>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Sat__2_Oct_2010_02_00_08_+0200_A8BhsaIdwduKJw_U"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp206.alice.it ([82.57.200.102]:46474 "EHLO smtp206.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752172Ab0JBAAT (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 1 Oct 2010 20:00:19 -0400
In-Reply-To: <20101001000309.9bb53de4.ospite@studenti.unina.it>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alan Ott <alan@signal11.us>
Cc: Jiri Kosina <jkosina@suse.cz>, linux-input@vger.kernel.org

--Signature=_Sat__2_Oct_2010_02_00_08_+0200_A8BhsaIdwduKJw_U
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 1 Oct 2010 00:03:09 +0200
Antonio Ospite <ospite@studenti.unina.it> wrote:


>=20
> Alan I am still talking about GET_FEATURE here, not SET, the question
> here is what value the first byte (buf[0]) is expected to have in a
> buffer returned from a GET. If it has to be the report ID then I
> suspect my device is changing it behind our backs, maybe a failsafe
> measure like the following could do?
>=20
> diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
> index df80532..83e1b48 100644
> --- a/drivers/hid/usbhid/hid-core.c
> +++ b/drivers/hid/usbhid/hid-core.c
> @@ -875,6 +875,9 @@ static int usbhid_output_raw_report(struct hid_device=
 *hid, __u8 *buf, size_t co

Actually I meant to change the code in usbhid_get_raw_report() instead,
like the following:

diff --git a/drivers/hid/usbhid/hid-core.c b/drivers/hid/usbhid/hid-core.c
index df80532..c6648d3 100644
--- a/drivers/hid/usbhid/hid-core.c
+++ b/drivers/hid/usbhid/hid-core.c
@@ -825,6 +825,11 @@ static int usbhid_get_raw_report(struct hid_device *hi=
d,
                interface->desc.bInterfaceNumber, buf, count,
                USB_CTRL_SET_TIMEOUT);

+       /* restore report number into buf[0],
+        * some non conformant device might be mangling it
+        */
+       buf[0] =3D report_number;
+
        /* count also the report id */
        if (ret > 0 && skipped_report_id)
                ret++;

But again, I haven't checked yet what the specs say about byte 0 in the
returned buffer.

Regards,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Signature=_Sat__2_Oct_2010_02_00_08_+0200_A8BhsaIdwduKJw_U
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAkymdggACgkQ5xr2akVTsAEp3gCeJ+szBGMp9JlpIn1zxT5FNGgJ
Xn4An1Nmd5m8nNcdmu5hjvIzF40Bu3CE
=CGtR
-----END PGP SIGNATURE-----

--Signature=_Sat__2_Oct_2010_02_00_08_+0200_A8BhsaIdwduKJw_U--
