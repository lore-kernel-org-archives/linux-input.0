From: Forest Bond <forest@alittletooquiet.net>
Subject: [PATCH] hid: ignore digitizer usage Undefined (0x00)
Date: Thu, 27 May 2010 11:18:08 -0400
Message-ID: <20100527151808.GA484@alittletooquiet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Q68bSM7Ycu6FN28Q"
Return-path: <linux-input-owner@vger.kernel.org>
Received: from storm.alittletooquiet.net ([67.23.28.199]:41167 "EHLO
	storm.alittletooquiet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756311Ab0E0PZw (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Thu, 27 May 2010 11:25:52 -0400
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Bjorn Behrendt <bbehrendt@msjvermont.org>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

SMART Technologies has recommended this change to fix a problem reported
with SMART Board series interactive whiteboards.

A description of the device-specific symptom follows:

  When the board is connected my mouse bounces up to the top left corner.

Bjorn has tested this fix with model SB680.

Tested-by: Bjorn Behrendt <bbehrendt@msjvermont.org>
Signed-off-by: Forest Bond <forest@alittletooquiet.net>
---
 drivers/hid/hid-input.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 7a0d2e4..6b10e5a 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -301,6 +301,9 @@ static void hidinput_configure_usage(struct hid_input *=
hidinput, struct hid_fiel
=20
 	case HID_UP_DIGITIZER:
 		switch (usage->hid & 0xff) {
+		case 0x00: /* Undefined */
+			goto ignore;
+
 		case 0x30: /* TipPressure */
 			if (!test_bit(BTN_TOUCH, input->keybit)) {
 				device->quirks |=3D HID_QUIRK_NOTOUCH;
--=20
1.7.0.4

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFL/o0wRO4fQQdv5AwRAiKfAJ9H88Q3i3WdU49fYQNKjQVN+Q5gEQCgmTGE
0h5XB7yakJemCNi3tvlrz1o=
=CiLv
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
