From: Antonio Ospite <ospite@studenti.unina.it>
Subject: Re: Sony DualShock3 - Detected but no events
Date: Mon, 14 Nov 2011 13:08:02 +0100
Message-ID: <20111114130802.baca1cf201cac865f167eb06@studenti.unina.it>
References: <CAOazyz0GNJKFWNsaFiwheMjhBVJrcP-p8QBcsSvS3V97iuZFtQ@mail.gmail.com>
	<20111101011854.5e0e87b561f6b18dcc09a988@studenti.unina.it>
	<CAOazyz1EfHdg4gExfeVaQ_8mMV=1Tu-aYBTEo_j4MjLnNC4kHA@mail.gmail.com>
	<20111101090645.0d3abeac5909f87dae8bec58@studenti.unina.it>
	<CAOazyz0pBZE_qE3NYbz6n54kCA30dU2Z3PaT3_ufZv2egpj=cg@mail.gmail.com>
	<20111101124258.744fdba3f854ce81b4e0c8be@studenti.unina.it>
	<CAOazyz1N4QmrC4MN6M532_3m_gVC+7PBBOUU+Mu8Qq7_eX5iZA@mail.gmail.com>
	<20111101201142.af88469abf03d8a9779c4e46@studenti.unina.it>
	<CAOazyz03G1ofwh-GnLDECUqC1qgO0tXzSVjjdwML_JdXZR_9ug@mail.gmail.com>
	<CAOazyz1xOjJxXytp+1JzrDvd3o7f6uySu3fvpxOKz_VSEZwvEA@mail.gmail.com>
	<CAOazyz1NLwD5AA7CuLfwwy=gRyfE9o4zD9bvtsNVSQVjNUm4xA@mail.gmail.com>
	<CAOazyz1KrCqm=O-ftttVQEGLbC+R_4LV_tbNaFvw1y1wV+4UMg@mail.gmail.com>
	<CAOazyz13OeA7-mo130+JK8JMLy0AhLgeO5m8eM9t4yBQ8LPtcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Mon__14_Nov_2011_13_08_02_+0100_t3RL385eci.SsUlV"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from smtp209.alice.it ([82.57.200.105]:34949 "EHLO smtp209.alice.it"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751413Ab1KNMIH (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Mon, 14 Nov 2011 07:08:07 -0500
In-Reply-To: <CAOazyz13OeA7-mo130+JK8JMLy0AhLgeO5m8eM9t4yBQ8LPtcQ@mail.gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Alon Bar-Lev <alon.barlev@gmail.com>
Cc: linux-input@vger.kernel.org

--Signature=_Mon__14_Nov_2011_13_08_02_+0100_t3RL385eci.SsUlV
Content-Type: multipart/mixed;
 boundary="Multipart=_Mon__14_Nov_2011_13_08_02_+0100_tvCWCg2_sMlZ6koW"


--Multipart=_Mon__14_Nov_2011_13_08_02_+0100_tvCWCg2_sMlZ6koW
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 10 Nov 2011 00:16:54 +0200
Alon Bar-Lev <alon.barlev@gmail.com> wrote:

> Got real sony device.
> USB is working!
> Thanks for your help.

Ah, so it was a (not so much) compatible controller, wasn't it?

Can you test the attached patch to see it it makes the non-Sony device
work too? Some other user reported a compatible controller not sending
events, and it turned out that to be made operational it was expecting
the interrupt endpoint to be queried at least once. I don't see this
behavior in USB dumps of communication with PS3 tho.

> Is there anywhere organized I can fetch the bluez patches?
>=20

I will send them to you off-list.

Thanks,
   Antonio

--=20
Antonio Ospite
http://ao2.it

PGP public key ID: 0x4553B001

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?

--Multipart=_Mon__14_Nov_2011_13_08_02_+0100_tvCWCg2_sMlZ6koW
Content-Type: text/x-diff;
 name="__michele_compatible_controller_operational.patch"
Content-Disposition: attachment;
 filename="__michele_compatible_controller_operational.patch"
Content-Transfer-Encoding: quoted-printable

diff --git a/drivers/hid/hid-sony.c b/drivers/hid/hid-sony.c
index 5cd25bd..95355e0 100644
--- a/drivers/hid/hid-sony.c
+++ b/drivers/hid/hid-sony.c
@@ -131,6 +131,8 @@ static int sixaxis_set_operational_usb(struct hid_devic=
e *hdev)
 	__u16 ifnum =3D intf->cur_altsetting->desc.bInterfaceNumber;
 	int ret;
 	char *buf =3D kmalloc(18, GFP_KERNEL);
+	unsigned char buf2[] =3D { 0x00 };
+	int transfered;
=20
 	if (!buf)
 		return -ENOMEM;
@@ -142,7 +144,15 @@ static int sixaxis_set_operational_usb(struct hid_devi=
ce *hdev)
 				 (3 << 8) | 0xf2, ifnum, buf, 17,
 				 USB_CTRL_GET_TIMEOUT);
 	if (ret < 0)
-		hid_err(hdev, "can't set operational mode\n");
+		hid_err(hdev, "can't set operational mode on the Control EP\n");
+
+	/* Some compatible controllers like the Speedlink Strike FX need a
+	 * write tothe Interrupt EP to get opertional */
+	ret =3D usb_interrupt_msg(dev, usb_sndintpipe(dev, 0x02),
+	                         buf2, sizeof(buf2),
+				 &transfered, USB_CTRL_SET_TIMEOUT);
+	if (ret < 0)
+		dev_err(&hdev->dev, "can't set operational mode on the Interrupt EP\n");
=20
 	kfree(buf);
=20

--Multipart=_Mon__14_Nov_2011_13_08_02_+0100_tvCWCg2_sMlZ6koW--

--Signature=_Mon__14_Nov_2011_13_08_02_+0100_t3RL385eci.SsUlV
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAk7BBKIACgkQ5xr2akVTsAGywACffOBX91BEGcfmquKPg7KY357b
XCQAoLElePq5TESgP/8QuU1BOqYgGy08
=QK6z
-----END PGP SIGNATURE-----

--Signature=_Mon__14_Nov_2011_13_08_02_+0100_t3RL385eci.SsUlV--
