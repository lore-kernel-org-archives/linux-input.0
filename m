From: =?ISO-8859-1?Q?=C9ric_Piel?= <E.A.B.Piel@tudelft.nl>
Subject: [PATCH 3/6] elantech: implement data check for 6-byte protocol
Date: Sat, 14 May 2011 08:47:20 +0200
Message-ID: <4DCE2578.9060308@tudelft.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mailservice.tudelft.nl ([130.161.131.5]:46424 "EHLO
	mailservice.tudelft.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755081Ab1ENLIM (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 14 May 2011 07:08:12 -0400
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, Henrik Rydberg <rydberg@euromail.se>, Chris Bagwell <chris@cnpbagwell.com>, Florian Ragwitz <rafl@debian.org>

Based on the protocol description, and the source code of the
Dell/Ubuntu driver, the two additional types of data checking for the
6-byte protocol are added. Technically, this is not parity checking, bu=
t
to avoid too much change, "paritycheck" is kept to talk about the check=
s.

In addition, as in the Dell/Ubuntu driver, instead of dropping all the
bytes when an error is detected, just drop the first byte, so that
it's possible to re-synchronize quickly.

Signed-off-by: =C9ric Piel <eric.piel@tremplin-utc.net>
---
 drivers/input/mouse/elantech.c |   61 ++++++++++++++++++++++++++++++++=
+++++--
 1 files changed, 57 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elant=
ech.c
index badb2ea..8f0a1ee 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -348,6 +348,57 @@ static int elantech_check_parity_v1(struct psmouse=
 *psmouse)
 	       etd->parity[packet[3]] =3D=3D p3;
 }
=20
+static int elantech_check_parity_ef113(struct psmouse *psmouse)
+{
+	unsigned char *packet =3D psmouse->packet;
+
+	/* Consistency checks as in the Dell/Ubuntu driver */
+	return !((((packet[0] & 0x3c) !=3D 0x3c) && ((packet[0] & 0xc0) !=3D =
0x80)) ||
+		 (((packet[0] & 0x0c) !=3D 0x0c) && ((packet[0] & 0xc0) =3D=3D 0x80)=
) ||
+		 (((packet[0] & 0xc0) !=3D 0x80) && ((packet[1] & 0xf0) !=3D 0x00)) =
||
+		 (((packet[3] & 0x3e) !=3D 0x38) && ((packet[0] & 0xc0) !=3D 0x80)) =
||
+		 (((packet[3] & 0x0e) !=3D 0x08) && ((packet[0] & 0xc0) =3D=3D 0x80)=
) ||
+		 (((packet[0] & 0xc0) !=3D 0x80) && ((packet[4] & 0xf0) !=3D 0x00)))=
;
+}
+
+static int elantech_check_parity_const(struct psmouse *psmouse)
+{
+	unsigned char *packet =3D psmouse->packet;
+
+	/* Some bits which are constant in the 6 packets */
+	return (((packet[0] & 0x0c) =3D=3D 0x04) && ((packet[3] & 0x0f) =3D=3D=
 0x02));
+}
+
+/*
+ * Returns 0 if an error is detected in the packets.
+ */
+static int elantech_check_parity(struct psmouse *psmouse)
+{
+	struct elantech_data *etd =3D psmouse->private;
+
+	switch (etd->paritycheck) {
+	case ETP_FULL_PC:
+		return elantech_check_parity_v1(psmouse);
+	case ETP_EF113_CHECK:
+		return elantech_check_parity_ef113(psmouse);
+	case ETP_CONST_CHECK:
+		return elantech_check_parity_const(psmouse);
+	case ETP_NOT_CHECK:
+	default:
+		return 1;
+	}
+}
+
+static void elantech_shift_packets(struct psmouse *psmouse)
+{
+	unsigned char *packet =3D psmouse->packet;
+	int i;
+
+	for (i =3D 0; i < (psmouse->pktsize - 1); i++)
+		packet[i] =3D packet[i + 1];
+	psmouse->pktcnt--;
+}
+
 /*
  * Process byte stream from mouse and handle complete packets
  */
@@ -361,16 +412,18 @@ static psmouse_ret_t elantech_process_byte(struct=
 psmouse *psmouse)
 	if (etd->debug > 1)
 		elantech_packet_dump(psmouse->packet, psmouse->pktsize);
=20
+	if (!elantech_check_parity(psmouse)) {
+		/* Try to re-synchronize */
+		elantech_shift_packets(psmouse);
+		return PSMOUSE_GOOD_DATA;
+	}
+
 	switch (etd->hw_version) {
 	case 1:
-		if (etd->paritycheck && !elantech_check_parity_v1(psmouse))
-			return PSMOUSE_BAD_DATA;
-
 		elantech_report_absolute_v1(psmouse);
 		break;
=20
 	case 2:
-		/* We don't know how to check parity in protocol v2 */
 		elantech_report_absolute_v2(psmouse);
 		break;
 	}
--=20
1.7.5.1

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
