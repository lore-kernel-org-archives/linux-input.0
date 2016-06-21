From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 4/5] input/alps: Set DualPoint flag for 74 03 28 devices
Date: Tue, 21 Jun 2016 11:19:32 +0200
Message-ID: <1466500773-3470-5-git-send-email-ben@smart-cactus.org>
References: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56541 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751059AbcFUJUa (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Tue, 21 Jun 2016 05:20:30 -0400
In-Reply-To: <1466500773-3470-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Ben Gamari <ben@smart-cactus.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>

Here we introduce logic in alps_identify to set the ALPS_DUALPOINT flag
for touchpad hardware responding to E7 report with 73 03 28, as is found
in the Dell Latitude E7470.
---
 drivers/input/mouse/alps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 25d2cad..308f289 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2745,6 +2745,9 @@ static int alps_set_protocol(struct psmouse *psmouse,
 		if (alps_set_defaults_ss4_v2(psmouse, priv))
 			return -EIO;
 
+		if (priv->fw_ver[1] == 0x1)
+			priv->flags |= ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE;
+
 		break;
 	}
 
@@ -2817,6 +2820,9 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
 			   e7[2] == 0x14 && ec[1] == 0x02) {
 			protocol = &alps_v8_protocol_data;
+		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
+			   e7[2] == 0x28 && ec[1] == 0x01) {
+			protocol = &alps_v8_protocol_data;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
-- 
2.8.1

