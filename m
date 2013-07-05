From: Matteo Delfino <kendatsuba@gmail.com>
Subject: [PATCH] elantech: fix for newer hardware versions (v7)
Date: Sat, 06 Jul 2013 00:18:32 +0200
Message-ID: <51D74638.1020305@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail-ee0-f51.google.com ([74.125.83.51]:54876 "EHLO
	mail-ee0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751286Ab3GEWSg (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Fri, 5 Jul 2013 18:18:36 -0400
Received: by mail-ee0-f51.google.com with SMTP id e52so1654372eek.10
        for <linux-input@vger.kernel.org>; Fri, 05 Jul 2013 15:18:35 -0700 (PDT)
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org
Cc: Alessandro Rubini <rubini@ipvvis.unipv.it>, Dmitry Torokhov <dmitry.torokhov@gmail.com>

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
 drivers/input/mouse/elantech.c |   11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index e2a9867..4d54773 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -677,17 +677,15 @@ static int elantech_packet_check_v3(struct psmouse
*psmouse)
 static int elantech_packet_check_v4(struct psmouse *psmouse)
 {
 	unsigned char *packet = psmouse->packet;
+	unsigned char packet_type = packet[3] & 0x03;

-	if ((packet[0] & 0x0c) == 0x04 &&
-	    (packet[3] & 0x1f) == 0x11)
+	if (packet_type == 0x01)
 		return PACKET_V4_HEAD;

-	if ((packet[0] & 0x0c) == 0x04 &&
-	    (packet[3] & 0x1f) == 0x12)
+	if (packet_type == 0x02)
 		return PACKET_V4_MOTION;

-	if ((packet[0] & 0x0c) == 0x04 &&
-	    (packet[3] & 0x1f) == 0x10)
+	if (packet_type == 0x00)
 		return PACKET_V4_STATUS;

 	return PACKET_UNKNOWN;
@@ -1226,6 +1224,7 @@ static int elantech_set_properties(struct
elantech_data *etd)
 			etd->hw_version = 3;
 			break;
 		case 6:
+		case 7:
 			etd->hw_version = 4;
 			break;
 		default:
-- 
1.7.10.4
