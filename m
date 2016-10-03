From: Ben Gamari <ben@smart-cactus.org>
Subject: [PATCH 4/5] input/alps: Set DualPoint flag for 74 03 28 devices
Date: Mon,  3 Oct 2016 08:16:29 -0400
Message-ID: <20161003121630.5285-4-ben@smart-cactus.org>
References: <20161003121630.5285-1-ben@smart-cactus.org>
Return-path: <linux-input-owner@vger.kernel.org>
Received: from turtle.smart-cactus.org ([163.172.166.228]:55540 "EHLO
        mail.smart-cactus.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751957AbcJCMZo (ORCPT
        <rfc822;linux-input@vger.kernel.org>); Mon, 3 Oct 2016 08:25:44 -0400
In-Reply-To: <20161003121630.5285-1-ben@smart-cactus.org>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Michal Hocko <mhocko@kernel.org>, linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Allen Hung <Allen_Hung@dell.com>, Masaki Ota <masaki.ota@jp.alps.com>, Ben Morgan <Ben_Morgan@dell.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Jiri Kosina <jikos@kernel.org>
Cc: Ben Gamari <ben@smart-cactus.org>

Here we introduce logic in alps_identify to set the ALPS_DUALPOINT flag
for touchpad hardware responding to E7 report with 73 03 28, as is found
in the Dell Latitude E7470.

Tested-by: Michal Hocko <mhocko@suse.com>
Signed-off-by: Ben Gamari <ben@smart-cactus.org>
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
2.9.3

