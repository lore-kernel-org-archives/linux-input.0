From: Matteo Delfino <kendatsuba@gmail.com>
Subject: [PATCH] Input: elantech - fix packet check for v3 and v4 hardware
Date: Wed, 14 Aug 2013 11:37:17 +0200
Message-ID: <1376473037-11211-1-git-send-email-kendatsuba@gmail.com>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53589 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751399Ab3HNJhd (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Wed, 14 Aug 2013 05:37:33 -0400
Received: by mail-wg0-f47.google.com with SMTP id j13so7493361wgh.14
        for <linux-input@vger.kernel.org>; Wed, 14 Aug 2013 02:37:31 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org

The signatures of v3 and v4 packets change depending on the value of a
hardware flag called 'crc_enabled'. The packet type detection must change
accordingly.

This patch also restores a consistency check for v4 packets inadvertently
removed by commit:

9eebed7de660c0b5ab129a9de4f89d20b60de68c
Input: elantech - fix for newer hardware versions (v7)

A note about the naming convention: v3 hardware is associated with IC body
v5 while v4 hardware is associated with IC body v6 and v7. The above commit
refers to IC body v7, not to v7 hardware.

Tested on Samsung NP730U3E (fw = 0x675f05, ICv7, crc_enabled = 1)

Tested-by: Giovanni Frigione <gio.frigione@gmail.com>
Signed-off-by: Matteo Delfino <kendatsuba@gmail.com>
---

Hello Dmitry,
this patch is based on some information provided by elantech. It has
been successfully tested on the above v4 hardware so the information
seems to be reliable. More testing is needed on v3 hardware with
crc_enabled=1 (if there's such hardware out there..). The behaviour
should be unchanged for v3 and v4 hardware with crc_enabled=0 (the
vast majority).

I was asked to CC stable kernels too since this patch restores a
consistency check on v4 packets removed by a previous commit already
queued in linux-3.5.y-queue but, considering the above, I think it's
best to leave this decision to you.

Best regards,
Matteo

 drivers/input/mouse/elantech.c |   44 ++++++++++++++++++++++++++++++++++++----
 drivers/input/mouse/elantech.h |    1 +
 2 files changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index 57b2637..8551dca 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -672,6 +672,7 @@ static int elantech_packet_check_v2(struct psmouse *psmouse)
  */
 static int elantech_packet_check_v3(struct psmouse *psmouse)
 {
+	struct elantech_data *etd = psmouse->private;
 	const u8 debounce_packet[] = { 0xc4, 0xff, 0xff, 0x02, 0xff, 0xff };
 	unsigned char *packet = psmouse->packet;
 
@@ -682,19 +683,48 @@ static int elantech_packet_check_v3(struct psmouse *psmouse)
 	if (!memcmp(packet, debounce_packet, sizeof(debounce_packet)))
 		return PACKET_DEBOUNCE;
 
-	if ((packet[0] & 0x0c) == 0x04 && (packet[3] & 0xcf) == 0x02)
-		return PACKET_V3_HEAD;
+	/*
+	 * If the hardware flag 'crc_enabled' is set the packets have
+	 * different signatures.
+	 */
+	if (etd->crc_enabled) {
+		if ((packet[3] & 0x09) == 0x08)
+			return PACKET_V3_HEAD;
+
+		if ((packet[3] & 0x09) == 0x09)
+			return PACKET_V3_TAIL;
+	} else {
+		if ((packet[0] & 0x0c) == 0x04 && (packet[3] & 0xcf) == 0x02)
+			return PACKET_V3_HEAD;
 
-	if ((packet[0] & 0x0c) == 0x0c && (packet[3] & 0xce) == 0x0c)
-		return PACKET_V3_TAIL;
+		if ((packet[0] & 0x0c) == 0x0c && (packet[3] & 0xce) == 0x0c)
+			return PACKET_V3_TAIL;
+	}
 
 	return PACKET_UNKNOWN;
 }
 
 static int elantech_packet_check_v4(struct psmouse *psmouse)
 {
+	struct elantech_data *etd = psmouse->private;
 	unsigned char *packet = psmouse->packet;
 	unsigned char packet_type = packet[3] & 0x03;
+	bool sanity_check;
+
+	/*
+	 * Sanity check based on the constant bits of a packet.
+	 * The constant bits change depending on the value of
+	 * the hardware flag 'crc_enabled' but are the same for
+	 * every packet, regardless of the type.
+	 */
+	if (etd->crc_enabled)
+		sanity_check = ((packet[3] & 0x08) == 0x00);
+	else
+		sanity_check = ((packet[0] & 0x0c) == 0x04 &&
+				(packet[3] & 0x1c) == 0x10);
+
+	if (!sanity_check)
+		return PACKET_UNKNOWN;
 
 	switch (packet_type) {
 	case 0:
@@ -1313,6 +1343,12 @@ static int elantech_set_properties(struct elantech_data *etd)
 			etd->reports_pressure = true;
 	}
 
+	/*
+	 * The signatures of v3 and v4 packets change depending on the
+	 * value of this hardware flag.
+	 */
+	etd->crc_enabled = ((etd->fw_version & 0x4000) == 0x4000);
+
 	return 0;
 }
 
diff --git a/drivers/input/mouse/elantech.h b/drivers/input/mouse/elantech.h
index 46db3be..036a04a 100644
--- a/drivers/input/mouse/elantech.h
+++ b/drivers/input/mouse/elantech.h
@@ -129,6 +129,7 @@ struct elantech_data {
 	bool paritycheck;
 	bool jumpy_cursor;
 	bool reports_pressure;
+	bool crc_enabled;
 	unsigned char hw_version;
 	unsigned int fw_version;
 	unsigned int single_finger_reports;
-- 
1.7.10.4

