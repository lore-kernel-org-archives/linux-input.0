From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 4/4] input/alps: Set DualPoint flag for 74 03 28 devices
Date: Sat, 28 May 2016 14:01:02 +0200
Message-ID: <1464436862-2649-5-git-send-email-ben@smart-cactus.org>
References: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from mail.smart-cactus.org ([54.187.36.80]:56308 "EHLO
	mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752720AbcE1MBW (ORCPT
	<rfc822;linux-input@vger.kernel.org>);
	Sat, 28 May 2016 08:01:22 -0400
In-Reply-To: <1464436862-2649-1-git-send-email-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali.rohar@gmail.com>, linux-input@vger.kernel.org
Cc: Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Ben Gamari <ben@smart-cactus.org>

Here we introduce logic in alps_identify to set the ALPS_DUALPOINT flag
for touchpad hardware responding to E7 report with 73 03 28, as is found
in the Dell Latitude E7470.
---
 drivers/input/mouse/alps.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/mouse/alps.c b/drivers/input/mouse/alps.c
index 25d2cad..431bc26 100644
--- a/drivers/input/mouse/alps.c
+++ b/drivers/input/mouse/alps.c
@@ -2776,6 +2776,7 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 	const struct alps_protocol_info *protocol;
 	unsigned char e6[4], e7[4], ec[4];
 	int error;
+	int flags = 0;
 
 	/*
 	 * First try "E6 report".
@@ -2817,6 +2818,10 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
 			   e7[2] == 0x14 && ec[1] == 0x02) {
 			protocol = &alps_v8_protocol_data;
+		} else if (e7[0] == 0x73 && e7[1] == 0x03 &&
+			   e7[2] == 0x28 && ec[1] == 0x01) {
+			protocol = &alps_v8_protocol_data;
+			flags |= ALPS_DUALPOINT | ALPS_DUALPOINT_WITH_PRESSURE;
 		} else {
 			psmouse_dbg(psmouse,
 				    "Likely not an ALPS touchpad: E7=%3ph, EC=%3ph\n", e7, ec);
@@ -2830,6 +2835,7 @@ static int alps_identify(struct psmouse *psmouse, struct alps_data *priv)
 		error = alps_set_protocol(psmouse, priv, protocol);
 		if (error)
 			return error;
+		priv->flags |= flags;
 	}
 
 	return 0;
-- 
2.8.1

