From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>
Subject: [PATCH v3 3/4] input: alps: For protocol V3, do not process data when last packet's bit7 is set
Date: Sun,  2 Nov 2014 00:25:09 +0100
Message-ID: <1414884310-19842-4-git-send-email-pali.rohar@gmail.com>
References: <1412329392-5580-1-git-send-email-pali.rohar@gmail.com>
 <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f42.google.com ([74.125.82.42]:57786 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbaKAX0G (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 1 Nov 2014 19:26:06 -0400
In-Reply-To: <1414884310-19842-1-git-send-email-pali.rohar@gmail.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Hans de Goede <hdegoede@redhat.com>, Yunkang Tang <yunkang.tang@cn.alps.com>, Tommy Will <tommywill2011@gmail.com>
Cc: linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>

Sometimes on Dell Latitude laptops psmouse/alps driver receive invalid =
ALPS
protocol V3 packets with bit7 set in last byte. More often it can be re=
produced
on Dell Latitude E6440 or E7440 with closed lid and pushing cover above=
 touchpad.

If bit7 in last packet byte is set then it is not valid ALPS packet. I =
was told
that ALPS devices never send these packets. It is not know yet who send=
 those
packets, it could be Dell EC, bug in BIOS and also bug in touchpad firm=
ware...

With this patch alps driver does not process those invalid packets and =
drops it
with PSMOUSE_FULL_PACKET so psmouse driver does not enter to out of syn=
c state.

This patch fix problem when psmouse driver still resetting ALPS device =
when
laptop lid is closed because of receiving invalid packets in out of syn=
c state.

Signed-off-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Tested-by: Pali Roh=C3=A1r <pali.rohar@gmail.com>
Cc: stable@vger.kernel.org
---
 drivers/input/mouse/alps.c |   10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 7c47e97..e802d28 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -1181,6 +1181,16 @@ static psmouse_ret_t alps_process_byte(struct ps=
mouse *psmouse)
 		return PSMOUSE_BAD_DATA;
 	}
=20
+	if (priv->proto_version =3D=3D ALPS_PROTO_V3 && psmouse->pktcnt =3D=3D=
 psmouse->pktsize) {
+		// For protocol V3, do not process data when last packet's bit7 is s=
et
+		if (psmouse->packet[psmouse->pktcnt - 1] & 0x80) {
+			psmouse_dbg(psmouse, "v3 discard packet[%i] =3D %x\n",
+				    psmouse->pktcnt - 1,
+				    psmouse->packet[psmouse->pktcnt - 1]);
+			return PSMOUSE_FULL_PACKET;
+		}
+	}
+
 	/* Bytes 2 - pktsize should have 0 in the highest bit */
 	if ((priv->proto_version < ALPS_PROTO_V5) &&
 	    psmouse->pktcnt >=3D 2 && psmouse->pktcnt <=3D psmouse->pktsize &=
&
--=20
1.7.9.5

--
To unsubscribe from this list: send the line "unsubscribe linux-input" =
in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
