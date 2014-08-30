From: Ulrik De Bie <ulrik.debie-os@e2big.org>
Subject: [PATCH 1/5] Input: elantech - use elantech_report_trackpoint for hardware v4 too
Date: Sat, 30 Aug 2014 16:10:42 +0200
Message-ID: <1409407846-15449-2-git-send-email-ulrik.debie-os@e2big.org>
References: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from e2big.org ([198.61.226.133]:47764 "EHLO e2big.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751620AbaH3OL2 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Sat, 30 Aug 2014 10:11:28 -0400
In-Reply-To: <1409407846-15449-1-git-send-email-ulrik.debie-os@e2big.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, David Herrmann <dh.herrmann@gmail.com>, ulrik.debie-os@e2big.org

The Fujitsu H730 has hardware v4 with a trackpoint. This enables
the elantech_report_trackpoint for v4.

Reported-by: Stefan Valouch <stefan@valouch.com>
Tested-by: Stefan Valouch <stefan@valouch.com>
Tested-by: Alfredo Gemma <alfredo.gemma@gmail.com>
Signed-off-by: Ulrik De Bie <ulrik.debie-os@e2big.org>
---
 drivers/input/mouse/elantech.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index da51738..f0a55b4d 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -792,6 +792,9 @@ static int elantech_packet_check_v4(struct psmouse *psmouse)
 	unsigned char packet_type = packet[3] & 0x03;
 	bool sanity_check;
 
+	if ((packet[3]&0x0f) == 0x06)
+		return PACKET_TRACKPOINT;
+
 	/*
 	 * Sanity check based on the constant bits of a packet.
 	 * The constant bits change depending on the value of
@@ -877,10 +880,19 @@ static psmouse_ret_t elantech_process_byte(struct psmouse *psmouse)
 
 	case 4:
 		packet_type = elantech_packet_check_v4(psmouse);
-		if (packet_type == PACKET_UNKNOWN)
+		switch (packet_type) {
+		case PACKET_UNKNOWN:
 			return PSMOUSE_BAD_DATA;
 
-		elantech_report_absolute_v4(psmouse, packet_type);
+		case PACKET_TRACKPOINT:
+			elantech_report_trackpoint(psmouse, packet_type);
+			break;
+
+		default:
+			elantech_report_absolute_v4(psmouse, packet_type);
+			break;
+		}
+
 		break;
 	}
 
-- 
2.1.0

