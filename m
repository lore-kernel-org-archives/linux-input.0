From: Matteo Delfino <kendatsuba@gmail.com>
Subject: [PATCH RESEND] elantech: fix for newer hardware versions (v7)
Date: Sat, 06 Jul 2013 09:27:34 +0200
Message-ID: <51D7C6E6.8010904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ea0-f182.google.com ([209.85.215.182]:33215 "EHLO
	mail-ea0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747Ab3GFH1h (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Sat, 6 Jul 2013 03:27:37 -0400
Received: by mail-ea0-f182.google.com with SMTP id d10so1872438eaj.13
        for <linux-input@vger.kernel.org>; Sat, 06 Jul 2013 00:27:36 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>, Alessandro Rubini <rubini@ipvvis.unipv.it>

* Fix version recognition in elantech_set_properties

  The new hardware reports itself as v7 but the packets'
  structure is unaltered.

* Fix packet type recognition in elantech_packet_check_v4

  The bitmask used for v6 is too wide, only the last three bits of
  the third byte in a packet (packet[3] & 0x03) are actually used to
  distinguish between packet types.
  Starting from v7, additional information (to be interpreted) is
  stored in the remaining bits (packets[3] & 0x1c).
  In addition, the value stored in (packet[0] & 0x0c) is no longer
  a constant but contains additional information yet to be deciphered.
  This change should be backwards compatible with v6 hardware.

Additional-author: Giovanni Frigione <gio.frigione@gmail.com>
Signed-off-by: Matteo Delfino <kendatsuba@gmail.com>
---
 drivers/input/mouse/elantech.c |   17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index e2a9867..1c792c9 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -677,18 +677,18 @@ static int elantech_packet_check_v3(struct psmouse *psmouse)
 static int elantech_packet_check_v4(struct psmouse *psmouse)
 {
 	unsigned char *packet = psmouse->packet;
+	unsigned char packet_type = packet[3] & 0x03;

-	if ((packet[0] & 0x0c) == 0x04 &&
-	    (packet[3] & 0x1f) == 0x11)
+	switch (packet_type) {
+	case 0:
+		return PACKET_V4_STATUS;
+
+	case 1:
 		return PACKET_V4_HEAD;

-	if ((packet[0] & 0x0c) == 0x04 &&
-	    (packet[3] & 0x1f) == 0x12)
+	case 2:
 		return PACKET_V4_MOTION;
-
-	if ((packet[0] & 0x0c) == 0x04 &&
-	    (packet[3] & 0x1f) == 0x10)
-		return PACKET_V4_STATUS;
+	}

 	return PACKET_UNKNOWN;
 }
@@ -1226,6 +1226,7 @@ static int elantech_set_properties(struct elantech_data *etd)
 			etd->hw_version = 3;
 			break;
 		case 6:
+		case 7:
 			etd->hw_version = 4;
 			break;
 		default:
-- 
1.7.10.4
