From: Daniel Martin <daniel.martin@secunet.com>
Subject: [PATCH 1/5] Input: synaptics - Split synaptics_resolution(), query first
Date: Fri, 6 Feb 2015 14:25:04 +0100
Message-ID: <1423229108-29268-2-git-send-email-daniel.martin@secunet.com>
References: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Reply-To: Daniel Martin <consume.noise@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-input-owner@vger.kernel.org>
Received: from a.mx.secunet.com ([195.81.216.161]:41575 "EHLO a.mx.secunet.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752367AbbBFNT1 (ORCPT <rfc822;linux-input@vger.kernel.org>);
	Fri, 6 Feb 2015 08:19:27 -0500
In-Reply-To: <1423229108-29268-1-git-send-email-daniel.martin@secunet.com>
Sender: linux-input-owner@vger.kernel.org
List-Id: linux-input@vger.kernel.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: linux-input@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, Benjamin Tissoires <benjamin.tissoires@gmail.com>, Daniel Martin <consume.noise@gmail.com>

From: Daniel Martin <consume.noise@gmail.com>

Split the function synaptics_resolution() into
    synaptics_resolution() and synaptics_quirks().

synaptics_resolution() will be called before synaptics_quirks() to query
dimensions and resolutions before overwriting them with quirks.

v2: Removed SYN_ID_MAJOR() check from synaptics_quirks().

Signed-off-by: Daniel Martin <consume.noise@gmail.com>
---
 drivers/input/mouse/synaptics.c | 37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

diff --git a/drivers/input/mouse/synaptics.c b/drivers/input/mouse/synaptics.c
index f947292..89b408b 100644
--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -342,7 +342,6 @@ static int synaptics_resolution(struct psmouse *psmouse)
 {
 	struct synaptics_data *priv = psmouse->private;
 	unsigned char resp[3];
-	int i;
 
 	if (SYN_ID_MAJOR(priv->identity) < 4)
 		return 0;
@@ -354,17 +353,6 @@ static int synaptics_resolution(struct psmouse *psmouse)
 		}
 	}
 
-	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
-		if (psmouse_matches_pnp_id(psmouse,
-					   min_max_pnpid_table[i].pnp_ids)) {
-			priv->x_min = min_max_pnpid_table[i].x_min;
-			priv->x_max = min_max_pnpid_table[i].x_max;
-			priv->y_min = min_max_pnpid_table[i].y_min;
-			priv->y_max = min_max_pnpid_table[i].y_max;
-			return 0;
-		}
-	}
-
 	if (SYN_EXT_CAP_REQUESTS(priv->capabilities) >= 5 &&
 	    SYN_CAP_MAX_DIMENSIONS(priv->ext_cap_0c)) {
 		if (synaptics_send_cmd(psmouse, SYN_QUE_EXT_MAX_COORDS, resp)) {
@@ -390,6 +378,29 @@ static int synaptics_resolution(struct psmouse *psmouse)
 	return 0;
 }
 
+/*
+ * Apply quirk(s) if the hardware matches
+ */
+
+static int synaptics_quirks(struct psmouse *psmouse)
+{
+	struct synaptics_data *priv = psmouse->private;
+	int i;
+
+	for (i = 0; min_max_pnpid_table[i].pnp_ids; i++) {
+		if (psmouse_matches_pnp_id(psmouse,
+					   min_max_pnpid_table[i].pnp_ids)) {
+			priv->x_min = min_max_pnpid_table[i].x_min;
+			priv->x_max = min_max_pnpid_table[i].x_max;
+			priv->y_min = min_max_pnpid_table[i].y_min;
+			priv->y_max = min_max_pnpid_table[i].y_max;
+			break;
+		}
+	}
+
+	return 0;
+}
+
 static int synaptics_query_hardware(struct psmouse *psmouse)
 {
 	if (synaptics_identify(psmouse))
@@ -404,6 +415,8 @@ static int synaptics_query_hardware(struct psmouse *psmouse)
 		return -1;
 	if (synaptics_resolution(psmouse))
 		return -1;
+	if (synaptics_quirks(psmouse))
+		return -1;
 
 	return 0;
 }
-- 
2.2.2

