From: Sam hung <sam.hung@emc.com.tw>
Subject: [PATCH] [ADD] 1.support new ic type for version 4.
Date: Tue,  6 Jan 2015 16:10:16 +0800
Message-ID: <1420531816-4744-1-git-send-email-sam.hung@emc.com.tw>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from emcscan.emc.com.tw ([192.72.220.5]:23437 "EHLO
	emcscan.emc.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753165AbbAFIUO (ORCPT
	<rfc822;linux-input@vger.kernel.org>); Tue, 6 Jan 2015 03:20:14 -0500
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: linux-input@vger.kernel.org, dmitry.torokhov@gmail.com
Cc: dusonlin@emc.com.tw, Sam hung <sam.hung@emc.com.tw>

---
 drivers/input/mouse/elantech.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/drivers/input/mouse/elantech.c b/drivers/input/mouse/elantech.c
index f2b9780..4891d07 100644
--- a/drivers/input/mouse/elantech.c
+++ b/drivers/input/mouse/elantech.c
@@ -700,14 +700,14 @@ static int elantech_packet_check_v1(struct psmouse *psmouse)
 
 static int elantech_debounce_check_v2(struct psmouse *psmouse)
 {
-        /*
-         * When we encounter packet that matches this exactly, it means the
-         * hardware is in debounce status. Just ignore the whole packet.
-         */
-        const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
-        unsigned char *packet = psmouse->packet;
-
-        return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
+	/*
+	* When we encounter packet that matches this exactly, it means the
+	* hardware is in debounce status. Just ignore the whole packet.
+	*/
+	const u8 debounce_packet[] = { 0x84, 0xff, 0xff, 0x02, 0xff, 0xff };
+	unsigned char *packet = psmouse->packet;
+
+	return !memcmp(packet, debounce_packet, sizeof(debounce_packet));
 }
 
 static int elantech_packet_check_v2(struct psmouse *psmouse)
@@ -1499,7 +1499,7 @@ static const struct dmi_system_id no_hw_res_dmi_table[] = {
 /*
  * determine hardware version and set some properties according to it.
  */
-static int elantech_set_properties(struct elantech_data *etd)
+static int elantech_set_properties(struct psmouse *psmouse, struct elantech_data *etd)
 {
 	/* This represents the version of IC body. */
 	int ver = (etd->fw_version & 0x0f0000) >> 16;
@@ -1520,9 +1520,12 @@ static int elantech_set_properties(struct elantech_data *etd)
 		case 7:
 		case 8:
 		case 9:
+		case 10:
+		case 13:
 			etd->hw_version = 4;
 			break;
 		default:
+			psmouse_err(psmouse, "failed to setting hw version.\n");
 			return -1;
 		}
 	}
@@ -1593,7 +1596,7 @@ int elantech_init(struct psmouse *psmouse)
 	}
 	etd->fw_version = (param[0] << 16) | (param[1] << 8) | param[2];
 
-	if (elantech_set_properties(etd)) {
+	if (elantech_set_properties(psmouse, etd)) {
 		psmouse_err(psmouse, "unknown hardware version, aborting...\n");
 		goto init_fail;
 	}
-- 
1.8.3.2

